<?php
// 客户企业表
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
        Schema::create('customer_enterprises', function (Blueprint $table) {
            $table->id()->comment('主键ID');
            $table->string('company_type', 100)->nullable()->comment('企业类型');
            $table->decimal('registered_capital', 15, 2)->nullable()->comment('注册资本');
            $table->date('established_date')->nullable()->comment('成立日期');
            $table->string('industry_category', 255)->nullable()->comment('行业分类');
            $table->text('main_business')->nullable()->comment('主营业务');
            $table->string('company_website', 255)->nullable()->comment('公司网址');
            $table->timestamps();

            // 索引
            $table->index('company_type');
            $table->index('industry_category');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('customer_enterprises');
    }
};
