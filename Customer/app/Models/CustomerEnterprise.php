<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CustomerEnterprise extends Model
{
    use HasFactory;

    protected $table = 'customer_enterprises';

    protected $fillable = [
        'company_type',
        'registered_capital',
        'established_date',
        'industry_category',
        'main_business',
        'company_website',
    ];

    protected $casts = [
        'registered_capital' => 'decimal:2',
        'established_date'   => 'date:Y-m-d',
    ];
}