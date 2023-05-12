<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

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
            return redirect('/dashboard');
        }
        return back()
            ->withInput()
            ->withErrors('error', 'Invalid!');
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
