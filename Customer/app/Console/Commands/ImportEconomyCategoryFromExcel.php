<?php

namespace App\Console\Commands;

use App\Models\EconomyCategory;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use PhpOffice\PhpSpreadsheet\Reader\Xlsx;

class ImportEconomyCategoryFromExcel extends Command
{
    protected $signature = 'import:economy-category
                            {--all : 导入全部小类（默认仅精选约500行）}
                            {--file= : 自定义 Excel 文件路径}';
    protected $description = '从 Excel 导入 GB/T 4754-2017 国民经济行业分类到 sys_economy_category';

    public function handle(): int
    {
        $file = $this->option('file') ?? base_path('国民经济行业分类注释.xlsx');

        if (! file_exists($file)) {
            $this->error("文件不存在: {$file}");
            return 1;
        }

        $this->info('正在解析 Excel 文件...');
        $reader = new Xlsx();
        $spreadsheet = $reader->load($file);
        $sheet = $spreadsheet->getActiveSheet();

        // 第一遍：收集所有分类数据
        $categories = []; // 门类 (A-T)
        $majors = [];     // 大类 (2-digit)
        $middles = [];    // 中类 (3-digit)
        $minors = [];     // 小类 (4-digit)

        for ($i = 1; $i <= $sheet->getHighestRow(); $i++) {
            $a = $sheet->getCell('A' . $i)->getValue();
            $b = $sheet->getCell('B' . $i)->getValue();
            $d = $sheet->getCell('D' . $i)->getValue();

            $a = $a !== null ? trim((string) $a) : '';
            $b = $b !== null ? trim((string) $b) : '';
            $d = $d !== null ? trim((string) $d) : '';

            if ($a !== '' && $d !== '' && $d !== '—') {
                if (preg_match('/^[A-T]$/', $a)) {
                    $categories[$a] = ['code' => $a, 'name' => $d];
                } elseif (preg_match('/^\d{2}$/', $a)) {
                    $majors[$a] = ['code' => $a, 'name' => $d];
                } elseif (preg_match('/^\d{3}$/', $a)) {
                    // 中类：即使同行有 B 列小类代码，也需收录
                    $middles[$a] = ['code' => $a, 'name' => $d];
                }
            }

            if ($b !== '' && $d !== '' && $d !== '—') {
                $minors[$b] = ['code' => $b, 'name' => $d];
            }
        }

        $this->info("解析完成: 门类 " . count($categories) . " / 大类 " . count($majors) . " / 中类 " . count($middles) . " / 小类 " . count($minors));

        // 门类与大类的对应关系（GB/T 4754-2017 标准）
        $categoryMajorMap = [
            'A' => ['01', '02', '03', '04', '05'],
            'B' => ['06', '07', '08', '09', '10', '11', '12'],
            'C' => ['13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41', '42', '43'],
            'D' => ['44', '45', '46'],
            'E' => ['47', '48', '49', '50'],
            'F' => ['51', '52'],
            'G' => ['53', '54', '55', '56', '57', '58', '59', '60'],
            'H' => ['61', '62'],
            'I' => ['63', '64', '65'],
            'J' => ['66', '67', '68', '69'],
            'K' => ['70'],
            'L' => ['71', '72'],
            'M' => ['73', '74', '75'],
            'N' => ['76', '77', '78', '79'],
            'O' => ['80', '81', '82'],
            'P' => ['83'],
            'Q' => ['84', '85'],
            'R' => ['86', '87', '88', '89', '90'],
            'S' => ['91', '92', '93', '94', '95', '96'],
            'T' => ['97'],
        ];

        DB::transaction(function () use ($categories, $majors, $middles, $minors, $categoryMajorMap) {
            EconomyCategory::query()->delete();
            $this->info('已清空旧数据');

            $total = 0;
            $sort = 0;

            foreach ($categories as $catCode => $cat) {
                $sort++;
                $catRecord = EconomyCategory::create([
                    'parent_id'     => 0,
                    'category_code' => $catCode,
                    'category_name' => $cat['name'],
                    'level'         => 1,
                    'full_path'     => $cat['name'],
                    'sort_order'    => $sort,
                    'status'        => 1,
                ]);
                $total++;

                // 导入该门类下的大类
                $majorCodes = $categoryMajorMap[$catCode] ?? [];
                foreach ($majorCodes as $majorCode) {
                    if (! isset($majors[$majorCode])) continue;

                    $majorRecord = EconomyCategory::create([
                        'parent_id'     => $catRecord->id,
                        'category_code' => $majorCode,
                        'category_name' => $majors[$majorCode]['name'],
                        'level'         => 2,
                        'full_path'     => $cat['name'] . ' > ' . $majors[$majorCode]['name'],
                        'sort_order'    => (int) $majorCode,
                        'status'        => 1,
                    ]);
                    $total++;

                    // 导入该大类下的中类
                    foreach ($middles as $midCode => $mid) {
                        if (substr($midCode, 0, 2) !== $majorCode) continue;

                        $midRecord = EconomyCategory::create([
                            'parent_id'     => $majorRecord->id,
                            'category_code' => $midCode,
                            'category_name' => $mid['name'],
                            'level'         => 3,
                            'full_path'     => $majorRecord->full_path . ' > ' . $mid['name'],
                            'sort_order'    => (int) $midCode,
                            'status'        => 1,
                        ]);
                        $total++;
                    }

                    // 导入该大类下的小类
                    $importAll = $this->option('all');
                    foreach ($minors as $minorCode => $minor) {
                        if (substr($minorCode, 0, 2) !== $majorCode) continue;

                        // 非 --all 模式：仅导入末尾为 0 的代表性小类（精选）
                        if (! $importAll && substr($minorCode, -1) !== '0') continue;

                        // 找到父级中类
                        $parentMidCode = substr($minorCode, 0, 3);
                        $parentId = isset($middles[$parentMidCode])
                            ? EconomyCategory::where('category_code', $parentMidCode)->value('id')
                            : $majorRecord->id;

                        EconomyCategory::create([
                            'parent_id'     => $parentId ?? $majorRecord->id,
                            'category_code' => $minorCode,
                            'category_name' => $minor['name'],
                            'level'         => 4,
                            'full_path'     => $majorRecord->full_path . ' > ' . $minor['name'],
                            'sort_order'    => (int) $minorCode,
                            'status'        => 1,
                        ]);
                        $total++;
                    }
                }
            }

            $this->info("导入完成，共 {$total} 条记录");
        });

        return 0;
    }
}
