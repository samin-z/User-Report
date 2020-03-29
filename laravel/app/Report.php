<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Report extends Model
{
    //
    function User()
    {
        return $this->belongsTo('App\User');
    }

    function Task()
    {
        return $this->hasMany('App\ReportTask');
    }
}
