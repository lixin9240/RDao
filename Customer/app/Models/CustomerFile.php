<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Models\FileCategory;

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
        $fileName = $params['file_name'] ?? $params['fileName'] ?? null;
        $fileType = $params['file_type'] ?? $params['fileType'] ?? null;
        $customerName = $params['customer_name'] ?? $params['customerName'] ?? null;
        $startTime = $params['start_time'] ?? $params['startTime'] ?? null;
        $endTime = $params['end_time'] ?? $params['endTime'] ?? null;

        if (! empty($fileName)) {
            $query->where('original_name', 'like', "%{$fileName}%");
        }

        if (! empty($fileType)) {
            $catIds = [$fileType];
            $childIds = FileCategory::where('parent_id', $fileType)->pluck('id')->toArray();
            if (! empty($childIds)) {
                $catIds = array_merge($catIds, $childIds);
            }
            $query->whereIn('category_id', $catIds);
        }

        if (! empty($customerName)) {
            $query->whereHas('customer', function ($q) use ($customerName) {
                $q->where('innovation_subject', 'like', "%{$customerName}%");
            });
        }

        if (! empty($startTime)) {
            $query->whereDate('created_at', '>=', $startTime);
        }

        if (! empty($endTime)) {
            $query->whereDate('created_at', '<=', $endTime);
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
