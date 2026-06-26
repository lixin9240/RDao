<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('applicant', function (Blueprint $table) {
            $table->id()->comment('主键ID');
            $table->unsignedBigInteger('customer_id')->comment('关联客户ID');
            $table->string('customer_name', 100)->comment('客户名称');
            $table->string('customer_code', 50)->nullable()->comment('客户代码');
            $table->string('customer_no', 50)->nullable()->comment('客户编号');
            $table->string('applicant_name_cn', 100)->comment('申请人中文名称');
            $table->string('applicant_name_en', 200)->nullable()->comment('申请人英文名称');
            $table->string('applicant_no', 50)->unique()->comment('申请人编号');
            $table->string('applicant_type', 50)->comment('申请人类型');
            $table->string('entity_type', 50)->comment('实体类型');
            $table->string('nationality', 50)->default('中国')->comment('国籍');
            $table->string('id_type', 50)->nullable()->comment('证件类型');
            $table->string('id_no', 50)->nullable()->comment('证件号码');
            $table->tinyInteger('fee_reduction_filing')->default(0)->comment('费减备案 0=否,1=是');
            $table->date('fee_reduction_start')->nullable()->comment('费减开始时间');
            $table->date('fee_reduction_end')->nullable()->comment('费减结束时间');
            $table->unsignedBigInteger('region_id')->nullable()->comment('行政区划ID');
            $table->string('street', 200)->nullable()->comment('街道详细地址');
            $table->string('business_address', 200)->nullable()->comment('经营地址');
            $table->string('address_en', 300)->nullable()->comment('英文地址');
            $table->string('zip_code', 10)->nullable()->comment('邮编');
            $table->string('email', 100)->nullable()->comment('邮箱');
            $table->string('phone', 20)->nullable()->comment('联系电话');
            $table->string('attorney_power_no', 50)->nullable()->comment('总委托书编号');
            $table->date('sync_date')->nullable()->comment('同步日期');
            $table->unsignedBigInteger('operator_id')->nullable()->comment('业务人员ID');
            $table->text('applicant_remark')->nullable()->comment('备注');
            $table->string('create_by', 50)->nullable()->comment('创建人');
            $table->datetime('create_time')->useCurrent()->comment('创建时间');
            $table->string('update_by', 50)->nullable()->comment('更新人');
            $table->datetime('update_time')->nullable()->useCurrentOnUpdate()->comment('更新时间');
            $table->tinyInteger('is_deleted')->default(0)->comment('逻辑删除 0=正常,1=删除');

            $table->index('customer_id');
            $table->index('applicant_name_cn');
            $table->index('region_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('applicant');
    }
};