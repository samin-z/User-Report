<?php

namespace App\Http\Controllers;

use App\Report;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class PanelController extends Controller
{
    //
    public function __construct()
    {
        $this->middleware('auth');
    }
    
    function index()
    {
        if(!Auth::user()->is_admin)
            abort(403);
        
        // "paginate" is used for reading bulk records from database which helps with pagination
        $reports = Report::orderBy('id','DESC')->paginate(15);
        return view('cp-index',['user'=>Auth::user(),'reports'=>$reports]);
    }

    function view($id)
    {
        $report = Report::findOrFail($id);
        return view('report-view',['report'=>$report]);
    }
}
