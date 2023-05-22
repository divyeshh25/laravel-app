<!DOCTYPE html>

<!--
 // WEBSITE: https://themefisher.com
 // TWITTER: https://twitter.com/themefisher
 // FACEBOOK: https://www.facebook.com/themefisher
 // GITHUB: https://github.com/themefisher/
-->

<html lang="en-us">

<head>
    <meta charset="utf-8">
    <title>Post</title>

    <!-- mobile responsive meta -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=5">
    <meta name="description" content="This is meta description">
    <meta name="author" content="Themefisher">

    <!-- plugins -->
    <link rel="preload" href="https://fonts.gstatic.com/s/opensans/v18/mem8YaGs126MiZpBA-UFWJ0bbck.woff2"
        style="font-display: optional;">
    <link rel="stylesheet" href="/plugins/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
        integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css?family=Montserrat:600%7cOpen&#43;Sans&amp;display=swap" media="screen">

    <link rel="stylesheet" href="/plugins/themify-icons/themify-icons.css">
    <link rel="stylesheet" href="/plugins/slick/slick.css">

    <!-- Main Stylesheet -->
    <link rel="stylesheet" href="/css/style.css">
    <link href="/toastr/build/toastr.min.css" rel="stylesheet" type="text/css">
    <!--Favicon-->
    <link rel="shortcut icon" href="images/favicon.png" type="image/x-icon">
    <link rel="icon" href="/images/favicon.png" type="image/x-icon">
</head>

<body>
    <!-- navigation -->
    <header class="sticky-top bg-white border-bottom border-default">
        <div class="container">
            <x-main.main-nav />
        </div>
    </header>
    <!-- /navigation -->

    <section class="section">
        <div class="container">

            <article class="row mb-4">
                <div class="col-lg-10 mx-auto mb-4">
                    <a href="/" class="be-comment-time" style="font-size:14px"><i
                            class="ti-angle-left"></i>Back</a>
                    <h1 class="h2 mb-3">{{ $post->excerpt }}</h1>
                    <ul class="list-inline post-meta mb-3">
                        <li class="list-inline-item"><i class="ti-user mr-2"></i><a
                                href="/author/{{ $post->user->id }}">{{ Str::ucfirst($post->user->name) }}</a>
                        </li>
                        <li class="list-inline-item">Date : {{ $post->updated_at->format('F j, Y') }}</li>
                        <li class="list-inline-item">Categories : <a href="/category/{{ $post->category->id }}"
                                class="ml-1">{{ $post->category->name }}
                            </a>
                        </li>
                        <li class="list-inline-item">Tags : <a href="/category/{{ $post->category->id }}"
                                class="ml-1">{{ $post->category->name }}
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="col-12 mb-3">
                    <div class="post-slider">
                        <img src="{{ asset($post->image) }}" class="img-fluid" alt="post-thumb">
                    </div>
                </div>
                <div class="col-lg-10 mx-auto">
                    <div class="content">
                        <h1 id="heading-1">{{ $post->title }}</h1>
                        <hr>
                        <h5 id="paragraph">Main Content</h5>
                        <p>{!! $post->body !!}</p>
                        <hr>
                        <h3 id="blockquote" style="text-align:right;">
                            <span>
                                <button class="btn btn-success" id="like">
                                    <i class="fa fa-thumbs-up fa-lg" aria-hidden="true"></i>
                                    {{ count($post->likes->where('status', 0)) }}
                                </button>
                                <button class="btn btn-danger" id="dislike">
                                    <i class="fa fa-thumbs-down fa-lg" aria-hidden="true"></i>
                                    {{ count($post->likes->where('status', 1)) }}
                                </button>
                            </span>

                        </h3>
                        <blockquote style="background-color:white">
                            <x-comment :data="$post->comments->reverse()" :postid='$post->id' />
                        </blockquote>
                        <hr>
                        {{-- <h5 id="youtube-video">Youtube video</h5>
                        <div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden;">
                            <iframe src="https://www.youtube.com/embed/C0DPdy98e4c"
                                style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border:0;"
                                allowfullscreen title="YouTube Video"></iframe>
                        </div> --}}
                    </div>
                </div>
            </article>
        </div>
    </section>

    <x-main.main-footer />


    <!-- JS Plugins -->
    <script src="/plugins/jquery/jquery.min.js"></script>
    {{-- <script src="/plugins/bootstrap/bootstrap.min.js" async></script> --}}
    {{-- <script src="/plugins/slick/slick.min.js"></script> --}}
    <script src="/toastr/build/toastr.min.js"></script>

    <!-- Main Script -->
    <script src="/js/script.js"></script>
</body>

</html>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"
    integrity="sha512-+NqPlbbtM1QqiK8ZAo4Yrj2c4lNQoGv8P79DPtKzj++l5jnN39rHA/xsqn8zE9l0uSoxaCdrOgFs6yjyfbBxSg=="
    crossorigin="anonymous" referrerpolicy="no-referrer"></script>

@if (session()->has('commentPost'))
    <h1>Enter</h1>
    {{ session()->get('successComment') }}
    <script>
        toastr.success('Done', "Thank You For Your Interest");
    </script>
@endif
<script src="https://use.fontawesome.com/fe459689b4.js"></script>

<script>

    $(document).ready(function() {
        $('#like').click(function() {
            var id = {{ $post->id }}
            $.ajax({
                url: '{{ route('likes.store') }}',
                type: "POST",
                data: {
                    _token: '{{ csrf_token() }}',
                    id: id,
                    status: 0,
                },
                cache: false,
                success: function(dataResult) {
                    window.location.reload();
                },
                error: function(dataResult) {
                    console.log(dataResult);
                    $error = dataResult.responseJSON.errors;
                    if (dataResult.status == 422) {
                        $.each($error, function(key, value) {
                            $('#err1-add' + key).html(value);
                        });
                    }
                }
            });
        });
        $('#dislike').click(function() {
            var id = {{ $post->id }};
            $.ajax({
                url: '{{ route('likes.store') }}',
                type: "POST",
                data: {
                    _token: '{{ csrf_token() }}',
                    id: id,
                    status: 1,
                },
                cache: false,
                success: function(dataResult) {
                    window.location.reload();
                },
                error: function(dataResult) {
                    console.log(dataResult);
                    $error = dataResult.responseJSON.errors;
                    if (dataResult.status == 422) {
                        $.each($error, function(key, value) {
                            $('#err1-add' + key).html(value);
                        });
                    }
                }
            });
        });
    });
</script>
<script src="js/like-dislike.js"></script>
