<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('inventor', function (Blueprint $table) {
            $table->id()->comment('主键ID');
            $table->unsignedBigInteger('customer_id')->comment('关联客户ID');
            $table->string('customer_name', 100)->comment('客户名称');
            $table->string('customer_no', 50)->nullable()->comment('客户编号');
            $table->string('name', 100)->comment('发明人姓名');
            $table->string('english_name', 100)->nullable()->comment('英文姓名');
            $table->string('inventor_no', 50)->unique()->comment('发明人编号');
            $table->string('nationality', 50)->default('中国')->comment('国籍');
            $table->string('id_type', 50)->default('身份证')->comment('证件类型');
            $table->string('id_no', 50)->nullable()->comment('证件号码');
            $table->string('phone', 20)->comment('手机号');
            $table->string('landline', 20)->nullable()->comment('座机');
            $table->string('wechat', 50)->nullable()->comment('微信号');
            $table->string('email', 100)->comment('邮箱');
            $table->unsignedBigInteger('region_id')->nullable()->comment('行政区划ID');
            $table->string('street_address', 200)->nullable()->comment('街道地址');
            $table->string('address_en', 300)->nullable()->comment('英文地址');
            $table->string('zip_code', 10)->nullable()->comment('邮编');
            $table->text('inventor_remark')->nullable()->comment('备注');
            $table->unsignedBigInteger('operator_id')->nullable()->comment('业务人员ID');
            $table->string('create_by', 50)->nullable()->comment('创建人');
            $table->datetime('create_time')->useCurrent()->comment('创建时间');
            $table->string('update_by', 50)->nullable()->comment('更新人');
            $table->datetime('update_time')->nullable()->useCurrentOnUpdate()->comment('更新时间');
            $table->tinyInteger('is_deleted')->default(0)->comment('逻辑删除 0=正常,1=删除');

            $table->index('customer_id');
            $table->index('name');
            $table->index('region_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('inventor');
    }
};