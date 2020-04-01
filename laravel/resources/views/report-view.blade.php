@extends('master')
@section('main')
    <div class="card report-form  padding-zero" >
        {{csrf_field()}}
        <div class="card-header bg-dark text-white" style="font-weight:bold;">
            Report Form
        </div>
        <div class="card-body">
            <ul class="report-ul">
                <li>
                    <label class="title">Report Date:</label>
                    <span>{{date("Y-m-d",strtotime($report->created_at))}}</span>
                </li>
                <li>
                    <label class="title">User:</label>
                    <span>{{$report->User->name}} {{$report->User->last_name}}</span>
                </li>
                <li>
                    <label class="title">Week Summary:</label>
                    <p >
                        {{$report->current_week}}
                    </p>
                </li>
                <li>
                    <label class="title" style="margin-bottom: 0px">Task(s) Done:</label>
                    @if(!$report->Task->isEmpty())
                        <ul class="cp-task-ul">
                            {{--$report->Task--}}
                            {{--through "report" model a relation is made with ReportTasks table--}}
                            {{--with foriegn key which is "report_id"--}}
                            {{--so $report->Task is actually an array of report tasks that their report_id is
                            equel to the intended report id--}}
                            {{--by going to Report.php file (model) in "app" folder you can see the--}}
                            {{--relation--}}
                            @foreach($report->Task as $task)
                                <li>{{$task->task}}</li>
                            @endforeach
                        </ul>
                    @else
                        <div class="alert alert-light" role="alert">
                            No task was added!
                        </div>
                    @endif
                </li>
                <li>
                    <label class="title">Next Week Summary: ({{date('d/m/y',strtotime($report->next_week_date))}})</label>
                    <p>
                        {{$report->next_week}}
                    </p>
                </li>
            </ul>
        </div>
    </div>
    <div>
        <a href="{{route('cp_index')}}" class="btn btn-success pull-left " style="margin-top: 15px"> Return to panel</a>
    </div>
@endsection
