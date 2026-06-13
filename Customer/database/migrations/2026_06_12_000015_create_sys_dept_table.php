<?php
// 系统部门表
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
        Schema::create('sys_dept', function (Blueprint $table) {
            $table->id()->comment('主键ID');
            $table->unsignedBigInteger('parent_id')->default(0)->comment('父部门ID，顶级为0');
            $table->string('dept_name', 50)->comment('部门名称');
            $table->string('dept_code', 30)->unique()->comment('部门编码');
            $table->unsignedBigInteger('leader_id')->nullable()->comment('负责人ID');
            $table->string('description', 255)->nullable()->comment('部门描述');
            $table->text('remark')->nullable()->comment('备注');
            $table->unsignedTinyInteger('status')->default(1)->comment('状态：0-停用，1-正常');
            $table->timestamps();

            // 索引
            $table->index('parent_id');
            $table->index('leader_id');
            $table->index('status');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('sys_dept');
    }
};
