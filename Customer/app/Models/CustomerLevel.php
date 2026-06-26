<?php
// 客户等级模型
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CustomerLevel extends Model
{
    protected $table = 'sys_customer_level';

    protected $fillable = [
        'sort_order',   // 排序权重
        'level_name',   // 客户等级名称
        'level_code',   // 等级编码
        'description',  // 描述
        'status',       // 状态：1-有效，0-无效
        'updated_by',   // 更新人ID
    ];
}
