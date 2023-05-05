<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

// LoginSystem Rotue
Route::get('login',function(){
    return view('login.login');
});
Route::get('register',function(){
    return view('login.register');
});
Route::get('forgot-password',function(){
    return view('login.forgot-password');
});
Route::get('recover-password',function(){
    return view('login.recover-password');
});
Route::get('dashboard',function(){
    return view('pages.dashboard');
});

// Sidebar Navbar Footer
Route::get('normal-sidebar',function(){
        return view('pages.dynamic-page',[
            'data'=> "layout-navbar-fixed  layout-footer-fixed"
        ]);
});
Route::get('fixed-sidebar',function(){
    return view('pages.dynamic-page',[
        'data'=> "layout-fixed layout"
    ]);
});
Route::get('normal-navbar',function(){
    return view('pages.dynamic-page',[
        'data'=> "layout-footer-fixed"
    ]);
});
Route::get('fixed-navbar',function(){
    return view('pages.dynamic-page',[
        'data'=> "layout-navbar-fixed"
    ]);
});