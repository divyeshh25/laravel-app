<?php

namespace App\Http\Controllers;

use App\Models\Like;
use App\Models\Post;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use PhpParser\Node\Expr\Cast\String_;

class LikeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        if (Auth()->user() != null) {
            $data = [
                'post_id' => $request->id,
                'user_id' => Auth::user()->id,
            ];
            if (Like::where($data)->exists()) {
                $data1 = Like::where($data)->first();
                Like::where($data)->delete();
                $data['status'] = $request->status;
                if ($data1->status != $data['status']) {
                    Like::create($data);
                }
                // Like::where($data)->update(['status'=>(Like::where($data)->first()->status == 0 ? 1 : 0)]);
            } else {
                $data['status'] = $request->status;
                Like::create($data);
            }
        }
        $post = Post::findOrFail($request->id);
        $like = count($post->likes->where('status','=','0'));
        $dislike = count($post->likes->where('status','=','1'));
        return compact('like','dislike');
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
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
