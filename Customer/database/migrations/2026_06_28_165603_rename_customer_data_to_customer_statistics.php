<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::rename('customer_data', 'customer_statistics');
    }

    public function down(): void
    {
        Schema::rename('customer_statistics', 'customer_data');
    }
};
