<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CustomerStatistics extends Model
{
    protected $table = 'customer_statistics';

    protected $fillable = [
        'basic_id',
        'economy_category',
        'economy_sub_category',
        'economy_large_category',
        'economy_mid_category',
        'sales_2021',
        'sales_2020',
        'sales_2019',
        'rd_fee_2021',
        'rd_fee_2020',
        'rd_fee_2019',
        'loan_2021',
        'loan_2020',
        'loan_2019',
        'tech_verified',
        'is_high_tech',
        'is_provincial_enterprise',
        'is_municipal_enterprise',
        'is_engineering_center',
        'ip_index',
        'integration_standard',
        'creator',
    ];

    protected $casts = [
        'tech_verified'         => 'boolean',
        'is_high_tech'          => 'boolean',
        'is_provincial_enterprise' => 'boolean',
        'is_municipal_enterprise' => 'boolean',
        'is_engineering_center' => 'boolean',
        'sales_2021'            => 'decimal:4',
        'sales_2020'            => 'decimal:4',
        'sales_2019'            => 'decimal:4',
        'rd_fee_2021'           => 'decimal:4',
        'rd_fee_2020'           => 'decimal:4',
        'rd_fee_2019'           => 'decimal:4',
        'loan_2021'             => 'decimal:4',
        'loan_2020'             => 'decimal:4',
        'loan_2019'             => 'decimal:4',
    ];

    public function basic()
    {
        return $this->belongsTo(CustomerBasic::class, 'basic_id');
    }

    public function scopeSearch($query, $params)
    {
        if (!empty($params['basic_id'])) {
            $query->where('basic_id', $params['basic_id']);
        }
        if (!empty($params['search'])) {
            $term = $params['search'];
            $query->where(function ($q) use ($term) {
                $q->where('economy_category', 'like', "%{$term}%")
                    ->orWhere('economy_sub_category', 'like', "%{$term}%")
                    ->orWhere('economy_large_category', 'like', "%{$term}%")
                    ->orWhere('economy_mid_category', 'like', "%{$term}%");
            });
        }
        $sort = $params['sort'] ?? 'created_at';
        $order = $params['order'] ?? 'desc';
        return $query->orderBy($sort, $order);
    }
}
