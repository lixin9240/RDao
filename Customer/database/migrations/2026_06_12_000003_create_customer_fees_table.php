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
        Schema::create('customer_fees', function (Blueprint $table) {
            $table->id()->comment('主键ID');
            $table->string('account_name', 255)->nullable()->comment('开户名称');
            $table->string('bank_name', 255)->nullable()->comment('开户银行');
            $table->string('bank_account', 50)->nullable()->comment('银行账号');
            $table->string('invoice_address', 500)->nullable()->comment('开票地址');
            $table->string('invoice_phone', 20)->nullable()->comment('开票电话');
            $table->string('taxpayer_type', 50)->nullable()->comment('一般纳税人');
            $table->string('billing_address', 500)->nullable()->comment('账单地址');
            $table->timestamps();

            // 索引
            $table->index('account_name');
            $table->index('bank_account');
            $table->index('taxpayer_type');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('customer_fees');
    }
};
