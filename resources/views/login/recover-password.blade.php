<x-form.login-layout>
    @extends('components.form.form', ['action' => '#', 'method' => 'get'])
    @section('form-data')
        <div class="card-body login-card-body">
            <p class="login-box-msg">Recover your password now.</p>
            <x-form.input name="password" type="password" class="fas fa-key"></x-form.input>
            <x-form.input name="retype" type="password" class="fas fa-key"></x-form.input>
            <div class="row">
                <div class="col-12">
                    <x-form.button type="submit" name="Change password"></x-form.button>
                </div>
            </div>
            <p class="mt-3 mb-1">
                <a href="/login">Login</a>
            </p>
        </div>
        <!-- /.login-card-body -->
        </div>
    @endsection
</x-form.layout>
