<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;

class ImportRegion extends Command
{
    protected $signature = 'region:import';
    protected $description = '从本地 JSON 文件导入行政区划数据';

    public function handle()
    {
        $filePath = base_path('database/pca.json');

        if (!File::exists($filePath)) {
            $this->error('找不到数据文件: ' . $filePath);
            return;
        }

        $data = json_decode(File::get($filePath), true);

        DB::table('sys_location_region')->truncate();
        $this->info('开始导入行政区划数据...');

        DB::transaction(function () use ($data) {
            $this->importProvinces($data);
        });

        $this->info('行政区划数据导入成功！');
    }

    /**
     * 导入省份（第一层）
     */
    private function importProvinces(array $data)
    {
        foreach ($data as $provinceName => $cities) {
            $provinceId = DB::table('sys_location_region')->insertGetId([
                'parent_id'   => 0,
                'region_name' => $provinceName,
                'region_type' => 1,
                'region_code' => null,
                'level'       => 1,
                'sort_order'  => 0,
                'status'      => 1,
                'created_at'  => now(),
                'updated_at'  => now(),
            ]);

            $this->importCities($cities, $provinceId);
        }
    }

    /**
     * 导入城市（第二层）
     */
    private function importCities(array $cities, int $parentId)
    {
        foreach ($cities as $cityName => $districts) {
            $cityId = DB::table('sys_location_region')->insertGetId([
                'parent_id'   => $parentId,
                'region_name' => $cityName,
                'region_type' => 2,
                'region_code' => null,
                'level'       => 2,
                'sort_order'  => 0,
                'status'      => 1,
                'created_at'  => now(),
                'updated_at'  => now(),
            ]);

            $this->importDistricts($districts, $cityId);
        }
    }

    /**
     * 导入区县（第三层）
     */
    private function importDistricts(array $districts, int $parentId)
    {
        foreach ($districts as $index => $districtName) {
            DB::table('sys_location_region')->insertGetId([
                'parent_id'   => $parentId,
                'region_name' => $districtName,
                'region_type' => 3,
                'region_code' => null,
                'level'       => 3,
                'sort_order'  => $index,
                'status'      => 1,
                'created_at'  => now(),
                'updated_at'  => now(),
            ]);
        }
    }
}