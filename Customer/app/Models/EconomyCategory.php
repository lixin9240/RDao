<?php
// 行业分类模型
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EconomyCategory extends Model
{
    protected $table = 'sys_economy_category';

    protected $fillable = [
        'parent_id',      // 父级ID
        'category_code',  // 行业代码
        'category_name',  // 行业名称
        'level',          // 层级深度
        'full_path',      // 全路径名称
        'sort_order',     // 排序权重
        'status',         // 状态：1-启用，0-停用
    ];
}
