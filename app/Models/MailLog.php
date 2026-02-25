<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MailLog extends Model
{
    protected $fillable = [
        'mail_type',
        'mailable_id',
        'mailable_type',
        'employee_id',
        'to_email',
        'subject',
        'status',
        'error_message',
        'sent_at',
    ];

    public function mailable()
    {
        return $this->morphTo();
    }

    public function employee()
    {
        return $this->belongsTo(Employee::class);
    }
}