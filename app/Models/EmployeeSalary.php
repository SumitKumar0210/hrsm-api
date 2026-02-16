<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class EmployeeSalary extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'employee_id',
        'basic_salary',
        'hra',
        'medical',
        'special_allowance',
        'overtime_rate',
        'pf_applicable',
        'esic_applicable',
        'status',
        'uan_number',
        'esic_number',
        'effective_from',
        'previous_salary',
    ];

    public function employee(){
        return $this->belongsTo(Employee::class, 'employee_id','id');
    }
}
