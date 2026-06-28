<?php

namespace App\Console\Commands;

use App\Models\EconomyCategory;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class ImportIndustryFromConfig extends Command
{
    protected $signature = 'import:industry-from-config';
    protected $description = '从 config/industry_categories.php 导入行业分类到数据库';

    public function handle(): int
    {
        $config = config('industry_categories');
        $list = $config['list'] ?? [];

        if (empty($list)) {
            $this->error('config/industry_categories.php 中 list 为空，请先补全数据');
            return 1;
        }

        DB::transaction(function () use ($list) {
            EconomyCategory::query()->delete();
            $this->info('已清空旧数据');

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