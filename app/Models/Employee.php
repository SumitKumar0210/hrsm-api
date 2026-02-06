<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Employee extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'employee_code',
        'first_name',
        'last_name',
        'mobile',
        'email',
        'department_id',
        'shift_id',
        'date_of_joining',
        'employment_type',
        'designation',
        'status',
        'week_off',
    ];

    public function user(){
        return $this->hasOne(User::class, 'id','user_id');
    }
    public function department()
    {
        return $this->hasOne(Department::class, 'id','department_id');
    }
    public function shift()
    {
        return $this->hasOne(Shift::class, 'id','shift_id');
    }
}
