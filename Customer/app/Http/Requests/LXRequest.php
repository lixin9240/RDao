<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class LXRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        // 登录场景
        if ($this->is('api/v1/login')) {
            return [
                'username' => 'required|string|max:50',
                'password' => 'required|string|max:100',
            ];
        }

        // 部门场景
        if ($this->is('api/v1/depts') || $this->is('api/v1/depts/*')) {
            $rules = [
                'parentId'    => 'required|integer|min:0',
                'deptName'    => 'required|string|max:50',
                'deptCode'    => 'required|string|max:30|unique:sys_dept,dept_code',
                'leaderId'    => 'nullable|integer|exists:sys_user,id',
                'leaderName'  => 'nullable|string|max:50',
                'description' => 'nullable|string|max:255',
                'remark'      => 'nullable|string',
            ];

            if ($this->isMethod('PUT') || $this->isMethod('PATCH')) {
                $deptId = $this->route('id');
                $rules['deptCode'] = 'required|string|max:30|unique:sys_dept,dept_code,' . $deptId;
            }

            return $rules;
        }

        // 角色创建场景
        if ($this->is('api/v1/roles') && $this->isMethod('POST')) {
            return [
                'roleName'    => 'required|string|max:50',
                'roleKey'     => 'required|string|max:50|unique:sys_role,role_key',
                'description' => 'nullable|string|max:255',
                'status'      => 'nullable|integer|in:0,1',
                'sortOrder'   => 'nullable|integer',
            ];
        }

        // 角色修改场景
        if ($this->is('api/v1/roles/*') && $this->isMethod('PUT')) {
            $roleId = $this->route('id');
            return [
                'roleName'    => 'required|string|max:50',
                'roleKey'     => 'required|string|max:50|unique:sys_role,role_key,' . $roleId,
                'description' => 'nullable|string|max:255',
                'status'      => 'nullable|integer|in:0,1',
                'sortOrder'   => 'nullable|integer',
            ];
        }

        // 角色权限分配场景
        if ($this->is('api/v1/roles/*/menus')) {
            return [
                'menuIds'   => 'required|array',
                'menuIds.*' => 'integer|exists:sys_menu,id',
            ];
        }

        // 用户场景
        $rules = [
            'username'           => 'required|string|max:50|unique:sys_user,username',
            'password'           => 'required|string|max:100',
            'realName'           => 'required|string|max:50',
            'gender'             => 'nullable|integer|in:0,1,2',
            'deptId'             => 'required|integer|exists:sys_dept,id',
            'jobTitle'           => 'nullable|string|max:50',
            'email'              => 'required|string|email|max:100',
            'phone'              => 'required|string|max:20',
            'professionalLevel'  => 'nullable|string|max:20',
            'businessLevel'      => 'nullable|string|max:20',
            'status'             => 'required|integer|in:0,1',
            'employmentStatus'   => 'required|integer|in:0,1',
        ];

        // 修改时：username 唯一性排除当前记录，password 可选
        if ($this->isMethod('PUT') || $this->isMethod('PATCH')) {
            $userId = $this->route('user');
            $rules['username'] = 'required|string|max:50|unique:sys_user,username,' . $userId;
            $rules['password'] = 'nullable|string|max:100';
        }

        return $rules;
    }
    /**
     * 获取校验后的数据
     */
    public function validatedData(): array
    {
        $data = $this->validated();

        // 登录场景无需转换
        if ($this->is('api/v1/login')) {
            return $data;
        }

        // 部门场景
        if ($this->is('api/v1/depts') || $this->is('api/v1/depts/*')) {
            $map = [
                'parentId' => 'parent_id',
                'deptName' => 'dept_name',
                'deptCode' => 'dept_code',
                'leaderId' => 'leader_id',
            ];
            foreach ($map as $camel => $snake) {
                if (array_key_exists($camel, $data)) {
                    $data[$snake] = $data[$camel];
                    unset($data[$camel]);
                }
            }
            return $data;
        }

        // 角色场景（创建 + 修改）
        if (
            ($this->is('api/v1/roles') && $this->isMethod('POST'))
            || ($this->is('api/v1/roles/*') && $this->isMethod('PUT'))
        ) {
            $map = [
                'roleName'  => 'role_name',
                'roleKey'   => 'role_key',
                'sortOrder' => 'sort_order',
            ];
            foreach ($map as $camel => $snake) {
                if (array_key_exists($camel, $data)) {
                    $data[$snake] = $data[$camel];
                    unset($data[$camel]);
                }
            }
            return $data;
        }

        // 用户场景
        $map = [
            'realName'          => 'real_name',
            'deptId'            => 'dept_id',
            'jobTitle'          => 'job_title',
            'professionalLevel' => 'professional_level',
            'businessLevel'     => 'business_level',
            'status'            => 'account_status',
            'employmentStatus'  => 'employment_status',
        ];
        foreach ($map as $camel => $snake) {
            if (array_key_exists($camel, $data)) {
                $data[$snake] = $data[$camel];
                unset($data[$camel]);
            }
        }
        return $data;
    }
}
