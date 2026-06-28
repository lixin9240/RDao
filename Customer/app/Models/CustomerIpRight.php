<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CustomerIpRight extends Model
{
    protected $table = 'customer_ip_rights';

    protected $fillable = [
        'trademark_count',
        'patent_count',
        'authorized_invention_patent_count',
        'copyright_count',
        'has_enjoyed_additional_deduction',
        'has_school_enterprise_cooperation',
        'cooperative_university_name',
    ];

    protected $casts = [
        'has_enjoyed_additional_deduction'  => 'boolean',
        'has_school_enterprise_cooperation' => 'boolean',
    ];

    protected $dates = [
        'created_at',
        'updated_at',
    ];

    public function scopeSearch($query, $params)
    {
        if (!empty($params['search'])) {
            $query->where('cooperative_university_name', 'like', "%{$params['search']}%");
        }

        $sort = $params['sort'] ?? 'created_at';
        $order = $params['order'] ?? 'desc';

        return $query->orderBy($sort, $order);
    }
}
