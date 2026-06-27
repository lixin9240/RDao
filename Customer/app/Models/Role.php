<?php
// 角色模型
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Role extends Model
{
    protected $table = 'sys_role';

    protected $fillable = [
        'role_name',  // 角色名称
        'role_key',   // 角色权限字符串
        'description',// 角色描述
        'status',     // 是否有效：0-无效，1-有效
        'sort_order', // 显示排序
    ];
}
