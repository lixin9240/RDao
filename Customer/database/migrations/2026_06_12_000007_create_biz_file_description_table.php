<?php
// 文件描述表（大类小类）
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
        Schema::create('biz_file_description', function (Blueprint $table) {
            $table->id()->comment('主键ID');
            $table->string('project_type', 50)->comment('项目类型');
            $table->string('country_code', 10)->comment('国家/地区代码');
            $table->unsignedBigInteger('file_category_id')->comment('文件大类ID');
            $table->unsignedBigInteger('file_subcategory_id')->comment('文件小类ID');
            $table->string('file_name_template', 255)->nullable()->comment('文件名称模板');
            $table->string('file_code_rule', 100)->nullable()->comment('文件编号规则');
            $table->string('internal_code', 50)->nullable()->comment('内部代码');
            $table->string('auth_role', 100)->nullable()->comment('授权角色');
            $table->unsignedInteger('sort_order')->default(0)->comment('排序权重');
            $table->unsignedTinyInteger('status')->default(1)->comment('状态：1-有效，0-无效');
            $table->timestamps();
            $table->unsignedBigInteger('updated_by')->nullable()->comment('更新人ID');

            // 索引
            $table->index('project_type');
            $table->index('country_code');
            $table->index('file_category_id');
            $table->index('file_subcategory_id');
            $table->index('status');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('biz_file_description');
    }
};
