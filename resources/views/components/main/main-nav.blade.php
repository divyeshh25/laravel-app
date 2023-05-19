<nav class="navbar navbar-expand-lg navbar-white">
    <a class="navbar-brand" href="/" style="color:brown">
        <b class="animate-charcter">BlogoPedia</b>
    </a>
    <button class="navbar-toggler border-0" type="button" data-toggle="collapse" data-target="#navigation">
        <i class="ti-menu"></i>
    </button>

    <div class="collapse navbar-collapse text-center" id="navigation">
        <ul class="navbar-nav ml-auto">
            @auth
                <li class="nav-item">
                    <a class="nav-link"><span class="text-monospace text-success">Welcome Back!</span> <span
                            class="pl-2 text-info btn btn-sm" style="padding:1px 8px;">{{ Auth()->user()->name }}</span></a>
                </li>
            @endauth
            <li class="nav-item dropdown">
                <a class="nav-link" href="/" role="button" data-toggle="dropdown" aria-haspopup="true"
                    aria-expanded="false">
                    homepage
                </a>
            </li>

            {{-- <li class="nav-item">
                <a class="nav-link" href="/about">About</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/contact">Contact</a>
            </li> --}}
            <li class="nav-item">
                @if (auth()->user())
                    <a class="nav-link" href="/logout">Sign Out</a>
                @else
                    <a class="nav-link" href="/login">Sign In</a>
                @endif

            </li>
            {{-- <li class="nav-item">
             <a class="nav-link"  href="/author" role="button" data-toggle="dropdown" aria-haspopup="true"
                aria-expanded="false">Author
             </a>
             <div class="dropdown-menu">
                <a class="dropdown-item" href="author.html">Author</a>
                <a class="dropdown-item" href="post-details-1.html">Post Details 1</a>
                <a class="dropdown-item" href="post-details-2.html">Post Details 2</a>
                <a class="dropdown-item" href="post-elements.html">Post Elements</a>
                <a class="dropdown-item" href="privacy-policy.html">Privacy Policy</a>
                <a class="dropdown-item" href="terms-conditions.html">Terms Conditions</a>
             </div>
          </li> --}}
        </ul>
    </div>
</nav>
