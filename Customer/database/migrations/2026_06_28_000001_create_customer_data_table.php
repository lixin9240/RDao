<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('customer_data', function (Blueprint $table) {
            $table->id();
            // 国民经济分类
            $table->string('economy_category', 50)->nullable()->comment('国民经济门类');
            $table->string('economy_sub_category', 50)->nullable()->comment('国民经济小类');
            $table->string('economy_large_category', 50)->nullable()->comment('国民经济大类');
            $table->string('economy_mid_category', 50)->nullable()->comment('国民经济中类');
            // 销售额度
            $table->decimal('sales_2021', 18, 4)->nullable()->comment('2021年销售额度');
            $table->decimal('sales_2020', 18, 4)->nullable()->comment('2020年销售额度');
            $table->decimal('sales_2019', 18, 4)->nullable()->comment('2019年销售额度');
            // 研发费用
            $table->decimal('rd_fee_2021', 18, 4)->nullable()->comment('2021年研发费用');
            $table->decimal('rd_fee_2020', 18, 4)->nullable()->comment('2020年研发费用');
            $table->decimal('rd_fee_2019', 18, 4)->nullable()->comment('2019年研发费用');
            // 贷款
            $table->decimal('loan_2021', 18, 4)->nullable()->comment('2021年贷款');
            $table->decimal('loan_2020', 18, 4)->nullable()->comment('2020年贷款');
            $table->decimal('loan_2019', 18, 4)->nullable()->comment('2019年贷款');
            // 企业资质
            $table->boolean('tech_verified')->default(false)->comment('科技口是否验证');
            $table->boolean('is_high_tech')->default(false)->comment('高企');
            $table->boolean('is_provincial_enterprise')->default(false)->comment('省企');
            $table->boolean('is_municipal_enterprise')->default(false)->comment('市企');
            $table->boolean('is_engineering_center')->default(false)->comment('省级工程技术中心');
            // 其他指标
            $table->string('ip_index', 50)->nullable()->comment('知识产权指标');
            $table->string('integration_standard', 50)->nullable()->comment('两化融合贯标');
            // 审计字段
            $table->string('creator', 100)->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('customer_data');
    }
};
