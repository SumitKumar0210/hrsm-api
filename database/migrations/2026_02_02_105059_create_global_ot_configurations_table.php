<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('global_ot_configurations', function (Blueprint $table) {

            // Single-row configuration table
            $table->id();

            $table->boolean('is_ot_applicable')
                  ->default(false)
                  ->comment('Enable/Disable OT globally');

            // Base hourly salary calculation
            $table->decimal('employee_base_hourly_rate', 10, 2)
                  ->default(0);

            // OT % over base hourly rate
            $table->decimal('employee_ot_percentage', 5, 2)
                  ->default(0)
                  ->comment('e.g. 50% extra');

            // Final OT hourly rate (optional override)
            $table->decimal('ot_hourly_rate', 10, 2)
                  ->default(0);

            // Maximum OT hours allowed per day
            $table->decimal('ot_hours_worked', 5, 2)
                  ->default(0);

            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('global_ot_configurations');
    }
};
