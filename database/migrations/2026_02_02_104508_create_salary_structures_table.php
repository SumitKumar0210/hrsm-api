<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('salary_structures', function (Blueprint $table) {
            $table->id(); // bigint unsigned

            $table->unsignedBigInteger('employee_id');

            $table->decimal('basic_salary', 10, 2);
            $table->decimal('hra', 10, 2)->default(0);
            $table->decimal('medical', 10, 2)->default(0);
            $table->decimal('special_allowance', 10, 2)->default(0);

            // Per hour OT rate
            $table->decimal('overtime_rate', 8, 2)->default(0);

            $table->boolean('pf_applicable')->default(true);
            $table->boolean('esic_applicable')->default(false);

            $table->enum('status', ['active', 'inactive'])
                  ->default('active');

            // Statutory numbers
            $table->string('uan_number')->nullable();
            $table->string('esic_number')->nullable();

            $table->timestamps();
            $table->softDeletes();

            // One active salary structure per employee
            $table->unique(['employee_id', 'status']);

            // Foreign key (enable after employees table)
            // $table->foreign('employee_id')->references('id')->on('employees')->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('salary_structures');
    }
};
