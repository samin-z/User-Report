@extends('master')
@section('main')
    <div class="card report-form  padding-zero" >
        {{csrf_field()}}
        <div class="card-header" style="font-weight: bold">
            Report Form
        </div>
        <div class="card-body">
            <ul class="report-ul">
                <li>
                    <label class="title">Report Date:</label>
                    <span>{{date('l , d-m')}}</span>
                </li>
                <li>
                    <label class="title">User:</label>
                    <span>{{$user->name}} {{$user->last_name}}</span>
                </li>
                <li>
                    <label class="title">Week Summary:</label>
                    <textarea class="form-control" data-id="week_summary"></textarea>
                </li>
                <li>
                    <label class="title">Task(s) Done:</label>
                    <i class="fa fa-plus-square pull-right add-task"></i>
                    <div class="tasks-wrapper">
                        <input class="form-control"/>
                    </div>
                </li>
                <li>
                    <label class="title">Next Week Summary: ({{date('d/m/y',strtotime("+7 day"))}})</label>
                    <textarea class="form-control" data-id="next_week"></textarea>
                </li>
            </ul>
        </div>
    </div>
    <div>
        <button class="btn btn-danger pull-left submit-report" data-route="{{route('report_form_store',['id'=>$user->id])}}" style="margin-top: 15px"> submit report</button>
    </div>

    <script>
        $(document).on('click' , '.add-task' , function(){
            $('.tasks-wrapper').append(`
                <input class="form-control" data-id="task-field" style="margin-top: 5px"/>
            `);
        });
    </script>
@endsection
