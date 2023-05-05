
<x-form.login-layout>
    @extends('components.form.form', ['action' => '#', 'method' => 'get'])
    @section('form-data')
        <div class="card-body login-card-body">
            <p class="login-box-msg">Sign in to start your session</p>

            <x-form.input name="email" type="email" class="fas fa-envelope"/>
            <x-form.input name="password" type="password" class="fas fa-key"/>
            <div class="row">
                <x-form.checkbox name="remeber" type="checkbox"/>
                <div class="col-4">
                    <x-form.button type="submit" name="login"/>
                </div>
            </div>
            <div class="social-auth-links text-center mb-3">
                <p>-- OR --</p>
            </div>
            <!-- /.social-auth-links -->

            <p class="mb-1">
                <a href="/forgot-password">I forgot my password</a>
            </p>
            <p class="mb-0">
                <a href="/register" class="text-center">Register a new membership</a>
            </p>
        </div>
    @endsection
</x-form.login-layout>
