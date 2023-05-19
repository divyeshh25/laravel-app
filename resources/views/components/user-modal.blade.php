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
                    <input class="form-control" type="text" name="{{ $emailId }}" placeholder="Enter Email:"
                        id="{{ $emailId }}" />
                    <p id="err1-{{ $emailId }}" class="text-danger text-sm"></p>
                    {{-- @if ($btnname == 'add')
                        <input class="form-control" type="text" name="{{ $passId }}" placeholder="Enter Password:"
                            id="{{ $passId }}" />
                        <p id="err1-{{ $passId }}" class="text-danger text-sm"></p>
                    @endif --}}
                    <div class="flex form-check">
                        @foreach ($roles as $role)
                            <input class="form-check-input " type="radio" name="{{ $statusName }}" id="status1"
                                value='{{ $role->name }}'>
                            <label class="form-check-label mr-4" for="flexRadioDefault1">
                                {{ $role->name }}
                            </label>
                        @endforeach
                    </div>
                    <p id="{{ $errName }}-status" class="text-danger text-sm"></p>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" id="{{ $btnname }}"
                        class="btn btn-primary">{{ $btnname == 'edit' ? 'Save changes' : 'Add' }}</button>
                </div>
            </form>

        </div>
    </div>
</div>
