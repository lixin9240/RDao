<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CustomerFinancial extends Model
{
    protected $table = 'customer_financials';

    protected $fillable = [
        'basic_id',
        'sales_2025',
        'sales_2024',
        'sales_2023',
        'rd_fee_2025',
        'rd_fee_2024',
        'rd_fee_2023',
        'loan_2025',
        'loan_2024',
        'loan_2023',
        'creator',
    ];

    protected $casts = [
        'sales_2025' => 'decimal:4',
        'sales_2024' => 'decimal:4',
        'sales_2023' => 'decimal:4',
        'rd_fee_2025' => 'decimal:4',
        'rd_fee_2024' => 'decimal:4',
        'rd_fee_2023' => 'decimal:4',
        'loan_2025' => 'decimal:4',
        'loan_2024' => 'decimal:4',
        'loan_2023' => 'decimal:4',
    ];

    public function basic()
    {
        return $this->belongsTo(CustomerBasic::class, 'basic_id');
    }
}
