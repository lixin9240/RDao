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
            $table->boolean('is_general_taxpayer')->nullable()->default(false)->comment('是否一般纳税人');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('customer_fees', function (Blueprint $table) {
            $table->dropColumn('is_general_taxpayer');
        });
    }
};