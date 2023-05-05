<x-form.login-layout>
    @extends('components.form.form', ['action' => '#', 'method' => 'get'])
    @section('form-data')
        <div class="card-body login-card-body">
            <p class="login-box-msg">Here you can easily retrieve a new password.</p>

            <x-form.input name="email" type="email" class="fas fa-envelope"></x-form.input>
            <div class="row">
                <div class="col-12">
                    <x-form.button type="submit" name="Request New Password"></x-form.button>
                </div>
                <!-- /.col -->
            </div>

            <p class="mt-3 mb-1">
                <a href="/login">Login</a>
            </p>
            <p class="mb-0">
                <a href="/register" class="text-center">Register a new membership</a>
            </p>
        </div>
    @endsection
</x-form.login-layout>
