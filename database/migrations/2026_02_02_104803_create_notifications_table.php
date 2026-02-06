<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('notifications', function (Blueprint $table) {
            $table->id(); // bigint unsigned

            // Can be employee or user
            $table->unsignedBigInteger('notifiable_id');
            $table->enum('notifiable_type', ['employee', 'user']);

            $table->text('message');

            $table->boolean('is_read')->default(false);

            $table->timestamps();
            $table->softDeletes();

            // Index for fast notification fetch
            $table->index(['notifiable_id', 'notifiable_type']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('notifications');
    }
};
