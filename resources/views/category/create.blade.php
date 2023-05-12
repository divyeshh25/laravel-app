<x-link/>
<x-sidebar.sidebar/>
<section class="content-wrapper">
    <div class="container-fluid">
        <form action="create" method="post">
            @csrf
                {{-- <x-form.input type="text" value="" name="cat_id" class="fas fa-pencil" /> --}}
                <x-form.input type="text" value="" name="name" class="fas fa-pencil" />
                @error('name')
                        <p>{{ $message }}</p>
                @enderror
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="status" id="status1" value='0' checked>
                    <label class="form-check-label" for="flexRadioDefault1">
                        Active
                    </label>
                </div>

                <div class="form-check">
                    <input class="form-check-input" type="radio" name="status" id="status2" value='1'>
                    <label class="form-check-label" for="flexRadioDefault2">
                        Inactive
                    </label>
                </div>

                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="submit" id="butsave" class="btn btn-primary">Save changes</button>
        </form>
    </div>
</section>
