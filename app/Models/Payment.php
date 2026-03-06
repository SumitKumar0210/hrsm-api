<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;


class Payment extends Model
{
    use SoftDeletes;
    protected $fillable = [
        'payroll_id',
        'amount',
        'due',
        'mode',
        'date',
        'transaction_id',
        'remarks',
        'action_by',
    ];
}