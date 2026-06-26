<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('customer_business', function (Blueprint $table) {
            $table->id()->comment('主键ID');
            $table->string('economy_category_code', 10)->comment('国民经济分类编码');
            $table->unsignedBigInteger('basic_id')->comment('关联客户基本信息表ID');
            $table->date('established_time')->nullable()->comment('成立时间');
            $table->unsignedInteger('employee_count')->nullable()->comment('员工人数');
            $table->decimal('registered_capital', 15, 2)->nullable()->comment('注册资本');
            $table->text('main_business_product')->nullable()->comment('主营业务产品');
            $table->unsignedInteger('rd_personnel')->nullable()->comment('研发人数');
            $table->unsignedInteger('phd_count')->nullable()->comment('博士人数');
            $table->unsignedInteger('senior_engineer_count')->nullable()->comment('高工人数');
            $table->unsignedInteger('master_count')->nullable()->comment('硕士人数');
            $table->unsignedInteger('intermediate_engineer_count')->nullable()->comment('中工人数');
            $table->unsignedInteger('bachelor_count')->nullable()->comment('本科人数');
            $table->unsignedInteger('overseas_returnee_count')->nullable()->comment('海归人数');
            $table->text('business_scope')->nullable()->comment('营业范围');
            $table->timestamps();

            $table->index('basic_id');
            $table->index('economy_category_code');
            $table->index('established_time');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('customer_business');
    }
};