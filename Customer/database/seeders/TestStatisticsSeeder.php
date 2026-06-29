<?php

namespace Database\Seeders;

use App\Models\CustomerBasic;
use App\Models\CustomerStatistics;
use Illuminate\Database\Seeder;

class TestStatisticsSeeder extends Seeder
{
    public function run()
    {
        // 先创建基础客户数据
        $basics = [
            [
                'id' => 1,
                'customer_no' => 'C20260001',
                'innovation_subject' => '测试公司A',
                'innovation_subject_en' => 'Test Company A',
                'credit_code' => '91110000123456789A',
                'legal_representative' => '张三',
                'company_contact' => '13800138000',
                'customer_level' => 'A',
                'customer_scale' => '中型',
                'creator' => 'admin',
            ],
            [
                'id' => 2,
                'customer_no' => 'C20260002',
                'innovation_subject' => '测试公司B',
                'innovation_subject_en' => 'Test Company B',
                'credit_code' => '91110000123456789B',
                'legal_representative' => '李四',
                'company_contact' => '13900139000',
                'customer_level' => 'B',
                'customer_scale' => '大型',
                'creator' => 'admin',
            ],
        ];

        foreach ($basics as $basic) {
            CustomerBasic::updateOrCreate(
                ['id' => $basic['id']],
                $basic
            );
        }

        // 创建统计数据
        $statistics = [
            [
                'basic_id' => 1,
                'economy_category' => '制造业',
                'economy_large_category' => '通用设备制造业',
                'economy_mid_category' => '泵、阀门、压缩机及类似机械的制造',
                'economy_sub_category' => '泵及真空设备制造',
                'sales_2021' => 1000.0000,
                'sales_2020' => 900.0000,
                'sales_2019' => 800.0000,
                'rd_fee_2021' => 100.0000,
                'rd_fee_2020' => 90.0000,
                'rd_fee_2019' => 80.0000,
                'loan_2021' => 500.0000,
                'loan_2020' => 400.0000,
                'loan_2019' => 300.0000,
                'tech_verified' => true,
                'is_high_tech' => true,
                'is_provincial_enterprise' => false,
                'is_municipal_enterprise' => false,
                'is_engineering_center' => true,
                'ip_index' => 85.5,
                'integration_standard' => 90.0,
                'creator' => 'admin',
            ],
            [
                'basic_id' => 2,
                'economy_category' => '制造业',
                'economy_large_category' => '计算机、通信和其他电子设备制造业',
                'economy_mid_category' => '电子元件及电子专用材料制造',
                'economy_sub_category' => '电子元件制造',
                'sales_2021' => 2000.0000,
                'sales_2020' => 1800.0000,
                'sales_2019' => 1600.0000,
                'rd_fee_2021' => 200.0000,
                'rd_fee_2020' => 180.0000,
                'rd_fee_2019' => 160.0000,
                'loan_2021' => 1000.0000,
                'loan_2020' => 900.0000,
                'loan_2019' => 800.0000,
                'tech_verified' => true,
                'is_high_tech' => true,
                'is_provincial_enterprise' => true,
                'is_municipal_enterprise' => false,
                'is_engineering_center' => false,
                'ip_index' => 92.0,
                'integration_standard' => 88.0,
                'creator' => 'admin',
            ],
        ];

        foreach ($statistics as $item) {
            CustomerStatistics::updateOrCreate(
                ['basic_id' => $item['basic_id']],
                $item
            );
        }

        echo "Created " . count($basics) . " basic records and " . count($statistics) . " statistics records.\n";
    }
}
