<?php 
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;


class Attendance extends Model
{
    use SoftDeletes;
    protected $fillable = [
        'employee_id',
        'date',
        'sign_in',
        'sign_out',
        'total_hours',
        'status',
        'is_corrected'
    ];

    public function employees()
    {
        return $this->belongsTo(Employee::class, 'employee_id');
    }
}