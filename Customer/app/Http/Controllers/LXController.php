<?php

namespace App\Http\Controllers;

use App\Http\Requests\LXRequest;
use App\Services\LXService;
use Illuminate\Http\JsonResponse;

class LXController extends Controller
{
    protected LXService $service;

    public function __construct(LXService $service)
    {
        $this->service = $service;
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
}
