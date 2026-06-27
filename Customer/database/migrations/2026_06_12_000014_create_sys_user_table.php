<?php
// 系统用户表
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('sys_user', function (Blueprint $table) {
            $table->id()->comment('主键ID');
            $table->string('username', 50)->unique()->comment('用户名（工号），登录账号');
            $table->string('password', 100)->comment('密码，加密存储');
            $table->string('real_name', 50)->comment('姓名');
            $table->unsignedTinyInteger('gender')->default(0)->comment('性别：0-未知，1-男，2-女');
            $table->unsignedBigInteger('dept_id')->comment('所属部门ID');
            $table->string('job_title', 50)->nullable()->comment('职位');
            $table->string('email', 100)->comment('邮箱');
            $table->string('phone', 20)->comment('手机号');
            $table->string('professional_level', 20)->nullable()->comment('专业等级');
            $table->string('business_level', 20)->nullable()->comment('商务等级');
            $table->unsignedTinyInteger('employment_status')->default(1)->comment('离职在职状态：0-离职，1-在职');
            $table->unsignedTinyInteger('account_status')->default(1)->comment('账号状态：0-禁用，1-启用');
            $table->timestamps();

            // 索引
            $table->index('dept_id');
            $table->index('employment_status');
            $table->index('account_status');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('sys_user');
    }
};
