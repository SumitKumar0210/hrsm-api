<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;


class EmployeeShiftLog extends Model
{
    use SoftDeletes;
    protected $table = "employee_shift_logs";

    protected $fillable = [
        'employee_id',
        'shift_id',
        'sign_in',
        'sign_out',
        'action_by',
        'status'
    ];

    
}