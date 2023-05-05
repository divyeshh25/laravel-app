@props(
    [
        'action'=>'',
        'method'=>''
    ]
)
<form 
    action="{{ $action }}" 
    method="{{ $method }}">
@yield('form-data')
</form>