<x-form.login-layout>
    @extends('components.form.form', ['action' => '/register', 'method' => 'POST'])
    @section('form-data')
        @csrf
        <div class="card-body register-card-body">
            <p class="login-box-msg">Register a new membership</p>

            <x-form.input type="text" name="name" class="fas fa-user" value="{{ old('name') }}"></x-form.input>
            @error('name')
                <p class="text-sm text-danger">* {{ $message }}</p>
            @enderror
            <x-form.input type="email" name="email" class="fas fa-envelope" value="{{ old('email') }}"></x-form.input>
            @error('email')
                <p class="text-sm text-danger">* {{ $message }}</p>
            @enderror
            <x-form.input type="password" name="password" class="fas fa-key" value="{{ old('password') }}"></x-form.input>
            @error('password')
                <p class="text-sm text-danger">* {{ $message }}</p>
            @enderror
            <x-form.input type="password" name="retype" class="fas fa-key" value="{{ old('retype') }}"></x-form.input>
            <div class="row">
                {{-- <x-form.checkbox type="checkbox" name="remember"></x-form.checkbox> --}}
                <div class="col-4">
                    <x-form.button type="submit" name="signup"></x-form.button>
                </div>
            </div>
            <div class="social-auth-links text-center">
                <p>-- OR --</p>
            </div>
            <a href="/login" class="text-center">I already have a membership</a>
        </div>
        </div>
    @endsection
    </x-form.layout>
