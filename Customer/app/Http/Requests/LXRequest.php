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
     * 根据路由场景自动映射 camelCase → snake_case
     */
    protected function prepareForValidation(): void
    {
        $data = $this->all();
        array_walk_recursive($data, function (&$v) {
            if (is_string($v)) $v = trim($v);
        });

        $map = match (true) {
            // 登录场景无需转换
            $this->is('api/v1/login') => [],

            // 菜单场景
            $this->is('api/v1/menus') && $this->isMethod('POST') => [
                'parentId'  => 'parent_id',
                'menuName'  => 'menu_name',
                'menuType'  => 'menu_type',
                'sortOrder' => 'sort_order',
            ],

            // 部门场景
            $this->is('api/v1/depts') || $this->is('api/v1/depts/*') => [
                'parentId'   => 'parent_id',
                'deptName'   => 'dept_name',
                'deptCode'   => 'dept_code',
                'leaderId'   => 'leader_id',
                'leaderName' => 'leader_name',
            ],

            // 角色权限分配场景（无需转换）
            $this->is('api/v1/roles/*/menus') => [],

            // 角色场景（创建 + 修改）
            ($this->is('api/v1/roles') && $this->isMethod('POST'))
            || ($this->is('api/v1/roles/*') && $this->isMethod('PUT')) => [
                'roleName'  => 'role_name',
                'roleKey'   => 'role_key',
                'sortOrder' => 'sort_order',
            ],

            // 字典场景
            $this->is('api/v1/customer-levels') || $this->is('api/v1/customer-levels/*') => [
                'sortOrder'   => 'sort_order',
                'levelName'   => 'level_name',
                'levelCode'   => 'level_code',
            ],
            $this->is('api/v1/customer-scales') || $this->is('api/v1/customer-scales/*') => [
                'sortOrder' => 'sort_order',
                'scaleName' => 'scale_name',
            ],
            $this->is('api/v1/file-descriptions') || $this->is('api/v1/file-descriptions/*') => [
                'projectType'       => 'project_type',
                'countryCode'       => 'country_code',
                'fileCategoryId'    => 'file_category_id',
                'fileSubcategoryId' => 'file_subcategory_id',
                'fileNameTemplate'  => 'file_name_template',
                'fileCodeRule'      => 'file_code_rule',
                'internalCode'      => 'internal_code',
                'authRole'          => 'auth_role',
                'sortOrder'         => 'sort_order',
            ],
            $this->is('api/v1/file-categories') || $this->is('api/v1/file-categories/*') => [
                'sortOrder' => 'sort_order',
                'parentId'  => 'parent_id',
            ],
            $this->is('api/v1/price-indexes') || $this->is('api/v1/price-indexes/*') => [
                'sortOrder' => 'sort_order',
                'indexName' => 'index_name',
            ],
            $this->is('api/v1/innovation-indexes') || $this->is('api/v1/innovation-indexes/*') => [
                'sortOrder' => 'sort_order',
                'indexName' => 'index_name',
            ],
            $this->is('api/v1/industrial-parks') || $this->is('api/v1/industrial-parks/*') => [
                'sortOrder'     => 'sort_order',
                'parkName'      => 'park_name',
                'parkCode'      => 'park_code',
                'contactPerson' => 'contact_person',
                'contactPhone'  => 'contact_phone',
            ],

            // 用户场景
            default => [
                'realName'          => 'real_name',
                'deptId'            => 'dept_id',
                'jobTitle'          => 'job_title',
                'professionalLevel' => 'professional_level',
                'businessLevel'     => 'business_level',
                'status'            => 'account_status',
                'employmentStatus'  => 'employment_status',
            ],
        };

        $converted = [];
        foreach ($data as $key => $value) {
            if (isset($map[$key])) {
                $converted[$map[$key]] = $value;
            } else {
                $converted[\Illuminate\Support\Str::snake($key)] = $value;
            }
        }

        $this->replace($converted);
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
                'parent_id'   => 'required|integer|min:0',
                'dept_name'   => 'required|string|max:50',
                'dept_code'   => 'required|string|max:30|unique:sys_dept,dept_code',
                'leader_id'   => 'nullable|integer|exists:sys_user,id',
                'leader_name' => 'nullable|string|max:50',
                'description' => 'nullable|string|max:255',
                'remark'      => 'nullable|string',
            ];

            if ($this->isMethod('PUT') || $this->isMethod('PATCH')) {
                $deptId = $this->route('id');
                $rules['dept_code'] = 'required|string|max:30|unique:sys_dept,dept_code,' . $deptId;
            }

            return $rules;
        }

        // 角色权限分配场景（必须放在角色修改之前，避免被 roles/* 吞掉）
        if ($this->is('api/v1/roles/*/menus')) {
            return [
                'menu_ids'   => 'required|array',
                'menu_ids.*' => 'integer|exists:sys_menu,id',
            ];
        }

        // 角色创建场景
        if ($this->is('api/v1/roles') && $this->isMethod('POST')) {
            return [
                'role_name'   => 'required|string|max:50',
                'role_key'    => 'required|string|max:50|unique:sys_role,role_key',
                'description' => 'nullable|string|max:255',
                'status'      => 'nullable|integer|in:0,1',
                'sort_order'  => 'nullable|integer',
            ];
        }

        // 角色修改场景
        if ($this->is('api/v1/roles/*') && $this->isMethod('PUT')) {
            $roleId = $this->route('id');
            return [
                'role_name'   => 'required|string|max:50',
                'role_key'    => 'required|string|max:50|unique:sys_role,role_key,' . $roleId,
                'description' => 'nullable|string|max:255',
                'status'      => 'nullable|integer|in:0,1',
                'sort_order'  => 'nullable|integer',
            ];
        }

        // 菜单创建场景
        if ($this->is('api/v1/menus') && $this->isMethod('POST')) {
            return [
                'parent_id'  => 'nullable|integer',
                'menu_name'  => 'required|string|max:50',
                'menu_type'  => 'required|string|in:M,C,F',
                'perms'      => 'nullable|string|max:100',
                'path'       => 'nullable|string|max:200',
                'icon'       => 'nullable|string|max:100',
                'sort_order' => 'nullable|integer',
            ];
        }

        // 字典场景
        if ($this->is('api/v1/customer-levels') || $this->is('api/v1/customer-levels/*')) {
            return [
                'sort_order'  => 'nullable|integer',
                'level_name'  => 'required|string|max:50',
                'level_code'  => 'nullable|string|max:20',
                'description' => 'nullable|string|max:255',
                'status'      => 'nullable|integer|in:0,1',
            ];
        }
        if ($this->is('api/v1/customer-scales') || $this->is('api/v1/customer-scales/*')) {
            return [
                'sort_order' => 'nullable|integer',
                'scale_name' => 'required|string|max:50',
                'status'     => 'nullable|integer|in:0,1',
            ];
        }
        if ($this->is('api/v1/file-descriptions') || $this->is('api/v1/file-descriptions/*')) {
            $countryCodes = implode(',', array_column(config('countries.list', []), 'code'));

            return [
                'project_type'       => 'required|string|max:50',
                'country_code'       => 'required|string|in:' . $countryCodes,
                'file_category_id'    => 'required|integer|exists:sys_file_category,id',
                'file_subcategory_id' => 'required|integer|exists:sys_file_category,id',
                'file_name_template'  => 'nullable|string|max:255',
                'file_code_rule'      => 'nullable|string|max:100',
                'internal_code'      => 'nullable|string|max:50',
                'auth_role'          => [
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
                'sort_order'         => 'nullable|integer',
                'status'             => 'nullable|integer|in:0,1',
            ];
        }
        if ($this->is('api/v1/file-categories') || $this->is('api/v1/file-categories/*')) {
            return [
                'sort_order' => 'nullable|integer',
                'name'       => 'required|string|max:100',
                'parent_id'  => 'nullable|integer',
                'level'      => 'nullable|integer',
                'status'     => 'nullable|integer|in:0,1',
            ];
        }
        if ($this->is('api/v1/price-indexes') || $this->is('api/v1/price-indexes/*')) {
            return [
                'sort_order'  => 'nullable|integer',
                'index_name'  => 'required|string|max:100',
                'description' => 'nullable|string|max:255',
                'status'      => 'nullable|integer|in:0,1',
            ];
        }
        if ($this->is('api/v1/innovation-indexes') || $this->is('api/v1/innovation-indexes/*')) {
            return [
                'sort_order'  => 'nullable|integer',
                'index_name'  => 'required|string|max:100',
                'description' => 'nullable|string|max:255',
                'status'      => 'nullable|integer|in:0,1',
            ];
        }
        if ($this->is('api/v1/industrial-parks') || $this->is('api/v1/industrial-parks/*')) {
            return [
                'sort_order'     => 'nullable|integer',
                'park_name'      => 'required|string|max:100',
                'park_code'      => 'nullable|string|max:50',
                'address'        => 'nullable|string|max:255',
                'contact_person' => 'nullable|string|max:50',
                'contact_phone'  => 'nullable|string|max:20',
                'description'    => 'nullable|string|max:255',
                'status'         => 'nullable|integer|in:0,1',
            ];
        }

        // 用户场景
        $rules = [
            'username'           => 'required|string|max:50|unique:sys_user,username',
            'password'           => 'required|string|max:100',
            'real_name'          => 'required|string|max:50',
            'gender'             => 'nullable|integer|in:0,1,2',
            'dept_id'            => 'required|integer|exists:sys_dept,id',
            'job_title'          => 'nullable|string|max:50',
            'email'              => 'required|string|email|max:100',
            'phone'              => 'required|string|max:20',
            'professional_level' => 'nullable|string|max:20',
            'business_level'     => 'nullable|string|max:20',
            'account_status'     => 'required|integer|in:0,1',
            'employment_status'  => 'required|integer|in:0,1',
        ];

        // 修改时：username 唯一性排除当前记录，password 可选
        if ($this->isMethod('PUT') || $this->isMethod('PATCH')) {
            $userId = $this->route('user');
            $rules['username'] = 'required|string|max:50|unique:sys_user,username,' . $userId;
            $rules['password'] = 'nullable|string|max:100';
        }

        return $rules;
    }
}
