<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CustomerBusiness extends Model
{
    use HasFactory;

    protected $table = 'customer_business';

    protected $guarded = [];

    protected $casts = [
        'established_time'   => 'date',
        'registered_capital' => 'decimal:2',
    ];
}