@can('edit role')
<x-link class="layout-navbar-fixed layout-fixed  layout-footer-fixed"></x-link>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

<x-sidebar.sidebar />
<x-navbar.navbar />
<style>
    .grid-list {
        list-style-type: none;
        column-count: 4;
    }
    a{
        text-decoration: none
    }
</style>

<link href="/toastr/build/toastr.min.css" rel="stylesheet" type="text/css">
<script src="/toastr/build/toastr.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<section class="content-wrapper">
    <div class="container-fluid">
        <div class="card bg-light mt-4 h-auto">
            <div class="card-body">
                {{-- {{ dd()}} --}}
                <div class="flex">
                    <span class="text-blue text-bold text-lg" style="font-size:32px">Edit Role</span>
                    {{-- <span class="mailbox-attachment-close">
                        <a class="btn btn-sm btn-primary mb-3" data-toggle="modal" data-target="#AddRole">
                            Add <i class="fas fa-plus"></i></a>
                    </span> --}}
                </div>
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="basic-addon1">@</span>
                    </div>
                    <input type="text" class="form-control" id="name" placeholder="Rolename"
                        aria-label="Username" aria-describedby="basic-addon1" value="{{ $role->name }}">
                </div>
                <div class="mt-3">
                    <span class="float-left"><b>Permisssion:</b></span>
                    <span class="float-right">
                        <input class="form-check-input" id="checkAll" type="checkbox" value=""
                            onchange="pushToArray('checkAll')"
                            style="cursor: pointer;">
                        <label class="form-check-label text-dark text-capitalize" for="checkAll" style="cursor: pointer; user-select: none;">
                            Check All
                        </label>
                    </span>
                </div>
                <br><br>
                {{-- {{ dd($rolePer) }} --}}
                <div class="accordion" id="accordionExample">
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingOne">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                Post Permission
                            </button>
                        </h2>
                        <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne"
                            data-bs-parent="#accordionExample">
                            <div class="accordion-body">
                                <x-role find="post" :role="$rolePer" pagename="edit"/>
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingTwo">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                Category Permission
                            </button>
                        </h2>
                        <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo"
                            data-bs-parent="#accordionExample">
                            <div class="accordion-body">
                                <x-role :role="$rolePer" find="category" pagename="edit"/>
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingThree">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                User Permission
                            </button>
                        </h2>
                        <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree"
                            data-bs-parent="#accordionExample">
                            <div class="accordion-body">
                                <x-role :role="$rolePer" find="user" pagename="edit"/>
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingThree">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseThree">
                                Role Permission
                            </button>
                        </h2>
                        <div id="collapseFour" class="accordion-collapse collapse" aria-labelledby="headingThree"
                            data-bs-parent="#accordionExample">
                            <div class="accordion-body">
                                <x-role :role="$rolePer" find="role" pagename="edit"/>
                            </div>
                        </div>
                    </div>
                </div>
                <button type="button" id="EditRole" value="{{ $role->id }}"
                    class="btn btn-primary mt-3">Save Changes</button>
            </div>
        </div>
    </div>
</section>
<script>
    var permissions = [];
    PrevioueData();

    function PrevioueData() {
        @foreach ($rolePer as $per)
            permissions.push('{{ $per->name }}');
            var id = '{{ str_replace(' ', '-', $per->name) }}';
            $('#' + id).attr('checked', true);
        @endforeach
    }

    function pushToArray(id) {
        if (id == "checkAll") {
            if ($('input[type="checkbox"][id=' + id + ']').is(":checked")) {
                var cid = document.querySelectorAll(".permission");
                for (var index = 0; index < cid.length; index++) {
                    if (!$(cid[index]).is(':checked')) {
                        $(cid[index]).attr('checked', true);
                        permissions.push($(cid[index]).val());
                    }
                }
            } else {
                $('input[type="checkbox"][name="permission"]').attr('checked', false);
                permissions = [];
                PrevioueData();
            }
        }else {
            $('input[type="checkbox"][id=' + id + ']').is(":checked") ?
                permissions.push($('#' + id).val()) :
                permissions.splice(permissions.indexOf($('#' + id).val()), 1);
        }
    }
    $('#EditRole').on('click', function() {
        var id = $(this).val();
        var name = $('#name').val();
        var url = "{{ route('roles.update', '/id') }}";
        url = url.replace('/id', id);
        // alert(permissions);
        $.ajax({
            url: url,
            type: "PATCH",
            data: {
                _token: '{{ csrf_token() }}',
                name: name,
                permission: permissions,
            },
            cache: false,

            success: function(dataResult) {
                window.location = "/roles";
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
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous">
</script>
@else
    <script>window.location = "/error";</script>
@endcan
