<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('documents', function (Blueprint $table) {
            $table->id(); // bigint unsigned

            $table->unsignedBigInteger('employee_id');

            $table->enum('document_type', [
                'aadhar',
                'pan',
                'resume',
                'offer_letter',
                'appointment_letter',
                'experience_letter',
                'other'
            ]);

            $table->string('file_path');

            $table->timestamps();
            $table->softDeletes();

            // Foreign key (enable after employees table)
            // $table->foreign('employee_id')->references('id')->on('employees')->onDelete('cascade');

            // Prevent duplicate document type per employee
            $table->unique(['employee_id', 'document_type']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('documents');
    }
};
