<x-form.login-layout>
    @extends('components.form.form', ['action' => '#', 'method' => 'get'])
    @section('form-data')
        <div class="card-body register-card-body">
            <p class="login-box-msg">Register a new membership</p>

            <x-form.input type="text" name="full-name" class="fas fa-user"></x-form.input>
            <x-form.input type="email" name="email" class="fas fa-envelope"></x-form.input>
      
            <x-form.input type="password" name="password" class="fas fa-key"></x-form.input>
            <x-form.input type="password" name="retype" class="fas fa-key"></x-form.input>
            <div class="row">
               <x-form.checkbox type="checkbox" name="remember"></x-form.checkbox>
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
