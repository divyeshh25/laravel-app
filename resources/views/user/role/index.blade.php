{{-- <script src="/plugins/jquery/jquery.min.js"></script> --}}

<x-link class="layout-navbar-fixed layout-fixed  layout-footer-fixed"></x-link>
<x-sidebar.sidebar />
<x-navbar.navbar />
<link href="/toastr/build/toastr.min.css" rel="stylesheet" type="text/css">
<script src="/toastr/build/toastr.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
    <style>.permission {
        font-size: 23px;
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

    .grid-list {
        list-style-type: none;
        column-count: 4;
    }
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
                    @can('add role')
                        <span class="mailbox-attachment-close">
                            <a href="{{ route('roles.create') }}" class="btn btn-sm btn-primary mb-3">
                                Add <i class="fas fa-plus"></i></a>
                        </span>
                    @endcan
                </div>
                <table id="userTable" class="display">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Created At</th>
                            {{-- <th>Role</th> --}}
                            {{-- <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Permission <br> Write &nbsp; Edit
                                &nbsp;
                                Publish</th> --}}
                            {{-- <th>Permissions</th> --}}
                            @canany(['edit role', 'delete role'])
                                <th>Action</th>
                            @endcanany
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($roles as $role)
                            @if ($role->name == 'admin')
                                @continue
                            @endif
                            <tr>
                                <td>{{ Str::ucfirst($role->name) }}</td>
                                <td>{{ $role->updated_at->format('F j, Y, g:i a') }}</td>
                                {{-- <td class="flex-column">
                                    @foreach ($role->permissions()->get() as $permission)
                                        <p style="width: max-content;" class="text-sm text-blue bg-blue rounded-pill pl-1 pr-1">
                                            {{ $permission->name }}</p>
                                    @endforeach
                                </td> --}}
                                {{-- <td>
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
                                </td> --}}
                                @canany(['edit role', 'delete role'])
                                    <td class="flex">
                                        @can('edit role')
                                            <a href="{{ route('roles.edit', $role->id) }}" data-id="{{ $role->id }}"
                                                id="viewEdit" style="cursor:pointer;border:none"><i
                                                    class="fas fa-pencil text-primary"></i></a>
                                        @endcan
                                        @can('delete role')
                                            <span class="mx-2" data-id="{{ $role->id }}" id="delete"
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
{{-- <x-role-modal id="EditRole" title="Edit Role" btnName="edit" nameId="editname" errName="edit" :permissions="$permissions" /> --}}
<x-role-modal id="AddRole" title="Add Role" btnName="add" nameId="addname" errName="add" :permissions="$permissions" />

<script>
    $('#userTable').DataTable();

    $(document).ready(function() {




        // delete roles
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
