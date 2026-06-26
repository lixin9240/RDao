<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Model;

class CustomerBasic extends Model
{
    protected $table = 'customer_basics';
    protected $fillable = [
        'customer_no',
        'innovation_subject',
        'innovation_subject_en',
        'credit_code',
        'legal_representative',
        'company_contact',
        'customer_level',
        'customer_scale',
        'creator',
        'price_index',
        'innovation_index',
        'contract_count',
        'latest_contract_date',
        'remark'
    ];
    protected $dates = [
        'latest_contract_date',
        'created_at',
        'updated_at'
    ];

    // 列表搜索分页
    public function scopeSearch($query, $params)
    {
        if (!empty($params['search'])) {
            $query->where('customer_no', 'like', "%{$params['search']}%")
                ->orWhere('innovation_subject', 'like', "%{$params['search']}%")
                ->orWhere('credit_code', 'like', "%{$params['search']}%");
        }
        $sort = $params['sort'] ?? 'created_at';
        $order = $params['order'] ?? 'desc';
        return $query->orderBy($sort, $order);
    }
}
