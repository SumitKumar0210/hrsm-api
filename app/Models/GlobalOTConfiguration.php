<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class GlobalOTConfiguration extends Model
{
    use SoftDeletes;
    protected $table= 'global_ot_configurations';
    protected $fillable = [
        'is_ot_applicable',
        'employee_base_hourly_rate',
        'employee_ot_percentage',
        'ot_hourly_rate',
        'ot_hours_worked',
    ];

}
