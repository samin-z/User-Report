<?php

namespace App\Http\Controllers;
use App\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;

class UserController extends Controller
{
    //

    function store(Request $request)
    {
        //this line was commented because it will not allow the rest of codes to work.
        //this command refrain users to post their report before or after friday
//        if(date('D') != 'Fri')
//            jerror('Users can Submit their Report on Friday!');

//        this line kind of works as a login page too, if user has submited a report before they dont need to fill in
//        all field necessery, only enter their email and can move to the next stage
        $user = User::where('email',$request->input('email'))->first();
        if(!$user)
        {
            $validator = Validator::make($request->all(), [
                'name'      => 'required|string|max:255',
                'last_name' => 'required|string|max:255',
                'email'     => 'required|string|email|max:255',
            ]);

            if ($validator->fails()) {
                jerror($validator);
            }

            $user           = new User();
            $user->email    = $request->input('email');
            $user->name     = $request->input('name');
            $user->last_name= $request->input('last_name');
            $user->password = Hash::make($request->input('email'));
            $user->save();
        }
        jok(['url'=>route('report_form',['id'=>$user->id])]);
    }
}
