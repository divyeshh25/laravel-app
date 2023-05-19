<?php

use App\Http\Controllers\CategoryController;
use App\Http\Controllers\CommentController;
use App\Http\Controllers\RegisterController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\LikeController;
use App\Models\Category;
use App\Models\Post;
use App\Models\User;
use Illuminate\Support\Facades\Route;
use Spatie\Permission\Models\Role;
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

// Route::get('/',[LoginController::class, 'load']);
Route::get('/',[PostController::class, 'show']);

Route::get('about',function(){
    return view('about');
});

Route::get('contact',function(){
    return view('contact');
});

Route::get('author/{user}',function(User $user){
    return view('author',compact('user'));
});

Route::get('post/{post}',function(Post $post){

    return view('post',compact('post'));
});

Route::get('category/{category}',function(Category $category){
    return view('category',compact('category'));
});


//Mian Page Routes
Route::get('/login',[LoginController::class, 'load'])->name('login');

Route::post('login',[LoginController::class,'check']);

Route::get('register',function(){
    return view('login.register');
});


// Loginsystem Routes
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

//Users , Category , roles Routes

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
Route::resource('comments',CommentController::class);
Route::resource('likes',LikeController::class);

//update catregory status
Route::post('/updateCategoryStatus/{category}',[CategoryController::class,'updateStatus']);
//update post status
Route::post('/updatePostStatus/{post}',[PostController::class,'updateStatus']);
//update status of roles
Route::post('/updateStatus/{id}',[UserController::class,'updateStatus']);
//update status of permission
Route::post('/updatePermission/{id}',[RoleController::class,'updatePermission']);
