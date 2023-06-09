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
    <title>Blog</title>

    <!-- mobile responsive meta -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=5">
    <meta name="description" content="This is meta description">
    <meta name="author" content="Themefisher">

    <!-- plugins -->
    <link rel="preload" href="https://fonts.gstatic.com/s/opensans/v18/mem8YaGs126MiZpBA-UFWJ0bbck.woff2"
        style="font-display: optional;">
    <link rel="stylesheet" href="/plugins/bootstrap/bootstrap.min.css">
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css?family=Montserrat:600%7cOpen&#43;Sans&amp;display=swap" media="screen">

    <link rel="stylesheet" href="/plugins/themify-icons/themify-icons.css">
    <link rel="stylesheet" href="/plugins/slick/slick.css">

    <!-- Main Stylesheet -->
    <link rel="stylesheet" href="/css/style.css">

    <!--Favicon-->
    <link rel="shortcut icon" href="images/favicon.png" type="image/x-icon">
    <link rel="icon" href="images/favicon.png" type="image/x-icon">
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
            <div class="row">
                <div class="col-lg-8  mb-5 mb-lg-0">
                    @if(session()->has('NoPost'))
                        <p style="font-size:16px;font-weight:bolder;">Sorry , {{ session('NoPost') }}</p>
                        <br>
                        <p style="font-size:16px;font-weight:bolder;color:black">Other Post</p>
                    @endif
                    @foreach ($posts as $post)
                        <article class="row mb-5">
                            <div class="col-12">
                                <div class="post-slider">
                                    <img loading="lazy" src="{{ $post->image }}" class="img-fluid" alt="post-thumb">
                                </div>
                            </div>
                            <div class="col-12 mx-auto">
                                <h3><a class="post-title" href="/post/{{ $post->id }}">{{ $post->title }}</a></h3>
                                <ul class="list-inline post-meta mb-4">
                                    <li class="list-inline-item"><i class="ti-user mr-2"></i>
                                        <a href="/author/{{ $post->user->id }}">{{ $post->user->name }}</a>
                                    </li>
                                    <li class="list-inline-item">Date : {{ $post->updated_at->format('F j, Y') }}</li>
                                    <li class="list-inline-item">Categories : <a href="/category/{{ $post->category->id }}"
                                            class="ml-1">{{ $post->category->name }}
                                        </a>
                                    </li>
                                    <li class="list-inline-item">Tags : <a href="/category/{{ $post->category->id }}" class="ml-1">{{ $post->category->name }} </a>
                                    </li>
                                </ul>
                                <p>{{ $post->excerpt }}</p> <a href="/post/{{ $post->id }}"
                                    class="btn btn-outline-primary">Continue Reading</a>
                            </div>
                        </article>
                    @endforeach
                </div>
                <aside class="col-lg-4">
                    <!-- Search -->
                    <div class="widget">
                        <h5 class="widget-title"><span>Search</span></h5>
                        <form action="/" class="widget-search">
                            <input id="search-query" name="search" type="search"
                                placeholder="Type &amp; Hit Enter...">
                            <button type="submit"><i class="ti-search"></i>
                            </button>
                        </form>
                    </div>
                    <!-- categories -->
                    <div class="widget">
                        <h5 class="widget-title"><span>Categories</span></h5>
                        <ul class="list-unstyled widget-list">
                            @foreach ($categories as $category)
                                <li><a href="/category/{{ $category->id }}" class="d-flex">{{ $category->name }}
                                        <small class="ml-auto">({{ count($category->posts->where('status','0')) }})</small></a>
                                </li>
                            @endforeach
                        </ul>
                    </div>
                    <!-- tags -->
                    <div class="widget">
                        <h5 class="widget-title"><span>Tags</span></h5>
                        <ul class="list-inline widget-list-inline">
                            @foreach ($categories as $category)
                                <li class="list-inline-item"><a href="/category/{{ $category->id }}">{{ $category->name }}</a>
                                </li>
                            @endforeach
                    </div>
                    <!-- latest post -->
                    <div class="widget">
                        <h5 class="widget-title"><span>Latest Article</span></h5>
                        <!-- post-item -->
                        @foreach ($posts as $post)
                            <ul class="list-unstyled widget-list">
                                <li class="media widget-post align-items-center">
                                    <a href="/post/{{ $post->id }}">
                                        <img loading="lazy" class="mr-3" src="{{ $post->image }}">
                                    </a>
                                    <div class="media-body">
                                        <h5 class="h6 mb-0"><a href="/post/{{ $post->id }}">
                                                {{ $post->excerpt }}
                                            </a>
                                        </h5>
                                        <small>{{ $post->updated_at->format('F j, Y') }}</small>
                                    </div>
                                </li>
                            </ul>
                        @endforeach
                    </div>
                </aside>
            </div>
        </div>
    </section>

    <x-main.main-footer/>
    <!-- JS Plugins -->
    <script src="/plugins/jQuery/jquery.min.js"></script>
    <script src="/plugins/bootstrap/bootstrap.min.js" async></script>
    <script src="/plugins/slick/slick.min.js"></script>

    <!-- Main Script -->
    <script src="/js/script.js"></script>
</body>

</html>
