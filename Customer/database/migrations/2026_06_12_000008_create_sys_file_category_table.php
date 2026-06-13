<?php
// 文件分类表
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
        Schema::create('sys_file_category', function (Blueprint $table) {
            $table->id()->comment('主键ID');
            $table->unsignedInteger('sort_order')->default(0)->comment('排序权重');
            $table->string('name', 100)->comment('分类名称');
            $table->unsignedBigInteger('parent_id')->default(0)->comment('父级分类ID，顶级为0');
            $table->unsignedTinyInteger('level')->nullable()->comment('层级深度');
            $table->unsignedTinyInteger('status')->default(1)->comment('状态：1-有效，0-无效');
            $table->timestamps();
            $table->unsignedBigInteger('updated_by')->nullable()->comment('更新人ID');

            // 索引
            $table->index('parent_id');
            $table->index('level');
            $table->index('status');
            $table->index('sort_order');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('sys_file_category');
    }
};
