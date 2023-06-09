@can('edit post')
    <x-link class="layout-navbar-fixed layout-fixed  layout-footer-fixed" />
    <x-sidebar.sidebar />
    <x-navbar.navbar />

    <section class="content-wrapper">
        <div class="container-fluid">
            {{-- {{ dd($categories) }} --}}
            <div class="card bg-light mt-4 h-auto">
                <h1 class="rounded text-center mb-2 text-bold text-lg-center text-xl">Edit Post</h1>
                <div class="card-body m-2 shadow-lg">
                    <x-post-form btnType='submit' iDName='edit' action="{{ route('posts.update', $post->id) }}" method="POST"
                        otherMethod='PATCH' :data="$categories" />
                </div>
            </div>
        </div>
    </section>

    <script>
        $(document).ready(function() {
            $('#editBody').summernote({
                height: 150
            });

            $('#editImg').attr("data-default-file", "{{ asset($post->image) }}");
            $('#editTitle').val('{{ $post->title }}');
            $("#editBody").summernote("code", '{!! $post->body !!}');
            $("#editExcerpt").text("{{ $post->excerpt }}");
            $("input[name='editStatus'][value='" + {{ $post->status }} + "']").prop('checked', true);
            $('#editImg').dropify();
            $('#editCat option[value="{{ $post->category_id }}"]').attr('selected', true);

        });
    </script>
@else
    <script>
        window.location = "/error";
    </script>
@endcan
