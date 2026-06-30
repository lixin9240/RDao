<?php
// 创新指数模型
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InnovationIndex extends Model
{
    use Traits\DictModelTrait;

    protected $table = 'biz_innovation_index';

    protected $fillable = [
        'sort_order',   // 排序权重
        'index_name',   // 指数名称
        'description',  // 描述
        'status',       // 状态：1-有效，0-无效
        'updated_by',   // 更新人ID
    ];
}
