@extends('master')
@section('main')
    <div class="card report-form  padding-zero" >
        {{csrf_field()}}
        <div class="card-header bg-dark text-white" >
            <span class="cp-header col-12 col-md-8">Control Panel | {{Auth::user()->name}} {{Auth::user()->last_name}}</span>
            <div class="pull-right" style="margin-left: 20px;">

                <a class="btn btn-light"  href="#" onclick="event.preventDefault();
                                                     document.getElementById('logout-form').submit();" aria-expanded="false">
                    <i class="fa fa-sign-out"></i>
                </a>
                <form id="logout-form" action="{{ route('logout') }}" method="POST" style="display: none;">
                    {{ csrf_field() }}
                </form>
            </div>
            <span class="pull-right" style="margin-top: 3px">{{date('Y-m-d')}}</span>
        </div>
        <div class="card-body">
            <form class="alert alert-light search-wrapper" method="get">
                <div class="col-md-8 col-12 pull-left">
                    <span class="item">From:</span><input type="text" name="date_start" value="{{Request::input('date_start')}}" class="datepicker item">
                    <span class="item">To:</span><input type="text" name="date_end" value="{{Request::input('date_end')}}"  class="datepicker item">
                </div>
                <div class="col-md-2 col-12 pull-left">
                    <button type="submit" class="col-xs-12 btn btn-danger btn-search item"><i class="fa fa-search-plus"></i></button>
                </div>
                <br style="clear: both"/>
            </form>
            @if(!$reports->isEmpty())
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">User</th>
                                <th scope="col">Submit Date</th>
                                <th scope="col">View</th>
                                <th scope="col">Download</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($reports as $k=>$u_report)
                                <tr>
                                    <th scope="row">{{$k+1}}</th>
                                    <td>{{$u_report->User->name}} {{$u_report->User->last_name}}</td>
                                    <td>{{date("Y-m-d",strtotime($u_report->created_at))}}</td>
                                    <td><a href="{{route('cp_report_view',['id'=>$u_report->id])}}">view</a></td>
                                    <td><a href="{{route('cp_report_download',['id'=>$u_report->id])}}">PDF</a> </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                    <nav aria-label="Page navigation example " id="custom-navigation">
                        {{$reports->links()}}
                    </nav>
                </div>
            @else
                <div class="alert alert-warning" role="alert">
                    No report has been submited yet!
                </div>
            @endif
        </div>
    </div>
    <script>
        $( function() {
            $('.datepicker').datepicker({ dateFormat: 'yy-mm-dd' }).val();
        } );
    </script>
@endsection
