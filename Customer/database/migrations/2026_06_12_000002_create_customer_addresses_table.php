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
        Schema::create('customer_addresses', function (Blueprint $table) {
            $table->id()->comment('主键ID');
            $table->string('nationality', 100)->nullable()->comment('国籍');
            $table->string('province', 100)->nullable()->comment('省份');
            $table->string('city', 100)->nullable()->comment('城市');
            $table->string('district', 100)->nullable()->comment('区县');
            $table->string('street_address', 500)->nullable()->comment('街道地址');
            $table->string('address_en', 500)->nullable()->comment('英文地址');
            $table->string('other_address', 500)->nullable()->comment('其他地址');
            $table->string('industrial_park', 255)->nullable()->comment('产业园区');
            $table->string('postal_code', 20)->nullable()->comment('邮政编码');
            $table->string('company_website', 255)->nullable()->comment('公司网站');
            $table->timestamps();

            // 索引
            $table->index('nationality');
            $table->index('province');
            $table->index('city');
            $table->index('district');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('customer_addresses');
    }
};
