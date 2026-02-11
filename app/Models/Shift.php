<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Shift extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'name',
        'sign_in',
        'sign_out',
        'rotational_time',
        'status',
    ];

    // protected $casts = [
    //     'rotational_time' => 'boolean',
    // ];
    public function employeeShift()
    {
        return $this->hasMany(EmployeeShiftLog::class, 'shift_id', 'id');
    }
}
