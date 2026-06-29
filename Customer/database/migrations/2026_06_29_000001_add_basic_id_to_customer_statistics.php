<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('customer_statistics', function (Blueprint $table) {
            $table->unsignedBigInteger('basic_id')->nullable()->comment('关联客户基本信息表ID');
            $table->foreign('basic_id')->references('id')->on('customer_basics')->onDelete('cascade');
            $table->index('basic_id');
        });
    }

    public function down(): void
    {
        Schema::table('customer_statistics', function (Blueprint $table) {
            $table->dropForeign(['basic_id']);
            $table->dropColumn('basic_id');
        });
    }
};
