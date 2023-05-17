<x-link class="layout-navbar-fixed layout-fixed  layout-footer-fixed"></x-link>
<x-sidebar.sidebar />
<x-navbar.navbar />
<link href="/toastr/build/toastr.min.css" rel="stylesheet" type="text/css">
<script src="/toastr/build/toastr.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
    <style>
    .permission{
        font-size:23px;
        font-weight: 900;
    }
    .switch-toggle {
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
        width: 50px;
        height: 20px;
        border-radius: 12px;
        margin: 0;
        cursor: pointer;
        box-shadow: inset -8px -8px 15px rgba(215, 228, 30, 0.6),
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
        left: 35%;
        content: 'ON';
        color: #1a1919;
        background-color: #00b33c;
        box-shadow: -3px -3px 3px rgba(255, 255, 255, .5),
            3px 3px 5px rgba(0, 0, 0, .25);
    }
</style>
</style>
@if (session()->has('successRole'))
    <script>
        toastr.info('Done', "{{ session()->get('successRole') }}");
    </script>
@endif
<section class="content-wrapper">
    <div class="container-fluid">

        <div class="card bg-light mt-4 h-auto">
            <div class="card-body">
                {{-- {{ dd($users)}} --}}
                <div class="flex">
                    <span class="text-blue text-bold text-lg" style="font-size:32px">Manage Users</span>
                    <span class="mailbox-attachment-close">
                        <a class="btn btn-sm btn-primary mb-3" data-toggle="modal" data-target="#AddRole">
                            Add <i class="fas fa-plus"></i></a>
                    </span>
                </div>
                <table id="userTable" class="display">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Created At</th>
                            {{-- <th>Role</th> --}}
                            <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Permission <br> Write &nbsp; Edit
                                &nbsp;
                                Publish</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($roles as $role)
                            <tr>
                                <td>{{ Str::ucfirst($role->name) }}</td>
                                <td>{{ $role->updated_at->format('F j, Y, g:i a') }}</td>

                                <td>
                                    <div class="form-group clearfix row">
                                        &nbsp;
                                        <div class="icheck-primary d-inline cols">
                                            <div class="switch-toggle">
                                                <input type="checkbox" id="write-{{ $role->id }}"
                                                    {{ $role->hasPermissionTo('write post') ? 'checked' : '' }}
                                                    onchange="check('write-{{ $role->id }}')">
                                                <label for="write-{{ $role->id }}"></label>
                                            </div>
                                        </div>

                                        &nbsp;&nbsp;&nbsp;
                                        <div class="icheck-primary d-inline cols">
                                            <div class="switch-toggle">
                                                <input type="checkbox" id="edit-{{ $role->id }}"
                                                    {{ $role->hasPermissionTo('edit post') ? 'checked' : '' }}
                                                    onchange="check('edit-{{ $role->id }}')">
                                                <label for="edit-{{ $role->id }}"></label>
                                            </div>
                                        </div>
                                        &nbsp;&nbsp;
                                        <div class="icheck-primary d-inline cols">
                                            <div class="switch-toggle">
                                                <input type="checkbox" id="publish-{{ $role->id }}"
                                                    {{ $role->hasPermissionTo('publish post') ? 'checked' : '' }}
                                                    onchange="check('publish-{{ $role->id }}')">
                                                <label for="publish-{{ $role->id }}"></label>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td class="flex">
                                    {{-- href="post/edit/{{$category->id}}" --}}
                                    {{-- <span data-id="{{ $role->id }}" id="viewEdit"
                                        style="cursor:pointer;border:none"><i
                                            class="fas fa-pencil text-primary"></i></span> --}}
                                    <span class="mx-2" data-id="{{ $role->id }}" id="delete"
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
<x-role-modal id="EditRole" title="Edit Role" btnName="edit"
    nameId="editname" errName="edit" />
<x-role-modal id="AddRole" title="Add Role" btnName="add"
    nameId="addname" errName="add" />

<script>
    $('#userTable').DataTable();

    function check(text) {
        var value = text.split("-")[0] + " post";
        var id = text.split("-")[1];
        var status = $('#' + text).is(':checked') ? 'add' : 'remove';
        var url = "/updatePermission/" + id;
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

    $(document).ready(function(){
        // Add user modal
        $('#add').on('click', function() {
            var name = $('#addname').val();
            const permission = [];
            $('#write-add').is(":checked") ? permission.push($('#write-add').val()) : '';
            $('#edit-add').is(":checked") ? permission.push($('#edit-add').val()) : '';
            $('#publish-add').is(":checked") ? permission.push($('#publish-add').val()) : '';
            // alert(permission);
            $.ajax({
                url: '{{ route('roles.store') }}',
                type: "POST",
                data: {
                    _token: '{{ csrf_token() }}',
                    type: 1,
                    name: name,
                    permission:permission,
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



        $(document).on('click', '#delete', function() {
            var id = $(this).attr("data-id");
            var url = "{{ route('roles.destroy', '/id') }}";
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
