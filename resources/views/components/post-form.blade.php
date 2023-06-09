<div>
    <!-- Very little is needed to make a happy life. - Marcus Aurelius -->
    <form {{ $attributes }} enctype="multipart/form-data">
        @csrf
        @if ($otherMethod != '')
            @method('PATCH')
        @endif
        <div class="form-group">
            <label for="">Select Category</label>
            <select class="custom-select" id="{{ $iDName }}Cat" name="{{ $iDName }}Cat">
                <option value="Select Category" selected>Select Category</option>

                @foreach ($categories as $category)
                    <option value="{{ $category->id }}">{{ $category->name }}</option>
                @endforeach
            </select>
            @error($iDName . 'Cat')
                <p class="text-sm text-danger ">{{ $message }}</p>
            @enderror
        </div>
        <div class="form-group">
            <label for="">Title</label>
            <input type="text" class="form-control" name="{{ $iDName }}Title" id="{{ $iDName }}Title"
                placeholder="Enter Title" value="{{ old($iDName.'Title') }}">
            @error($iDName . 'Title')
                <p class="text-sm text-danger ">{{ $message }}</p>
            @enderror
        </div>
        {{-- {{ $ExcerotID }} --}}
        <div class="form-group">
            <label for="">Excerpt</label>
            <textarea class="form-control" name="{{ $iDName }}Excerpt" id="{{ $iDName }}Excerpt"
                placeholder="Enter Short Description Here">{{ old($iDName.'Excerpt') }}</textarea>
            @error($iDName . 'Excerpt')
                <p class="text-sm text-danger ">{{ $message }}</p>
            @enderror
        </div>
        <div class="form-group">
            <label for="">Body</label>
            <textarea class="form-control" name="{{ $iDName }}Body" placeholder="Enter Body Here"
                id="{{ $iDName }}Body">{{ old($iDName.'Body') }}</textarea>
            @error($iDName . 'Body')
                <p class="text-sm text-danger ">{{ $message }}</p>
            @enderror
        </div>
        @can('publish post')
            <div class="form-group">
                <label for="exampleInputEmail1">Status</label>
                <br>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="{{ $iDName }}Status" value="0" checked>
                    <label class="form-check-label" for="">Active</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="{{ $iDName }}Status" value="1">
                    <label class="form-check-label" for="">Inactive</label>
                </div>
            </div>
        @endcan
        <div class="form-group">
            <label for="">Related Image</label>
            <input type="file" class="form-control" name="{{ $iDName }}Img" id="{{ $iDName }}Img"
                placeholder="Enter Title" value="{{ old($iDName.'Img') }}">
            @error($iDName . 'Img')
                <p class="text-sm text-danger ">{{ $message }}</p>
            @enderror
        </div>
        <div class="form-group">
            <input type="{{ $btnType }}" id="{{ $iDName }}Btn"
                value="{{ $iDName == 'add' ? 'Add Post' : 'Save Changes' }}">
        </div>
    </form>
</div>
