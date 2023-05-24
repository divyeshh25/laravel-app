<!-- Button trigger modal -->
<x-link />
<!-- Modal -->
<div class="modal fade bd-example-modal-lg" data-refresh="true" id="{{ $id }}" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">{{ $title }}</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form method="POST">
                <div class="modal-body">
                    {{-- <x-form.input type="text" value="" name="cat_id" class="fas fa-pencil" /> --}}
                    <input class="form-control" type="text" name="{{ $nameId }}" placeholder="Enter Name:"
                        id="{{ $nameId }}" />
                    <p id="err1-{{ $nameId }}" class="text-danger text-sm"></p>
                    <div>
                        <span class="float-left"><b>Permisssion:</b></span>
                        <span class="float-right">
                            <input class="form-check-input" id="checkAll" type="checkbox" value=""
                                onchange="pushToArray('checkAll')"
                                >
                            <label class="form-check-label text-dark text-capitalize"
                                for="checkAll">
                                Check All
                            </label>
                        </span>
                    </div>
                    <br>
                    <div class="form-group clearfix">


                        {{-- <tr>
                                <td class="permission">Write</td>
                                <td class="permission">Edit</td>
                                <td class="permission">Publish</td>
                            </tr> --}}
                        <ul class="grid-list">
                            @foreach ($permissions as $permission)
                                <li class="nav-item">
                                    <div class="form-check">
                                        <input class="form-check-input permission"
                                            id="{{ str_replace(' ', '-', $permission->name) }}" type="checkbox"
                                            value="{{ $permission->name }}"
                                            onchange="pushToArray('{{ str_replace(' ', '-', $permission->name) }}')"
                                            name="permission">
                                        <label class="form-check-label text-dark text-capitalize"
                                            for="write-{{ $btnName }}">
                                            {{ $permission->name }}
                                        </label>
                                    </div>
                                </li>
                            @endforeach


                        </ul>

                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" data-refresh="">Close</button>
                    <button type="button" id="{{ $btnName }}"
                        class="btn btn-primary">{{ $btnName == 'edit' ? 'Save changes' : 'Add' }}</button>
                </div>
            </form>

        </div>
    </div>
</div>
