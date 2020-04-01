<?php

namespace App\Http\Controllers;

use App\Report;
use App\ReportTask;
use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ReportController extends Controller
{
    //
    function show($id)
    {
        $user = User::findOrFail($id);
        return view('report-form',['user'=>$user]);
    }

    function store(Request $request,$id)
    {

        $validator = Validator::make($request->all(), [
            'week_summary' => 'required|string',
            'next_week'    => 'required|string',
            'task_stack'   => 'required|array',
        ]);

        if ($validator->fails()) {
            jerror($validator);
        }

        $user = User::findOrFail($id);

        \DB::beginTransaction();
        try {
            $report = new Report();
            $report->user_id        = $user->id;
            $report->current_week   = $request->input('week_summary');
            $report->next_week      = $request->input('next_week');
            //create the date 7 days from the current date
            $report->next_week_date = date('Y-m-d',strtotime("+7 day"));
            $report->save();

            foreach($request->input('task_stack') as $ts)
            {
                if(empty($ts))
                    jerror("Task input can not be empty!");

                $task            = new ReportTask();
                $task->report_id = $report->id;
                $task->task      = $ts;
                $task->save();
            }
        }
        catch (\Exception $e )
        {
            \DB::rollBack();
            jerror($e->getMessage());
        }
        \DB::commit();
        jok(['url'=>route('index')]);
    }
}
