<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('payrolls', function (Blueprint $table) {
            $table->id(); // bigint unsigned

            $table->unsignedBigInteger('employee_id');

            // Payroll month (e.g. 2025-01)
            $table->string('month', 7);

            $table->decimal('gross_salary', 12, 2);
            $table->decimal('deductions', 12, 2)->default(0);
            $table->decimal('net_salary', 12, 2);

            $table->enum('status', [
                'generated',
                'processed',
                'paid'
            ])->default('generated');

            $table->timestamps();
            $table->softDeletes();

            // Prevent duplicate payroll for same employee & month
            $table->unique(['employee_id', 'month']);

            // Foreign key (enable after employees table)
            // $table->foreign('employee_id')->references('id')->on('employees')->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('payrolls');
    }
};
