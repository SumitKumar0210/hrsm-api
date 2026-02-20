<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Payroll extends Model
{
    protected $fillable = [
        'employee_id',
        'month',
        'year',
        'present_days',
        'paid_leaves',
        'gross_salary',
        'deductions',
        'net_salary'
    ];
}