<!-- Button trigger modal -->
<x-link />
<!-- Modal -->
<div class="modal fade" id="{{ $id }}" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
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
                    <div class="form-group clearfix">
                        &nbsp;
                        <table>
                            <tr>
                                <td class="permission">Write</td>
                                <td class="permission">Edit</td>
                                <td class="permission">Publish</td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="icheck-primary d-inline cols">
                                        <div class="switch-toggle">
                                            <input type="checkbox" id="write-{{ $btnName }}" value="write post">
                                            <label for="write-{{ $btnName }}"></label>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="icheck-primary d-inline cols">
                                        <div class="switch-toggle">
                                            <input type="checkbox" id="edit-{{ $btnName }}" value="edit post">
                                            <label for="edit-{{ $btnName }}"></label>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="icheck-primary d-inline cols">
                                        <div class="switch-toggle">
                                            <input type="checkbox" id="publish-{{ $btnName }}" value="publish post">
                                            <label for="publish-{{ $btnName }}"></label>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" id="{{ $btnName }}"
                        class="btn btn-primary">{{ $btnName == 'edit' ? 'Save changes' : 'Add' }}</button>
                </div>
            </form>

        </div>
    </div>
</div>
