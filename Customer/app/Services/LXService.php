<?php

namespace App\Services;

use App\Models\Dept;
use App\Models\Role;
use App\Models\SysUser;
use Illuminate\Support\Facades\DB;
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

    /* ==================== 角色管理 ==================== */

    /**
     * 创建角色
     */
    public function createRole(array $data): array
    {
        $role = Role::create($data);

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
}
