<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title style="direction: rtl">digital infusion</title>
    <meta name="description" content="">
    <meta name="keywords" content="">
    <link type="text/css" rel="stylesheet" href="{{URL::asset('public/css/font-awesome.min.css')}}">
    <link type="text/css" rel="stylesheet" href="{{URL::asset('public/css/bootstrap.min.css')}}">
    <link type="text/css" rel="stylesheet" href="{{URL::asset('public/css/jquery.bxslider.css')}}">
    <link type="text/css" rel="stylesheet" href="{{URL::asset('public/css/jquery-ui-1.10.4.custom.min.css')}}">
    <link type="text/css" rel="stylesheet" href="{{URL::asset('public/css/jquery-ui/jquery-ui.css')}}">
    <link type="text/css" rel="stylesheet" media="screen" href="{{URL::asset('public/css/report.css')}}">

    <script src="{{URL::asset('public/js/jquery.js')}}"></script>
    <script src="{{URL::asset('public/js/jquery-migrate-1.2.1.min.js')}}"></script>
    <script src="{{URL::asset('public/js/bootstrap.js')}}"></script>
    <script src="{{URL::asset('public/js/global.js')}}"></script>
    <script src="{{URL::asset('public/js/script.js')}}"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
</head>

<body>

<div class="main-container padding-zero  col-12 col-md-8 offset-md-2">
    @yield('main')
</div>

{{--the result of "er" and "ok" functions are shown using these modals--}}
<div class="card"  id="error-toast">
    <div class="card-header" style="background-color: #ec475e ; color: black">
        Warning!

        <a href="javascript:void(0)" class="pull-right" onclick="$(this).parents('.card:first').fadeOut();">
            <i class="mdi mdi-window-close "><span aria-hidden="true">&times;</span></i>
        </a>

    </div>
    <div class="card-body" style="background-color: #ff5c73 ; color: black">


    </div>
</div>
<div class="card"  id="success-toast">
    <div class="card-header" style="background-color: #3acc7b ; color: black">
        Success!

        <a href="javascript:void(0)" class="pull-right" onclick="$(this).parents('.card:first').fadeOut();">
            <i class="mdi mdi-window-close"><span aria-hidden="true">&times;</span></i>
        </a>

    </div>
    <div class="card-body" style="background-color: #4dda8c ; color: black">

    </div>
</div>


</body>
</html>