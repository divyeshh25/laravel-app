<x-link class="layout-navbar-fixed layout-fixed  layout-footer-fixed"></x-link>
<x-sidebar.sidebar />
<x-navbar.navbar />
<link href="/toastr/build/toastr.min.css" rel="stylesheet" type="text/css">
<script src="/toastr/build/toastr.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
    <style>.switch-toggle {
        height: 40px;
    }

    .switch-toggle input[type="checkbox"] {
        position: absolute;
        opacity: 0;
        z-index: -2;
    }

    .switch-toggle input[type="checkbox"]+label {
        position: relative;
        display: inline-block;
        width: 40px;
        height: 20px;
        border-radius: 12px;
        margin: 0;
        cursor: pointer;
        box-shadow: inset -8px -8px 15px rgba(255, 255, 255, .6),
            inset 10px 10px 10px rgba(0, 0, 0, .25);

    }

    .switch-toggle input[type="checkbox"]+label::before {
        position: absolute;
        content: 'OFF';
        font-size: 10px;
        text-align: center;
        line-height: 20px;
        width: 30px;
        height: 20px;
        border-radius: 20px;
        background-color: #64913b;
        box-shadow: -3px -3px 3px rgba(255, 255, 255, .5),
            3px 3px 5px rgba(0, 0, 0, .25);
        transition: .3s ease-in-out;
    }

    .switch-toggle input[type="checkbox"]:checked+label::before {
        left: 20%;
        content: 'ON';
        color: #1a1919;
        background-color: #00b33c;
        box-shadow: -3px -3px 3px rgba(255, 255, 255, .5),
            3px 3px 5px rgba(0, 0, 0, .25);
    }
</style>
</style>
@if (session()->has('successUser'))
    <script>
        toastr.info('Done', "{{ session()->get('successUser') }}");
    </script>
@endif
<section class="content-wrapper">
    <div class="container-fluid">

        <div class="card bg-light mt-4 h-auto">
            <div class="card-body">
                {{-- {{ dd($users)}} --}}
                <div class="flex">
                    <span class="text-blue text-bold text-lg" style="font-size:32px">Manage Users</span>
                    {{-- <span class="mailbox-attachment-close">
                        <a class="btn btn-sm btn-primary mb-3" data-toggle="modal" data-target="#AddEmp">
                            Add <i class="fas fa-plus"></i></a>
                    </span> --}}
                </div>
                <table id="userTable" class="display">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Permission <br> Write &nbsp; Edit
                                &nbsp;
                                Publish</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($users as $user)
                            <tr>
                                <td>{{ Str::ucfirst($user->name) }}</td>
                                <td>{{ $user->email }}</td>
                                <td>
                                    @foreach ($user->getRoleNames() as $roleName)
                                        {{ Str::ucfirst($roleName) }}
                                    @endforeach
                                </td>
                                <td>
                                    <div class="form-group clearfix row">
                                        &nbsp;
                                        <div class="icheck-primary d-inline cols">
                                            <div class="switch-toggle">
                                                <input type="checkbox" id="write-{{ $user->id }}"
                                                    {{ $user->hasPermissionTo('write post') ? 'checked' : '' }}
                                                    onchange="check('write-{{ $user->id }}')">
                                                <label for="write-{{ $user->id }}"></label>
                                            </div>
                                        </div>

                                        &nbsp;&nbsp;&nbsp;
                                        <div class="icheck-primary d-inline cols">
                                            <div class="switch-toggle">
                                                <input type="checkbox" id="edit-{{ $user->id }}"
                                                    {{ $user->hasPermissionTo('edit post') ? 'checked' : '' }}
                                                    onchange="check('edit-{{ $user->id }}')">
                                                <label for="edit-{{ $user->id }}"></label>
                                            </div>
                                        </div>
                                        &nbsp;&nbsp;
                                        <div class="icheck-primary d-inline cols">
                                            <div class="switch-toggle">
                                                <input type="checkbox" id="publish-{{ $user->id }}"
                                                    {{ $user->hasPermissionTo('publish post') ? 'checked' : '' }}
                                                    onchange="check('publish-{{ $user->id }}')">
                                                <label for="publish-{{ $user->id }}"></label>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td class="flex">
                                    {{-- href="post/edit/{{$category->id}}" --}}
                                    <span data-id="{{ $user->id }}" id="viewEdit"
                                        style="cursor:pointer;border:none"><i
                                            class="fas fa-pencil text-primary"></i></span>
                                    <span class="mx-2" data-id="{{ $user->id }}" id="delete"
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
<x-user-modal id="EditEmp" title="Edit Employee" emailId="editemail" statusName="editstatus" btnname="edit"
    nameId="editname" errName="edit" :roles='$roles' />
