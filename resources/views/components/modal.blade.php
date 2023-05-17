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
            <form action="{{ $action }}" method="{{ $method }}">
                @csrf
                {{-- @method('{{ $method2 }}') --}}
                <div class="modal-body">
                    {{-- <x-form.input type="text" value="" name="cat_id" class="fas fa-pencil" /> --}}
                    <input class="form-control" type="text"  name="{{ $nameId }}"
                        placeholder="Enter Category Name:" id="{{ $nameId }}"/>
                    <p id="{{ $errName }}-name" class="text-danger text-sm"></p>
                    <div class="flex form-check">
                            <input class="form-check-input" type="radio" name="{{ $statusName }}" id="status1" value='0'
                                checked>
                            <label class="form-check-label" for="flexRadioDefault1">
                                Active
                            </label>
                            <input class="form-check-input ml-2" type="radio" name="{{ $statusName }}" id="status2" value='1'>
                            <label class="form-check-label ml-4" for="flexRadioDefault2">
                                Inactive
                            </label>

                    </div>
                    <p id="{{ $errName }}-status" class="text-danger text-sm"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="{{ $btnType }}" id="{{ $btnname }}" class="btn btn-primary">Save changes</button>
                </div>
            </form>
        </div>
    </div>
</div>
