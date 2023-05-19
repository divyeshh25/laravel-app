<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Spatie\Permission\Models\Role;


class LoginController extends Controller
{
    public function check()
    {
        $data = request()->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);
        // User::create($data);
        if (auth()->attempt($data)) {
            if(auth()->user()->hasRole('visitor'))
                return redirect('/');
            else
                return redirect('/dashboard');
        }
        return back()
            ->withInput()->withErrors(['Invalid'=>'Invalid Credentials']);
    }
    public function load()
    {
        return view('login.login');
    }
    public function destroy(){
        auth()->logout();
        return redirect('/');
    }
}
