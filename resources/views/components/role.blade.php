<div class="form-group clearfix">
    <ul class="grid-list">
        @foreach ($permissions as $permission)
            @if (Str::contains($permission->name, $find))
                <li class="nav-item">
                    <div class="form-check">
                        <input class="form-check-input permission" id="{{ str_replace(' ', '-', $permission->name) }}" type="checkbox"
                            value="{{ $permission->name }}"
                            onchange="pushToArray('{{ str_replace(' ', '-', $permission->name) }}')" name="permission"
                            @if($pageName == 'edit')
                            @foreach ($role as $per)
                            {{ $per->name == $permission->name ? 'checked' : '' }} @endforeach
                            @endif>
                        <label class="form-check-label text-dark text-capitalize">
                            {{ $permission->name }}
                        </label>
                    </div>
                </li>
            @endif
        @endforeach
    </ul>
</div>
