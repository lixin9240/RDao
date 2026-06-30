<?php

namespace App\Models\Traits;

trait DictModelTrait
{
    /**
     * 通用字典列表查询作用域
     */
    public function scopeDictList($query, array $params, string $nameField = 'name')
    {
        if (isset($params['status'])) {
            $query->where('status', $params['status']);
        }
        if (! empty($params['keyword'])) {
            $query->where($nameField, 'like', '%' . $params['keyword'] . '%');
        }
        return $query->orderBy('sort_order');
    }
}