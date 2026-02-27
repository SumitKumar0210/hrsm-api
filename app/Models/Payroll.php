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
        'net_salary',
        'overtime',
        'basic_amount',
        'hra_allowance',
        'conveyance_allowance',
        'medical_allowance',
        'special_allowance',
        'pf_amount',
        'esic_amount',
        'is_mail_sent',
        'mail_sent_at',
    ];
}