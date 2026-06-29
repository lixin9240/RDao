<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('customer_rd_investments', function (Blueprint $table) {
            $table->id()->comment('主键ID');
            $table->unsignedBigInteger('basic_id')->comment('关联客户基础信息ID');
            $table->year('year')->comment('年份，如2025');
            $table->text('projects')->nullable()->comment('研发项目，多个项目逗号分隔');
            $table->decimal('amount', 15, 2)->nullable()->comment('项目金额');
            $table->timestamps();

            $table->index('basic_id');
            $table->unique(['basic_id', 'year']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('customer_rd_investments');
    }
};