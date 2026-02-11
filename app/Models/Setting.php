<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Setting extends Model
{
    // use SoftDeletes;

    protected $fillable = [
        'logo',
        'favicon',
        'application_name',
        'about',
        'theme_color',
        'copyright',
        'powered_by',
        'contact',
        'email',
        'address',
        'api_key',
        'city',
        'state',
        'country',
        'zip',
        'short_description',
    ];
}
