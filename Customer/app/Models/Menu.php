<?php
// 菜单模型
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Menu extends Model
{
    protected $table = 'sys_menu';

    protected $fillable = [
        'parent_id',  // 父菜单ID
        'menu_name',  // 菜单名称
        'menu_type',  // 菜单类型：M-目录，C-菜单，F-按钮
        'perms',      // 权限标识
        'path',       // 路由地址
        'icon',       // 菜单图标
        'sort_order', // 显示排序
    ];
}
