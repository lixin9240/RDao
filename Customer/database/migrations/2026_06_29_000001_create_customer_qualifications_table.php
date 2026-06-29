<?php
// 客户资质表--创新主体详情页面
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
        Schema::create('customer_qualifications', function (Blueprint $table) {
            $table->id()->comment('主键ID');
            $table->unsignedBigInteger('customer_id')->comment('关联客户ID');

            // 经信口验收
            $table->boolean('is_economic_accepted')->default(false)->comment('经信口是否验收');
            $table->date('economic_accept_time')->nullable()->comment('经信口验收时间');

            // 科技口验收
            $table->boolean('is_tech_accepted')->default(false)->comment('科技口是否验收');
            $table->date('tech_accept_time')->nullable()->comment('科技口验收时间');

            // 高企
            $table->boolean('is_high_tech')->default(false)->comment('高企');
            $table->date('high_tech_time')->nullable()->comment('高企认定时间');

            // 省企
            $table->boolean('is_province_tech')->default(false)->comment('省企');
            $table->date('province_tech_time')->nullable()->comment('省企认定时间');

            // 市企
            $table->boolean('is_city_tech')->default(false)->comment('市企');
            $table->date('city_tech_time')->nullable()->comment('市企认定时间');

            // 省级工程技术中心
            $table->boolean('is_province_engineer_center')->default(false)->comment('省级工程技术中心');
            $table->date('province_engineer_center_time')->nullable()->comment('省级工程技术中心认定时间');

            // 知识产权贯标
            $table->boolean('is_ip_standard')->default(false)->comment('知识产权贯标');
            $table->date('ip_standard_time')->nullable()->comment('知识产权贯标认定时间');

            // 两化融合贯标
            $table->boolean('is_integration_standard')->default(false)->comment('两化融合贯标');
            $table->date('integration_standard_time')->nullable()->comment('两化融合贯标认定时间');

            $table->string('creator', 100)->nullable()->comment('创建人');
            $table->timestamps();

            // 索引
            $table->index('customer_id');
            $table->index('is_high_tech');
            $table->index('is_province_tech');
            $table->index('is_city_tech');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('customer_qualifications');
    }
};
