<!DOCTYPE html>
<html lang="en">
<head>
    <title>Control panel | Report pdf</title>
    <meta charset="utf-8">
</head>
<body>
<div class="container" id="main-container">
    <style>
        .inner-table .inner-table th, .inner-table td
        {
            border: none !important;
            text-align: center !important;
        }
        table, th, td {
            border: 1px solid black;
            direction: rtl;
            font-size: 10px !important;
            font-weight: 100;
            text-align: right;
        }
        .td-span
        {
            display: inline-block; float: right;
            text-align: center  ;
        }
    </style>
    <table class="main-table" cellpadding="5px" style="width:100%">
        <tr>
            <td colspan="2" style="text-align: left">Report Date :  {{date("Y-m-d",strtotime($report->created_at))}}    </td>
            <td colspan="2" style="text-align: left"> User :  {{$report->User->last_name}} {{$report->User->name}}     </td>
        </tr>
        <tr>
            <td colspan="4" style="text-align: center;background-color: #f1f1f1; direction: ltr">
                 Week Summary
            </td>
        </tr>
        <tr>
            <td colspan="4" style="direction: ltr; text-align: left; line-height: 20px">
                {{$report->current_week}}
                @if($report->Task)
                    <br/>
                    <span>Task(s) Done:</span>
                    @foreach($report->Task as $task)
                        <br/>
                        {{$task->task}}
                    @endforeach
                @endif
            </td>
        </tr>
        <tr>
            <td colspan="4" style="text-align: center;background-color: #f1f1f1; direction: ltr">
                Next Week Summary | {{date("Y-m-d",strtotime($report->next_week_date))}}
            </td>
        </tr>
        <tr>
            <td colspan="4" style="direction: ltr; text-align: left; line-height: 20px">
                {{$report->next_week}}
            </td>
        </tr>

    </table>
</div>

</body>
</html>
