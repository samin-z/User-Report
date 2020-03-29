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

    private function search_filter($request)
    {
        $que = Report::orderBy('id','DESC');

        if($request->input('date_start'))
        {

            $date_start = date('Y-m-d',strtotime($request->input('date_start')));

            if($request->input('date_end'))
                $date_end = date('Y-m-d',strtotime($request->input('date_end')));
            else
                $date_end = date('Y-m-d');
            if($date_start > $date_end)
                exit("Start Date can't be bigger than End date!");

            $que = $que->whereBetween('created_at',[$date_start,$date_end]);

        }

        return $que;
    }
    function index(Request $request)
    {
        if(!Auth::user()->is_admin)
            abort(403);

        $que = $this->search_filter($request);

        // "paginate" is used for reading bulk records from database which helps with pagination
        $reports = $que->paginate(15);
        return view('cp-index',['user'=>Auth::user(),'reports'=>$reports]);
    }

    function view($id)
    {
        $report = Report::findOrFail($id);
        return view('report-view',['report'=>$report]);
    }
}
