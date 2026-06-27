<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('customer_ip_rights', function (Blueprint $table) {
            $table->id();
            $table->integer('trademark_count')->default(0)->comment('商标数量/件');
            $table->integer('patent_count')->default(0)->comment('专利数量/件');
            $table->integer('authorized_invention_patent_count')->default(0)->comment('授权发明专利数量/件');
            $table->integer('copyright_count')->default(0)->comment('版权登记数量/件');
            $table->boolean('has_enjoyed_additional_deduction')->default(false)->comment('是否享受过加计扣除');
            $table->boolean('has_school_enterprise_cooperation')->default(false)->comment('是否有校企合作');
            $table->string('cooperative_university_name')->nullable()->comment('合作高校名称');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('customer_ip_rights');
    }
};
