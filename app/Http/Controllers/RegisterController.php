<?php

namespace App\Http\Controllers;
use App\Models\RegisterModel;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Auth\Events\Registered;


class RegisterController extends Controller
{
    //
    public function store()
    {
        $data = request()->validate([
            'name'=>'required|min:2',
            'email'=>'required|email|unique:users,email',
            'password'=>'required|min:8|max:24|same:retype',
        ]);
        $user = User::create($data);
        auth()->login($user);
        event(new Registered($user));
        return view('notVerify');
        // app('App\Http\Controllers\PublishPostController')->verify($save);
        // if($save){
        //     if($save->verified == 0)
        //     {
        //         return view('notVerify');
        //     }
        // }
    }
}
