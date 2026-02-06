<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Leave extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'employee_id',
        'leave_type',
        'from_date',
        'to_date',
        'total_days',
        'reason',
        'status',
        'rejected_reason',
    ];

    protected $casts = [
        'from_date' => 'date',
        'to_date'   => 'date',
    ];
}
