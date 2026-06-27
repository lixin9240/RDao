<?php

namespace App\Services;

use App\Models\CustomerLevel;
use App\Models\CustomerScale;
use App\Models\Dept;
use App\Models\FileCategory;
use App\Models\FileDescription;
use App\Models\IndustrialPark;
use App\Models\InnovationIndex;
use App\Models\Menu;
use App\Models\PriceIndex;
use App\Models\Role;
use App\Models\SysUser;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Tymon\JWTAuth\Facades\JWTAuth;

class LXService
{
    /**
     * 用户登录
     */
    public function login(array $credentials): ?string
    {
        $token = JWTAuth::attempt($credentials);

        if (! $token) {
            return null;
        }

        return $token;
    }

    /**
     * 新增用户（密码由模型自动哈希）
     */
    public function createUser(array $data): array
    {
        $user = SysUser::create($data);

        return $this->userToArray($user);
    }

    /**
     * 修改用户（密码由模型自动哈希）
     */
    public function updateUser(int $id, array $data): array
    {
        $user = SysUser::findOrFail($id);

        if (empty($data['password'])) {
            unset($data['password']);
        }

        $user->update($data);

        return $this->userToArray($user->fresh());
    }

    /**
     * 获取用户详情
     */
    public function userDetail(int $id): ?array
    {
        $user = SysUser::with('dept:id,dept_name')->find($id);

        if (! $user) {
            return null;
        }

        return $this->userToArray($user);
    }

    /**
     * 将用户模型转为接口所需的 camelCase 数组
     */
    private function userToArray(SysUser $user): array
    {
        return [
            'id'                => $user->id,
            'username'          => $user->username,
            'realName'          => $user->real_name,
            'gender'            => $user->gender,
            'deptId'            => $user->dept_id,
            'deptName'          => $user->dept?->dept_name,
            'jobTitle'          => $user->job_title,
            'email'             => $user->email,
            'phone'             => $user->phone,
            'professionalLevel' => $user->professional_level,
            'businessLevel'     => $user->business_level,
            'status'            => $user->account_status,
            'employmentStatus'  => $user->employment_status,
        ];
    }

    /* ==================== 部门管理 ==================== */

    /**
     * 新增部门
     */
    public function createDept(array $data): array
    {
        $data = $this->resolveLeaderId($data);
        $dept = Dept::create($data);

        return $this->deptToArray($dept);
    }

    /**
     * 修改部门
     */
    public function updateDept(int $id, array $data): array
    {
        $dept = Dept::findOrFail($id);
        $data = $this->resolveLeaderId($data);
        $dept->update($data);

        return $this->deptToArray($dept->fresh());
    }

    /**
     * 获取部门树形结构
     */
    public function deptTree(): array
    {
        $all = Dept::where('status', 1)->orderBy('id')->get();

        return $this->buildTree($all);
    }

    /**
     * 根据 leaderName 解析 leaderId
     */
    private function resolveLeaderId(array $data): array
    {
        if (! empty($data['leader_name']) && empty($data['leader_id'])) {
            $user = SysUser::where('real_name', $data['leader_name'])->first();
            if ($user) {
                $data['leader_id'] = $user->id;
            }
            unset($data['leader_name']);
        }

        return $data;
    }

    /**
     * 递归构建部门树
     */
    private function buildTree($depts, int $parentId = 0): array
    {
        $tree = [];
        foreach ($depts as $dept) {
            if ($dept->parent_id == $parentId) {
                $children = $this->buildTree($depts, $dept->id);
                $node = [
                    'id'    => $dept->id,
                    'label' => $dept->dept_name,
                ];
                if (! empty($children)) {
                    $node['children'] = $children;
                }
                $tree[] = $node;
            }
        }

        return $tree;
    }

    /**
     * 将部门模型转为 camelCase 数组
     */
    private function deptToArray(Dept $dept): array
    {
        return [
            'id'          => $dept->id,
            'parentId'    => $dept->parent_id,
            'deptName'    => $dept->dept_name,
            'deptCode'    => $dept->dept_code,
            'leaderId'    => $dept->leader_id,
            'description' => $dept->description,
            'remark'      => $dept->remark,
            'status'      => $dept->status,
        ];
    }

    /* ==================== 菜单管理 ==================== */

    /**
     * 创建菜单
     */
    public function createMenu(array $data): array
    {
        $menu = Menu::create($data);

        return [
            'id'        => $menu->id,
            'parentId'  => $menu->parent_id,
            'menuName'  => $menu->menu_name,
            'menuType'  => $menu->menu_type,
            'perms'     => $menu->perms,
            'path'      => $menu->path,
            'icon'      => $menu->icon,
            'sortOrder' => $menu->sort_order,
        ];
    }

