<?php

namespace Database\Seeders;

use App\Models\CustomerFee;
use Illuminate\Database\Seeder;

class CustomerFeeSeeder extends Seeder
{
    public function run(): void
    {
        $data = [
            [
                'account_name'   => '深圳某某智能科技有限公司',
                'bank_name'      => '中国工商银行深圳南山支行',
                'bank_account'   => '4001234567890123456',
                'invoice_address' => '广东省深圳市南山区科技园南路88号',
                'invoice_phone'  => '0755-26001234',
                'taxpayer_type'  => '一般纳税人',
                'billing_address' => '广东省深圳市南山区科技园南路88号A栋501室',
            ],
            [
                'account_name'   => '广州某某贸易有限公司',
                'bank_name'      => '中国建设银行广州天河支行',
                'bank_account'   => '6217003320012345678',
                'invoice_address' => '广东省广州市天河区天河路385号太古汇B座1201',
                'invoice_phone'  => '020-88881234',
                'taxpayer_type'  => '一般纳税人',
                'billing_address' => '广东省广州市天河区天河路385号太古汇B座1201财务部',
            ],
            [
                'account_name'   => '上海某某金融信息服务有限公司',
                'bank_name'      => '招商银行上海浦东支行',
                'bank_account'   => '6214830123456789',
                'invoice_address' => '上海市浦东新区世纪大道100号环球金融中心60楼',
                'invoice_phone'  => '021-68881234',
                'taxpayer_type'  => '小规模纳税人',
                'billing_address' => '上海市浦东新区世纪大道100号环球金融中心60楼',
            ],
            [
                'account_name'   => '北京某某科技有限公司',
                'bank_name'      => '中国银行北京朝阳支行',
                'bank_account'   => '621660010001234567',
                'invoice_address' => '北京市朝阳区建国门外大街1号国贸大厦A座28层',
                'invoice_phone'  => '010-65001234',
                'taxpayer_type'  => '一般纳税人',
                'billing_address' => '北京市朝阳区建国门外大街1号国贸大厦A座28层财务中心',
            ],
            [
                'account_name'   => '杭州某某网络技术有限公司',
                'bank_name'      => '浙江杭州联合农村商业银行',
                'bank_account'   => '201000123456789',
                'invoice_address' => '浙江省杭州市西湖区文三路398号东信大厦15楼',
                'invoice_phone'  => '0571-88001234',
                'taxpayer_type'  => '小规模纳税人',
                'billing_address' => '浙江省杭州市西湖区文三路398号东信大厦15楼',
            ],
        ];

        foreach ($data as $item) {
            CustomerFee::create($item);
        }
    }
}
