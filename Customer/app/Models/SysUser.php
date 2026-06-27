<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Support\Facades\Hash;
use Tymon\JWTAuth\Contracts\JWTSubject;

class SysUser extends Authenticatable implements JWTSubject
{
    protected $table = 'sys_user';

    protected $fillable = [
        'username',           // 用户名（工号）
        'password',           // 密码
        'real_name',          // 姓名
        'gender',             // 性别：0-未知，1-男，2-女
        'dept_id',            // 所属部门ID
        'role_id',            // 所属角色ID
        'job_title',          // 职位
        'email',              // 邮箱
        'phone',              // 手机号
        'professional_level', // 专业等级
        'business_level',     // 商务等级
        'employment_status',  // 离职在职状态：0-离职，1-在职
        'account_status',     // 账号状态：0-禁用，1-启用
    ];

    /**
     * 密码自动哈希
     */
    public function setPasswordAttribute(string $value): void
    {
        $this->attributes['password'] = Hash::make($value);
    }

    /**
     * 所属角色
     */
    public function role(): BelongsTo
    {
        return $this->belongsTo(Role::class, 'role_id');
    }

    /**
     * 所属部门
     */
    public function dept(): BelongsTo
    {
        return $this->belongsTo(Dept::class, 'dept_id');
    }

    /**
     * 判断用户是否拥有指定角色
     */
    public function hasRole(string $roleKey): bool
    {
        if ($this->role !== null && $this->role->role_key === $roleKey) {
            return true;
        }

        return $this->professional_level === $roleKey || $this->business_level === $roleKey;
    }

    /**
     * JWT 标识符
     */
    public function getJWTIdentifier(): mixed
    {
        return $this->getKey();
    }

    /**
     * JWT 自定义声明
     */
    public function getJWTCustomClaims(): array
    {
        return [];
    }
}
