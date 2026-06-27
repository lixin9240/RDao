<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Model;

class CustomerAddress extends Model
{
    protected $table = 'customer_addresses';
    protected $fillable = [
        'nationality',
        'province',
        'city',
        'district',
        'street_address',
        'address_en',
        'other_address',
        'industrial_park',
        'postal_code',
        'company_website'
    ];
    protected $dates = ['created_at','updated_at'];

    public function scopeSearch($query, $params)
    {
        if (!empty($params['search'])) {
            $query->where('province', 'like', "%{$params['search']}%")
                ->orWhere('city', 'like', "%{$params['search']}%")
                ->orWhere('street_address', 'like', "%{$params['search']}%");
        }
        $sort = $params['sort'] ?? 'created_at';
        $order = $params['order'] ?? 'desc';
        return $query->orderBy($sort, $order);
    }
}
