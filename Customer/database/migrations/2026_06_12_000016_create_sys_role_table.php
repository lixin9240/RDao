<?php
// 系统角色表
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
        Schema::create('sys_role', function (Blueprint $table) {
            $table->id()->comment('主键ID');
            $table->string('role_name', 50)->comment('角色名称');
            $table->string('role_key', 50)->unique()->comment('角色权限字符串');
            $table->string('description', 255)->nullable()->comment('角色描述');
            $table->unsignedTinyInteger('status')->default(1)->comment('是否有效：0-无效，1-有效');
            $table->unsignedInteger('sort_order')->default(0)->comment('显示排序');
            $table->timestamps();

            // 索引
            $table->index('status');
            $table->index('sort_order');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('sys_role');
    }
};
