<?php

use App\Http\Controllers\CategoryController;
use App\Http\Controllers\RegisterController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\User;
use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Route;
use Symfony\Component\HttpFoundation\Response;
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

Route::get('/',[LoginController::class, 'load']);

// LoginSystem Rotue
Route::get('/login',[LoginController::class, 'load'])->name('login');
Route::post('login',[LoginController::class,'check']);


Route::get('register',function(){
    return view('login.register');
});
Route::post('register',[RegisterController::class,'store']);

Route::get('logout',[LoginController::class,'destroy']);

Route::get('forgot-password',function(){
    return view('login.forgot-password');
})->middleware('guest');
Route::get('recover-password',function(){
    return view('login.recover-password');
})->middleware('guest');
Route::get('dashboard',function(){
    return view('pages.dashboard');
})->middleware('auth')
->name('dashboard');

Route::group([
    'middleware' => ['auth','admin'],
], function () {
    Route::resources([
        'categories' => CategoryController::class,
        'users' => UserController::class,
        'roles' => RoleController::class
    ]);
});
Route::resource('posts',PostController::class);
Route::post('/updateStatus/{id}',[UserController::class,'updateStatus']);
Route::post('/updatePermission/{id}',[RoleController::class,'updatePermission']);

Route::get('/404',function(){
    return view('404');
});

