<?php
// 部门模型
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Dept extends Model
{
    protected $table = 'sys_dept';

    protected $fillable = [
        'parent_id',   // 父部门ID
        'dept_name',   // 部门名称
        'dept_code',   // 部门编码
        'leader_id',   // 负责人ID
        'description', // 部门描述
        'remark',      // 备注
        'status',      // 状态：0-停用，1-正常
    ];
}
