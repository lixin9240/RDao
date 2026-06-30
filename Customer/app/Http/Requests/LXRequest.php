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

        // 角色权限分配场景（必须放在角色修改之前，避免被 roles/* 吞掉）
        if ($this->is('api/v1/roles/*/menus')) {
            return [
                'menuIds'   => 'required|array',
                'menuIds.*' => 'integer|exists:sys_menu,id',
            ];
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

        // 菜单创建场景
        if ($this->is('api/v1/menus') && $this->isMethod('POST')) {
            return [
                'parentId'  => 'nullable|integer',
                'menuName'  => 'required|string|max:50',
                'menuType'  => 'required|string|in:M,C,F',
                'perms'     => 'nullable|string|max:100',
                'path'      => 'nullable|string|max:200',
                'icon'      => 'nullable|string|max:100',
                'sortOrder' => 'nullable|integer',
            ];
        }

        // 字典场景
        if ($this->is('api/v1/customer-levels') || $this->is('api/v1/customer-levels/*')) {
            return [
                'sortOrder'   => 'nullable|integer',
                'levelName'   => 'required|string|max:50',
                'levelCode'   => 'nullable|string|max:20',
                'description' => 'nullable|string|max:255',
                'status'      => 'nullable|integer|in:0,1',
            ];
        }
        if ($this->is('api/v1/customer-scales') || $this->is('api/v1/customer-scales/*')) {
            return [
                'sortOrder' => 'nullable|integer',
                'scaleName' => 'required|string|max:50',
                'status'    => 'nullable|integer|in:0,1',
            ];
        }
        if ($this->is('api/v1/file-descriptions') || $this->is('api/v1/file-descriptions/*')) {
            $countryCodes = implode(',', array_column(config('countries.list', []), 'code'));

            return [
                'projectType'       => 'required|string|max:50',
                'countryCode'       => 'required|string|in:' . $countryCodes,
                'fileCategoryId'    => 'required|integer|exists:sys_file_category,id',
                'fileSubcategoryId' => 'required|integer|exists:sys_file_category,id',
                'fileNameTemplate'  => 'nullable|string|max:255',
                'fileCodeRule'      => 'nullable|string|max:100',
                'internalCode'      => 'nullable|string|max:50',
                'authRole'          => [
                    'nullable',
                    'string',
                    'max:100',
                    function ($attribute, $value, $fail) {
                        $roles = array_map('trim', explode(',', $value));
                        foreach ($roles as $role) {
                            if (! \App\Models\Role::where('role_key', $role)->exists()) {
                                $fail("角色 {$role} 不存在。");
                            }
                        }
                    },
                ],
                'sortOrder'         => 'nullable|integer',
                'status'            => 'nullable|integer|in:0,1',
            ];
        }
        if ($this->is('api/v1/file-categories') || $this->is('api/v1/file-categories/*')) {
            return [
                'sortOrder' => 'nullable|integer',
                'name'      => 'required|string|max:100',
                'parentId'  => 'nullable|integer',
                'level'     => 'nullable|integer',
                'status'    => 'nullable|integer|in:0,1',
            ];
        }
        if ($this->is('api/v1/price-indexes') || $this->is('api/v1/price-indexes/*')) {
            return [
                'sortOrder'   => 'nullable|integer',
                'indexName'   => 'required|string|max:100',
                'description' => 'nullable|string|max:255',
                'status'      => 'nullable|integer|in:0,1',
            ];
        }
        if ($this->is('api/v1/innovation-indexes') || $this->is('api/v1/innovation-indexes/*')) {
            return [
                'sortOrder'   => 'nullable|integer',
                'indexName'   => 'required|string|max:100',
                'description' => 'nullable|string|max:255',
                'status'      => 'nullable|integer|in:0,1',
            ];
        }
        if ($this->is('api/v1/industrial-parks') || $this->is('api/v1/industrial-parks/*')) {
            return [
                'sortOrder'     => 'nullable|integer',
                'parkName'      => 'required|string|max:100',
                'parkCode'      => 'nullable|string|max:50',
                'address'       => 'nullable|string|max:255',
                'contactPerson' => 'nullable|string|max:50',
                'contactPhone'  => 'nullable|string|max:20',
                'description'   => 'nullable|string|max:255',
                'status'        => 'nullable|integer|in:0,1',
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

        // 菜单场景
        if ($this->is('api/v1/menus') && $this->isMethod('POST')) {
            $map = [
                'parentId'  => 'parent_id',
                'menuName'  => 'menu_name',
                'menuType'  => 'menu_type',
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

        // 部门场景
        if ($this->is('api/v1/depts') || $this->is('api/v1/depts/*')) {
            $map = [
                'parentId' => 'parent_id',
                'deptName' => 'dept_name',
                'deptCode' => 'dept_code',
                'leaderId' => 'leader_id',
                'leaderName' => 'leader_name',
            ];
            foreach ($map as $camel => $snake) {
                if (array_key_exists($camel, $data)) {
                    $data[$snake] = $data[$camel];
                    unset($data[$camel]);
                }
            }
            return $data;
        }

        // 角色权限分配场景（无需转换，直接返回）
        if ($this->is('api/v1/roles/*/menus')) {
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

        // 字典场景
        if ($this->is('api/v1/customer-levels') || $this->is('api/v1/customer-levels/*')) {
            $map = [
                'sortOrder'   => 'sort_order',
                'levelName'   => 'level_name',
                'levelCode'   => 'level_code',
            ];
            foreach ($map as $camel => $snake) {
                if (array_key_exists($camel, $data)) {
                    $data[$snake] = $data[$camel];
                    unset($data[$camel]);
                }
            }
            return $data;
        }
        if ($this->is('api/v1/customer-scales') || $this->is('api/v1/customer-scales/*')) {
            $map = [
                'sortOrder' => 'sort_order',
                'scaleName' => 'scale_name',
            ];
            foreach ($map as $camel => $snake) {
                if (array_key_exists($camel, $data)) {
                    $data[$snake] = $data[$camel];
                    unset($data[$camel]);
                }
            }
            return $data;
        }
        if ($this->is('api/v1/file-descriptions') || $this->is('api/v1/file-descriptions/*')) {
            $map = [
                'projectType'       => 'project_type',//项目类型
                'countryCode'       => 'country_code',//国家代码
                'fileCategoryId'    => 'file_category_id',//文件分类ID
                'fileSubcategoryId' => 'file_subcategory_id',//文件子分类ID
                'fileNameTemplate'  => 'file_name_template',//文件名模板
                'fileCodeRule'      => 'file_code_rule',//文件编码规则
                'internalCode'      => 'internal_code',//内部编码
                'authRole'          => 'auth_role',//权限角色
                'sortOrder'         => 'sort_order',//排序
            ];
            foreach ($map as $camel => $snake) {
                if (array_key_exists($camel, $data)) {
                    $data[$snake] = $data[$camel];
                    unset($data[$camel]);
                }
            }
            return $data;
        }
        if ($this->is('api/v1/file-categories') || $this->is('api/v1/file-categories/*')) {
            $map = [
                'sortOrder' => 'sort_order',
                'parentId'  => 'parent_id',
            ];
            foreach ($map as $camel => $snake) {
                if (array_key_exists($camel, $data)) {
                    $data[$snake] = $data[$camel];
                    unset($data[$camel]);
                }
            }
            return $data;
        }
        if ($this->is('api/v1/price-indexes') || $this->is('api/v1/price-indexes/*')) {
            $map = [
                'sortOrder' => 'sort_order',
                'indexName' => 'index_name',
            ];
            foreach ($map as $camel => $snake) {
                if (array_key_exists($camel, $data)) {
                    $data[$snake] = $data[$camel];
                    unset($data[$camel]);
                }
            }
            return $data;
        }
        if ($this->is('api/v1/innovation-indexes') || $this->is('api/v1/innovation-indexes/*')) {
            $map = [
                'sortOrder' => 'sort_order',
                'indexName' => 'index_name',
            ];
            foreach ($map as $camel => $snake) {
                if (array_key_exists($camel, $data)) {
                    $data[$snake] = $data[$camel];
                    unset($data[$camel]);
                }
            }
            return $data;
        }
        if ($this->is('api/v1/industrial-parks') || $this->is('api/v1/industrial-parks/*')) {
            $map = [
                'sortOrder'     => 'sort_order',
                'parkName'      => 'park_name',
                'parkCode'      => 'park_code',
                'contactPerson' => 'contact_person',
                'contactPhone'  => 'contact_phone',
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
