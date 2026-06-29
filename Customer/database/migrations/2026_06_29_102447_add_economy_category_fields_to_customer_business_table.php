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
        Schema::table('customer_business', function (Blueprint $table) {
            $table->string('economy_category', 50)->nullable()->comment('国民经济行业分类-门类');
            $table->string('economy_large_category', 50)->nullable()->comment('国民经济行业分类-大类');
            $table->string('economy_mid_category', 50)->nullable()->comment('国民经济行业分类-中类');
            $table->string('economy_sub_category', 50)->nullable()->comment('国民经济行业分类-小类');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('customer_business', function (Blueprint $table) {
            $table->dropColumn(['economy_category', 'economy_large_category', 'economy_mid_category', 'economy_sub_category']);
        });
    }
};
