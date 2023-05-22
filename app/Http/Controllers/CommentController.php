<?php

namespace App\Http\Controllers;

use App\Models\Comment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CommentController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $comments = Comment::all();
        return view('comments.index',compact('comments'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {

    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'comment'=> 'required'
        ]);
        // $data['user_id'] = Auth::id();
        $data['body'] = $request->input('comment');
        $data['post_id'] = $request->input('post_id');
        $comment = Comment::create($data);
        $comment->user()->attach([Auth::id()]);
        // $comment->user_comment()->attch(Auth::id(),$comment->id);
        // Auth::id()->
        return redirect()->back()->with('commentPost','');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Comment $comment)
    {
        return $comment;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Comment $comment)
    {
        // dd($request->all());
        $request->validate([
            'body'=> 'required'
        ]);

        $comment->body = $request->input('body');
        $comment->save();
        session()->flash('successComment', 'Comment Update.');

    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Comment $comment)
    {
        $comment->delete();
        session()->flash('successComment', 'Comment Delete.');
    }
}
