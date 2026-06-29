<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CustomerBusiness extends Model
{
    use HasFactory;

    protected $table = 'customer_business';

    protected $fillable = [
        'basic_id',
        'economy_category_code',
        'economy_category',
        'economy_large_category',
        'economy_mid_category',
        'economy_sub_category',
        'established_time',
        'employee_count',
        'registered_capital',
        'main_business_product',
        'rd_personnel',
        'phd_count',
        'senior_engineer_count',
        'master_count',
        'intermediate_engineer_count',
        'bachelor_count',
        'overseas_returnee_count',
        'business_scope',
    ];

    protected $casts = [
        'established_time'   => 'date',
        'registered_capital' => 'decimal:2',
        'employee_count'    => 'integer',
        'rd_personnel'      => 'integer',
        'phd_count'         => 'integer',
        'senior_engineer_count' => 'integer',
        'master_count'      => 'integer',
        'intermediate_engineer_count' => 'integer',
        'bachelor_count'   => 'integer',
        'overseas_returnee_count' => 'integer',
    ];

    public function basic()
    {
        return $this->belongsTo(CustomerBasic::class, 'basic_id');
    }
}