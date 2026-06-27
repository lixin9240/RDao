<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('sys_user', function (Blueprint $table) {
            $table->unsignedBigInteger('role_id')->nullable()->after('dept_id')->comment('所属角色ID');
            $table->foreign('role_id')->references('id')->on('sys_role')->onDelete('set null');
            $table->index('role_id');
        });
    }

    public function down(): void
    {
        Schema::table('sys_user', function (Blueprint $table) {
            $table->dropForeign(['role_id']);
            $table->dropColumn('role_id');
        });
    }
};
