<?php

namespace App\Http\Controllers;

use App\Http\Requests\LXRequest;
use App\Services\LXService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class LXController extends Controller
{
    protected LXService $service;

    public function __construct(LXService $service)
    {
        $this->service = $service;
    }

    /**
     * 用户登录
     */
    public function login(LXRequest $request): JsonResponse
    {
        $token = $this->service->login($request->validatedData());

        if (! $token) {
            return $this->error('账号或密码错误', 401);
        }

        return $this->success([
            'token'      => $token,
            'tokenType'  => 'bearer',
            'expiresIn'  => config('jwt.ttl') * 60,
        ], '登录成功');
    }

    /**
     * 新增用户
     */
    public function store(LXRequest $request): JsonResponse
    {
        $user = $this->service->createUser($request->validatedData());

        return $this->success($user, '用户创建成功');
    }

    /**
     * 获取用户详情
     */
    public function show(int $id): JsonResponse
    {
        $user = $this->service->userDetail($id);

        if (! $user) {
            return $this->error('用户不存在', 404);
        }

        return $this->success($user);
    }

    /**
     * 修改用户
     */
    public function update(LXRequest $request, int $id): JsonResponse
    {
        $user = $this->service->updateUser($id, $request->validatedData());

        return $this->success($user, '用户更新成功');
    }

    /**
     * 新增部门
     */
    public function storeDept(LXRequest $request): JsonResponse
    {
        $dept = $this->service->createDept($request->validatedData());

        return $this->success($dept, '部门创建成功');
    }

    /**
     * 修改部门
     */
    public function updateDept(LXRequest $request, int $id): JsonResponse
    {
        $dept = $this->service->updateDept($id, $request->validatedData());

        return $this->success($dept, '部门更新成功');
    }

    /**
     * 获取部门树形结构
     */
    public function deptTree(): JsonResponse
    {
        $tree = $this->service->deptTree();

        return $this->success($tree);
    }

    /* ==================== 菜单管理 ==================== */

    /**
     * 创建菜单
     */
    public function storeMenu(LXRequest $request): JsonResponse
    {
        $menu = $this->service->createMenu($request->validatedData());

        return $this->success($menu, '菜单创建成功');
    }

    /**
     * 获取菜单树形结构
     */
    public function menuTree(): JsonResponse
    {
        $tree = $this->service->menuTree();

        return $this->success($tree);
    }

    /* ==================== 角色管理 ==================== */

    /**
     * 创建角色
     */
    public function storeRole(LXRequest $request): JsonResponse
    {
        $role = $this->service->createRole($request->validatedData());

        return $this->success($role, '角色创建成功');
    }

    /**
     * 获取角色详情
     */
    public function roleDetail(int $id): JsonResponse
    {
        $role = $this->service->roleDetail($id);

        if (! $role) {
            return $this->error('角色不存在', 404);
        }

        return $this->success($role);
    }

    /**
     * 修改角色
     */
    public function updateRole(LXRequest $request, int $id): JsonResponse
    {
        $role = $this->service->updateRole($id, $request->validatedData());

        return $this->success($role, '角色更新成功');
    }

    /**
     * 删除角色
     */
    public function destroyRole(int $id): JsonResponse
    {
        $this->service->deleteRole($id);

        return $this->success([], '角色删除成功');
    }

    /**
     * 角色分页列表
     */
    public function roleList(Request $request): JsonResponse
    {
        $data = $this->service->roleList($request->all());

        return $this->success($data);
    }

    /**
     * 分配/保存角色权限
     */
    public function assignMenus(LXRequest $request, int $id): JsonResponse
    {
        $this->service->assignRoleMenus($id, $request->validatedData()['menuIds'] ?? []);

        return $this->success([], '权限分配成功');
    }

    /**
     * 获取角色已选权限
     */
    public function roleMenus(int $id): JsonResponse
    {
        $menuIds = $this->service->getRoleMenus($id);

        return $this->success($menuIds);
    }
}
