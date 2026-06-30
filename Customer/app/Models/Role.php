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

    /**
     * 分配角色菜单权限（先删后插）
     */
    public function assignMenus(array $menuIds): void
    {
        \Illuminate\Support\Facades\DB::transaction(function () use ($menuIds) {
            \Illuminate\Support\Facades\DB::table('sys_role_menu')
                ->where('role_id', $this->id)
                ->delete();

            $insertData = [];
            foreach (array_unique($menuIds) as $menuId) {
                $insertData[] = [
                    'role_id'    => $this->id,
                    'menu_id'    => $menuId,
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            }

            if (! empty($insertData)) {
                \Illuminate\Support\Facades\DB::table('sys_role_menu')->insert($insertData);
            }
        });
    }

    /**
     * 获取角色已选权限 ID 数组
     */
    public function getMenuIds(): array
    {
        return \Illuminate\Support\Facades\DB::table('sys_role_menu')
            ->where('role_id', $this->id)
            ->pluck('menu_id')
            ->toArray();
    }
}
