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
                            @endif
                            style="cursor: pointer;">
                        <label class="form-check-label text-dark text-capitalize" for="{{ str_replace(' ', '-', $permission->name) }}" style="cursor: pointer; user-select: none;">
                            {{ $permission->name }}
                        </label>
                    </div>
                </li>
            @endif
        @endforeach
    </ul>
</div>
