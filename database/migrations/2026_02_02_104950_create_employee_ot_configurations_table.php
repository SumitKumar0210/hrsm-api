<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('employee_ot_configurations', function (Blueprint $table) {
            $table->id(); // bigint unsigned

            $table->unsignedBigInteger('employee_id');

            // OT rate per hour
            $table->decimal('ot_rate', 8, 2)->default(0);

            // Minimum & maximum OT time in hours
            $table->decimal('min_time', 5, 2)->default(0);
            $table->decimal('max_time', 5, 2)->default(0);

            $table->enum('status', ['active', 'inactive'])
                  ->default('active');

            $table->timestamps();
            $table->softDeletes();

            // One active OT config per employee
            $table->unique(['employee_id', 'status']);

            // Foreign key (enable later)
            // $table->foreign('employee_id')->references('id')->on('employees')->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('employee_ot_configurations');
    }
};
