<x-form.login-layout>

    @extends('components.form.form', ['action' => '/login', 'method' => 'POST'])

    @section('form-data')
        @csrf
        <div class="card-body login-card-body">
            <p class="login-box-msg">Sign in to start your session</p>

            <x-form.input name="email" type="email" class="fas fa-envelope" value="{{ old('email') }}" />
            @error('email')
                <p class="text-sm text-danger">* {{ $message }}</p>
            @enderror
            <x-form.input name="password" type="password" class="fas fa-key" value="{{ old('password') }}" />
            @error('password')
                <p class="text-sm text-danger">* {{ $message }}</p>
            @enderror
            @error('Invalid')
                <p class="text-sm text-danger">* {{ $message }}</p>
            @enderror
            <div class="row">
                {{-- <x-form.checkbox name="remeber" type="checkbox"/> --}}
                <div class="col-4">
                    <x-form.button type="submit" name="login" />
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
