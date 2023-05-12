<?php

namespace App\Http\Controllers;

use App\Http\Requests\BlogPost;
use App\Models\Category;
use App\Models\Post;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class PostController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $posts = Post::with('category','user')->get();
        return view('post.index',compact('posts'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $categories = Category::all();
        return view('post.create', compact('categories'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(BlogPost $request)
    {
        $request->all();
        // dd($request->file('addImg'));
        $imgName = $request->file('addImg')->getClientOriginalName();
        $request->file('addImg')->move(public_path('BlogImage'),$imgName);
        // dd($request->file('addImg')->extension());
        // $request->addImg->move(public_path('blogImage',$request->file('addImg')));
        Post::create([
            'title' => $request->addTitle,
            'excerpt' => $request->addExcerpt,
            'body' => $request->addBody,
            'status' => $request->addStatus,
            'title' => $request->addTitle,
            'category_id' => $request->addCat,
            'user_id' => Auth::user()->id,
            'image' => 'BlogImage/'.$imgName

        ]);
        session()->flash('successPost', "Post Added");
        $posts = Post::with('category','user')->get();
        return view('post.index',compact('posts'));
    }

    /**
     * Display the specified resource.
     */
    public function show(Post $post)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Post $post)
    {
        // $post = Post::findOrFail($post);
        $categories = Category::all();
        return view('post.edit',compact(['post','categories']));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Post $post)
    {
        $post->title = $request->editTitle;
        $post->excerpt = $request->editExcerpt;
        $post->body = $request->editBody;
        $post->status = $request->editStatus;
        $post->category_id = $request->editCat;
        $post->save();
        session()->flash('successPost', "Post Update");
        $posts = Post::with('category','user')->get();
        return redirect('/posts')->with(compact('posts'));
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Post $post)
    {
        $post->delete();
        session()->flash('successPost', "Post Delete");
    }
}
