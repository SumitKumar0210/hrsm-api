<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Shift extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'name',
        'check_in_timing',
        'check_out_timing',
        'default_time',
        'status',
    ];

    protected $casts = [
        'default_time' => 'boolean',
    ];
}