    /**
     * 获取菜单树形结构
     */
    public function menuTree(): array
    {
        $all = Menu::orderBy('sort_order')
            ->get([
                'id',
                'parent_id',
                'menu_name',
                'menu_type',
            ]);

        return $this->buildMenuTree($all);
    }

    /**
     * 递归构建菜单树
     */
    private function buildMenuTree($menus, int $parentId = 0): array
    {
        $tree = [];
        foreach ($menus as $menu) {
            if ($menu->parent_id == $parentId) {
                $children = $this->buildMenuTree($menus, $menu->id);
                $node = [
                    'id'       => $menu->id,
                    'label'    => $menu->menu_name,
                    'menuType' => $menu->menu_type,
                ];
                if (! empty($children)) {
                    $node['children'] = $children;
                }
                $tree[] = $node;
            }
        }

        return $tree;
    }

    /* ==================== 角色管理 ==================== */

    /**
     * 创建角色
     */
    public function createRole(array $data): array
    {
        $role = Role::create($data);

        return $this->roleToArray($role);
    }

    /**
     * 获取角色详情
     */
    public function roleDetail(int $id): ?array
    {
        $role = Role::find($id);

        if (! $role) {
            return null;
        }

        return $this->roleToArray($role);
    }

    /**
     * 修改角色
     */
    public function updateRole(int $id, array $data): array
    {
        $role = Role::findOrFail($id);
        $role->update($data);

        return $this->roleToArray($role->fresh());
    }

    /**
     * 删除角色
     */
    public function deleteRole(int $id): void
    {
        $role = Role::findOrFail($id);
        $role->delete();
    }

    /**
     * 角色分页列表
     */
    public function roleList(array $params): array
    {
        $pageNum  = (int) ($params['pageNum'] ?? 1);
        $pageSize = (int) ($params['pageSize'] ?? 10);
        $roleName = $params['roleName'] ?? null;

        $query = Role::query();

        if (! empty($roleName)) {
            $query->where('role_name', 'like', '%' . $roleName . '%');
        }

        $total = $query->count();
        $rows  = $query->offset(($pageNum - 1) * $pageSize)
                       ->limit($pageSize)
                       ->get();

        return [
            'total' => $total,
            'rows'  => $rows->map(fn (Role $role) => [
                'id'          => $role->id,
                'roleName'    => $role->role_name,
                'roleKey'     => $role->role_key,
                'description' => $role->description,
                'status'      => $role->status,
                'createTime'  => $role->created_at?->toDateTimeString(),
            ])->toArray(),
        ];
    }

