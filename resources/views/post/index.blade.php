<x-link class="layout-navbar-fixed layout-fixed  layout-footer-fixed"></x-link>
<x-sidebar.sidebar />
<x-navbar.navbar />
<link href="/css/activeInactive.css" rel="stylesheet">
<link href="/toastr/build/toastr.min.css" rel="stylesheet" type="text/css">
<script src="/toastr/build/toastr.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

@if (session()->has('successPost'))
    <script>
        toastr.success('Done', "{{ session()->get('successPost') }}");
    </script>
@endif
<section class="content-wrapper">
    <div class="container-fluid">

        <div class="card bg-light mt-4 h-auto">
            <div class="card-body">
                <div class="flex">
                    <span class="text-blue text-bold text-lg" style="font-size:32px">Manage Posts</span>
                    @can('write post')
                        <span class="mailbox-attachment-close">
                            <a class="btn btn-sm btn-primary mb-3" href="{{ route('posts.create') }}">
                                Add <i class="fas fa-plus"></i></a>
                        </span>
                    @endcan
                </div>
                <table id="postTable" class="display">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Category</th>
                            <th>Title</th>
                            <th>Posted By</th>
                            {{-- <th>Excerpt</th> --}}
                            @can('publish post')
                                <th>Status</th>
                            @endcan
                            <th>Image</th>
                            @canany(['delete post', 'edit post'])
                                <th>Action</th>
                            @endcanany
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($posts as $post)
                            <tr>
                                <td>{{ $post->id }}</td>
                                <td>{{ $post->category->name }}</td>
                                <td>{{ $post->title }}</td>
                                <td>{{ $post->user->name }}</td>
                                {{-- <td>{{ $post->excerpt }}</td> --}}
                                {{-- <td>{{ $post->status == 0 ? 'Active' : 'Inactive' }}</td> --}}
                                @can('publish post')
                                    <td>
                                        <p>
                                            <input type="checkbox" id="switch-{{ $post->id }}" switch="bool"
                                                {{ $post->status == 0 ? 'checked' : '' }}
                                                onchange="check('switch-{{ $post->id }}')" />
                                            <label for="switch-{{ $post->id }}" data-on-label="Active"
                                                data-off-label="Inactive"></label>
                                        </p>
                                    </td>
                                @endcan
                                <td><img src="{{ asset($post->image) }}" height="50" width="50"></td>
                                @canany(['delete post', 'edit post'])
                                    <td class="flex">
                                        {{-- href="post/edit/{{$category->id}}" --}}
                                        @can('edit post')
                                            <a href="{{ route('posts.edit', $post->id) }}" data-id="{{ $post->id }}"
                                                id="viewEdit" style="cursor:pointer;border:none"><i
                                                    class="fas fa-pencil text-primary"></i></a>
                                        @endcan
                                        @can('delete post')
                                            <span class="mx-2" data-id="{{ $post->id }}" id="delete"
                                                style="cursor:pointer;border:none"><i
                                                    class="fas fa-trash text-danger"></i></span>
                                        @endcan

                                    </td>
                                @endcanany
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>




<script>
    $('#postTable').DataTable();

    //status update
    function check(text) {
        var id = text.split("-")[1];
        var status = $('#' + text).is(':checked') ? '0' : '1';
        var url = "/updatePostStatus/" + id;
        $.ajax({
            url: url,
            type: "POST",
            data: {
                '_token': '{{ csrf_token() }}',
                'status': status,
            },
            success: function(dataResult) {
                window.location.reload();
            },
            error: function(dataResult) {
                console.log(dataResult);
            }
        });
    }

    $(document).ready(function() {
        // Delete Post
        $(document).on('click', '#delete', function() {
            var id = $(this).attr("data-id");
            console.log(id);
            var url = "{{ route('posts.destroy', '/id') }}";
            url = url.replace('/id', id);
            console.log(url);
            Swal.fire({
                title: 'Are you sure?',
                text: "You won't be able to revert this!",
                icon: 'error',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: url,
                        type: "DELETE",
                        data: {
                            '_token': '{{ csrf_token() }}',
                        },
                        success: function(dataResult) {
                            window.location.reload();
                        },
                        error: function(dataResult) {
                            console.log(dataResult);
                        }
                    });
                }
            })
        });



    });
</script>
