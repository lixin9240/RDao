<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CustomerQualification extends Model
{
    protected $table = 'customer_qualifications';

    protected $fillable = [
        'customer_id', // 关联客户ID
        'is_economic_accepted', // 经信口是否验收
        'economic_accept_time', // 经信口验收时间
        'is_tech_accepted', // 科技口是否验收
        'tech_accept_time', // 科技口验收时间
        'is_high_tech', // 高企
        'high_tech_time', // 高企认定时间
        'is_province_tech', // 省企
        'province_tech_time', // 省企认定时间
        'is_city_tech', // 市企
        'city_tech_time', // 市企认定时间
        'is_province_engineer_center', // 省级工程技术中心
        'province_engineer_center_time', // 省级工程技术中心认定时间
        'is_ip_standard', // 知识产权贯标
        'ip_standard_time', // 知识产权贯标认定时间
        'is_integration_standard', // 两化融合贯标
        'integration_standard_time', // 两化融合贯标认定时间
        'creator', // 创建人
    ];

    protected $casts = [
        'is_economic_accepted' => 'boolean',
        'economic_accept_time' => 'date:Y-m-d',
        'is_tech_accepted' => 'boolean',
        'tech_accept_time' => 'date:Y-m-d',
        'is_high_tech' => 'boolean',
        'high_tech_time' => 'date:Y-m-d',
        'is_province_tech' => 'boolean',
        'province_tech_time' => 'date:Y-m-d',
        'is_city_tech' => 'boolean',
        'city_tech_time' => 'date:Y-m-d',
        'is_province_engineer_center' => 'boolean',
        'province_engineer_center_time' => 'date:Y-m-d',
        'is_ip_standard' => 'boolean',
        'ip_standard_time' => 'date:Y-m-d',
        'is_integration_standard' => 'boolean',
        'integration_standard_time' => 'date:Y-m-d',
        'created_at' => 'datetime:Y-m-d H:i:s',
        'updated_at' => 'datetime:Y-m-d H:i:s',
    ];

    /**
     * 列表搜索分页
     */
    public function scopeSearch($query, $params)
    {
        if (!empty($params['keyword'])) {
            $term = $params['keyword'];
            $query->whereHas('customerBasic', function ($q) use ($term) {
                $q->where('customer_no', 'like', "%{$term}%")
                    ->orWhere('innovation_subject', 'like', "%{$term}%");
            });
        }

        $sort = $params['sort'] ?? 'created_at';
        $order = $params['order'] ?? 'desc';
        return $query->orderBy($sort, $order);
    }

    /**
     * 关联客户基础信息
     */
    public function customerBasic()
    {
        return $this->belongsTo(CustomerBasic::class, 'customer_id');
    }
}
