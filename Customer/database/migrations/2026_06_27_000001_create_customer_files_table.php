<?php
// 客户文件表
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
        Schema::create('customer_files', function (Blueprint $table) {
            $table->id()->comment('主键ID');
            $table->unsignedBigInteger('category_id')->comment('文件类型，关联 file_categories 表');
            $table->unsignedBigInteger('customer_id')->comment('客户名称，关联 customers 表');
            $table->unsignedBigInteger('salesperson_id')->comment('业务人员，关联 users 表');
            $table->text('remarks')->nullable()->comment('文件备注信息');
            $table->string('file_url', 255)->comment('文件存储路径或URL（如 OSS 地址）');
            $table->unsignedInteger('file_size')->nullable()->comment('文件大小，单位：字节 (Bytes)');
            $table->unsignedBigInteger('created_by')->comment('上传人/创建人ID，关联 users 表');
            $table->unsignedBigInteger('updated_by')->nullable()->comment('最后修改人ID，关联 users 表');
            $table->string('original_name', 255)->comment('文件名称');
            $table->timestamps();
            $table->softDeletes()->comment('软删除，防止误删');

            // 索引
            $table->index('category_id');
            $table->index('customer_id');
            $table->index('salesperson_id');
            $table->index('created_by');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('customer_files');
    }
};
