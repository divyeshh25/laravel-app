<div class="container">
    <div class="be-comment-block">

        <h1 class="comments-title mt-3">Comments ({{ count($comments) }})</h1>
        @auth
            <form method="POST" action="{{ route('comments.store') }}" class="mb-4">
                @csrf
                <div class="form-group">
                    <label for="message">Post Your Comment</label>
                    <textarea name="comment" id="message" class="form-control"></textarea>
                    @error('comment')
                        <p class="text-danger text-sm-left">{{ $message }}</p>
                    @enderror
                </div>
                <button type="submit" name="post_id" value="{{ $post_id }}" id="StoreComment"
                    class="btn btn-primary ">Send Now</button>
            </form>
        @endauth
        @guest
            <label style="font-size:12px">You have the right to reply or like after <a href="/login"
                    style="font-size:16px">login</a></label>
        @endguest

        @foreach ($comments as $comment)
            @foreach ($comment->user as $user)
                <div class="be-comment">
                    <div class="be-img-comment">
                        <a href="blog-detail-2.html">
                            <img src="https://i.pravatar.cc/150?u={{ $user->id }}" alt=""
                                class="be-ava-comment">
                        </a>
                    </div>
                    <div class="be-comment-content">

                        <span class="be-comment-name">
                            <a>{{ Str::ucfirst($user->name) }}</a>
                        </span>
            @endforeach
            <span class="be-comment-time" style="color:#ce8460">
                <i class="fas fa-clock"></i>
                {{ $comment->created_at->diffForHumans() }}
            </span>

            <p class="be-comment-text">
                {{ $comment->body }}
            </p>
    </div>
</div>
@endforeach

</div>
</div>
