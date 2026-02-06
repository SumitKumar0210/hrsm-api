<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('employee_shift_logs', function (Blueprint $table) {
            $table->id(); // bigint unsigned

            $table->unsignedBigInteger('employee_id');

            // Stored as string because source may vary (manual / device / system)
            $table->string('check_in')->nullable();
            $table->string('check_out')->nullable();

            // User/Admin who performed the action
            $table->unsignedBigInteger('action_by')->nullable();

            $table->timestamps();
            $table->softDeletes();

            // Foreign keys (enable later)
            // $table->foreign('employee_id')->references('id')->on('employees')->onDelete('cascade');
            // $table->foreign('action_by')->references('id')->on('users')->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('employee_shift_logs');
    }
};
