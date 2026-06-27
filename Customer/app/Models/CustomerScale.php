<?php
// 客户规模模型
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CustomerScale extends Model
{
    protected $table = 'sys_customer_scale';

    protected $fillable = [
        'sort_order',   // 排序权重
        'scale_name',   // 客户规模名称
        'status',       // 状态：1-有效，0-无效
        'updated_by',   // 更新人ID
    ];
}
