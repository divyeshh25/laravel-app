{{-- {{ dd($author) }} --}}

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
    <title>Author</title>

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
    <link rel="shortcut icon" href="/images/favicon.png" type="image/x-icon">
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

    <section class="section-sm border-bottom">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="title-bordered mb-5 d-flex align-items-center">
                        <h1 class="h4">{{ $category->name }}</h1>
                        <ul class="list-inline social-icons ml-auto mr-3 d-none d-sm-block">
                            <li class="list-inline-item"><a href="#"><i class="ti-facebook"></i></a>
                            </li>
                            <li class="list-inline-item"><a href="#"><i class="ti-twitter-alt"></i></a>
                            </li>
                            <li class="list-inline-item"><a href="#"><i class="ti-github"></i></a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="section-sm">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="title text-center">
                        <h2 class="mb-5">{{$category->name}} Category</h2>
                    </div>
                </div>

                @foreach ($category->posts as $post)
                    <div class="col-lg-4 col-sm-6 mb-4">
                        <article class="mb-5">
                            <div class="post-slider slider-sm">
                                <img loading="lazy" src="{{ asset($post->image) }}" class="img-fluid" alt="post-thumb">
                            </div>
                            <h3 class="h5"><a class="post-title"
                                    href="/post/{{ $post->id }}">{{ $post->title }}</a>
                            </h3>
                            <ul class="list-inline post-meta mb-2">
                                <li class="list-inline-item"><i class="ti-user mr-2"></i><a
                                        href="/author/{{ $category->user->id }}">{{ $category->user->name }}</a>
                                </li>
                                <li class="list-inline-item">Date : {{ $post->updated_at->format('F j, Y') }}</li>
                                <li class="list-inline-item">Categories : <a href="/category/{{ $post->category->id }}"
                                        class="ml-1">{{ $post->category->name }}
                                    </a>
                                </li>
                                <li class="list-inline-item">Tags : <a href="/category/{{ $post->category->id }}"
                                        class="ml-1">{{ $post->category->name }} </a>
                                </li>
                            </ul>
                            <p>{{ $post->excerpt }} …</p> <a href="/post/{{ $post->id }}"
                                class="btn btn-outline-primary">Continue
                                Reading</a>
                        </article>
                    </div>
                @endforeach
            </div>
        </div>
    </section>

    <x-main.main-footer />


    <!-- JS Plugins -->
    <script src="/plugins/jQuery/jquery.min.js"></script>
    <script src="/plugins/bootstrap/bootstrap.min.js" async></script>
    <script src="/plugins/slick/slick.min.js"></script>

    <!-- Main Script -->
    <script src="/js/script.js"></script>
</body>

</html>
