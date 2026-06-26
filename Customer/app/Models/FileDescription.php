<?php
// 文件描述模型
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class FileDescription extends Model
{
    protected $table = 'biz_file_description';

    protected $fillable = [
        'project_type',        // 项目类型
        'country_code',        // 国家/地区代码
        'file_category_id',    // 文件大类ID
        'file_subcategory_id', // 文件小类ID
        'file_name_template',  // 文件名称模板
        'file_code_rule',      // 文件编号规则
        'internal_code',       // 内部代码
        'auth_role',           // 授权角色
        'sort_order',          // 排序权重
        'status',              // 状态：1-有效，0-无效
        'updated_by',          // 更新人ID
    ];
}
