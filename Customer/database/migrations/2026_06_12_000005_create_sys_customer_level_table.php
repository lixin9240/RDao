<?php
// 客户等级表
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
        Schema::create('sys_customer_level', function (Blueprint $table) {
            $table->id()->comment('主键ID');
            $table->unsignedInteger('sort_order')->default(0)->comment('排序权重');
            $table->string('level_name', 50)->comment('客户等级名称');
            $table->string('level_code', 20)->nullable()->comment('等级编码');
            $table->string('description', 255)->nullable()->comment('描述');
            $table->unsignedTinyInteger('status')->default(1)->comment('状态：1-有效，0-无效');
            $table->timestamps();
            $table->unsignedBigInteger('updated_by')->nullable()->comment('更新人ID');

            // 索引
            $table->index('level_code');
            $table->index('status');
            $table->index('sort_order');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('sys_customer_level');
    }
};
