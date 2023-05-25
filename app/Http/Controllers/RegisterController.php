<?php

namespace App\Http\Controllers;
use App\Models\RegisterModel;
use App\Models\User;
use Illuminate\Http\Request;

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
        $save = User::create($data);
        if($save){
            return redirect("/login")->with('successLogin','');
        }
    }
}
