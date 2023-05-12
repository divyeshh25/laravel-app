<div class="input-group mb-3">
    <input type="{{ $type }}" class="form-control" placeholder="{{ $name }}"
        name="{{ $name }}"
        id="{{ $name }}"
        value="{{ $value }}">
    <div class="input-group-append">
        <div class="input-group-text">
            <span {{ $attributes }}></span>
        </div>
    </div>
</div>
