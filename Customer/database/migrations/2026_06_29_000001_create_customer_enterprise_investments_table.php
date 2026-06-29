<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('customer_enterprise_investments', function (Blueprint $table) {
            $table->id()->comment('主键ID');
            $table->foreignId('customer_id')->comment('客户ID')->index();
            $table->unsignedSmallInteger('year')->comment('年份，如2025');

            $table->boolean('has_audit_report')->nullable()->comment('是否有审计报告');
            $table->boolean('has_imported_equipment')->nullable()->comment('是否有进口设备');
            $table->boolean('has_investment_filing')->nullable()->comment('是否有投资备案表');
            $table->decimal('rd_equipment_original_value', 15, 2)->nullable()->comment('研发设备原值');
            $table->decimal('asset_liability_ratio', 5, 2)->nullable()->comment('资产负债率(%)');
            $table->decimal('fixed_asset_investment', 15, 2)->nullable()->comment('固定资产投资');
            $table->decimal('equipment_investment', 15, 2)->nullable()->comment('设备投资');
            $table->decimal('smart_equipment_investment', 15, 2)->nullable()->comment('智能设备投资');
            $table->decimal('rd_equipment_investment', 15, 2)->nullable()->comment('研发设备投资');
            $table->decimal('informatization_investment', 15, 2)->nullable()->comment('信息化投资');
            $table->decimal('filing_amount', 15, 2)->nullable()->comment('备案金额');
            $table->date('filing_start_date')->nullable()->comment('备案开始日期');
            $table->date('filing_end_date')->nullable()->comment('备案结束日期');
            $table->unsignedBigInteger('created_by')->nullable()->comment('创建人');
            $table->unsignedBigInteger('updated_by')->nullable()->comment('更新人');
            $table->timestamps();
            $table->index('year');
            $table->unique(['customer_id', 'year']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('customer_enterprise_investments');
    }
};
