<?php

namespace Database\Seeders;

use App\Models\CustomerAddress;
use Illuminate\Database\Seeder;

class CustomerAddressSeeder extends Seeder
{
    public function run(): void
    {
        $data = [
            [
                'nationality'     => '中国',
                'province'        => '广东省',
                'city'            => '深圳市',
                'district'        => '南山区',
                'street_address'  => '科技园南路88号',
                'address_en'      => '88 Kejiyuan South Road, Nanshan, Shenzhen',
                'other_address'   => 'A栋501室',
                'industrial_park'  => '深圳科技园',
                'postal_code'     => '518000',
                'company_website' => 'https://www.example-shenzhen.com',
            ],
            [
                'nationality'     => '中国',
                'province'        => '广东省',
                'city'            => '广州市',
                'district'        => '天河区',
                'street_address'  => '天河路385号太古汇',
                'address_en'      => 'Taikoo Hui, Tianhe Road, Tianhe, Guangzhou',
                'other_address'   => '写字楼B座1201',
                'industrial_park'  => '天河中央商务区',
                'postal_code'     => '510620',
                'company_website' => 'https://www.example-guangzhou.com',
            ],
            [
                'nationality'     => '中国',
                'province'        => '上海市',
                'city'            => '上海市',
                'district'        => '浦东新区',
                'street_address'  => '世纪大道100号环球金融中心',
                'address_en'      => '100 Century Avenue, Pudong New Area, Shanghai',
                'other_address'   => '60楼',
                'industrial_park'  => '陆家嘴金融贸易区',
                'postal_code'     => '200120',
                'company_website' => 'https://www.example-shanghai.com',
            ],
            [
                'nationality'     => '中国',
                'province'        => '北京市',
                'city'            => '北京市',
                'district'        => '朝阳区',
                'street_address'  => '建国门外大街1号国贸大厦',
                'address_en'      => '1 Jianguomenwai Avenue, Chaoyang, Beijing',
                'other_address'   => 'A座28层',
                'industrial_park'  => '国贸CBD',
                'postal_code'     => '100004',
                'company_website' => 'https://www.example-beijing.com',
            ],
            [
                'nationality'     => '中国',
                'province'        => '浙江省',
                'city'            => '杭州市',
                'district'        => '西湖区',
                'street_address'  => '文三路398号东信大厦',
                'address_en'      => '398 Wensan Road, Xihu District, Hangzhou',
                'other_address'   => '15楼',
                'industrial_park'  => '杭州高新技术产业开发区',
                'postal_code'     => '310012',
                'company_website' => 'https://www.example-hangzhou.com',
            ],
        ];

        foreach ($data as $item) {
            CustomerAddress::create($item);
        }
    }
}
