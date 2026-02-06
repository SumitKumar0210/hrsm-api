<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('attendance', function (Blueprint $table) {
            $table->id(); // bigint unsigned

            $table->unsignedBigInteger('employee_id');

            $table->date('date');

            $table->dateTime('check_in')->nullable();
            $table->dateTime('check_out')->nullable();

            // Total working hours for the day
            $table->decimal('total_hours', 5, 2)->nullable();

            $table->enum('status', [
                'present',
                'absent',
                'half_day',
                'leave'
            ])->default('present');

            $table->enum('is_corrected', ['yes', 'no'])
                  ->default('no')
                  ->comment('manual correction applied or not');

            $table->timestamps();
            $table->softDeletes();

            // Foreign key (enable when employees table exists)
            // $table->foreign('employee_id')->references('id')->on('employees')->onDelete('cascade');

            // Prevent duplicate attendance entries
            $table->unique(['employee_id', 'date']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('attendance');
    }
};
