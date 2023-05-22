<x-link class="layout-navbar-fixed layout-fixed  layout-footer-fixed"></x-link>
<x-sidebar.sidebar />
<x-navbar.navbar />
<link href="/toastr/build/toastr.min.css" rel="stylesheet" type="text/css">
<script src="/toastr/build/toastr.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

@if (session()->has('successComment'))
    <script>
        toastr.info('Done', "{{ session()->get('successComment') }}");
    </script>
@endif
<section class="content-wrapper">
    <div class="container-fluid">

        <div class="card bg-light mt-4 h-auto">
            <div class="card-body">
                {{-- {{ dd($users)}} --}}
                <div class="flex">
                    <span class="text-blue text-bold text-lg" style="font-size:32px">Manage Comments</span>
                    {{-- <span class="mailbox-attachment-close">
                        <a class="btn btn-sm btn-primary mb-3" data-toggle="modal" data-target="#AddEmp">
                            Add <i class="fas fa-plus"></i></a>
                    </span> --}}
                </div>
                <table id="userTable" class="display">
                    <thead>
                        <tr>
                            <th>Body</th>
                            <th>Username</th>
                            <th>Category</th>
                            <th>Post Title</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($comments as $comment)
                            <tr>
                                <td>{{ $comment->body }} </td>
                                <td>
                                    @foreach ($comment->user as $user)
                                        {{ Str::ucfirst($user->name) }}
                                    @endforeach

                                </td>
                                <td>{{ $comment->post->category->name }} </td>
                                <td>{{ $comment->post->title }}</td>
                                <td class="flex">
                                    {{-- href="post/edit/{{$category->id}}" --}}
                                    {{-- <span data-id="{{ $comment->id }}" id="viewEdit"
                                        style="cursor:pointer;border:none"><i
                                            class="fas fa-pencil text-primary"></i></span> --}}
                                    <span class="mx-2" data-id="{{ $comment->id }}" id="delete"
                                        style="cursor:pointer;border:none"><i
                                            class="fas fa-trash text-danger"></i></span>
                                </td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>

{{-- //edit modal --}}
{{-- <div class="modal fade" id="CommentEdit" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Edit Comment</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form  method="POST">
                <div class="modal-body">
                    <textarea class="form-control" name="commentText" id="commentText"></textarea>
                    <p id="ErrComment" class="text-danger text-sm"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" id="EditBtn" class="btn btn-primary">Save
                        changes</button>
                </div>
            </form>
        </div>
    </div>
</div> --}}


<script>
    $('#userTable').DataTable();
    $(document).ready(function() {
        //view edit modal
        $(document).on('click', '#viewEdit', function() {
            var id = $(this).attr("data-id");
            var url = "{{ route('comments.edit', '/id') }}";
            url = url.replace('/id', id);
            $.ajax({
                type: "GET",
                url: url,
                success: function(dataResult) {
                    $("#CommentEdit").modal("show");
                    $("#commentText").text(dataResult.body);
                    $("#EditBtn").val(dataResult.id);
                },
                error: function(dataResult) {
                    console.log('error');
                }
            });
        });

        // Edit Category
        $('#EditBtn').on('click', function(e) {
            e.preventDefault();
            var id = $(this).val();
            var text = $("#commentText").text();
            alert(text);
            var url = "{{ route('comments.update', '/id') }}";
            url = url.replace('/id', id);
            $.ajax({
                type: 'PATCH',
                url: url,
                data: {
                    _token: '{{ csrf_token() }}',
                    body: text,
                },
                success: function(dataResult) {
                    window.location.reload();
                },
                error: function(dataResult) {
                    $error = dataResult.responseJSON.errors;
                    // console.log($error);
                    if (dataResult.status == 422) {
                        $.each($error, function(key, value) {
                            $('#err1-edit' + key).html(value);
                        });
                    }

                }
            });
        });

        // Delete Post
        $(document).on('click', '#delete', function() {
            var id = $(this).attr("data-id");
            var url = "{{ route('comments.destroy', '/id') }}";
            url = url.replace('/id', id);
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
