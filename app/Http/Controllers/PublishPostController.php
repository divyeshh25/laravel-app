<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Notifications\PublishNotification;
use Illuminate\Http\Request;

class PublishPostController extends Controller
{
    public function index($id)
    {
        $user = User::role('admin')->first();
        $data['id'] = $id;
        $user->notify(new PublishNotification($data));
    }
}
