<?php

namespace Database\Seeders;

use App\Models\CustomerRdInvestment;
use Illuminate\Database\Seeder;

class CustomerRdInvestmentSeeder extends Seeder
{
    public function run(): void
    {
        $data = [
            ['basic_id' => 1, 'year' => 2025, 'projects' => 'AI算法优化, 云平台建设', 'amount' => 3000000],
            ['basic_id' => 1, 'year' => 2024, 'projects' => '大数据分析系统', 'amount' => 2000000],
            ['basic_id' => 1, 'year' => 2023, 'projects' => '物联网终端研发, 5G通信模块', 'amount' => 1500000],
        ];

        foreach ($data as $item) {
            CustomerRdInvestment::create($item);
        }
    }
}