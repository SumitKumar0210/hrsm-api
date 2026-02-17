<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class EmployeeOTConfiguration extends Model
{
    use SoftDeletes;
    protected $table= 'employee_ot_configurations';
    protected $fillable = [
        'employee_id',
        'ot_rate',
        'min_time',
        'max_time',
        'status',
    ];

    public function employee()
    {
        return $this->belongsTo(Employee::class, 'employee_id');
    }

}
