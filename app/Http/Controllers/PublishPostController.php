<?php

namespace App\Http\Controllers;

use App\Models\Post;
use App\Models\User;
use App\Notifications\PublishNotification;
use App\Notifications\VerifyAcc;
use Illuminate\Http\Request;

class PublishPostController extends Controller
{
    public function index(Post $post)
    {
        $user = $post->user;
        $data['id'] = $post->id;
        $user->notify(new PublishNotification($data));
    }

    public function verify(User $user)
    {
        $data['id'] = $user->id;
        $user->notify(new VerifyAcc($data));
    }
}