    /**
     * 分配角色权限（先删后插）
     */
    public function assignRoleMenus(int $roleId, array $menuIds): void
    {
        DB::transaction(function () use ($roleId, $menuIds) {
            DB::table('sys_role_menu')->where('role_id', $roleId)->delete();

            $insertData = [];
            foreach (array_unique($menuIds) as $menuId) {
                $insertData[] = [
                    'role_id'    => $roleId,
                    'menu_id'    => $menuId,
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            }

            if (! empty($insertData)) {
                DB::table('sys_role_menu')->insert($insertData);
            }
        });
    }

    /**
     * 获取角色已选权限 ID 数组
     */
    public function getRoleMenus(int $roleId): array
    {
        return DB::table('sys_role_menu')
            ->where('role_id', $roleId)
            ->pluck('menu_id')
            ->toArray();
    }

    /**
     * 将角色模型转为 camelCase 数组
     */
    private function roleToArray(Role $role): array
    {
        return [
            'id'          => $role->id,
            'roleName'    => $role->role_name,
            'roleKey'     => $role->role_key,
            'description' => $role->description,
            'status'      => $role->status,
            'sortOrder'   => $role->sort_order,
            'createTime'  => $role->created_at?->toDateTimeString(),
        ];
    }

    /* ==================== 字典管理 ==================== */

    /**
     * 通用字典列表查询
     */
    private function dictQuery(string $modelClass, array $params, string $nameField)
    {
        $query = $modelClass::query();
        if (isset($params['status'])) {
            $query->where('status', $params['status']);
        }
        if (! empty($params['keyword'])) {
            $query->where($nameField, 'like', '%' . $params['keyword'] . '%');
        }
        return $query->orderBy('sort_order')->get();
    }

    /**
     * 模型转为 camelCase 数组
     */
    private function modelToCamelCase($model): array
    {
        $data = is_array($model) ? $model : $model->toArray();
        $result = [];
        foreach ($data as $key => $value) {
            $result[Str::camel($key)] = $value;
        }
        return $result;
    }

    // ----- 客户等级 -----
    public function customerLevelList(array $params): array
    {
        return $this->dictQuery(CustomerLevel::class, $params, 'level_name')
            ->map(fn ($item) => $this->modelToCamelCase($item))
            ->toArray();
    }

    public function customerLevelCreate(array $data): array
    {
        return $this->modelToCamelCase(CustomerLevel::create($data));
    }

    public function customerLevelUpdate(int $id, array $data): array
    {
        $model = CustomerLevel::findOrFail($id);
        $model->update($data);
        return $this->modelToCamelCase($model->fresh());
    }

    public function customerLevelDelete(int $id): void
    {
        CustomerLevel::findOrFail($id)->delete();
    }

    // ----- 客户规模 -----
    public function customerScaleList(array $params): array
    {
        return $this->dictQuery(CustomerScale::class, $params, 'scale_name')
            ->map(fn ($item) => $this->modelToCamelCase($item))
            ->toArray();
    }

    public function customerScaleCreate(array $data): array
    {
        return $this->modelToCamelCase(CustomerScale::create($data));
    }

    public function customerScaleUpdate(int $id, array $data): array
    {
        $model = CustomerScale::findOrFail($id);
        $model->update($data);
        return $this->modelToCamelCase($model->fresh());
    }

    public function customerScaleDelete(int $id): void
    {
        CustomerScale::findOrFail($id)->delete();
    }

    // ----- 文件描述 -----
    public function fileDescriptionList(array $params): array
    {
        return $this->dictQuery(FileDescription::class, $params, 'file_name_template')
            ->map(fn ($item) => $this->modelToCamelCase($item))
            ->toArray();
    }

    public function fileDescriptionCreate(array $data): array
    {
        return $this->modelToCamelCase(FileDescription::create($data));
    }

    public function fileDescriptionUpdate(int $id, array $data): array
    {
        $model = FileDescription::findOrFail($id);
        $model->update($data);
        return $this->modelToCamelCase($model->fresh());
    }

    public function fileDescriptionDelete(int $id): void
    {
        FileDescription::findOrFail($id)->delete();
    }

    // ----- 文件分类 -----
    public function fileCategoryList(array $params): array
    {
        return $this->dictQuery(FileCategory::class, $params, 'name')
            ->map(fn ($item) => $this->modelToCamelCase($item))
            ->toArray();
    }

    public function fileCategoryCreate(array $data): array
    {
        return $this->modelToCamelCase(FileCategory::create($data));
    }

    public function fileCategoryUpdate(int $id, array $data): array
    {
        $model = FileCategory::findOrFail($id);
        $model->update($data);
        return $this->modelToCamelCase($model->fresh());
    }

    public function fileCategoryDelete(int $id): void
    {
        FileCategory::findOrFail($id)->delete();
    }

    // ----- 价格指数 -----
    public function priceIndexList(array $params): array
    {
        return $this->dictQuery(PriceIndex::class, $params, 'index_name')
            ->map(fn ($item) => $this->modelToCamelCase($item))
            ->toArray();
    }

    public function priceIndexCreate(array $data): array
    {
        return $this->modelToCamelCase(PriceIndex::create($data));
    }

    public function priceIndexUpdate(int $id, array $data): array
    {
        $model = PriceIndex::findOrFail($id);
        $model->update($data);
        return $this->modelToCamelCase($model->fresh());
    }

    public function priceIndexDelete(int $id): void
    {
        PriceIndex::findOrFail($id)->delete();
    }

    // ----- 创新指数 -----
    public function innovationIndexList(array $params): array
    {
        return $this->dictQuery(InnovationIndex::class, $params, 'index_name')
            ->map(fn ($item) => $this->modelToCamelCase($item))
            ->toArray();
    }

    public function innovationIndexCreate(array $data): array
    {
        return $this->modelToCamelCase(InnovationIndex::create($data));
    }

    public function innovationIndexUpdate(int $id, array $data): array
    {
        $model = InnovationIndex::findOrFail($id);
        $model->update($data);
        return $this->modelToCamelCase($model->fresh());
    }

    public function innovationIndexDelete(int $id): void
    {
        InnovationIndex::findOrFail($id)->delete();
    }

    // ----- 工业园区 -----
    public function industrialParkList(array $params): array
    {
        return $this->dictQuery(IndustrialPark::class, $params, 'park_name')
            ->map(fn ($item) => $this->modelToCamelCase($item))
            ->toArray();
    }

    public function industrialParkCreate(array $data): array
    {
        return $this->modelToCamelCase(IndustrialPark::create($data));
    }

    public function industrialParkUpdate(int $id, array $data): array
    {
        $model = IndustrialPark::findOrFail($id);
        $model->update($data);
        return $this->modelToCamelCase($model->fresh());
    }

    public function industrialParkDelete(int $id): void
    {
        IndustrialPark::findOrFail($id)->delete();
    }
}
