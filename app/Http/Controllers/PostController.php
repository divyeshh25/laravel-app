<?php

namespace App\Http\Controllers;

use App\Http\Requests\BlogPost;
use App\Models\Category;
use App\Models\Post;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

use function PHPUnit\Framework\isEmpty;

class PostController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $posts = Post::with('category', 'user')->get();
        return view('post.index', compact('posts'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $categories = Category::where('status', '=', '0')->get();
        return view('post.create', compact('categories'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(BlogPost $request)
    {
        $request->all();
        $imgName = $request->file('addImg')->getClientOriginalName();
        $request->file('addImg')->move(public_path('BlogImage'), $imgName);
        Post::create([
            'title' => $request->addTitle,
            'excerpt' => $request->addExcerpt,
            'body' => $request->addBody,
            'status' => $request->addStatus,
            'title' => $request->addTitle,
            'category_id' => $request->addCat,
            'user_id' => Auth::user()->id,
            'image' => 'BlogImage/' . $imgName,
        ]);
        session()->flash('successPost', 'Post Added');
        $posts = Post::with('category', 'user')->get();
        return view('post.index', compact('posts'));
    }

    /**
     * Display the specified resource.
     */
    public function show(Post $post)
    {
        if (isset($_GET['search'])) {
            $posts = Post::where('body', 'LIKE', '%' . $_GET['search'] . '%')
                ->with('user', 'category')
                ->where('status', '0')
                ->orderBy('updated_at', 'desc')
                ->get();
        } else {
            $posts = Post::with('user', 'category')
                ->where('status', '0')
                ->orderBy('updated_at', 'desc')
                ->get();
        }
        $categories = Category::with('posts')
            ->where('status', '0')
            ->get();
        if (count($posts) == 0) {
            session()->flash('NoPost', 'No Post Found');
            $posts = Post::with('user', 'category')
                ->where('status', '0')
                ->orderBy('updated_at', 'desc')
                ->get();
        }
        return view('index', compact('posts', 'categories'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Post $post)
    {
        // $post = Post::findOrFail($post);
        $categories = Category::where('status', '=', '0')->get();
        return view('post.edit', compact(['post', 'categories']));
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
        if ($request->has('editImg')) {
            $imgName = $request->file('editImg')->getClientOriginalName();
            $request->file('editImg')->move(public_path('BlogImage'), $imgName);
            $post->image = 'BlogImage/' . $imgName;
        }
        $post->save();
        session()->flash('successPost', 'Post Update');
        $posts = Post::with('category', 'user')->get();
        return redirect('/posts')->with(compact('posts'));
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Post $post)
    {
        $post->delete();
        session()->flash('successPost', 'Post Delete');
    }

    public function updateStatus(Post $post)
    {
        $post->update(['status' => request()->status]);
    }
}
