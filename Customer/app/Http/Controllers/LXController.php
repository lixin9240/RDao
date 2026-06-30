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
     * 用户列表
     */
    public function index(Request $request): JsonResponse
    {
        return $this->success($this->service->userList($request->all()));
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
     * 删除用户
     */
    public function destroy(int $id): JsonResponse
    {
        $this->service->deleteUser($id);

        return $this->success([], '用户删除成功');
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

    public function showDept(int $id): JsonResponse
    {
        $dept = $this->service->deptDetail($id);

        return $this->success($dept);
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

    /* ==================== 字典管理 ==================== */

    // ----- 客户等级 -----
    public function customerLevelList(Request $request): JsonResponse
    {
        return $this->success($this->service->customerLevelList($request->all()));
    }

    public function customerLevelStore(LXRequest $request): JsonResponse
    {
        return $this->success($this->service->customerLevelCreate($request->validatedData()), '创建成功');
    }

    public function customerLevelUpdate(LXRequest $request, int $id): JsonResponse
    {
        return $this->success($this->service->customerLevelUpdate($id, $request->validatedData()), '更新成功');
    }

    public function customerLevelDestroy(int $id): JsonResponse
    {
        $this->service->customerLevelDelete($id);
        return $this->success([], '删除成功');
    }

    // ----- 客户规模 -----
    public function customerScaleList(Request $request): JsonResponse
    {
        return $this->success($this->service->customerScaleList($request->all()));
    }

    public function customerScaleStore(LXRequest $request): JsonResponse
    {
        return $this->success($this->service->customerScaleCreate($request->validatedData()), '创建成功');
    }

    public function customerScaleUpdate(LXRequest $request, int $id): JsonResponse
    {
        return $this->success($this->service->customerScaleUpdate($id, $request->validatedData()), '更新成功');
    }

    public function customerScaleDestroy(int $id): JsonResponse
    {
        $this->service->customerScaleDelete($id);
        return $this->success([], '删除成功');
    }

    // ----- 文件描述 -----
    public function fileDescriptionList(Request $request): JsonResponse
    {
        return $this->success($this->service->fileDescriptionList($request->all()));
    }

    public function fileDescriptionStore(LXRequest $request): JsonResponse
    {
        return $this->success($this->service->fileDescriptionCreate($request->validatedData()), '创建成功');
    }

    public function fileDescriptionUpdate(LXRequest $request, int $id): JsonResponse
    {
        return $this->success($this->service->fileDescriptionUpdate($id, $request->validatedData()), '更新成功');
    }

    public function fileDescriptionDestroy(int $id): JsonResponse
    {
        $this->service->fileDescriptionDelete($id);
        return $this->success([], '删除成功');
    }

    // ----- 文件分类 -----
    public function fileCategoryList(Request $request): JsonResponse
    {
        return $this->success($this->service->fileCategoryList($request->all()));
    }

    public function fileCategoryStore(LXRequest $request): JsonResponse
    {
        return $this->success($this->service->fileCategoryCreate($request->validatedData()), '创建成功');
    }

    public function fileCategoryUpdate(LXRequest $request, int $id): JsonResponse
    {
        return $this->success($this->service->fileCategoryUpdate($id, $request->validatedData()), '更新成功');
    }

    public function fileCategoryDestroy(int $id): JsonResponse
    {
        $this->service->fileCategoryDelete($id);
        return $this->success([], '删除成功');
    }

    // ----- 价格指数 -----
    public function priceIndexList(Request $request): JsonResponse
    {
        return $this->success($this->service->priceIndexList($request->all()));
    }

    public function priceIndexStore(LXRequest $request): JsonResponse
    {
        return $this->success($this->service->priceIndexCreate($request->validatedData()), '创建成功');
    }

    public function priceIndexUpdate(LXRequest $request, int $id): JsonResponse
    {
        return $this->success($this->service->priceIndexUpdate($id, $request->validatedData()), '更新成功');
    }

    public function priceIndexDestroy(int $id): JsonResponse
    {
        $this->service->priceIndexDelete($id);
        return $this->success([], '删除成功');
    }

    // ----- 创新指数 -----
    public function innovationIndexList(Request $request): JsonResponse
    {
        return $this->success($this->service->innovationIndexList($request->all()));
    }

    public function innovationIndexStore(LXRequest $request): JsonResponse
    {
        return $this->success($this->service->innovationIndexCreate($request->validatedData()), '创建成功');
    }

    public function innovationIndexUpdate(LXRequest $request, int $id): JsonResponse
    {
        return $this->success($this->service->innovationIndexUpdate($id, $request->validatedData()), '更新成功');
    }

    public function innovationIndexDestroy(int $id): JsonResponse
    {
        $this->service->innovationIndexDelete($id);
        return $this->success([], '删除成功');
    }

    // ----- 工业园区 -----
    public function industrialParkList(Request $request): JsonResponse
    {
        return $this->success($this->service->industrialParkList($request->all()));
    }

    public function industrialParkStore(LXRequest $request): JsonResponse
    {
        return $this->success($this->service->industrialParkCreate($request->validatedData()), '创建成功');
    }

    public function industrialParkUpdate(LXRequest $request, int $id): JsonResponse
    {
        return $this->success($this->service->industrialParkUpdate($id, $request->validatedData()), '更新成功');
    }

    public function industrialParkDestroy(int $id): JsonResponse
    {
        $this->service->industrialParkDelete($id);
        return $this->success([], '删除成功');
    }

    // ----- 国家/地区 -----
    public function countryList(): JsonResponse
    {
        return $this->success($this->service->countryList());
    }

    // ----- 行业分类 -----
    public function industryCategoryList(): JsonResponse
    {
        return $this->success($this->service->industryCategoryList());
    }

    // ----- 企业类型 -----
    public function enterpriseTypeList(): JsonResponse
    {
        return $this->success($this->service->enterpriseTypeList());
    }

    // ----- 国民经济分类四级联动 -----
    public function economyCategoryList(Request $request): JsonResponse
    {
        return $this->success($this->service->economyCategoryList($request->all()));
    }

    public function economyCategoryTree(): JsonResponse
    {
        return $this->success($this->service->economyCategoryTree());
    }
}
