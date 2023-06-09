<?php
use Illuminate\Foundation\Auth\EmailVerificationRequest;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\CommentController;
use App\Http\Controllers\RegisterController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\LikeController;
use App\Models\Category;
use App\Models\Comment;
use App\Models\Post;
use App\Models\User;
use Illuminate\Contracts\Session\Session;
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
Route::get('/login',[LoginController::class,'load'])->middleware('guest')->name('login');

Route::post('login',[LoginController::class,'check'])->middleware('guest');

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
    return view('pages.dashboard',['posts'=> Post::count(),'comments'=>Comment::count()]);
})->middleware('auth')
->name('dashboard');

//Users , Category , roles Routes
Route::middleware('auth')->group(function () {
    Route::resource('categories',CategoryController::class)->middleware(['category']);
    Route::resource('posts',PostController::class)->middleware(['post']);
    Route::resource('users',UserController::class)->middleware(['user']);
    Route::resource('roles',RoleController::class)->middleware(['role']);
    Route::resource('likes',LikeController::class);

    Route::post('/updateCategoryStatus/{category}',[CategoryController::class,'updateStatus'])
        ->middleware(['category']);
    //update post status
    Route::post('/updatePostStatus/{post}',[PostController::class,'updateStatus'])
        ->middleware(['post']);
    //update status of roles
    Route::post('/updateStatus',[UserController::class,'updateStatus'])
        ->middleware(['user']);
    //update status of permission
    Route::post('/updatePermission/{id}',[RoleController::class,'updatePermission'])
        ->middleware(['role']);
});


Route::resource('comments',CommentController::class);
//update catregory status


Route::get('error',function(){
return view('errors.403');
});

Route::get('publish-notify', [UserController::class, 'index']);

// Route::get('/verify/{user}',function(User $user){
//     return view('verify',compact('user'));
// });
// Route::get('/verifyaccount/{user}',function(User $user){

//     return redirect("/login")->with('successLogin','');
// });


Route::get('/email/verify', function () {
    return view('auth.verify-email');
})->name('verification.notice');


Route::get('/email/verify/{id}/{hash}', function (EmailVerificationRequest $request) {
    $request->fulfill();
    // [PostController::class, 'show'];
    return redirect('/');
})->middleware('signed')->name('verification.verify');
