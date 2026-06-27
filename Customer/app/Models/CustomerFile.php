<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class CustomerFile extends Model
{
    use SoftDeletes;

    protected $table = 'customer_files';

    protected $fillable = [
        'category_id',
        'customer_id',
        'salesperson_id',
        'remarks',
        'file_url',
        'file_size',
        'original_name',
        'created_by',
        'updated_by',
    ];

    protected $dates = [
        'created_at',
        'updated_at',
        'deleted_at',
    ];

    public function scopeSearch($query, $params)
    {
        if (! empty($params['fileName'])) {
            $query->where('original_name', 'like', "%{$params['fileName']}%");
        }

        if (! empty($params['fileType'])) {
            $query->where('category_id', $params['fileType']);
        }

        if (! empty($params['customerName'])) {
            $query->whereHas('customer', function ($q) use ($params) {
                $q->where('innovation_subject', 'like', "%{$params['customerName']}%");
            });
        }

        if (! empty($params['startTime'])) {
            $query->whereDate('created_at', '>=', $params['startTime']);
        }

        if (! empty($params['endTime'])) {
            $query->whereDate('created_at', '<=', $params['endTime']);
        }

        return $query->orderBy('created_at', 'desc');
    }

    public function customer()
    {
        return $this->belongsTo(CustomerBasic::class, 'customer_id');
    }

    public function category()
    {
        return $this->belongsTo(FileCategory::class, 'category_id');
    }

    public function creator()
    {
        return $this->belongsTo(SysUser::class, 'created_by');
    }
}
