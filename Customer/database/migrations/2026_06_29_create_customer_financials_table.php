<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('customer_financials', function (Blueprint $table) {
            $table->id()->comment('主键ID');
            $table->unsignedBigInteger('basic_id')->comment('关联客户基本信息表ID');
            $table->decimal('sales_2025', 15, 4)->nullable()->comment('2025年度销售额(万元)');
            $table->decimal('sales_2024', 15, 4)->nullable()->comment('2024年度销售额(万元)');
            $table->decimal('sales_2023', 15, 4)->nullable()->comment('2023年度销售额(万元)');
            $table->decimal('rd_fee_2025', 15, 4)->nullable()->comment('2025年度研发费用(万元)');
            $table->decimal('rd_fee_2024', 15, 4)->nullable()->comment('2024年度研发费用(万元)');
            $table->decimal('rd_fee_2023', 15, 4)->nullable()->comment('2023年度研发费用(万元)');
            $table->decimal('loan_2025', 15, 4)->nullable()->comment('2025年度贷款(万元)');
            $table->decimal('loan_2024', 15, 4)->nullable()->comment('2024年度贷款(万元)');
            $table->decimal('loan_2023', 15, 4)->nullable()->comment('2023年度贷款(万元)');
            $table->string('creator', 50)->nullable()->comment('创建人');
            $table->timestamps();

            $table->unique('basic_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('customer_financials');
    }
};
