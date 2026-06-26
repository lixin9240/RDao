<?php
// 系统用户模型
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SysUser extends Model
{
    protected $table = 'sys_user';

    protected $fillable = [
        'username',           // 用户名（工号）
        'password',           // 密码
        'real_name',          // 姓名
        'gender',             // 性别：0-未知，1-男，2-女
        'dept_id',            // 所属部门ID
        'job_title',          // 职位
        'email',              // 邮箱
        'phone',              // 手机号
        'professional_level', // 专业等级
        'business_level',     // 商务等级
        'employment_status',  // 离职在职状态：0-离职，1-在职
        'account_status',     // 账号状态：0-禁用，1-启用
    ];
}
