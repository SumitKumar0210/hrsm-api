<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('leaves', function (Blueprint $table) {
            $table->id(); // bigint unsigned

            $table->unsignedBigInteger('employee_id');

            $table->string('leave_type'); 
            // e.g. sick, casual, paid, unpaid

            $table->date('from_date');
            $table->date('to_date');

            $table->decimal('total_days', 5, 2);
            // supports half-day (0.5)

            $table->text('reason')->nullable();

            $table->enum('status', [
                'pending',
                'approved',
                'rejected',
                'cancelled'
            ])->default('pending');

            $table->text('rejected_reason')->nullable();

            $table->timestamps();
            $table->softDeletes();

            // Foreign key (enable when employees table exists)
            // $table->foreign('employee_id')->references('id')->on('employees')->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('leaves');
    }
};
