<x-link class="layout-navbar-fixed layout-fixed  layout-footer-fixed"></x-link>
<x-sidebar.sidebar />
<x-navbar.navbar />
<link href="/css/activeInactive.css" rel="stylesheet">
<link href="toastr/build/toastr.min.css" rel="stylesheet" type="text/css">
<script src="toastr/build/toastr.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
@if (session()->has('success'))
    <script>
        toastr.success('Done', "{{ session()->get('success') }}");
    </script>
@endif
<section class="content-wrapper">
    <div class="container-fluid">
        <form action="#" method="POST">
            @csrf
        </form>
        <div class="card bg-light mt-4 h-auto">
            <div class="card-body">
                <div class="flex">
                    <span class="text-blue text-bold text-lg" style="font-size:32px">Manage Category</span>
                    @can('add category')
                        <span class="mailbox-attachment-close">
                            <p class="btn btn-sm btn-primary" data-toggle="modal" data-target="#AddCatModal">
                                Add <i class="fas fa-plus"></i></p>
                        </span>
                    @endcan
                </div>
                <table id="myTable" class="display">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Name</th>
                            <th>Created By</th>
                            @canany(['edit category', 'add category'])
                                <th>Status</th>
                            @endcanany
                            @canany(['edit category', 'delete category'])
                                <th>Action</th>
                            @endcanany
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($categories as $category)
                            <tr>
                                <td>{{ $category->id }}</td>
                                <td>{{ Str::ucfirst($category->name) }}</td>
                                <td>{{ $category->user->name }}</td>

                                {{-- <td>{{ $category->status == 0 ? 'Active' : 'Inactive' }}</td> --}}
                                @canany(['edit category', 'add category'])
                                    <td>
                                        <p>
                                            <input type="checkbox" id="switch-{{ $category->id }}" switch="bool"
                                                {{ $category->status == 0 ? 'checked' : '' }}
                                                onchange="check('switch-{{ $category->id }}')"
                                                @can('edit category')
                                                    @disabled(false)
                                                @else
                                                    @disabled(true)
                                                @endcan>
                                            <label for="switch-{{ $category->id }}" data-on-label="Active"
                                                data-off-label="Inactive"></label>
                                        </p>
                                    </td>
                                @endcanany
                                @canany(['edit category', 'delete category'])
                                    <td class="flex">
                                        @can('edit category')
                                            <span data-id="{{ $category->id }}" id="viewEdit"
                                                style="cursor:pointer;border:none"><i
                                                    class="fas fa-pencil text-primary"></i></span>
                                        @endcan
                                        @can('delete category')
                                            <span class="mx-2" data-id="{{ $category->id }}" id="delete"
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
<x-modal id='AddCatModal' title='Add Category' action="#" method="POST" btnname='butsave' nameId='name'
    statusName='status' btnType="button" method2="post" errName="err" />
<x-modal id='EditCatModal' title='Edit Category' action="#" method="POST" btnname='btnEdit' nameId='name2'
    statusName='status2' btnType="button" method2="patch" errName="err1" />


<script>
    $('#myTable').DataTable({
        "processing": true,
    });

    //Status Update
    function check(text) {
        var id = text.split("-")[1];
        var status = $('#' + text).is(':checked') ? '0' : '1';
        var url = "/updateCategoryStatus/" + id;
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

        //Add New Category
        $('#butsave').on('click', function() {
            var name = $('#name').val();
            var status = $("input[name='status']:checked").val();
            /*  $("#butsave").attr("disabled", "disabled"); */
            $.ajax({
                url: '{{ route('categories.store') }}',
                type: "POST",
                data: {
                    _token: $("input[name='_token']").val(),
                    type: 1,
                    name: name,
                    status: status
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
                            $('#err-' + key).html(value);
                        });
                    }
                }
            });
        });

        // View Edit Modal
        $(document).on('click', '#viewEdit', function() {
            var id = $(this).attr("data-id");
            var url = "{{ route('categories.edit', '/id') }}";
            url = url.replace('/id', id);
            $.ajax({
                type: "GET",
                url: url,
                dataType: 'json',
                success: function(dataResult) {
                    // console.log();
                    // console.log(dataResult);
                    $("#EditCatModal").modal("show");
                    $("#name2").val(dataResult.name);
                    $("#btnEdit").val(id);
                },
                error: function(dataResult) {}
            })

        });

        // Edit Category
        $('#btnEdit').on('click', function() {
            var id = $(this).val();
            var name = $("#name2").val();
            console.log(name);
            var status = $("input[name='status2']:checked").val();
            var url = "{{ route('categories.update', '/id') }}";
            url = url.replace('/id', id);
            $.ajax({
                type: "PATCH",
                url: url,
                data: {
                    _token: $("input[name='_token']").val(),
                    name: name,
                    status: status
                },
                success: function(dataResult) {
                    window.location.reload();
                },
                error: function(dataResult) {
                    console.log(dataResult);
                    $error = dataResult.responseJSON.errors;
                    if (dataResult.status == 422) {
                        $.each($error, function(key, value) {
                            $('#err1-' + key).html(value);
                        });
                    }
                }
            });
        });

        // Delete Category
        $(document).on('click', '#delete', function() {
            var id = $(this).attr("data-id");
            console.log(id);
            var url = "{{ route('categories.destroy', '/id') }}";
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
                            _token: $("input[name='_token']").val(),
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
