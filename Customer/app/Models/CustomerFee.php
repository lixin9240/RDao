<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Model;

class CustomerFee extends Model
{
    protected $table = 'customer_fees';
    protected $fillable = [
        'account_name',
        'bank_name',
        'bank_account',
        'invoice_address',
        'invoice_phone',
        'taxpayer_type',
        'billing_address',
        'invoice_credit_code',
        'is_general_taxpayer',
    ];
    protected $dates = ['created_at','updated_at'];

    public function scopeSearch($query, $params)
    {
        if (!empty($params['search'])) {
            $query->where('account_name', 'like', "%{$params['search']}%")
                ->orWhere('bank_account', 'like', "%{$params['search']}%");
        }
        $sort = $params['sort'] ?? 'created_at';
        $order = $params['order'] ?? 'desc';
        return $query->orderBy($sort, $order);
    }
}
