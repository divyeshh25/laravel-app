<?php

namespace App\Http\Controllers;

use App\Mail\PostMail;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;

class PostMailController extends Controller
{
    public function index($title,$email,$url)
    {
        $data = [
            'title' => 'Post Title: '. $title,
            'body' => 'Posted By: '. $email,
            'url' => $url
        ];
        Mail::to('admin@gmail.com')->send(new PostMail($data));
    }
}
