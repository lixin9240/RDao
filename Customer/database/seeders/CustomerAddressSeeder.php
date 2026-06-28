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
                'id' => 3,
                'nationality' => '中国',
                'province' => '上海市',
                'city' => '上海市',
                'district' => '浦东新区',
                'street_address' => '世纪大道100号环球金融中心',
                'address_en' => '100 Century Avenue, Pudong New Area, Shanghai',
                'other_address' => '60楼',
                'industrial_park' => '陆家嘴金融贸易区',
                'postal_code' => '200120',
                'company_website' => 'https://www.example-shanghai.com',
            ],
            [
                'id' => 4,
                'nationality' => '中国',
                'province' => '北京市',
                'city' => '北京市',
                'district' => '朝阳区',
                'street_address' => '建国门外大街1号国贸大厦',
                'address_en' => '1 Jianguomenwai Avenue, Chaoyang, Beijing',
                'other_address' => 'A座28层',
                'industrial_park' => '国贸CBD',
                'postal_code' => '100004',
                'company_website' => 'https://www.example-beijing.com',
            ],
            [
                'id' => 5,
                'nationality' => '中国',
                'province' => '浙江省',
                'city' => '杭州市',
                'district' => '西湖区',
                'street_address' => '文三路398号东信大厦',
                'address_en' => '398 Wensan Road, Xihu District, Hangzhou',
                'other_address' => '15楼',
                'industrial_park' => '杭州高新技术产业开发区',
                'postal_code' => '310012',
                'company_website' => 'https://www.example-hangzhou.com',
            ],
            [
                'id' => 6,
                'nationality' => '中国',
                'province' => '广东省',
                'city' => '深圳市',
                'district' => '南山区',
                'street_address' => '科技园南区高新南七道R2-B栋5楼',
                'address_en' => '5F, Building R2-B, Gaoxin South 7th Road, Science Park, Nanshan District, Shenzhen',
                'other_address' => 'B区',
                'industrial_park' => '深圳南山科技园',
                'postal_code' => '518000',
                'company_website' => 'https://www.example-shenzhen.com',
            ],
            [
                'id' => 7,
                'nationality' => '中国',
                'province' => '广东省',
                'city' => '广州市',
                'district' => '黄埔区',
                'street_address' => '科学城科丰路88号A栋',
                'address_en' => '88 Kefeng Road, Science City, Building A, Huangpu District, Guangzhou',
                'other_address' => 'A栋',
                'industrial_park' => '广州科学城产业园',
                'postal_code' => '510700',
                'company_website' => 'https://www.gz-mz.com',
            ],
            [
                'id' => 8,
                'nationality' => '中国',
                'province' => '广东省',
                'city' => '佛山市',
                'district' => '南海区',
                'street_address' => '桂城街道南海大道北XX号',
                'address_en' => 'XX, North Nanhai Avenue, Guicheng Street, Nanhai District, Foshan, Guangdong, China',
                'other_address' => '佛山某新材料研究院',
                'industrial_park' => '南海软件科技园',
                'postal_code' => '528200',
                'company_website' => 'https://www.fs-mzxyjy.com',
            ],
            [
                'id' => 9,
                'nationality' => '中国',
                'province' => '广东省',
                'city' => '深圳市',
                'district' => '南山区',
                'street_address' => '科技园南区高新南七道R2-B栋5楼',
                'address_en' => '5F, Building R2-B, Gaoxin South 7th Road, Science Park, Nanshan District, Shenzhen',
                'other_address' => 'B区',
                'industrial_park' => '深圳南山科技园',
                'postal_code' => '518000',
                'company_website' => 'https://www.example-shenzhen.com',
            ],
            [
                'id' => 10,
                'nationality' => '中国',
                'province' => '广东省',
                'city' => '广州市',
                'district' => '黄埔区',
                'street_address' => '科学城科丰路88号',
                'address_en' => '88 Kefeng Road, Science City, Huangpu District, Guangzhou',
                'other_address' => 'A栋',
                'industrial_park' => '广州科学城产业园',
                'postal_code' => '510700',
                'company_website' => 'https://www.gz-mz.com',
            ],
            [
                'id' => 11,
                'nationality' => '中国',
                'province' => '广东省',
                'city' => '东莞市',
                'district' => '长安镇',
                'street_address' => '乌沙社区振安路12号',
                'address_en' => '12 Zhenan Road, Wusha Community, Changan Town, Dongguan',
                'other_address' => 'C座',
                'industrial_park' => '长安精密制造工业园',
                'postal_code' => '523850',
                'company_website' => 'https://www.dg-mz.com',
            ],
            [
                'id' => 12,
                'nationality' => '中国',
                'province' => '广东省',
                'city' => '佛山市',
                'district' => '南海区',
                'street_address' => '狮山镇三环西路23号',
                'address_en' => '23 West Sanhuan Road, Shishan Town, Nanhai District, Foshan',
                'other_address' => '研发楼',
                'industrial_park' => '佛山南海大学城',
                'postal_code' => '528225',
                'company_website' => 'https://www.fs-mz.com',
            ],
            [
                'id' => 13,
                'nationality' => '中国',
                'province' => '广东省',
                'city' => '珠海市',
                'district' => '金湾区',
                'street_address' => '三灶镇定湾七路28号',
                'address_en' => '28 Qiwan 7th Road, Sanzao Town, Jinwan District, Zhuhai',
                'other_address' => 'A区',
                'industrial_park' => '珠海航空产业园',
                'postal_code' => '519040',
                'company_website' => 'https://www.zh-mz.com',
            ],
        ];

        foreach ($data as $item) {
            $model = new CustomerAddress($item);
            $model->id = $item['id'];
            $model->save();
        }
    }
}
