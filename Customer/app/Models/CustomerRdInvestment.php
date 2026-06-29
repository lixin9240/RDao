<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;

class CustomerRdInvestment extends Model
{
    use HasFactory;

    protected $table = 'customer_rd_investments';

    protected $fillable = [
        'basic_id',
        'year',
        'projects',
        'amount',
    ];

    protected $casts = [
        'year'   => 'integer',
        'amount' => 'decimal:2',
    ];

    public function scopeSearch($query, $params)
    {
        if (!empty($params['basic_id'])) {
            $query->where('basic_id', $params['basic_id']);
        }
        if (!empty($params['year'])) {
            $query->where('year', $params['year']);
        }
        $sort = $params['sort'] ?? 'year';
        $order = $params['order'] ?? 'desc';
        return $query->orderBy($sort, $order);
    }
}