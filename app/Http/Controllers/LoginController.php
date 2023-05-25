<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redirect;
use Spatie\Permission\Models\Role;


class LoginController extends Controller
{
    public function check()
    {

        $data = request()->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);
        if (auth()->attempt($data)) {
            if(auth()->user()->hasAnyRole(Role::all()))
                if(session()->has('url')){
                    $url = session()->get('url');
                    session()->forget('url');
                    return redirect($url);
                }else{
                    return redirect('/dashboard');
                }
            else{
                return redirect('/');
            }
        }
        return back()
            ->withInput()->withErrors(['Invalid'=>'Invalid Credentials']);
    }
    public function load()
    {
        $this->url = session()->get('url');
        return view('login.login');
    }
    public function destroy(){
        auth()->logout();
        return redirect('/');
    }
}
