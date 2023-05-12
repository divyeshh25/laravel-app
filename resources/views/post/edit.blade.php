<x-link class="layout-navbar-fixed layout-fixed  layout-footer-fixed"></x-link>
<x-sidebar.sidebar />
<x-navbar.navbar />
<section class="content-wrapper">
    <div class="container-fluid">
        {{-- {{ $post }} --}}
        <div class="card bg-light mt-4 h-auto">
            <h1 class="rounded text-center mb-2 text-bold text-lg-center text-xl">Add Post</h1>
            <div class="card-body m-2 shadow-lg">
                <x-post-form btnType='submit' iDName='edit' action="{{ route('posts.update', $post->id) }}" method="POST"
                    otherMethod="PATCH" :data="$categories" :post="$post" />
            </div>
        </div>
    </div>
</section>
<script>
    $(document).ready(function() {
        $('#editBody').summernote({
            height: 150
        });
    });
    $('#editImg').attr("data-default-file", "{{ asset($post->image) }}");
    $('#editImg').dropify()
    $(document).ready(function() {
        $('#editCat option[value="{{ $post->category_id }}"]').attr('selected', true);
        $('#editTitle').val('{{ $post->title }}');
        $('#editExcerpt').val('{{ $post->excerpt }}');
        $("#editBody").summernote("code", '{!! $post->body !!}');
        if ({{ $post->status }} == 0)
            $("input[name='editStatus'][value='0']").prop('checked', true);
        else
            $("input[name='editStatus'][value='1']").prop('checked', true);

    });
</script>
