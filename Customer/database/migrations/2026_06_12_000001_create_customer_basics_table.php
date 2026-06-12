<?php

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
        Schema::create('customer_basics', function (Blueprint $table) {
            $table->id()->comment('主键ID');
            $table->string('customer_no', 50)->nullable()->comment('客户编号');
            $table->string('innovation_subject', 255)->nullable()->comment('创新主体');
            $table->string('innovation_subject_en', 255)->nullable()->comment('创新主体英文名称');
            $table->string('credit_code', 50)->nullable()->comment('信用代码');
            $table->string('legal_representative', 100)->nullable()->comment('法定代表人');
            $table->string('company_contact', 100)->nullable()->comment('公司负责人');
            $table->string('customer_level', 50)->nullable()->comment('客户等级');
            $table->string('customer_scale', 100)->nullable()->comment('客户规模');
            $table->string('creator', 100)->nullable()->comment('创建人');
            $table->decimal('price_index', 5, 2)->nullable()->comment('价格指数');
            $table->decimal('innovation_index', 5, 2)->nullable()->comment('创新指数');
            $table->unsignedInteger('contract_count')->nullable()->default(0)->comment('合同数量');
            $table->date('latest_contract_date')->nullable()->comment('最新合同日期');
            $table->text('remark')->nullable()->comment('客户资料备注');
            $table->timestamps();

            // 索引
            $table->index('customer_no');
            $table->index('innovation_subject');
            $table->index('credit_code');
            $table->index('customer_level');
            $table->index('customer_scale');
            $table->index('creator');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('customer_basics');
    }
};
