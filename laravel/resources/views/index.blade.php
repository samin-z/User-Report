@extends('master')
@section('main')
    <div class="card report-form  padding-zero" >
        {{csrf_field()}}
        <div class="card-header" style="font-weight: bold">
            Member Form
        </div>
        <div class="card-body">
            <ul class="report-ul">
                <li>
                    <label class="title">Report Date:</label>
                    <span>{{date('l , d-m')}}</span>
                </li>
                <li>
                    <label class="title">Name:</label>
                    <input class="form-control" data-id="name"/>
                </li>
                <li>
                    <label class="title">Last name:</label>
                    <input class="form-control" data-id="last_name"/>
                </li>
                <li>
                    <label class="title">Email:</label>
                    <input class="form-control" data-id="email"/>
                </li>
            </ul>
        </div>
    </div>
    <div>
        <button class="btn btn-danger pull-left submit-form" data-route="{{route('user_form_store')}}" style="margin-top: 15px">next stage</button>
    </div>
    <script>
        $(document).on('click' , '.submit-form' , function(){
            form = form_data('.report-form');
            var btn = $(this);
            loadspiner( btn);
            $.post( btn.data('route') , form , function(data){
                unloadspiner(btn);
                data = $.parseJSON(data);
                if(data.stat == 'ok')
                {
                    ok('Successful! move to Next Stage!');
                    document.location = data.url ;
                }
                else
                    er(data.msg);
            });
        });
    </script>
@endsection