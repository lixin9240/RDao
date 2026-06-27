<?php
// 联系人表
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
        Schema::create('customer_contacts', function (Blueprint $table) {
            $table->id()->comment('主键ID');
            $table->unsignedBigInteger('innovation_entity_id')->comment('创新主体，关联 innovation_entities 表');
            $table->string('contact_type', 50)->comment('联系人类型');
            $table->string('name', 255)->comment('联系人姓名');
            $table->string('phone', 20)->comment('手机号');
            $table->string('landline', 20)->nullable()->comment('座机');
            $table->boolean('is_active')->comment('是否在职');
            $table->string('position', 10)->nullable()->comment('职位');
            $table->string('email', 255)->nullable()->comment('邮箱');
            $table->unsignedBigInteger('sales_rep_id')->nullable()->comment('业务人员，关联 users 表');
            $table->unsignedBigInteger('sales_assistant_id')->nullable()->comment('业务助理，关联 users 表');
            $table->string('tech_lead_dept', 255)->nullable()->comment('技术主导部门');
            $table->unsignedBigInteger('tech_lead_id')->nullable()->comment('技术主导，关联 users 表');
            $table->text('work_address')->nullable()->comment('工作地址');
            $table->longText('notes')->nullable()->comment('备注');
            $table->unsignedBigInteger('created_by')->nullable()->comment('创建人ID，关联 users 表');
            $table->unsignedBigInteger('updated_by')->nullable()->comment('更新人ID，关联 users 表');
            $table->timestamps();

            // 索引
            $table->index('innovation_entity_id');
            $table->index('contact_type');
            $table->index('name');
            $table->index('phone');
            $table->index('sales_rep_id');
            $table->index('sales_assistant_id');
            $table->index('tech_lead_id');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('customer_contacts');
    }
};
