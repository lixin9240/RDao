<?php
// 位置区域表
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
        Schema::create('sys_location_region', function (Blueprint $table) {
            $table->id()->comment('主键ID');
            $table->unsignedBigInteger('parent_id')->default(0)->comment('父级区域ID，顶级为0');
            $table->string('region_name', 100)->comment('区域名称');
            $table->unsignedTinyInteger('region_type')->comment('区域类型：1-省份，2-城市，3-区县，4-园区/功能区');
            $table->string('region_code', 20)->nullable()->comment('区域编码');
            $table->unsignedTinyInteger('level')->nullable()->comment('层级深度：1(省)-2(市)-3(区)-4(园区)');
            $table->unsignedTinyInteger('status')->default(1)->comment('状态：1-有效，0-无效');
            $table->unsignedInteger('sort_order')->default(0)->comment('排序权重');
            $table->timestamps();

            // 索引
            $table->index('parent_id');
            $table->index('region_type');
            $table->index('region_code');
            $table->index('level');
            $table->index('status');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('sys_location_region');
    }
};
