<?php

namespace App\Console\Commands;

use App\Models\EconomyCategory;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class ImportIndustryCategory extends Command
{
    protected $signature = 'import:industry {file? : JSON 文件路径，默认 storage/app/industry_categories.json}';
    protected $description = '从 JSON 文件导入 GB/T 4754-2017 行业分类到数据库';

    public function handle(): int
    {
        $file = $this->argument('file') ?? storage_path('app/industry_categories.json');

        if (!file_exists($file)) {
            $this->error("文件不存在: {$file}");
            $this->line("请把 JSON 数据放到: " . storage_path('app/industry_categories.json'));
            return 1;
        }

        $json = file_get_contents($file);
        $data = json_decode($json, true);

        if (json_last_error() !== JSON_ERROR_NONE) {
            $this->error('JSON 解析失败: ' . json_last_error_msg());
            return 1;
        }

        $list = $data['list'] ?? [];

        if (empty($list)) {
            $this->error('JSON 中未找到 list 字段');
            return 1;
        }

        DB::transaction(function () use ($list) {
            // 清空旧数据
            EconomyCategory::query()->delete();
            $this->info('已清空旧数据');

            // 递归导入
            $total = $this->importBatch($list, 0, 1, '');
            $this->info("导入完成，共 {$total} 条记录");
        });

        return 0;
    }

    private function importBatch(array $items, int $parentId, int $level, string $parentPath): int
    {
        $count = 0;
        $sort = 0;

        foreach ($items as $item) {
            $sort++;
            $fullPath = $parentPath ? "{$parentPath} > {$item['name']}" : $item['name'];

            $record = EconomyCategory::create([
                'parent_id'     => $parentId,
                'category_code' => $item['code'],
                'category_name' => $item['name'],
                'level'         => $level,
                'full_path'     => $fullPath,
                'sort_order'    => $sort,
                'status'        => 1,
            ]);

            $count++;

            if (!empty($item['children'])) {
                $count += $this->importBatch($item['children'], $record->id, $level + 1, $fullPath);
            }
        }

        return $count;
    }
}