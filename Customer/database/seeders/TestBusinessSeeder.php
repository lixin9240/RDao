<?php

namespace Database\Seeders;

use App\Models\CustomerBasic;
use App\Models\CustomerBusiness;
use App\Models\CustomerStatistics;
use App\Models\EconomyCategory;
use Illuminate\Database\Seeder;

class TestBusinessSeeder extends Seeder
{
    public function run()
    {
        // 创建国民经济分类
        $categories = [
            ['category_code' => 'C34', 'category_name' => '通用设备制造业', 'full_path' => '制造业/通用设备制造业/泵、阀门、压缩机及类似机械的制造/泵及真空设备制造', 'level' => 4, 'parent_id' => 0, 'status' => 1],
            ['category_code' => 'C39', 'category_name' => '计算机、通信和其他电子设备制造业', 'full_path' => '制造业/计算机、通信和其他电子设备制造业/电子元件及电子专用材料制造/电子元件制造', 'level' => 4, 'parent_id' => 0, 'status' => 1],
        ];

        foreach ($categories as $cat) {
            EconomyCategory::updateOrCreate(
                ['category_code' => $cat['category_code']],
                $cat
            );
        }

        // 创建工商数据
        $businesses = [
            [
                'basic_id' => 1,
                'economy_category_code' => 'C34',
                'economy_category' => '制造业',
                'economy_large_category' => '通用设备制造业',
                'economy_mid_category' => '泵、阀门、压缩机及类似机械的制造',
                'economy_sub_category' => '泵及真空设备制造',
                'established_time' => '2010-05-20',
                'employee_count' => 500,
                'registered_capital' => 10000000.00,
                'main_business_product' => '真空泵、压缩机',
                'rd_personnel' => 80,
                'phd_count' => 5,
                'senior_engineer_count' => 20,
                'master_count' => 50,
                'intermediate_engineer_count' => 100,
                'bachelor_count' => 200,
                'overseas_returnee_count' => 10,
                'business_scope' => '泵及真空设备制造、销售',
            ],
            [
                'basic_id' => 2,
                'economy_category_code' => 'C39',
                'economy_category' => '制造业',
                'economy_large_category' => '计算机、通信和其他电子设备制造业',
                'economy_mid_category' => '电子元件及电子专用材料制造',
                'economy_sub_category' => '电子元件制造',
                'established_time' => '2015-03-15',
                'employee_count' => 800,
                'registered_capital' => 20000000.00,
                'main_business_product' => '电子元件、电路板',
                'rd_personnel' => 150,
                'phd_count' => 10,
                'senior_engineer_count' => 40,
                'master_count' => 100,
                'intermediate_engineer_count' => 200,
                'bachelor_count' => 300,
                'overseas_returnee_count' => 20,
                'business_scope' => '电子元件制造、研发',
            ],
        ];

        foreach ($businesses as $biz) {
            CustomerBusiness::updateOrCreate(
                ['basic_id' => $biz['basic_id']],
                $biz
            );
        }

        // 同步到统计表
        $service = new \App\Services\GyzService();
        $service->syncBusinessToStatistics(1);
        $service->syncBusinessToStatistics(2);

        echo "Created " . count($categories) . " categories, " . count($businesses) . " businesses, synced to statistics.\n";
    }
}
