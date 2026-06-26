<?php

namespace App\Services;

use App\Models\SysUser;
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
}
