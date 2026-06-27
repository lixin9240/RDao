<?php
// 工业园区表
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
        Schema::create('sys_industrial_park', function (Blueprint $table) {
            $table->id()->comment('主键ID');
            $table->unsignedInteger('sort_order')->default(0)->comment('排序权重');
            $table->string('park_name', 100)->comment('园区名称');
            $table->string('park_code', 50)->nullable()->comment('园区编码');
            $table->string('address', 255)->nullable()->comment('园区地址');
            $table->string('contact_person', 50)->nullable()->comment('联系人');
            $table->string('contact_phone', 20)->nullable()->comment('联系电话');
            $table->string('description', 255)->nullable()->comment('描述');
            $table->unsignedTinyInteger('status')->default(1)->comment('状态：1-有效，0-无效');
            $table->timestamps();
            $table->unsignedBigInteger('updated_by')->nullable()->comment('更新人ID');

            // 索引
            $table->index('park_code');
            $table->index('status');
            $table->index('sort_order');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('sys_industrial_park');
    }
};
