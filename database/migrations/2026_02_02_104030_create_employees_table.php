<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('employees', function (Blueprint $table) {
            $table->id(); // bigint unsigned

            $table->string('employee_code')->unique();
            $table->string('first_name');
            $table->string('last_name')->nullable();

            $table->string('mobile', 15)->unique();
            $table->string('email')->unique();

            $table->unsignedBigInteger('department_id');
            $table->unsignedBigInteger('shift_id')->nullable();

            $table->date('date_of_joining');

            // employment_type: 1 = Full Time, 2 = Part Time, 3 = Contract
            $table->tinyInteger('employment_type')
                  ->comment('1=Full Time, 2=Part Time, 3=Contract');

            $table->string('designation');

            $table->enum('status', ['active', 'inactive', 'terminated'])
                  ->default('active');

            $table->string('week_off')->nullable(); // e.g. Sunday / Sat-Sun

            $table->timestamps();
            $table->softDeletes();

            // Optional Foreign Keys (enable when tables exist)
            // $table->foreign('department_id')->references('id')->on('departments');
            // $table->foreign('shift_id')->references('id')->on('shifts');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('employees');
    }
};
