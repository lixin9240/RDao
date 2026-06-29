<?php

namespace Database\Seeders;

use App\Models\CustomerFee;
use Illuminate\Database\Seeder;

class CustomerFeeSeeder extends Seeder
{
    public function run(): void
    {
        CustomerFee::query()->delete();

        $data = [
            [
                'account_name' => '上海某某金融信息服务有限公司',
                'bank_name' => '招商银行上海浦东支行',
                'bank_account' => '6214830123456789',
                'invoice_address' => '上海市浦东新区世纪大道100号环球金融中心60楼',
                'invoice_phone' => '021-68881234',
                'taxpayer_type' => '小规模纳税人',
                'billing_address' => '上海市浦东新区世纪大道100号环球金融中心60楼',
            ],
            [
                'account_name' => '北京某某科技有限公司',
                'bank_name' => '中国银行北京朝阳支行',
                'bank_account' => '621660010001234567',
                'invoice_address' => '北京市朝阳区建国门外大街1号国贸大厦A座28层',
                'invoice_phone' => '010-65001234',
                'taxpayer_type' => '一般纳税人',
                'billing_address' => '北京市朝阳区建国门外大街1号国贸大厦A座28层财务中心',
            ],
            [
                'account_name' => '杭州某某网络技术有限公司',
                'bank_name' => '浙江杭州联合农村商业银行',
                'bank_account' => '201000123456789',
                'invoice_address' => '浙江省杭州市西湖区文三路398号东信大厦15楼',
                'invoice_phone' => '0571-88001234',
                'taxpayer_type' => '小规模纳税人',
                'billing_address' => '浙江省杭州市西湖区文三路398号东信大厦15楼',
            ],
            [
                'account_name' => '深圳某某创新科技有限公司',
                'bank_name' => '中国银行深圳南山支行',
                'bank_account' => '6217858000012345678',
                'invoice_address' => '广东省深圳市南山区科技园南区高新南七道R2-B栋5楼',
                'invoice_phone' => '0755-26781234',
                'taxpayer_type' => '一般纳税人',
                'billing_address' => '广东省深圳市南山区科技园南区高新南七道R2-B栋5楼',
            ],
            [
                'account_name' => '广州某智造科技股份有限公司',
                'bank_name' => '工商银行广州科学城支行',
                'bank_account' => '6222083602012345679',
                'invoice_address' => '广州市黄埔区科学城科丰路88号A栋',
                'invoice_phone' => '020-82081234',
                'taxpayer_type' => '一般纳税人',
                'billing_address' => '广州市黄埔区科学城科丰路88号A栋',
            ],
            [
                'account_name' => '佛山某新材料研究院有限公司',
                'bank_name' => '中国建设银行佛山南海支行',
                'bank_account' => '44050166789900001234',
                'invoice_address' => '广东省佛山市南海区桂城街道南海大道北XX号',
                'invoice_phone' => '0757-86712345',
                'taxpayer_type' => '一般纳税人',
                'billing_address' => '广东省佛山市南海区桂城街道南海大道北XX号',
            ],
            [
                'account_name' => '广州某智造科技股份有限公司',
                'bank_name' => '工商银行广州科学城支行',
                'bank_account' => '6222083602012345679',
                'invoice_address' => '广州市黄埔区科学城科丰路88号A栋',
                'invoice_phone' => '020-82081234',
                'taxpayer_type' => '一般纳税人',
                'billing_address' => '广州市黄埔区科学城科丰路88号A栋',
            ],
            [
                'account_name' => '东莞某精密机械有限公司',
                'bank_name' => '建设银行东莞长安支行',
                'bank_account' => '6217003240012345670',
                'invoice_address' => '广东省东莞市长安镇乌沙社区振安路12号C座',
                'invoice_phone' => '0769-85341234',
                'taxpayer_type' => '一般纳税人',
                'billing_address' => '广东省东莞市长安镇乌沙社区振安路12号C座',
            ],
            [
                'account_name' => '佛山某新材料研究院有限公司',
                'bank_name' => '农业银行佛山狮山支行',
                'bank_account' => '6228481234567890123',
                'invoice_address' => '广东省佛山市南海区狮山镇三环西路23号研发楼',
                'invoice_phone' => '0757-86601234',
                'taxpayer_type' => '一般纳税人',
                'billing_address' => '广东省佛山市南海区狮山镇三环西路23号研发楼',
            ],
            [
                'account_name' => '珠海某海洋工程装备有限公司',
                'bank_name' => '中国银行珠海金湾支行',
                'bank_account' => '6217858000023456789',
                'invoice_address' => '广东省珠海市金湾区三灶镇定湾七路28号A区',
                'invoice_phone' => '0756-7781234',
                'taxpayer_type' => '小规模纳税人',
                'billing_address' => '广东省珠海市金湾区三灶镇定湾七路28号A区',
            ],
        ];

        foreach ($data as $item) {
            CustomerFee::create($item);
        }
    }
}
