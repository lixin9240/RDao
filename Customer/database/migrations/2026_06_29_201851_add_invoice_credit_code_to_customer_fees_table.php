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
        Schema::table('customer_fees', function (Blueprint $table) {
            $table->string('invoice_credit_code')->nullable()->comment('开票信用代码');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('customer_fees', function (Blueprint $table) {
            $table->dropColumn('invoice_credit_code');
        });
    }
};