<x-user-modal id="AddEmp" title="Add Employee" emailId="addemail" statusName="addstatus" btnname="add"
    nameId="addname" errName="add" :roles='$roles'/>

<script>
    $('#userTable').DataTable();
    $(document).ready(function() {

        //Add user modal
        // $('#add').on('click', function() {
        //     var name = $('#addname').val();
        //     var email = $('#addemail').val();
        //     var status = $("input[name='addstatus']:checked").val();
        //     /*  $("#butsave").attr("disabled", "disabled"); */
        //     $.ajax({
        //         url: '{{ route('users.store') }}',
        //         type: "POST",
        //         data: {
        //             _token: '{{ csrf_token() }}',
        //             type: 1,
        //             name: name,
        //             status: status,
        //             email : email,
        //         },
        //         cache: false,

        //         success: function(dataResult) {
        //             window.location.reload();
        //         },
        //         error: function(dataResult) {
        //             console.log(dataResult);
        //             $error = dataResult.responseJSON.errors;
        //             if (dataResult.status == 422) {
        //                 $.each($error, function(key, value) {
        //                     $('#err-add' + key).html(value);
        //                 });
        //             }
        //         }
        //     });
        // });

        //view edit modal
        $(document).on('click', '#viewEdit', function() {
            var id = $(this).attr("data-id");
            var url = "{{ route('users.edit', '/id') }}";
            url = url.replace('/id', id);
            // console.log(url);
            $.ajax({
                type: "GET",
                url: url,
                // dataType: 'json',
                success: function(dataResult) {
                    // console.log();
                    // console.log(dataResult);
                    $("#EditEmp").modal("show");
                    $("#editname").val(dataResult.name);
                    $("#editemail").val(dataResult.email);
                    console.log();
                    $("input[name='editstatus'][value=" + dataResult.roles[0].name + "]")
                        .prop('checked', true);
                    $("#edit").val(id);
                },
                error: function(dataResult) {
                    console.log('error');
                }
            });
        });

        // Edit Category
        $('#edit').on('click', function(e) {
            e.preventDefault();
            var id = $(this).val();
            console.log(id);
            var name = $("#editname").val();
            var email = $("#editemail").val();
            var status = $("input[name='editstatus']:checked").val();
            // console.log(status);
            var url = "{{ route('users.update', '/id') }}";
            url = url.replace('/id', id);
            $.ajax({
                type: 'PATCH',
                url: url,
                data: {
                    _token: '{{ csrf_token() }}',
                    name: name,
                    status: status,
                    email: email,
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
            console.log(id);
            var url = "{{ route('users.destroy', '/id') }}";
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

    function check(text) {
        var value = text.split("-")[0] + " post";
        var id = text.split("-")[1];
        var status = $('#' + text).is(':checked') ? 'add' : 'remove';
        var url = "/updateStatus/" + id;
        // url = url.replace('/id', id);
        $.ajax({
            url: url,
            type: "POST",
            data: {
                '_token': '{{ csrf_token() }}',
                'value': value,
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
</script>
