<?php
// 系统菜单表
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
        Schema::create('sys_menu', function (Blueprint $table) {
            $table->id()->comment('主键ID');
            $table->unsignedBigInteger('parent_id')->default(0)->comment('父菜单ID，顶级为0');
            $table->string('menu_name', 50)->comment('菜单名称');
            $table->char('menu_type', 1)->comment('菜单类型：M-目录，C-菜单，F-按钮');
            $table->string('perms', 100)->nullable()->comment('权限标识');
            $table->string('path', 200)->nullable()->comment('路由地址');
            $table->string('icon', 100)->nullable()->comment('菜单图标');
            $table->unsignedInteger('sort_order')->default(0)->comment('显示排序');
            $table->timestamps();

            // 索引
            $table->index('parent_id');
            $table->index('menu_type');
            $table->index('perms');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('sys_menu');
    }
};
