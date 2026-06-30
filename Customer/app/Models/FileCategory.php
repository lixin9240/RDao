<?php
// 文件分类模型
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class FileCategory extends Model
{
    use Traits\DictModelTrait;

    protected $table = 'sys_file_category';

    protected $fillable = [
        'sort_order',  // 排序权重
        'name',        // 分类名称
        'parent_id',   // 父级分类ID
        'level',       // 层级深度
        'status',      // 状态：1-有效，0-无效
        'updated_by',  // 更新人ID
    ];
}
