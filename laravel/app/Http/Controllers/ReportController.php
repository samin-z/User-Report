<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;

class ReportController extends Controller
{
    //
    function show($id)
    {
        $user = User::findOrFail($id);
        return view('report-form',['user'=>$user]);
    }
}
