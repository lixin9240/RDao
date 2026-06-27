<?php
// 行业分类表
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
        Schema::create('sys_economy_category', function (Blueprint $table) {
            $table->id()->comment('主键ID');
            $table->unsignedBigInteger('parent_id')->default(0)->comment('父级ID，顶级为0');
            $table->string('category_code', 10)->comment('行业代码');
            $table->string('category_name', 100)->comment('行业名称');
            $table->unsignedTinyInteger('level')->comment('层级深度：1-门类，2-大类，3-中类，4-小类');
            $table->string('full_path', 255)->nullable()->comment('全路径名称');
            $table->unsignedInteger('sort_order')->default(0)->comment('排序权重');
            $table->unsignedTinyInteger('status')->default(1)->comment('状态：1-启用，0-停用');
            $table->timestamps();

            // 索引
            $table->index('parent_id');
            $table->index('category_code');
            $table->index('level');
            $table->index('status');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('sys_economy_category');
    }
};
