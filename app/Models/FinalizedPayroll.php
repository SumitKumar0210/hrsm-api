<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;


class FinalizedPayroll extends Model
{
    protected $fillable = [
       'month',
       'year',
       'total_amount',
       'pf_amount',
       'esic_amount',
       'action_by',
       'date_time',
       'attendance_approval_status',
       'pf_calculation_status',
       'esic_calculation_status',
       'payslip_generation_status',
       'compliance_status',
       'management_approval_status',
    ];
}