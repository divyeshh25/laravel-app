[1mdiff --git a/.env b/.env[m
[1mindex 952cb41..bb8697f 100644[m
[1m--- a/.env[m
[1m+++ b/.env[m
[36m@@ -13,7 +13,7 @@[m [mDB_HOST=127.0.0.1[m
 DB_PORT=3306[m
 DB_DATABASE=login_system[m
 DB_USERNAME=root[m
[31m-DB_PASSWORD=[m
[32m+[m[32mDB_PASSWORD=password[m
 [m
 BROADCAST_DRIVER=log[m
 CACHE_DRIVER=file[m
[1mdiff --git a/app/Http/Middleware/RedirectIfAuthenticated.php b/app/Http/Middleware/RedirectIfAuthenticated.php[m
[1mindex afc78c4..d3de767 100644[m
[1m--- a/app/Http/Middleware/RedirectIfAuthenticated.php[m
[1m+++ b/app/Http/Middleware/RedirectIfAuthenticated.php[m
[36m@@ -21,7 +21,7 @@[m [mpublic function handle(Request $request, Closure $next, string ...$guards): Resp[m
 [m
         foreach ($guards as $guard) {[m
             if (Auth::guard($guard)->check()) {[m
[31m-                return redirect(RouteServiceProvider::HOME);[m
[32m+[m[32m                return redirect('/dashboard');[m
             }[m
         }[m
 [m
[1mdiff --git a/app/Models/User.php b/app/Models/User.php[m
[1mindex 23b4063..808b8a2 100644[m
[1m--- a/app/Models/User.php[m
[1m+++ b/app/Models/User.php[m
[36m@@ -4,6 +4,7 @@[m
 [m
 // use Illuminate\Contracts\Auth\MustVerifyEmail;[m
 use Illuminate\Database\Eloquent\Factories\HasFactory;[m
[32m+[m[32muse Illuminate\Database\Eloquent\Relations\HasMany;[m
 use Illuminate\Foundation\Auth\User as Authenticatable;[m
 use Illuminate\Notifications\Notifiable;[m
 use Laravel\Sanctum\HasApiTokens;[m
[36m@@ -17,21 +18,16 @@[m [mclass User extends Authenticatable[m
      *[m
      * @var array<int, string>[m
      */[m
[31m-    protected $fillable = [[m
[31m-        'name',[m
[31m-        'email',[m
[31m-        'password',[m
[31m-    ];[m
[32m+[m[32m    // protected $with = ['category'];[m
[32m+[m
[32m+[m[32m    protected $fillable = ['name', 'email', 'password'];[m
 [m
     /**[m
      * The attributes that should be hidden for serialization.[m
      *[m
      * @var array<int, string>[m
      */[m
[31m-    protected $hidden = [[m
[31m-        'password',[m
[31m-        'remember_token',[m
[31m-    ];[m
[32m+[m[32m    protected $hidden = ['password', 'remember_token'];[m
 [m
     /**[m
      * The attributes that should be cast.[m
[36m@@ -41,4 +37,22 @@[m [mclass User extends Authenticatable[m
     protected $casts = [[m
         'email_verified_at' => 'datetime',[m
     ];[m
[32m+[m[32m    public function setpasswordAttribute($password)[m
[32m+[m[32m    {[m
[32m+[m[32m        // return $password;[m
[32m+[m[32m        $this->attributes['password'] = bcrypt($password);[m
[32m+[m[32m    }[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Get all of the comments for the User[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return \Illuminate\Database\Eloquent\Relations\HasMany[m
[32m+[m[32m     */[m
[32m+[m[32m    public function categories(): HasMany[m
[32m+[m[32m    {[m
[32m+[m[32m        return $this->hasMany(Category::class, 'user_id', 'id');[m
[32m+[m[32m    }[m
[32m+[m[32m    public function posts(): HasMany[m
[32m+[m[32m    {[m
[32m+[m[32m        return $this->hasMany(Post::class, 'user_id', 'id');[m
[32m+[m[32m    }[m
 }[m
[1mdiff --git a/app/View/Components/cards/SmCard.php b/app/View/Components/cards/SmCard.php[m
[1mindex 1f99b14..e73bf66 100644[m
[1m--- a/app/View/Components/cards/SmCard.php[m
[1m+++ b/app/View/Components/cards/SmCard.php[m
[36m@@ -14,6 +14,7 @@[m [mclass SmCard extends Component[m
     public $msg2 = '';[m
     public function __construct($icon,$bgcolor,$msg1,$msg2)[m
     {[m
[32m+[m
         $this->icon = $icon;[m
         $this->bgcolor = $bgcolor;[m
         $this->msg1 = $msg1;[m
[1mdiff --git a/composer.json b/composer.json[m
[1mindex 4ac9c6a..0434d49 100644[m
[1m--- a/composer.json[m
[1m+++ b/composer.json[m
[36m@@ -9,7 +9,8 @@[m
         "guzzlehttp/guzzle": "^7.2",[m
         "laravel/framework": "^10.8",[m
         "laravel/sanctum": "^3.2",[m
[31m-        "laravel/tinker": "^2.8"[m
[32m+[m[32m        "laravel/tinker": "^2.8",[m
[32m+[m[32m        "yajra/laravel-datatables-oracle": "^10.4"[m
     },[m
     "require-dev": {[m
         "fakerphp/faker": "^1.9.1",[m
[1mdiff --git a/composer.lock b/composer.lock[m
[1mindex 8b830cd..d5aefcd 100644[m
[1m--- a/composer.lock[m
[1m+++ b/composer.lock[m
[36m@@ -4,7 +4,7 @@[m
         "Read more about it at https://getcomposer.org/doc/01-basic-usage.md#installing-dependencies",[m
         "This file is @generated automatically"[m
     ],[m
[31m-    "content-hash": "8e6e7fe5fd9d19060838a2fee2857ca4",[m
[32m+[m[32m    "content-hash": "e1fa7c803071bccc21ef85e80250bca5",[m
     "packages": [[m
         {[m
             "name": "brick/math",[m
[36m@@ -5399,6 +5399,90 @@[m
                 "source": "https://github.com/webmozarts/assert/tree/1.11.0"[m
             },[m
             "time": "2022-06-03T18:03:27+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "yajra/laravel-datatables-oracle",[m
[32m+[m[32m            "version": "v10.4.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/yajra/laravel-datatables.git",[m
[32m+[m[32m                "reference": "2e641c3a5d4414dc2b0fce89ab0c74d73fbf7eb3"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/yajra/laravel-datatables/zipball/2e641c3a5d4414dc2b0fce89ab0c74d73fbf7eb3",[m
[32m+[m[32m                "reference": "2e641c3a5d4414dc2b0fce89ab0c74d73fbf7eb3",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "illuminate/database": "^9|^10",[m
[32m+[m[32m                "illuminate/filesystem": "^9|^10",[m
[32m+[m[32m                "illuminate/http": "^9|^10",[m
[32m+[m[32m                "illuminate/support": "^9|^10",[m
[32m+[m[32m                "illuminate/view": "^9|^10",[m
[32m+[m[32m                "php": "^8.0.2"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "nunomaduro/larastan": "^2.4",[m
[32m+[m[32m                "orchestra/testbench": "^8",[m
[32m+[m[32m                "yajra/laravel-datatables-html": "^9.3.4|^10"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "yajra/laravel-datatables-buttons": "Plugin for server-side exporting of dataTables.",[m
[32m+[m[32m                "yajra/laravel-datatables-editor": "Plugin to use DataTables Editor (requires a license).",[m
[32m+[m[32m                "yajra/laravel-datatables-export": "Plugin for server-side exporting using livewire and queue worker.",[m
[32m+[m[32m                "yajra/laravel-datatables-fractal": "Plugin for server-side response using Fractal.",[m
[32m+[m[32m                "yajra/laravel-datatables-html": "Plugin for server-side HTML builder of dataTables."[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "10.x-dev"[m
[32m+[m[32m                },[m
[32m+[m[32m                "laravel": {[m
[32m+[m[32m                    "providers": [[m
[32m+[m[32m                        "Yajra\\DataTables\\DataTablesServiceProvider"[m
[32m+[m[32m                    ],[m
[32m+[m[32m                    "aliases": {[m
[32m+[m[32m                        "DataTables": "Yajra\\DataTables\\Facades\\DataTables"[m
[32m+[m[32m                    }[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "src/helper.php"[m
[32m+[m[32m                ],[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Yajra\\DataTables\\": "src/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Arjay Angeles",[m
[32m+[m[32m                    "email": "aqangeles@gmail.com"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "jQuery DataTables API for Laravel 4|5|6|7|8|9|10",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "datatables",[m
[32m+[m[32m                "jquery",[m
[32m+[m[32m                "laravel"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/yajra/laravel-datatables/issues",[m
[32m+[m[32m                "source": "https://github.com/yajra/laravel-datatables/tree/v10.4.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/sponsors/yajra",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2023-03-28T07:33:58+00:00"[m
         }[m
     ],[m
     "packages-dev": [[m
[1mdiff --git a/config/app.php b/config/app.php[m
[1mindex 4c231b4..e392339 100644[m
[1m--- a/config/app.php[m
[1m+++ b/config/app.php[m
[36m@@ -4,7 +4,6 @@[m
 use Illuminate\Support\ServiceProvider;[m
 [m
 return [[m
[31m-[m
     /*[m
     |--------------------------------------------------------------------------[m
     | Application Name[m
[36m@@ -155,20 +154,27 @@[m
     |[m
     */[m
 [m
[31m-    'providers' => ServiceProvider::defaultProviders()->merge([[m
[31m-        /*[m
[31m-         * Package Service Providers...[m
[31m-         */[m
[31m-[m
[31m-        /*[m
[31m-         * Application Service Providers...[m
[31m-         */[m
[31m-        App\Providers\AppServiceProvider::class,[m
[31m-        App\Providers\AuthServiceProvider::class,[m
[31m-        // App\Providers\BroadcastServiceProvider::class,[m
[31m-        App\Providers\EventServiceProvider::class,[m
[31m-        App\Providers\RouteServiceProvider::class,[m
[31m-    ])->toArray(),[m
[32m+[m[32m    'providers' => [Yajra\DataTables\DataTablesServiceProvider::class],[m
[32m+[m[32m    'aliases' => [[m
[32m+[m[32m        'DataTables' => Yajra\DataTables\Facades\DataTables::class,[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m    'providers' => ServiceProvider::defaultProviders()[m
[32m+[m[32m        ->merge([[m
[32m+[m[32m            /*[m
[32m+[m[32m             * Package Service Providers...[m
[32m+[m[32m             */[m
[32m+[m
[32m+[m[32m            /*[m
[32m+[m[32m             * Application Service Providers...[m
[32m+[m[32m             */[m
[32m+[m[32m            App\Providers\AppServiceProvider::class,[m
[32m+[m[32m            App\Providers\AuthServiceProvider::class,[m
[32m+[m[32m            // App\Providers\BroadcastServiceProvider::class,[m
[32m+[m[32m            App\Providers\EventServiceProvider::class,[m
[32m+[m[32m            App\Providers\RouteServiceProvider::class,[m
[32m+[m[32m        ])[m
[32m+[m[32m        ->toArray(),[m
 [m
     /*[m
     |--------------------------------------------------------------------------[m
[36m@@ -181,8 +187,9 @@[m
     |[m
     */[m
 [m
[31m-    'aliases' => Facade::defaultAliases()->merge([[m
[31m-        // 'Example' => App\Facades\Example::class,[m
[31m-    ])->toArray(),[m
[31m-[m
[32m+[m[32m    'aliases' => Facade::defaultAliases()[m
[32m+[m[32m        ->merge([[m
[32m+[m[32m            // 'Example' => App\Facades\Example::class,[m
[32m+[m[32m        ])[m
[32m+[m[32m        ->toArray(),[m
 ];[m
[1mdiff --git a/config/filesystems.php b/config/filesystems.php[m
[1mindex e9d9dbd..185fd1d 100644[m
[1m--- a/config/filesystems.php[m
[1m+++ b/config/filesystems.php[m
[36m@@ -32,7 +32,7 @@[m
 [m
         'local' => [[m
             'driver' => 'local',[m
[31m-            'root' => storage_path('app'),[m
[32m+[m[32m            'root' => public_path(),[m
             'throw' => false,[m
         ],[m
 [m
[1mdiff --git a/database/seeders/DatabaseSeeder.php b/database/seeders/DatabaseSeeder.php[m
[1mindex a9f4519..7360780 100644[m
[1m--- a/database/seeders/DatabaseSeeder.php[m
[1m+++ b/database/seeders/DatabaseSeeder.php[m
[36m@@ -14,9 +14,16 @@[m [mpublic function run(): void[m
     {[m
         // \App\Models\User::factory(10)->create();[m
 [m
[31m-        // \App\Models\User::factory()->create([[m
[31m-        //     'name' => 'Test User',[m
[31m-        //     'email' => 'test@example.com',[m
[31m-        // ]);[m
[32m+[m[32m        \App\Models\User::factory()->create([[m
[32m+[m[32m            'name' => 'Test User',[m
[32m+[m[32m            'email' => 'test@example.com',[m
[32m+[m[32m            'password'=> '12345678'[m
[32m+[m[32m        ]);[m
[32m+[m[32m        \App\Models\User::factory()->create([[m
[32m+[m[32m            'name' => 'Test User2',[m
[32m+[m[32m            'email' => 'test1@example.com',[m
[32m+[m[32m            'password'=> '12345678'[m
[32m+[m[32m        ]);[m
[32m+[m[32m        // \App\Models\PostCategory::factory(2)->create();[m
     }[m
 }[m
[1mdiff --git a/public/css/adminlte.min.css b/public/css/adminlte.min.css[m
[1mindex 49d8c14..45e8d6a 100644[m
[1m--- a/public/css/adminlte.min.css[m
[1m+++ b/public/css/adminlte.min.css[m
[36m@@ -8,5 +8,5 @@[m
  * Copyright 2011-2021 The Bootstrap Authors[m
  * Copyright 2011-2021 Twitter, Inc.[m
  * Licensed under MIT (https://github.com/twbs/bootstrap/blob/main/LICENSE)[m
[31m-/*# sourceMappingURL=adminlte.min.css.map */[m
\ No newline at end of file[m
[32m+[m[32m/*# sourceMappingURL=adminlte.min.css.map */[m
[1mdiff --git a/public/js/demo.js b/public/js/demo.js[m
[1mindex 5627e56..7d08573 100644[m
[1m--- a/public/js/demo.js[m
[1m+++ b/public/js/demo.js[m
[36m@@ -8,682 +8,682 @@[m
 /* eslint-disable camelcase */[m
 [m
 (function ($) {[m
[31m-  'use strict'[m
[32m+[m[32m    'use strict'[m
 [m
[31m-  setTimeout(function () {[m
[31m-    if (window.___browserSync___ === undefined && Number(localStorage.getItem('AdminLTE:Demo:MessageShowed')) < Date.now()) {[m
[31m-      localStorage.setItem('AdminLTE:Demo:MessageShowed', (Date.now()) + (15 * 60 * 1000))[m
[31m-      // eslint-disable-next-line no-alert[m
[31m-      alert('You load AdminLTE\'s "demo.js", \nthis file is only created for testing purposes!')[m
[32m+[m[32m    setTimeout(function () {[m
[32m+[m[32m      if (window.___browserSync___ === undefined && Number(localStorage.getItem('AdminLTE:Demo:MessageShowed')) < Date.now()) {[m
[32m+[m[32m        localStorage.setItem('AdminLTE:Demo:MessageShowed', (Date.now()) + (15 * 60 * 1000))[m
[32m+[m[32m        // eslint-disable-next-line no-alert[m
[32m+[m[32m      //   alert('You load AdminLTE\'s "demo.js", \nthis file is only created for testing purposes!')[m
[32m+[m[32m      }[m
[32m+[m[32m    }, 1000)[m
[32m+[m
[32m+[m[32m    function capitalizeFirstLetter(string) {[m
[32m+[m[32m      return string.charAt(0).toUpperCase() + string.slice(1)[m
     }[m
[31m-  }, 1000)[m
 [m
[31m-  function capitalizeFirstLetter(string) {[m
[31m-    return string.charAt(0).toUpperCase() + string.slice(1)[m
[31m-  }[m
[32m+[m[32m    function createSkinBlock(colors, callback, noneSelected) {[m
[32m+[m[32m      var $block = $('<select />', {[m
[32m+[m[32m        class: noneSelected ? 'custom-select mb-3 border-0' : 'custom-select mb-3 text-light border-0 ' + colors[0].replace(/accent-|navbar-/, 'bg-')[m
[32m+[m[32m      })[m
 [m
[31m-  function createSkinBlock(colors, callback, noneSelected) {[m
[31m-    var $block = $('<select />', {[m
[31m-      class: noneSelected ? 'custom-select mb-3 border-0' : 'custom-select mb-3 text-light border-0 ' + colors[0].replace(/accent-|navbar-/, 'bg-')[m
[31m-    })[m
[32m+[m[32m      if (noneSelected) {[m
[32m+[m[32m        var $default = $('<option />', {[m
[32m+[m[32m          text: 'None Selected'[m
[32m+[m[32m        })[m
 [m
[31m-    if (noneSelected) {[m
[31m-      var $default = $('<option />', {[m
[31m-        text: 'None Selected'[m
[32m+[m[32m        $block.append($default)[m
[32m+[m[32m      }[m
[32m+[m
[32m+[m[32m      colors.forEach(function (color) {[m
[32m+[m[32m        var $color = $('<option />', {[m
[32m+[m[32m          class: (typeof color === 'object' ? color.join(' ') : color).replace('navbar-', 'bg-').replace('accent-', 'bg-'),[m
[32m+[m[32m          text: capitalizeFirstLetter((typeof color === 'object' ? color.join(' ') : color).replace(/navbar-|accent-|bg-/, '').replace('-', ' '))[m
[32m+[m[32m        })[m
[32m+[m
[32m+[m[32m        $block.append($color)[m
       })[m
[32m+[m[32m      if (callback) {[m
[32m+[m[32m        $block.on('change', callback)[m
[32m+[m[32m      }[m
 [m
[31m-      $block.append($default)[m
[32m+[m[32m      return $block[m
     }[m
 [m
[31m-    colors.forEach(function (color) {[m
[31m-      var $color = $('<option />', {[m
[31m-        class: (typeof color === 'object' ? color.join(' ') : color).replace('navbar-', 'bg-').replace('accent-', 'bg-'),[m
[31m-        text: capitalizeFirstLetter((typeof color === 'object' ? color.join(' ') : color).replace(/navbar-|accent-|bg-/, '').replace('-', ' '))[m
[32m+[m[32m    var $sidebar = $('.control-sidebar')[m
[32m+[m[32m    var $container = $('<div />', {[m
[32m+[m[32m      class: 'p-3 control-sidebar-content'[m
[32m+[m[32m    })[m
[32m+[m
[32m+[m[32m    $sidebar.append($container)[m
[32m+[m
[32m+[m[32m    // Checkboxes[m
[32m+[m
[32m+[m[32m    $container.append([m
[32m+[m[32m      '<h5>Customize AdminLTE</h5><hr class="mb-2"/>'[m
[32m+[m[32m    )[m
[32m+[m
[32m+[m[32m    var $dark_mode_checkbox = $('<input />', {[m
[32m+[m[32m      type: 'checkbox',[m
[32m+[m[32m      value: 1,[m
[32m+[m[32m      checked: $('body').hasClass('dark-mode'),[m
[32m+[m[32m      class: 'mr-1'[m
[32m+[m[32m    }).on('click', function () {[m
[32m+[m[32m      if ($(this).is(':checked')) {[m
[32m+[m[32m        $('body').addClass('dark-mode')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $('body').removeClass('dark-mode')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
[32m+[m[32m    var $dark_mode_container = $('<div />', { class: 'mb-4' }).append($dark_mode_checkbox).append('<span>Dark Mode</span>')[m
[32m+[m[32m    $container.append($dark_mode_container)[m
[32m+[m
[32m+[m[32m    $container.append('<h6>Header Options</h6>')[m
[32m+[m[32m    var $header_fixed_checkbox = $('<input />', {[m
[32m+[m[32m      type: 'checkbox',[m
[32m+[m[32m      value: 1,[m
[32m+[m[32m      checked: $('body').hasClass('layout-navbar-fixed'),[m
[32m+[m[32m      class: 'mr-1'[m
[32m+[m[32m    }).on('click', function () {[m
[32m+[m[32m      if ($(this).is(':checked')) {[m
[32m+[m[32m        $('body').addClass('layout-navbar-fixed')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $('body').removeClass('layout-navbar-fixed')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
[32m+[m[32m    var $header_fixed_container = $('<div />', { class: 'mb-1' }).append($header_fixed_checkbox).append('<span>Fixed</span>')[m
[32m+[m[32m    $container.append($header_fixed_container)[m
[32m+[m
[32m+[m[32m    var $dropdown_legacy_offset_checkbox = $('<input />', {[m
[32m+[m[32m      type: 'checkbox',[m
[32m+[m[32m      value: 1,[m
[32m+[m[32m      checked: $('.main-header').hasClass('dropdown-legacy'),[m
[32m+[m[32m      class: 'mr-1'[m
[32m+[m[32m    }).on('click', function () {[m
[32m+[m[32m      if ($(this).is(':checked')) {[m
[32m+[m[32m        $('.main-header').addClass('dropdown-legacy')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $('.main-header').removeClass('dropdown-legacy')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
[32m+[m[32m    var $dropdown_legacy_offset_container = $('<div />', { class: 'mb-1' }).append($dropdown_legacy_offset_checkbox).append('<span>Dropdown Legacy Offset</span>')[m
[32m+[m[32m    $container.append($dropdown_legacy_offset_container)[m
[32m+[m
[32m+[m[32m    var $no_border_checkbox = $('<input />', {[m
[32m+[m[32m      type: 'checkbox',[m
[32m+[m[32m      value: 1,[m
[32m+[m[32m      checked: $('.main-header').hasClass('border-bottom-0'),[m
[32m+[m[32m      class: 'mr-1'[m
[32m+[m[32m    }).on('click', function () {[m
[32m+[m[32m      if ($(this).is(':checked')) {[m
[32m+[m[32m        $('.main-header').addClass('border-bottom-0')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $('.main-header').removeClass('border-bottom-0')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
[32m+[m[32m    var $no_border_container = $('<div />', { class: 'mb-4' }).append($no_border_checkbox).append('<span>No border</span>')[m
[32m+[m[32m    $container.append($no_border_container)[m
[32m+[m
[32m+[m[32m    $container.append('<h6>Sidebar Options</h6>')[m
[32m+[m
[32m+[m[32m    var $sidebar_collapsed_checkbox = $('<input />', {[m
[32m+[m[32m      type: 'checkbox',[m
[32m+[m[32m      value: 1,[m
[32m+[m[32m      checked: $('body').hasClass('sidebar-collapse'),[m
[32m+[m[32m      class: 'mr-1'[m
[32m+[m[32m    }).on('click', function () {[m
[32m+[m[32m      if ($(this).is(':checked')) {[m
[32m+[m[32m        $('body').addClass('sidebar-collapse')[m
[32m+[m[32m        $(window).trigger('resize')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $('body').removeClass('sidebar-collapse')[m
[32m+[m[32m        $(window).trigger('resize')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
[32m+[m[32m    var $sidebar_collapsed_container = $('<div />', { class: 'mb-1' }).append($sidebar_collapsed_checkbox).append('<span>Collapsed</span>')[m
[32m+[m[32m    $container.append($sidebar_collapsed_container)[m
[32m+[m
[32m+[m[32m    $(document).on('collapsed.lte.pushmenu', '[data-widget="pushmenu"]', function () {[m
[32m+[m[32m      $sidebar_collapsed_checkbox.prop('checked', true)[m
[32m+[m[32m    })[m
[32m+[m[32m    $(document).on('shown.lte.pushmenu', '[data-widget="pushmenu"]', function () {[m
[32m+[m[32m      $sidebar_collapsed_checkbox.prop('checked', false)[m
[32m+[m[32m    })[m
[32m+[m
[32m+[m[32m    var $sidebar_fixed_checkbox = $('<input />', {[m
[32m+[m[32m      type: 'checkbox',[m
[32m+[m[32m      value: 1,[m
[32m+[m[32m      checked: $('body').hasClass('layout-fixed'),[m
[32m+[m[32m      class: 'mr-1'[m
[32m+[m[32m    }).on('click', function () {[m
[32m+[m[32m      if ($(this).is(':checked')) {[m
[32m+[m[32m        $('body').addClass('layout-fixed')[m
[32m+[m[32m        $(window).trigger('resize')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $('body').removeClass('layout-fixed')[m
[32m+[m[32m        $(window).trigger('resize')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
[32m+[m[32m    var $sidebar_fixed_container = $('<div />', { class: 'mb-1' }).append($sidebar_fixed_checkbox).append('<span>Fixed</span>')[m
[32m+[m[32m    $container.append($sidebar_fixed_container)[m
[32m+[m
[32m+[m[32m    var $sidebar_mini_checkbox = $('<input />', {[m
[32m+[m[32m      type: 'checkbox',[m
[32m+[m[32m      value: 1,[m
[32m+[m[32m      checked: $('body').hasClass('sidebar-mini'),[m
[32m+[m[32m      class: 'mr-1'[m
[32m+[m[32m    }).on('click', function () {[m
[32m+[m[32m      if ($(this).is(':checked')) {[m
[32m+[m[32m        $('body').addClass('sidebar-mini')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $('body').removeClass('sidebar-mini')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
[32m+[m[32m    var $sidebar_mini_container = $('<div />', { class: 'mb-1' }).append($sidebar_mini_checkbox).append('<span>Sidebar Mini</span>')[m
[32m+[m[32m    $container.append($sidebar_mini_container)[m
[32m+[m
[32m+[m[32m    var $sidebar_mini_md_checkbox = $('<input />', {[m
[32m+[m[32m      type: 'checkbox',[m
[32m+[m[32m      value: 1,[m
[32m+[m[32m      checked: $('body').hasClass('sidebar-mini-md'),[m
[32m+[m[32m      class: 'mr-1'[m
[32m+[m[32m    }).on('click', function () {[m
[32m+[m[32m      if ($(this).is(':checked')) {[m
[32m+[m[32m        $('body').addClass('sidebar-mini-md')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $('body').removeClass('sidebar-mini-md')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
[32m+[m[32m    var $sidebar_mini_md_container = $('<div />', { class: 'mb-1' }).append($sidebar_mini_md_checkbox).append('<span>Sidebar Mini MD</span>')[m
[32m+[m[32m    $container.append($sidebar_mini_md_container)[m
[32m+[m
[32m+[m[32m    var $sidebar_mini_xs_checkbox = $('<input />', {[m
[32m+[m[32m      type: 'checkbox',[m
[32m+[m[32m      value: 1,[m
[32m+[m[32m      checked: $('body').hasClass('sidebar-mini-xs'),[m
[32m+[m[32m      class: 'mr-1'[m
[32m+[m[32m    }).on('click', function () {[m
[32m+[m[32m      if ($(this).is(':checked')) {[m
[32m+[m[32m        $('body').addClass('sidebar-mini-xs')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $('body').removeClass('sidebar-mini-xs')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
[32m+[m[32m    var $sidebar_mini_xs_container = $('<div />', { class: 'mb-1' }).append($sidebar_mini_xs_checkbox).append('<span>Sidebar Mini XS</span>')[m
[32m+[m[32m    $container.append($sidebar_mini_xs_container)[m
[32m+[m
[32m+[m[32m    var $flat_sidebar_checkbox = $('<input />', {[m
[32m+[m[32m      type: 'checkbox',[m
[32m+[m[32m      value: 1,[m
[32m+[m[32m      checked: $('.nav-sidebar').hasClass('nav-flat'),[m
[32m+[m[32m      class: 'mr-1'[m
[32m+[m[32m    }).on('click', function () {[m
[32m+[m[32m      if ($(this).is(':checked')) {[m
[32m+[m[32m        $('.nav-sidebar').addClass('nav-flat')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $('.nav-sidebar').removeClass('nav-flat')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
[32m+[m[32m    var $flat_sidebar_container = $('<div />', { class: 'mb-1' }).append($flat_sidebar_checkbox).append('<span>Nav Flat Style</span>')[m
[32m+[m[32m    $container.append($flat_sidebar_container)[m
[32m+[m
[32m+[m[32m    var $legacy_sidebar_checkbox = $('<input />', {[m
[32m+[m[32m      type: 'checkbox',[m
[32m+[m[32m      value: 1,[m
[32m+[m[32m      checked: $('.nav-sidebar').hasClass('nav-legacy'),[m
[32m+[m[32m      class: 'mr-1'[m
[32m+[m[32m    }).on('click', function () {[m
[32m+[m[32m      if ($(this).is(':checked')) {[m
[32m+[m[32m        $('.nav-sidebar').addClass('nav-legacy')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $('.nav-sidebar').removeClass('nav-legacy')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
[32m+[m[32m    var $legacy_sidebar_container = $('<div />', { class: 'mb-1' }).append($legacy_sidebar_checkbox).append('<span>Nav Legacy Style</span>')[m
[32m+[m[32m    $container.append($legacy_sidebar_container)[m
[32m+[m
[32m+[m[32m    var $compact_sidebar_checkbox = $('<input />', {[m
[32m+[m[32m      type: 'checkbox',[m
[32m+[m[32m      value: 1,[m
[32m+[m[32m      checked: $('.nav-sidebar').hasClass('nav-compact'),[m
[32m+[m[32m      class: 'mr-1'[m
[32m+[m[32m    }).on('click', function () {[m
[32m+[m[32m      if ($(this).is(':checked')) {[m
[32m+[m[32m        $('.nav-sidebar').addClass('nav-compact')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $('.nav-sidebar').removeClass('nav-compact')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
[32m+[m[32m    var $compact_sidebar_container = $('<div />', { class: 'mb-1' }).append($compact_sidebar_checkbox).append('<span>Nav Compact</span>')[m
[32m+[m[32m    $container.append($compact_sidebar_container)[m
[32m+[m
[32m+[m[32m    var $child_indent_sidebar_checkbox = $('<input />', {[m
[32m+[m[32m      type: 'checkbox',[m
[32m+[m[32m      value: 1,[m
[32m+[m[32m      checked: $('.nav-sidebar').hasClass('nav-child-indent'),[m
[32m+[m[32m      class: 'mr-1'[m
[32m+[m[32m    }).on('click', function () {[m
[32m+[m[32m      if ($(this).is(':checked')) {[m
[32m+[m[32m        $('.nav-sidebar').addClass('nav-child-indent')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $('.nav-sidebar').removeClass('nav-child-indent')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
[32m+[m[32m    var $child_indent_sidebar_container = $('<div />', { class: 'mb-1' }).append($child_indent_sidebar_checkbox).append('<span>Nav Child Indent</span>')[m
[32m+[m[32m    $container.append($child_indent_sidebar_container)[m
[32m+[m
[32m+[m[32m    var $child_hide_sidebar_checkbox = $('<input />', {[m
[32m+[m[32m      type: 'checkbox',[m
[32m+[m[32m      value: 1,[m
[32m+[m[32m      checked: $('.nav-sidebar').hasClass('nav-collapse-hide-child'),[m
[32m+[m[32m      class: 'mr-1'[m
[32m+[m[32m    }).on('click', function () {[m
[32m+[m[32m      if ($(this).is(':checked')) {[m
[32m+[m[32m        $('.nav-sidebar').addClass('nav-collapse-hide-child')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $('.nav-sidebar').removeClass('nav-collapse-hide-child')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
[32m+[m[32m    var $child_hide_sidebar_container = $('<div />', { class: 'mb-1' }).append($child_hide_sidebar_checkbox).append('<span>Nav Child Hide on Collapse</span>')[m
[32m+[m[32m    $container.append($child_hide_sidebar_container)[m
[32m+[m
[32m+[m[32m    var $no_expand_sidebar_checkbox = $('<input />', {[m
[32m+[m[32m      type: 'checkbox',[m
[32m+[m[32m      value: 1,[m
[32m+[m[32m      checked: $('.main-sidebar').hasClass('sidebar-no-expand'),[m
[32m+[m[32m      class: 'mr-1'[m
[32m+[m[32m    }).on('click', function () {[m
[32m+[m[32m      if ($(this).is(':checked')) {[m
[32m+[m[32m        $('.main-sidebar').addClass('sidebar-no-expand')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $('.main-sidebar').removeClass('sidebar-no-expand')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
[32m+[m[32m    var $no_expand_sidebar_container = $('<div />', { class: 'mb-4' }).append($no_expand_sidebar_checkbox).append('<span>Disable Hover/Focus Auto-Expand</span>')[m
[32m+[m[32m    $container.append($no_expand_sidebar_container)[m
[32m+[m
[32m+[m[32m    $container.append('<h6>Footer Options</h6>')[m
[32m+[m[32m    var $footer_fixed_checkbox = $('<input />', {[m
[32m+[m[32m      type: 'checkbox',[m
[32m+[m[32m      value: 1,[m
[32m+[m[32m      checked: $('body').hasClass('layout-footer-fixed'),[m
[32m+[m[32m      class: 'mr-1'[m
[32m+[m[32m    }).on('click', function () {[m
[32m+[m[32m      if ($(this).is(':checked')) {[m
[32m+[m[32m        $('body').addClass('layout-footer-fixed')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $('body').removeClass('layout-footer-fixed')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
[32m+[m[32m    var $footer_fixed_container = $('<div />', { class: 'mb-4' }).append($footer_fixed_checkbox).append('<span>Fixed</span>')[m
[32m+[m[32m    $container.append($footer_fixed_container)[m
[32m+[m
[32m+[m[32m    $container.append('<h6>Small Text Options</h6>')[m
[32m+[m
[32m+[m[32m    var $text_sm_body_checkbox = $('<input />', {[m
[32m+[m[32m      type: 'checkbox',[m
[32m+[m[32m      value: 1,[m
[32m+[m[32m      checked: $('body').hasClass('text-sm'),[m
[32m+[m[32m      class: 'mr-1'[m
[32m+[m[32m    }).on('click', function () {[m
[32m+[m[32m      if ($(this).is(':checked')) {[m
[32m+[m[32m        $('body').addClass('text-sm')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $('body').removeClass('text-sm')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
[32m+[m[32m    var $text_sm_body_container = $('<div />', { class: 'mb-1' }).append($text_sm_body_checkbox).append('<span>Body</span>')[m
[32m+[m[32m    $container.append($text_sm_body_container)[m
[32m+[m
[32m+[m[32m    var $text_sm_header_checkbox = $('<input />', {[m
[32m+[m[32m      type: 'checkbox',[m
[32m+[m[32m      value: 1,[m
[32m+[m[32m      checked: $('.main-header').hasClass('text-sm'),[m
[32m+[m[32m      class: 'mr-1'[m
[32m+[m[32m    }).on('click', function () {[m
[32m+[m[32m      if ($(this).is(':checked')) {[m
[32m+[m[32m        $('.main-header').addClass('text-sm')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $('.main-header').removeClass('text-sm')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
[32m+[m[32m    var $text_sm_header_container = $('<div />', { class: 'mb-1' }).append($text_sm_header_checkbox).append('<span>Navbar</span>')[m
[32m+[m[32m    $container.append($text_sm_header_container)[m
[32m+[m
[32m+[m[32m    var $text_sm_brand_checkbox = $('<input />', {[m
[32m+[m[32m      type: 'checkbox',[m
[32m+[m[32m      value: 1,[m
[32m+[m[32m      checked: $('.brand-link').hasClass('text-sm'),[m
[32m+[m[32m      class: 'mr-1'[m
[32m+[m[32m    }).on('click', function () {[m
[32m+[m[32m      if ($(this).is(':checked')) {[m
[32m+[m[32m        $('.brand-link').addClass('text-sm')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $('.brand-link').removeClass('text-sm')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
[32m+[m[32m    var $text_sm_brand_container = $('<div />', { class: 'mb-1' }).append($text_sm_brand_checkbox).append('<span>Brand</span>')[m
[32m+[m[32m    $container.append($text_sm_brand_container)[m
[32m+[m
[32m+[m[32m    var $text_sm_sidebar_checkbox = $('<input />', {[m
[32m+[m[32m      type: 'checkbox',[m
[32m+[m[32m      value: 1,[m
[32m+[m[32m      checked: $('.nav-sidebar').hasClass('text-sm'),[m
[32m+[m[32m      class: 'mr-1'[m
[32m+[m[32m    }).on('click', function () {[m
[32m+[m[32m      if ($(this).is(':checked')) {[m
[32m+[m[32m        $('.nav-sidebar').addClass('text-sm')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $('.nav-sidebar').removeClass('text-sm')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
[32m+[m[32m    var $text_sm_sidebar_container = $('<div />', { class: 'mb-1' }).append($text_sm_sidebar_checkbox).append('<span>Sidebar Nav</span>')[m
[32m+[m[32m    $container.append($text_sm_sidebar_container)[m
[32m+[m
[32m+[m[32m    var $text_sm_footer_checkbox = $('<input />', {[m
[32m+[m[32m      type: 'checkbox',[m
[32m+[m[32m      value: 1,[m
[32m+[m[32m      checked: $('.main-footer').hasClass('text-sm'),[m
[32m+[m[32m      class: 'mr-1'[m
[32m+[m[32m    }).on('click', function () {[m
[32m+[m[32m      if ($(this).is(':checked')) {[m
[32m+[m[32m        $('.main-footer').addClass('text-sm')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $('.main-footer').removeClass('text-sm')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
[32m+[m[32m    var $text_sm_footer_container = $('<div />', { class: 'mb-4' }).append($text_sm_footer_checkbox).append('<span>Footer</span>')[m
[32m+[m[32m    $container.append($text_sm_footer_container)[m
[32m+[m
[32m+[m[32m    // Color Arrays[m
[32m+[m
[32m+[m[32m    var navbar_dark_skins = [[m
[32m+[m[32m      'navbar-primary',[m
[32m+[m[32m      'navbar-secondary',[m
[32m+[m[32m      'navbar-info',[m
[32m+[m[32m      'navbar-success',[m
[32m+[m[32m      'navbar-danger',[m
[32m+[m[32m      'navbar-indigo',[m
[32m+[m[32m      'navbar-purple',[m
[32m+[m[32m      'navbar-pink',[m
[32m+[m[32m      'navbar-navy',[m
[32m+[m[32m      'navbar-lightblue',[m
[32m+[m[32m      'navbar-teal',[m
[32m+[m[32m      'navbar-cyan',[m
[32m+[m[32m      'navbar-dark',[m
[32m+[m[32m      'navbar-gray-dark',[m
[32m+[m[32m      'navbar-gray'[m
[32m+[m[32m    ][m
[32m+[m
[32m+[m[32m    var navbar_light_skins = [[m
[32m+[m[32m      'navbar-light',[m
[32m+[m[32m      'navbar-warning',[m
[32m+[m[32m      'navbar-white',[m
[32m+[m[32m      'navbar-orange'[m
[32m+[m[32m    ][m
[32m+[m
[32m+[m[32m    var sidebar_colors = [[m
[32m+[m[32m      'bg-primary',[m
[32m+[m[32m      'bg-warning',[m
[32m+[m[32m      'bg-info',[m
[32m+[m[32m      'bg-danger',[m
[32m+[m[32m      'bg-success',[m
[32m+[m[32m      'bg-indigo',[m
[32m+[m[32m      'bg-lightblue',[m
[32m+[m[32m      'bg-navy',[m
[32m+[m[32m      'bg-purple',[m
[32m+[m[32m      'bg-fuchsia',[m
[32m+[m[32m      'bg-pink',[m
[32m+[m[32m      'bg-maroon',[m
[32m+[m[32m      'bg-orange',[m
[32m+[m[32m      'bg-lime',[m
[32m+[m[32m      'bg-teal',[m
[32m+[m[32m      'bg-olive'[m
[32m+[m[32m    ][m
[32m+[m
[32m+[m[32m    var accent_colors = [[m
[32m+[m[32m      'accent-primary',[m
[32m+[m[32m      'accent-warning',[m
[32m+[m[32m      'accent-info',[m
[32m+[m[32m      'accent-danger',[m
[32m+[m[32m      'accent-success',[m
[32m+[m[32m      'accent-indigo',[m
[32m+[m[32m      'accent-lightblue',[m
[32m+[m[32m      'accent-navy',[m
[32m+[m[32m      'accent-purple',[m
[32m+[m[32m      'accent-fuchsia',[m
[32m+[m[32m      'accent-pink',[m
[32m+[m[32m      'accent-maroon',[m
[32m+[m[32m      'accent-orange',[m
[32m+[m[32m      'accent-lime',[m
[32m+[m[32m      'accent-teal',[m
[32m+[m[32m      'accent-olive'[m
[32m+[m[32m    ][m
[32m+[m
[32m+[m[32m    var sidebar_skins = [[m
[32m+[m[32m      'sidebar-dark-primary',[m
[32m+[m[32m      'sidebar-dark-warning',[m
[32m+[m[32m      'sidebar-dark-info',[m
[32m+[m[32m      'sidebar-dark-danger',[m
[32m+[m[32m      'sidebar-dark-success',[m
[32m+[m[32m      'sidebar-dark-indigo',[m
[32m+[m[32m      'sidebar-dark-lightblue',[m
[32m+[m[32m      'sidebar-dark-navy',[m
[32m+[m[32m      'sidebar-dark-purple',[m
[32m+[m[32m      'sidebar-dark-fuchsia',[m
[32m+[m[32m      'sidebar-dark-pink',[m
[32m+[m[32m      'sidebar-dark-maroon',[m
[32m+[m[32m      'sidebar-dark-orange',[m
[32m+[m[32m      'sidebar-dark-lime',[m
[32m+[m[32m      'sidebar-dark-teal',[m
[32m+[m[32m      'sidebar-dark-olive',[m
[32m+[m[32m      'sidebar-light-primary',[m
[32m+[m[32m      'sidebar-light-warning',[m
[32m+[m[32m      'sidebar-light-info',[m
[32m+[m[32m      'sidebar-light-danger',[m
[32m+[m[32m      'sidebar-light-success',[m
[32m+[m[32m      'sidebar-light-indigo',[m
[32m+[m[32m      'sidebar-light-lightblue',[m
[32m+[m[32m      'sidebar-light-navy',[m
[32m+[m[32m      'sidebar-light-purple',[m
[32m+[m[32m      'sidebar-light-fuchsia',[m
[32m+[m[32m      'sidebar-light-pink',[m
[32m+[m[32m      'sidebar-light-maroon',[m
[32m+[m[32m      'sidebar-light-orange',[m
[32m+[m[32m      'sidebar-light-lime',[m
[32m+[m[32m      'sidebar-light-teal',[m
[32m+[m[32m      'sidebar-light-olive'[m
[32m+[m[32m    ][m
[32m+[m
[32m+[m[32m    // Navbar Variants[m
[32m+[m
[32m+[m[32m    $container.append('<h6>Navbar Variants</h6>')[m
[32m+[m
[32m+[m[32m    var $navbar_variants = $('<div />', {[m
[32m+[m[32m      class: 'd-flex'[m
[32m+[m[32m    })[m
[32m+[m[32m    var navbar_all_colors = navbar_dark_skins.concat(navbar_light_skins)[m
[32m+[m[32m    var $navbar_variants_colors = createSkinBlock(navbar_all_colors, function () {[m
[32m+[m[32m      var color = $(this).find('option:selected').attr('class')[m
[32m+[m[32m      var $main_header = $('.main-header')[m
[32m+[m[32m      $main_header.removeClass('navbar-dark').removeClass('navbar-light')[m
[32m+[m[32m      navbar_all_colors.forEach(function (color) {[m
[32m+[m[32m        $main_header.removeClass(color)[m
       })[m
 [m
[31m-      $block.append($color)[m
[32m+[m[32m      $(this).removeClass().addClass('custom-select mb-3 text-light border-0 ')[m
[32m+[m
[32m+[m[32m      if (navbar_dark_skins.indexOf(color) > -1) {[m
[32m+[m[32m        $main_header.addClass('navbar-dark')[m
[32m+[m[32m        $(this).addClass(color).addClass('text-light')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $main_header.addClass('navbar-light')[m
[32m+[m[32m        $(this).addClass(color)[m
[32m+[m[32m      }[m
[32m+[m
[32m+[m[32m      $main_header.addClass(color)[m
     })[m
[31m-    if (callback) {[m
[31m-      $block.on('change', callback)[m
[31m-    }[m
 [m
[31m-    return $block[m
[31m-  }[m
[32m+[m[32m    var active_navbar_color = null[m
[32m+[m[32m    $('.main-header')[0].classList.forEach(function (className) {[m
[32m+[m[32m      if (navbar_all_colors.indexOf(className) > -1 && active_navbar_color === null) {[m
[32m+[m[32m        active_navbar_color = className.replace('navbar-', 'bg-')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
 [m
[31m-  var $sidebar = $('.control-sidebar')[m
[31m-  var $container = $('<div />', {[m
[31m-    class: 'p-3 control-sidebar-content'[m
[31m-  })[m
[32m+[m[32m    $navbar_variants_colors.find('option.' + active_navbar_color).prop('selected', true)[m
[32m+[m[32m    $navbar_variants_colors.removeClass().addClass('custom-select mb-3 text-light border-0 ').addClass(active_navbar_color)[m
 [m
[31m-  $sidebar.append($container)[m
[32m+[m[32m    $navbar_variants.append($navbar_variants_colors)[m
 [m
[31m-  // Checkboxes[m
[32m+[m[32m    $container.append($navbar_variants)[m
 [m
[31m-  $container.append([m
[31m-    '<h5>Customize AdminLTE</h5><hr class="mb-2"/>'[m
[31m-  )[m
[32m+[m[32m    // Sidebar Colors[m
 [m
[31m-  var $dark_mode_checkbox = $('<input />', {[m
[31m-    type: 'checkbox',[m
[31m-    value: 1,[m
[31m-    checked: $('body').hasClass('dark-mode'),[m
[31m-    class: 'mr-1'[m
[31m-  }).on('click', function () {[m
[31m-    if ($(this).is(':checked')) {[m
[31m-      $('body').addClass('dark-mode')[m
[31m-    } else {[m
[31m-      $('body').removeClass('dark-mode')[m
[31m-    }[m
[31m-  })[m
[31m-  var $dark_mode_container = $('<div />', { class: 'mb-4' }).append($dark_mode_checkbox).append('<span>Dark Mode</span>')[m
[31m-  $container.append($dark_mode_container)[m
[31m-[m
[31m-  $container.append('<h6>Header Options</h6>')[m
[31m-  var $header_fixed_checkbox = $('<input />', {[m
[31m-    type: 'checkbox',[m
[31m-    value: 1,[m
[31m-    checked: $('body').hasClass('layout-navbar-fixed'),[m
[31m-    class: 'mr-1'[m
[31m-  }).on('click', function () {[m
[31m-    if ($(this).is(':checked')) {[m
[31m-      $('body').addClass('layout-navbar-fixed')[m
[31m-    } else {[m
[31m-      $('body').removeClass('layout-navbar-fixed')[m
[31m-    }[m
[31m-  })[m
[31m-  var $header_fixed_container = $('<div />', { class: 'mb-1' }).append($header_fixed_checkbox).append('<span>Fixed</span>')[m
[31m-  $container.append($header_fixed_container)[m
[31m-[m
[31m-  var $dropdown_legacy_offset_checkbox = $('<input />', {[m
[31m-    type: 'checkbox',[m
[31m-    value: 1,[m
[31m-    checked: $('.main-header').hasClass('dropdown-legacy'),[m
[31m-    class: 'mr-1'[m
[31m-  }).on('click', function () {[m
[31m-    if ($(this).is(':checked')) {[m
[31m-      $('.main-header').addClass('dropdown-legacy')[m
[31m-    } else {[m
[31m-      $('.main-header').removeClass('dropdown-legacy')[m
[31m-    }[m
[31m-  })[m
[31m-  var $dropdown_legacy_offset_container = $('<div />', { class: 'mb-1' }).append($dropdown_legacy_offset_checkbox).append('<span>Dropdown Legacy Offset</span>')[m
[31m-  $container.append($dropdown_legacy_offset_container)[m
[31m-[m
[31m-  var $no_border_checkbox = $('<input />', {[m
[31m-    type: 'checkbox',[m
[31m-    value: 1,[m
[31m-    checked: $('.main-header').hasClass('border-bottom-0'),[m
[31m-    class: 'mr-1'[m
[31m-  }).on('click', function () {[m
[31m-    if ($(this).is(':checked')) {[m
[31m-      $('.main-header').addClass('border-bottom-0')[m
[31m-    } else {[m
[31m-      $('.main-header').removeClass('border-bottom-0')[m
[31m-    }[m
[31m-  })[m
[31m-  var $no_border_container = $('<div />', { class: 'mb-4' }).append($no_border_checkbox).append('<span>No border</span>')[m
[31m-  $container.append($no_border_container)[m
[31m-[m
[31m-  $container.append('<h6>Sidebar Options</h6>')[m
[31m-[m
[31m-  var $sidebar_collapsed_checkbox = $('<input />', {[m
[31m-    type: 'checkbox',[m
[31m-    value: 1,[m
[31m-    checked: $('body').hasClass('sidebar-collapse'),[m
[31m-    class: 'mr-1'[m
[31m-  }).on('click', function () {[m
[31m-    if ($(this).is(':checked')) {[m
[31m-      $('body').addClass('sidebar-collapse')[m
[31m-      $(window).trigger('resize')[m
[31m-    } else {[m
[31m-      $('body').removeClass('sidebar-collapse')[m
[31m-      $(window).trigger('resize')[m
[31m-    }[m
[31m-  })[m
[31m-  var $sidebar_collapsed_container = $('<div />', { class: 'mb-1' }).append($sidebar_collapsed_checkbox).append('<span>Collapsed</span>')[m
[31m-  $container.append($sidebar_collapsed_container)[m
[31m-[m
[31m-  $(document).on('collapsed.lte.pushmenu', '[data-widget="pushmenu"]', function () {[m
[31m-    $sidebar_collapsed_checkbox.prop('checked', true)[m
[31m-  })[m
[31m-  $(document).on('shown.lte.pushmenu', '[data-widget="pushmenu"]', function () {[m
[31m-    $sidebar_collapsed_checkbox.prop('checked', false)[m
[31m-  })[m
[31m-[m
[31m-  var $sidebar_fixed_checkbox = $('<input />', {[m
[31m-    type: 'checkbox',[m
[31m-    value: 1,[m
[31m-    checked: $('body').hasClass('layout-fixed'),[m
[31m-    class: 'mr-1'[m
[31m-  }).on('click', function () {[m
[31m-    if ($(this).is(':checked')) {[m
[31m-      $('body').addClass('layout-fixed')[m
[31m-      $(window).trigger('resize')[m
[31m-    } else {[m
[31m-      $('body').removeClass('layout-fixed')[m
[31m-      $(window).trigger('resize')[m
[31m-    }[m
[31m-  })[m
[31m-  var $sidebar_fixed_container = $('<div />', { class: 'mb-1' }).append($sidebar_fixed_checkbox).append('<span>Fixed</span>')[m
[31m-  $container.append($sidebar_fixed_container)[m
[31m-[m
[31m-  var $sidebar_mini_checkbox = $('<input />', {[m
[31m-    type: 'checkbox',[m
[31m-    value: 1,[m
[31m-    checked: $('body').hasClass('sidebar-mini'),[m
[31m-    class: 'mr-1'[m
[31m-  }).on('click', function () {[m
[31m-    if ($(this).is(':checked')) {[m
[31m-      $('body').addClass('sidebar-mini')[m
[31m-    } else {[m
[31m-      $('body').removeClass('sidebar-mini')[m
[31m-    }[m
[31m-  })[m
[31m-  var $sidebar_mini_container = $('<div />', { class: 'mb-1' }).append($sidebar_mini_checkbox).append('<span>Sidebar Mini</span>')[m
[31m-  $container.append($sidebar_mini_container)[m
[31m-[m
[31m-  var $sidebar_mini_md_checkbox = $('<input />', {[m
[31m-    type: 'checkbox',[m
[31m-    value: 1,[m
[31m-    checked: $('body').hasClass('sidebar-mini-md'),[m
[31m-    class: 'mr-1'[m
[31m-  }).on('click', function () {[m
[31m-    if ($(this).is(':checked')) {[m
[31m-      $('body').addClass('sidebar-mini-md')[m
[31m-    } else {[m
[31m-      $('body').removeClass('sidebar-mini-md')[m
[31m-    }[m
[31m-  })[m
[31m-  var $sidebar_mini_md_container = $('<div />', { class: 'mb-1' }).append($sidebar_mini_md_checkbox).append('<span>Sidebar Mini MD</span>')[m
[31m-  $container.append($sidebar_mini_md_container)[m
[31m-[m
[31m-  var $sidebar_mini_xs_checkbox = $('<input />', {[m
[31m-    type: 'checkbox',[m
[31m-    value: 1,[m
[31m-    checked: $('body').hasClass('sidebar-mini-xs'),[m
[31m-    class: 'mr-1'[m
[31m-  }).on('click', function () {[m
[31m-    if ($(this).is(':checked')) {[m
[31m-      $('body').addClass('sidebar-mini-xs')[m
[31m-    } else {[m
[31m-      $('body').removeClass('sidebar-mini-xs')[m
[31m-    }[m
[31m-  })[m
[31m-  var $sidebar_mini_xs_container = $('<div />', { class: 'mb-1' }).append($sidebar_mini_xs_checkbox).append('<span>Sidebar Mini XS</span>')[m
[31m-  $container.append($sidebar_mini_xs_container)[m
[31m-[m
[31m-  var $flat_sidebar_checkbox = $('<input />', {[m
[31m-    type: 'checkbox',[m
[31m-    value: 1,[m
[31m-    checked: $('.nav-sidebar').hasClass('nav-flat'),[m
[31m-    class: 'mr-1'[m
[31m-  }).on('click', function () {[m
[31m-    if ($(this).is(':checked')) {[m
[31m-      $('.nav-sidebar').addClass('nav-flat')[m
[31m-    } else {[m
[31m-      $('.nav-sidebar').removeClass('nav-flat')[m
[31m-    }[m
[31m-  })[m
[31m-  var $flat_sidebar_container = $('<div />', { class: 'mb-1' }).append($flat_sidebar_checkbox).append('<span>Nav Flat Style</span>')[m
[31m-  $container.append($flat_sidebar_container)[m
[31m-[m
[31m-  var $legacy_sidebar_checkbox = $('<input />', {[m
[31m-    type: 'checkbox',[m
[31m-    value: 1,[m
[31m-    checked: $('.nav-sidebar').hasClass('nav-legacy'),[m
[31m-    class: 'mr-1'[m
[31m-  }).on('click', function () {[m
[31m-    if ($(this).is(':checked')) {[m
[31m-      $('.nav-sidebar').addClass('nav-legacy')[m
[31m-    } else {[m
[31m-      $('.nav-sidebar').removeClass('nav-legacy')[m
[31m-    }[m
[31m-  })[m
[31m-  var $legacy_sidebar_container = $('<div />', { class: 'mb-1' }).append($legacy_sidebar_checkbox).append('<span>Nav Legacy Style</span>')[m
[31m-  $container.append($legacy_sidebar_container)[m
[31m-[m
[31m-  var $compact_sidebar_checkbox = $('<input />', {[m
[31m-    type: 'checkbox',[m
[31m-    value: 1,[m
[31m-    checked: $('.nav-sidebar').hasClass('nav-compact'),[m
[31m-    class: 'mr-1'[m
[31m-  }).on('click', function () {[m
[31m-    if ($(this).is(':checked')) {[m
[31m-      $('.nav-sidebar').addClass('nav-compact')[m
[31m-    } else {[m
[31m-      $('.nav-sidebar').removeClass('nav-compact')[m
[31m-    }[m
[31m-  })[m
[31m-  var $compact_sidebar_container = $('<div />', { class: 'mb-1' }).append($compact_sidebar_checkbox).append('<span>Nav Compact</span>')[m
[31m-  $container.append($compact_sidebar_container)[m
[31m-[m
[31m-  var $child_indent_sidebar_checkbox = $('<input />', {[m
[31m-    type: 'checkbox',[m
[31m-    value: 1,[m
[31m-    checked: $('.nav-sidebar').hasClass('nav-child-indent'),[m
[31m-    class: 'mr-1'[m
[31m-  }).on('click', function () {[m
[31m-    if ($(this).is(':checked')) {[m
[31m-      $('.nav-sidebar').addClass('nav-child-indent')[m
[31m-    } else {[m
[31m-      $('.nav-sidebar').removeClass('nav-child-indent')[m
[31m-    }[m
[31m-  })[m
[31m-  var $child_indent_sidebar_container = $('<div />', { class: 'mb-1' }).append($child_indent_sidebar_checkbox).append('<span>Nav Child Indent</span>')[m
[31m-  $container.append($child_indent_sidebar_container)[m
[31m-[m
[31m-  var $child_hide_sidebar_checkbox = $('<input />', {[m
[31m-    type: 'checkbox',[m
[31m-    value: 1,[m
[31m-    checked: $('.nav-sidebar').hasClass('nav-collapse-hide-child'),[m
[31m-    class: 'mr-1'[m
[31m-  }).on('click', function () {[m
[31m-    if ($(this).is(':checked')) {[m
[31m-      $('.nav-sidebar').addClass('nav-collapse-hide-child')[m
[31m-    } else {[m
[31m-      $('.nav-sidebar').removeClass('nav-collapse-hide-child')[m
[31m-    }[m
[31m-  })[m
[31m-  var $child_hide_sidebar_container = $('<div />', { class: 'mb-1' }).append($child_hide_sidebar_checkbox).append('<span>Nav Child Hide on Collapse</span>')[m
[31m-  $container.append($child_hide_sidebar_container)[m
[31m-[m
[31m-  var $no_expand_sidebar_checkbox = $('<input />', {[m
[31m-    type: 'checkbox',[m
[31m-    value: 1,[m
[31m-    checked: $('.main-sidebar').hasClass('sidebar-no-expand'),[m
[31m-    class: 'mr-1'[m
[31m-  }).on('click', function () {[m
[31m-    if ($(this).is(':checked')) {[m
[31m-      $('.main-sidebar').addClass('sidebar-no-expand')[m
[31m-    } else {[m
[31m-      $('.main-sidebar').removeClass('sidebar-no-expand')[m
[31m-    }[m
[31m-  })[m
[31m-  var $no_expand_sidebar_container = $('<div />', { class: 'mb-4' }).append($no_expand_sidebar_checkbox).append('<span>Disable Hover/Focus Auto-Expand</span>')[m
[31m-  $container.append($no_expand_sidebar_container)[m
[31m-[m
[31m-  $container.append('<h6>Footer Options</h6>')[m
[31m-  var $footer_fixed_checkbox = $('<input />', {[m
[31m-    type: 'checkbox',[m
[31m-    value: 1,[m
[31m-    checked: $('body').hasClass('layout-footer-fixed'),[m
[31m-    class: 'mr-1'[m
[31m-  }).on('click', function () {[m
[31m-    if ($(this).is(':checked')) {[m
[31m-      $('body').addClass('layout-footer-fixed')[m
[31m-    } else {[m
[31m-      $('body').removeClass('layout-footer-fixed')[m
[31m-    }[m
[31m-  })[m
[31m-  var $footer_fixed_container = $('<div />', { class: 'mb-4' }).append($footer_fixed_checkbox).append('<span>Fixed</span>')[m
[31m-  $container.append($footer_fixed_container)[m
[31m-[m
[31m-  $container.append('<h6>Small Text Options</h6>')[m
[31m-[m
[31m-  var $text_sm_body_checkbox = $('<input />', {[m
[31m-    type: 'checkbox',[m
[31m-    value: 1,[m
[31m-    checked: $('body').hasClass('text-sm'),[m
[31m-    class: 'mr-1'[m
[31m-  }).on('click', function () {[m
[31m-    if ($(this).is(':checked')) {[m
[31m-      $('body').addClass('text-sm')[m
[31m-    } else {[m
[31m-      $('body').removeClass('text-sm')[m
[31m-    }[m
[31m-  })[m
[31m-  var $text_sm_body_container = $('<div />', { class: 'mb-1' }).append($text_sm_body_checkbox).append('<span>Body</span>')[m
[31m-  $container.append($text_sm_body_container)[m
[31m-[m
[31m-  var $text_sm_header_checkbox = $('<input />', {[m
[31m-    type: 'checkbox',[m
[31m-    value: 1,[m
[31m-    checked: $('.main-header').hasClass('text-sm'),[m
[31m-    class: 'mr-1'[m
[31m-  }).on('click', function () {[m
[31m-    if ($(this).is(':checked')) {[m
[31m-      $('.main-header').addClass('text-sm')[m
[31m-    } else {[m
[31m-      $('.main-header').removeClass('text-sm')[m
[31m-    }[m
[31m-  })[m
[31m-  var $text_sm_header_container = $('<div />', { class: 'mb-1' }).append($text_sm_header_checkbox).append('<span>Navbar</span>')[m
[31m-  $container.append($text_sm_header_container)[m
[31m-[m
[31m-  var $text_sm_brand_checkbox = $('<input />', {[m
[31m-    type: 'checkbox',[m
[31m-    value: 1,[m
[31m-    checked: $('.brand-link').hasClass('text-sm'),[m
[31m-    class: 'mr-1'[m
[31m-  }).on('click', function () {[m
[31m-    if ($(this).is(':checked')) {[m
[31m-      $('.brand-link').addClass('text-sm')[m
[31m-    } else {[m
[31m-      $('.brand-link').removeClass('text-sm')[m
[31m-    }[m
[31m-  })[m
[31m-  var $text_sm_brand_container = $('<div />', { class: 'mb-1' }).append($text_sm_brand_checkbox).append('<span>Brand</span>')[m
[31m-  $container.append($text_sm_brand_container)[m
[31m-[m
[31m-  var $text_sm_sidebar_checkbox = $('<input />', {[m
[31m-    type: 'checkbox',[m
[31m-    value: 1,[m
[31m-    checked: $('.nav-sidebar').hasClass('text-sm'),[m
[31m-    class: 'mr-1'[m
[31m-  }).on('click', function () {[m
[31m-    if ($(this).is(':checked')) {[m
[31m-      $('.nav-sidebar').addClass('text-sm')[m
[31m-    } else {[m
[31m-      $('.nav-sidebar').removeClass('text-sm')[m
[31m-    }[m
[31m-  })[m
[31m-  var $text_sm_sidebar_container = $('<div />', { class: 'mb-1' }).append($text_sm_sidebar_checkbox).append('<span>Sidebar Nav</span>')[m
[31m-  $container.append($text_sm_sidebar_container)[m
[31m-[m
[31m-  var $text_sm_footer_checkbox = $('<input />', {[m
[31m-    type: 'checkbox',[m
[31m-    value: 1,[m
[31m-    checked: $('.main-footer').hasClass('text-sm'),[m
[31m-    class: 'mr-1'[m
[31m-  }).on('click', function () {[m
[31m-    if ($(this).is(':checked')) {[m
[31m-      $('.main-footer').addClass('text-sm')[m
[31m-    } else {[m
[31m-      $('.main-footer').removeClass('text-sm')[m
[31m-    }[m
[31m-  })[m
[31m-  var $text_sm_footer_container = $('<div />', { class: 'mb-4' }).append($text_sm_footer_checkbox).append('<span>Footer</span>')[m
[31m-  $container.append($text_sm_footer_container)[m
[31m-[m
[31m-  // Color Arrays[m
[31m-[m
[31m-  var navbar_dark_skins = [[m
[31m-    'navbar-primary',[m
[31m-    'navbar-secondary',[m
[31m-    'navbar-info',[m
[31m-    'navbar-success',[m
[31m-    'navbar-danger',[m
[31m-    'navbar-indigo',[m
[31m-    'navbar-purple',[m
[31m-    'navbar-pink',[m
[31m-    'navbar-navy',[m
[31m-    'navbar-lightblue',[m
[31m-    'navbar-teal',[m
[31m-    'navbar-cyan',[m
[31m-    'navbar-dark',[m
[31m-    'navbar-gray-dark',[m
[31m-    'navbar-gray'[m
[31m-  ][m
[31m-[m
[31m-  var navbar_light_skins = [[m
[31m-    'navbar-light',[m
[31m-    'navbar-warning',[m
[31m-    'navbar-white',[m
[31m-    'navbar-orange'[m
[31m-  ][m
[31m-[m
[31m-  var sidebar_colors = [[m
[31m-    'bg-primary',[m
[31m-    'bg-warning',[m
[31m-    'bg-info',[m
[31m-    'bg-danger',[m
[31m-    'bg-success',[m
[31m-    'bg-indigo',[m
[31m-    'bg-lightblue',[m
[31m-    'bg-navy',[m
[31m-    'bg-purple',[m
[31m-    'bg-fuchsia',[m
[31m-    'bg-pink',[m
[31m-    'bg-maroon',[m
[31m-    'bg-orange',[m
[31m-    'bg-lime',[m
[31m-    'bg-teal',[m
[31m-    'bg-olive'[m
[31m-  ][m
[31m-[m
[31m-  var accent_colors = [[m
[31m-    'accent-primary',[m
[31m-    'accent-warning',[m
[31m-    'accent-info',[m
[31m-    'accent-danger',[m
[31m-    'accent-success',[m
[31m-    'accent-indigo',[m
[31m-    'accent-lightblue',[m
[31m-    'accent-navy',[m
[31m-    'accent-purple',[m
[31m-    'accent-fuchsia',[m
[31m-    'accent-pink',[m
[31m-    'accent-maroon',[m
[31m-    'accent-orange',[m
[31m-    'accent-lime',[m
[31m-    'accent-teal',[m
[31m-    'accent-olive'[m
[31m-  ][m
[31m-[m
[31m-  var sidebar_skins = [[m
[31m-    'sidebar-dark-primary',[m
[31m-    'sidebar-dark-warning',[m
[31m-    'sidebar-dark-info',[m
[31m-    'sidebar-dark-danger',[m
[31m-    'sidebar-dark-success',[m
[31m-    'sidebar-dark-indigo',[m
[31m-    'sidebar-dark-lightblue',[m
[31m-    'sidebar-dark-navy',[m
[31m-    'sidebar-dark-purple',[m
[31m-    'sidebar-dark-fuchsia',[m
[31m-    'sidebar-dark-pink',[m
[31m-    'sidebar-dark-maroon',[m
[31m-    'sidebar-dark-orange',[m
[31m-    'sidebar-dark-lime',[m
[31m-    'sidebar-dark-teal',[m
[31m-    'sidebar-dark-olive',[m
[31m-    'sidebar-light-primary',[m
[31m-    'sidebar-light-warning',[m
[31m-    'sidebar-light-info',[m
[31m-    'sidebar-light-danger',[m
[31m-    'sidebar-light-success',[m
[31m-    'sidebar-light-indigo',[m
[31m-    'sidebar-light-lightblue',[m
[31m-    'sidebar-light-navy',[m
[31m-    'sidebar-light-purple',[m
[31m-    'sidebar-light-fuchsia',[m
[31m-    'sidebar-light-pink',[m
[31m-    'sidebar-light-maroon',[m
[31m-    'sidebar-light-orange',[m
[31m-    'sidebar-light-lime',[m
[31m-    'sidebar-light-teal',[m
[31m-    'sidebar-light-olive'[m
[31m-  ][m
[31m-[m
[31m-  // Navbar Variants[m
[31m-[m
[31m-  $container.append('<h6>Navbar Variants</h6>')[m
[31m-[m
[31m-  var $navbar_variants = $('<div />', {[m
[31m-    class: 'd-flex'[m
[31m-  })[m
[31m-  var navbar_all_colors = navbar_dark_skins.concat(navbar_light_skins)[m
[31m-  var $navbar_variants_colors = createSkinBlock(navbar_all_colors, function () {[m
[31m-    var color = $(this).find('option:selected').attr('class')[m
[31m-    var $main_header = $('.main-header')[m
[31m-    $main_header.removeClass('navbar-dark').removeClass('navbar-light')[m
[31m-    navbar_all_colors.forEach(function (color) {[m
[31m-      $main_header.removeClass(color)[m
[31m-    })[m
[31m-[m
[31m-    $(this).removeClass().addClass('custom-select mb-3 text-light border-0 ')[m
[31m-[m
[31m-    if (navbar_dark_skins.indexOf(color) > -1) {[m
[31m-      $main_header.addClass('navbar-dark')[m
[31m-      $(this).addClass(color).addClass('text-light')[m
[31m-    } else {[m
[31m-      $main_header.addClass('navbar-light')[m
[31m-      $(this).addClass(color)[m
[31m-    }[m
[32m+[m[32m    $container.append('<h6>Accent Color Variants</h6>')[m
[32m+[m[32m    var $accent_variants = $('<div />', {[m
[32m+[m[32m      class: 'd-flex'[m
[32m+[m[32m    })[m
[32m+[m[32m    $container.append($accent_variants)[m
[32m+[m[32m    $container.append(createSkinBlock(accent_colors, function () {[m
[32m+[m[32m      var color = $(this).find('option:selected').attr('class')[m
[32m+[m[32m      var $body = $('body')[m
[32m+[m[32m      accent_colors.forEach(function (skin) {[m
[32m+[m[32m        $body.removeClass(skin)[m
[32m+[m[32m      })[m
 [m
[31m-    $main_header.addClass(color)[m
[31m-  })[m
[32m+[m[32m      var accent_color_class = color.replace('bg-', 'accent-')[m
 [m
[31m-  var active_navbar_color = null[m
[31m-  $('.main-header')[0].classList.forEach(function (className) {[m
[31m-    if (navbar_all_colors.indexOf(className) > -1 && active_navbar_color === null) {[m
[31m-      active_navbar_color = className.replace('navbar-', 'bg-')[m
[31m-    }[m
[31m-  })[m
[32m+[m[32m      $body.addClass(accent_color_class)[m
[32m+[m[32m    }, true))[m
 [m
[31m-  $navbar_variants_colors.find('option.' + active_navbar_color).prop('selected', true)[m
[31m-  $navbar_variants_colors.removeClass().addClass('custom-select mb-3 text-light border-0 ').addClass(active_navbar_color)[m
[32m+[m[32m    var active_accent_color = null[m
[32m+[m[32m    $('body')[0].classList.forEach(function (className) {[m
[32m+[m[32m      if (accent_colors.indexOf(className) > -1 && active_accent_color === null) {[m
[32m+[m[32m        active_accent_color = className.replace('navbar-', 'bg-')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
 [m
[31m-  $navbar_variants.append($navbar_variants_colors)[m
[32m+[m[32m    // $accent_variants.find('option.' + active_accent_color).prop('selected', true)[m
[32m+[m[32m    // $accent_variants.removeClass().addClass('custom-select mb-3 text-light border-0 ').addClass(active_accent_color)[m
 [m
[31m-  $container.append($navbar_variants)[m
[32m+[m[32m    $container.append('<h6>Dark Sidebar Variants</h6>')[m
[32m+[m[32m    var $sidebar_variants_dark = $('<div />', {[m
[32m+[m[32m      class: 'd-flex'[m
[32m+[m[32m    })[m
[32m+[m[32m    $container.append($sidebar_variants_dark)[m
[32m+[m[32m    var $sidebar_dark_variants = createSkinBlock(sidebar_colors, function () {[m
[32m+[m[32m      var color = $(this).find('option:selected').attr('class')[m
[32m+[m[32m      var sidebar_class = 'sidebar-dark-' + color.replace('bg-', '')[m
[32m+[m[32m      var $sidebar = $('.main-sidebar')[m
[32m+[m[32m      sidebar_skins.forEach(function (skin) {[m
[32m+[m[32m        $sidebar.removeClass(skin)[m
[32m+[m[32m        $sidebar_light_variants.removeClass(skin.replace('sidebar-dark-', 'bg-')).removeClass('text-light')[m
[32m+[m[32m      })[m
[32m+[m
[32m+[m[32m      $(this).removeClass().addClass('custom-select mb-3 text-light border-0').addClass(color)[m
 [m
[31m-  // Sidebar Colors[m
[32m+[m[32m      $sidebar_light_variants.find('option').prop('selected', false)[m
[32m+[m[32m      $sidebar.addClass(sidebar_class)[m
[32m+[m[32m      $('.sidebar').removeClass('os-theme-dark').addClass('os-theme-light')[m
[32m+[m[32m    }, true)[m
[32m+[m[32m    $container.append($sidebar_dark_variants)[m
 [m
[31m-  $container.append('<h6>Accent Color Variants</h6>')[m
[31m-  var $accent_variants = $('<div />', {[m
[31m-    class: 'd-flex'[m
[31m-  })[m
[31m-  $container.append($accent_variants)[m
[31m-  $container.append(createSkinBlock(accent_colors, function () {[m
[31m-    var color = $(this).find('option:selected').attr('class')[m
[31m-    var $body = $('body')[m
[31m-    accent_colors.forEach(function (skin) {[m
[31m-      $body.removeClass(skin)[m
[32m+[m[32m    var active_sidebar_dark_color = null[m
[32m+[m[32m    $('.main-sidebar')[0].classList.forEach(function (className) {[m
[32m+[m[32m      var color = className.replace('sidebar-dark-', 'bg-')[m
[32m+[m[32m      if (sidebar_colors.indexOf(color) > -1 && active_sidebar_dark_color === null) {[m
[32m+[m[32m        active_sidebar_dark_color = color[m
[32m+[m[32m      }[m
     })[m
 [m
[31m-    var accent_color_class = color.replace('bg-', 'accent-')[m
[32m+[m[32m    $sidebar_dark_variants.find('option.' + active_sidebar_dark_color).prop('selected', true)[m
[32m+[m[32m    $sidebar_dark_variants.removeClass().addClass('custom-select mb-3 text-light border-0 ').addClass(active_sidebar_dark_color)[m
[32m+[m
[32m+[m[32m    $container.append('<h6>Light Sidebar Variants</h6>')[m
[32m+[m[32m    var $sidebar_variants_light = $('<div />', {[m
[32m+[m[32m      class: 'd-flex'[m
[32m+[m[32m    })[m
[32m+[m[32m    $container.append($sidebar_variants_light)[m
[32m+[m[32m    var $sidebar_light_variants = createSkinBlock(sidebar_colors, function () {[m
[32m+[m[32m      var color = $(this).find('option:selected').attr('class')[m
[32m+[m[32m      var sidebar_class = 'sidebar-light-' + color.replace('bg-', '')[m
[32m+[m[32m      var $sidebar = $('.main-sidebar')[m
[32m+[m[32m      sidebar_skins.forEach(function (skin) {[m
[32m+[m[32m        $sidebar.removeClass(skin)[m
[32m+[m[32m        $sidebar_dark_variants.removeClass(skin.replace('sidebar-light-', 'bg-')).removeClass('text-light')[m
[32m+[m[32m      })[m
 [m
[31m-    $body.addClass(accent_color_class)[m
[31m-  }, true))[m
[32m+[m[32m      $(this).removeClass().addClass('custom-select mb-3 text-light border-0').addClass(color)[m
 [m
[31m-  var active_accent_color = null[m
[31m-  $('body')[0].classList.forEach(function (className) {[m
[31m-    if (accent_colors.indexOf(className) > -1 && active_accent_color === null) {[m
[31m-      active_accent_color = className.replace('navbar-', 'bg-')[m
[31m-    }[m
[31m-  })[m
[31m-[m
[31m-  // $accent_variants.find('option.' + active_accent_color).prop('selected', true)[m
[31m-  // $accent_variants.removeClass().addClass('custom-select mb-3 text-light border-0 ').addClass(active_accent_color)[m
[31m-[m
[31m-  $container.append('<h6>Dark Sidebar Variants</h6>')[m
[31m-  var $sidebar_variants_dark = $('<div />', {[m
[31m-    class: 'd-flex'[m
[31m-  })[m
[31m-  $container.append($sidebar_variants_dark)[m
[31m-  var $sidebar_dark_variants = createSkinBlock(sidebar_colors, function () {[m
[31m-    var color = $(this).find('option:selected').attr('class')[m
[31m-    var sidebar_class = 'sidebar-dark-' + color.replace('bg-', '')[m
[31m-    var $sidebar = $('.main-sidebar')[m
[31m-    sidebar_skins.forEach(function (skin) {[m
[31m-      $sidebar.removeClass(skin)[m
[31m-      $sidebar_light_variants.removeClass(skin.replace('sidebar-dark-', 'bg-')).removeClass('text-light')[m
[31m-    })[m
[31m-[m
[31m-    $(this).removeClass().addClass('custom-select mb-3 text-light border-0').addClass(color)[m
[31m-[m
[31m-    $sidebar_light_variants.find('option').prop('selected', false)[m
[31m-    $sidebar.addClass(sidebar_class)[m
[31m-    $('.sidebar').removeClass('os-theme-dark').addClass('os-theme-light')[m
[31m-  }, true)[m
[31m-  $container.append($sidebar_dark_variants)[m
[31m-[m
[31m-  var active_sidebar_dark_color = null[m
[31m-  $('.main-sidebar')[0].classList.forEach(function (className) {[m
[31m-    var color = className.replace('sidebar-dark-', 'bg-')[m
[31m-    if (sidebar_colors.indexOf(color) > -1 && active_sidebar_dark_color === null) {[m
[31m-      active_sidebar_dark_color = color[m
[31m-    }[m
[31m-  })[m
[31m-[m
[31m-  $sidebar_dark_variants.find('option.' + active_sidebar_dark_color).prop('selected', true)[m
[31m-  $sidebar_dark_variants.removeClass().addClass('custom-select mb-3 text-light border-0 ').addClass(active_sidebar_dark_color)[m
[31m-[m
[31m-  $container.append('<h6>Light Sidebar Variants</h6>')[m
[31m-  var $sidebar_variants_light = $('<div />', {[m
[31m-    class: 'd-flex'[m
[31m-  })[m
[31m-  $container.append($sidebar_variants_light)[m
[31m-  var $sidebar_light_variants = createSkinBlock(sidebar_colors, function () {[m
[31m-    var color = $(this).find('option:selected').attr('class')[m
[31m-    var sidebar_class = 'sidebar-light-' + color.replace('bg-', '')[m
[31m-    var $sidebar = $('.main-sidebar')[m
[31m-    sidebar_skins.forEach(function (skin) {[m
[31m-      $sidebar.removeClass(skin)[m
[31m-      $sidebar_dark_variants.removeClass(skin.replace('sidebar-light-', 'bg-')).removeClass('text-light')[m
[31m-    })[m
[31m-[m
[31m-    $(this).removeClass().addClass('custom-select mb-3 text-light border-0').addClass(color)[m
[31m-[m
[31m-    $sidebar_dark_variants.find('option').prop('selected', false)[m
[31m-    $sidebar.addClass(sidebar_class)[m
[31m-    $('.sidebar').removeClass('os-theme-light').addClass('os-theme-dark')[m
[31m-  }, true)[m
[31m-  $container.append($sidebar_light_variants)[m
[31m-[m
[31m-  var active_sidebar_light_color = null[m
[31m-  $('.main-sidebar')[0].classList.forEach(function (className) {[m
[31m-    var color = className.replace('sidebar-light-', 'bg-')[m
[31m-    if (sidebar_colors.indexOf(color) > -1 && active_sidebar_light_color === null) {[m
[31m-      active_sidebar_light_color = color[m
[31m-    }[m
[31m-  })[m
[31m-[m
[31m-  if (active_sidebar_light_color !== null) {[m
[31m-    $sidebar_light_variants.find('option.' + active_sidebar_light_color).prop('selected', true)[m
[31m-    $sidebar_light_variants.removeClass().addClass('custom-select mb-3 text-light border-0 ').addClass(active_sidebar_light_color)[m
[31m-  }[m
[31m-[m
[31m-  var logo_skins = navbar_all_colors[m
[31m-  $container.append('<h6>Brand Logo Variants</h6>')[m
[31m-  var $logo_variants = $('<div />', {[m
[31m-    class: 'd-flex'[m
[31m-  })[m
[31m-  $container.append($logo_variants)[m
[31m-  var $clear_btn = $('<a />', {[m
[31m-    href: '#'[m
[31m-  }).text('clear').on('click', function (e) {[m
[31m-    e.preventDefault()[m
[31m-    var $logo = $('.brand-link')[m
[31m-    logo_skins.forEach(function (skin) {[m
[31m-      $logo.removeClass(skin)[m
[31m-    })[m
[31m-  })[m
[31m-[m
[31m-  var $brand_variants = createSkinBlock(logo_skins, function () {[m
[31m-    var color = $(this).find('option:selected').attr('class')[m
[31m-    var $logo = $('.brand-link')[m
[31m-[m
[31m-    if (color === 'navbar-light' || color === 'navbar-white') {[m
[31m-      $logo.addClass('text-black')[m
[31m-    } else {[m
[31m-      $logo.removeClass('text-black')[m
[31m-    }[m
[32m+[m[32m      $sidebar_dark_variants.find('option').prop('selected', false)[m
[32m+[m[32m      $sidebar.addClass(sidebar_class)[m
[32m+[m[32m      $('.sidebar').removeClass('os-theme-light').addClass('os-theme-dark')[m
[32m+[m[32m    }, true)[m
[32m+[m[32m    $container.append($sidebar_light_variants)[m
 [m
[31m-    logo_skins.forEach(function (skin) {[m
[31m-      $logo.removeClass(skin)[m
[32m+[m[32m    var active_sidebar_light_color = null[m
[32m+[m[32m    $('.main-sidebar')[0].classList.forEach(function (className) {[m
[32m+[m[32m      var color = className.replace('sidebar-light-', 'bg-')[m
[32m+[m[32m      if (sidebar_colors.indexOf(color) > -1 && active_sidebar_light_color === null) {[m
[32m+[m[32m        active_sidebar_light_color = color[m
[32m+[m[32m      }[m
     })[m
 [m
[31m-    if (color) {[m
[31m-      $(this).removeClass().addClass('custom-select mb-3 border-0').addClass(color).addClass(color !== 'navbar-light' && color !== 'navbar-white' ? 'text-light' : '')[m
[31m-    } else {[m
[31m-      $(this).removeClass().addClass('custom-select mb-3 border-0')[m
[32m+[m[32m    if (active_sidebar_light_color !== null) {[m
[32m+[m[32m      $sidebar_light_variants.find('option.' + active_sidebar_light_color).prop('selected', true)[m
[32m+[m[32m      $sidebar_light_variants.removeClass().addClass('custom-select mb-3 text-light border-0 ').addClass(active_sidebar_light_color)[m
     }[m
 [m
[31m-    $logo.addClass(color)[m
[31m-  }, true).append($clear_btn)[m
[31m-  $container.append($brand_variants)[m
[32m+[m[32m    var logo_skins = navbar_all_colors[m
[32m+[m[32m    $container.append('<h6>Brand Logo Variants</h6>')[m
[32m+[m[32m    var $logo_variants = $('<div />', {[m
[32m+[m[32m      class: 'd-flex'[m
[32m+[m[32m    })[m
[32m+[m[32m    $container.append($logo_variants)[m
[32m+[m[32m    var $clear_btn = $('<a />', {[m
[32m+[m[32m      href: '#'[m
[32m+[m[32m    }).text('clear').on('click', function (e) {[m
[32m+[m[32m      e.preventDefault()[m
[32m+[m[32m      var $logo = $('.brand-link')[m
[32m+[m[32m      logo_skins.forEach(function (skin) {[m
[32m+[m[32m        $logo.removeClass(skin)[m
[32m+[m[32m      })[m
[32m+[m[32m    })[m
 [m
[31m-  var active_brand_color = null[m
[31m-  $('.brand-link')[0].classList.forEach(function (className) {[m
[31m-    if (logo_skins.indexOf(className) > -1 && active_brand_color === null) {[m
[31m-      active_brand_color = className.replace('navbar-', 'bg-')[m
[31m-    }[m
[31m-  })[m
[32m+[m[32m    var $brand_variants = createSkinBlock(logo_skins, function () {[m
[32m+[m[32m      var color = $(this).find('option:selected').attr('class')[m
[32m+[m[32m      var $logo = $('.brand-link')[m
[32m+[m
[32m+[m[32m      if (color === 'navbar-light' || color === 'navbar-white') {[m
[32m+[m[32m        $logo.addClass('text-black')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $logo.removeClass('text-black')[m
[32m+[m[32m      }[m
 [m
[31m-  if (active_brand_color) {[m
[31m-    $brand_variants.find('option.' + active_brand_color).prop('selected', true)[m
[31m-    $brand_variants.removeClass().addClass('custom-select mb-3 text-light border-0 ').addClass(active_brand_color)[m
[31m-  }[m
[31m-})(jQuery)[m
[32m+[m[32m      logo_skins.forEach(function (skin) {[m
[32m+[m[32m        $logo.removeClass(skin)[m
[32m+[m[32m      })[m
[32m+[m
[32m+[m[32m      if (color) {[m
[32m+[m[32m        $(this).removeClass().addClass('custom-select mb-3 border-0').addClass(color).addClass(color !== 'navbar-light' && color !== 'navbar-white' ? 'text-light' : '')[m
[32m+[m[32m      } else {[m
[32m+[m[32m        $(this).removeClass().addClass('custom-select mb-3 border-0')[m
[32m+[m[32m      }[m
[32m+[m
[32m+[m[32m      $logo.addClass(color)[m
[32m+[m[32m    }, true).append($clear_btn)[m
[32m+[m[32m    $container.append($brand_variants)[m
[32m+[m
[32m+[m[32m    var active_brand_color = null[m
[32m+[m[32m    $('.brand-link')[0].classList.forEach(function (className) {[m
[32m+[m[32m      if (logo_skins.indexOf(className) > -1 && active_brand_color === null) {[m
[32m+[m[32m        active_brand_color = className.replace('navbar-', 'bg-')[m
[32m+[m[32m      }[m
[32m+[m[32m    })[m
[32m+[m
[32m+[m[32m    if (active_brand_color) {[m
[32m+[m[32m      $brand_variants.find('option.' + active_brand_color).prop('selected', true)[m
[32m+[m[32m      $brand_variants.removeClass().addClass('custom-select mb-3 text-light border-0 ').addClass(active_brand_color)[m
[32m+[m[32m    }[m
[32m+[m[32m  })(jQuery)[m
[1mdiff --git a/public/js/pages/dashboard.js b/public/js/pages/dashboard.js[m
[1mindex 56539f2..bee2a90 100644[m
[1m--- a/public/js/pages/dashboard.js[m
[1m+++ b/public/js/pages/dashboard.js[m
[36m@@ -11,7 +11,7 @@[m [m$(function () {[m
   'use strict'[m
 [m
   // Make the dashboard widgets sortable Using jquery UI[m
[31m-  $('.connectedSortable').sortable({[m
[32m+[m[32m  /* $('.connectedSortable').sortable({[m
     placeholder: 'sort-highlight',[m
     connectWith: '.connectedSortable',[m
     handle: '.card-header, .nav-tabs',[m
[36m@@ -26,7 +26,7 @@[m [m$(function () {[m
     handle: '.handle',[m
     forcePlaceholderSize: true,[m
     zIndex: 999999[m
[31m-  })[m
[32m+[m[32m  }) */[m
 [m
   // bootstrap WYSIHTML5 - text editor[m
   $('.textarea').summernote()[m
[36m@@ -65,7 +65,7 @@[m [m$(function () {[m
     RU: 3000 // Russia[m
   }[m
   // World map by jvectormap[m
[31m-  $('#world-map').vectorMap({[m
[32m+[m[32m  /* $('#world-map').vectorMap({[m
     map: 'usa_en',[m
     backgroundColor: 'transparent',[m
     regionStyle: {[m
[36m@@ -89,16 +89,16 @@[m [m$(function () {[m
         el.html(el.html() + ': ' + visitorsData[code] + ' new visitors')[m
       }[m
     }[m
[31m-  })[m
[32m+[m[32m  }) */[m
 [m
   // Sparkline charts[m
[31m-  var sparkline1 = new Sparkline($('#sparkline-1')[0], { width: 80, height: 50, lineColor: '#92c1dc', endColor: '#ebf4f9' })[m
[32m+[m[32m  /* var sparkline1 = new Sparkline($('#sparkline-1')[0], { width: 80, height: 50, lineColor: '#92c1dc', endColor: '#ebf4f9' })[m
   var sparkline2 = new Sparkline($('#sparkline-2')[0], { width: 80, height: 50, lineColor: '#92c1dc', endColor: '#ebf4f9' })[m
   var sparkline3 = new Sparkline($('#sparkline-3')[0], { width: 80, height: 50, lineColor: '#92c1dc', endColor: '#ebf4f9' })[m
 [m
   sparkline1.draw([1000, 1200, 920, 927, 931, 1027, 819, 930, 1021])[m
   sparkline2.draw([515, 519, 520, 522, 652, 810, 370, 627, 319, 630, 921])[m
[31m-  sparkline3.draw([15, 19, 20, 22, 33, 27, 31, 27, 19, 30, 21])[m
[32m+[m[32m  sparkline3.draw([15, 19, 20, 22, 33, 27, 31, 27, 19, 30, 21]) */[m
 [m
   // The Calender[m
   $('#calendar').datetimepicker({[m
[1mdiff --git a/resources/views/components/cards/sm-card.blade.php b/resources/views/components/cards/sm-card.blade.php[m
[1mindex eba0cf5..e046bed 100644[m
[1m--- a/resources/views/components/cards/sm-card.blade.php[m
[1m+++ b/resources/views/components/cards/sm-card.blade.php[m
[36m@@ -1,4 +1,4 @@[m
[31m-<div class="col-md-4 col-sm-6 col-12">[m
[32m+[m[32m<div class="col-md-3 col-sm-6 col-12">[m
     <div class="info-box {{  $bgcolor  }}">[m
         <span class="info-box-icon">[m
             <i class="{{ $icon }}"></i>[m
[1mdiff --git a/resources/views/components/cards/xl-card.blade.php b/resources/views/components/cards/xl-card.blade.php[m
[1mindex 3a0f34a..5ee3d11 100644[m
[1m--- a/resources/views/components/cards/xl-card.blade.php[m
[1m+++ b/resources/views/components/cards/xl-card.blade.php[m
[36m@@ -1,4 +1,4 @@[m
[31m-<div class="col-lg-4 col-6">[m
[32m+[m[32m<div class="col-lg-3 col-6">[m
     <!-- small card -->[m
     <div class="small-box {{ $bgcolor }}">[m
         <div class="inner">[m
[1mdiff --git a/resources/views/components/form/input.blade.php b/resources/views/components/form/input.blade.php[m
[1mindex 21d88a7..129139a 100644[m
[1m--- a/resources/views/components/form/input.blade.php[m
[1m+++ b/resources/views/components/form/input.blade.php[m
[36m@@ -1,7 +1,8 @@[m
 <div class="input-group mb-3">[m
     <input type="{{ $type }}" class="form-control" placeholder="{{ $name }}"[m
         name="{{ $name }}"[m
[31m-        id="{{ $name }}">[m
[32m+[m[32m        id="{{ $name }}"[m
[32m+[m[32m        value="{{ $value }}">[m
     <div class="input-group-append">[m
         <div class="input-group-text">[m
             <span {{ $attributes }}></span>[m
[1mdiff --git a/resources/views/components/link.blade.php b/resources/views/components/link.blade.php[m
[1mindex 4a1ef68..83dde9e 100644[m
[1m--- a/resources/views/components/link.blade.php[m
[1m+++ b/resources/views/components/link.blade.php[m
[36m@@ -1,59 +1,64 @@[m
 <!-- Google Font: Source Sans Pro -->[m
 <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">[m
 <!-- Font Awesome -->[m
[31m-<link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">[m
[32m+[m[32m<link rel="stylesheet" href="/plugins/fontawesome-free/css/all.min.css">[m
 <!-- Ionicons -->[m
 <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">[m
 <!-- Tempusdominus Bootstrap 4 -->[m
[31m-<link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">[m
[32m+[m[32m<link rel="stylesheet" href="/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">[m
 <!-- iCheck -->[m
[31m-<link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">[m
[32m+[m[32m<link rel="stylesheet" href="/plugins/icheck-bootstrap/icheck-bootstrap.min.css">[m
 <!-- JQVMap -->[m
[31m-<link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">[m
[32m+[m[32m<link rel="stylesheet" href="/plugins/jqvmap/jqvmap.min.css">[m
 <!-- Theme style -->[m
[31m-<link rel="stylesheet" href="css/adminlte.min.css">[m
[32m+[m[32m<link rel="stylesheet" href="/css/adminlte.min.css">[m
 <!-- overlayScrollbars -->[m
[31m-<link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">[m
[32m+[m[32m<link rel="stylesheet" href="/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">[m
 <!-- Daterange picker -->[m
[31m-<link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">[m
[32m+[m[32m<link rel="stylesheet" href="/plugins/daterangepicker/daterangepicker.css">[m
 <!-- summernote -->[m
[31m-<link rel="stylesheet" href="plugins/summernote/summernote-bs4.min.css">[m
[31m-<body  {{ $attributes->merge(['class' =>'sidebar-mini']) }}>[m
[32m+[m[32m<link rel="stylesheet" href="/plugins/summernote/summernote-bs4.min.css">[m
[32m+[m[32m<link href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" rel="stylesheet">[m
[32m+[m[32m<link rel="stylesheet" type="text/css" href="https://jeremyfagis.github.io/dropify/dist/css/dropify.min.css">[m
[32m+[m
[32m+[m[32m<body {{ $attributes->merge(['class' => 'sidebar-mini']) }}>[m
[32m+[m
 [m
 </body>[m
 [m
 <!-- jQuery -->[m
[31m-<script src="plugins/jquery/jquery.min.js"></script>[m
[32m+[m[32m<script src="/plugins/jquery/jquery.min.js"></script>[m
 <!-- jQuery UI 1.11.4 -->[m
[31m-<script src="plugins/jquery-ui/jquery-ui.min.js"></script>[m
[31m-<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->[m
[32m+[m[32m<script src="/plugins/jquery-ui/jquery-ui.min.js"></script>[m
[32m+[m[32m{{-- <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->[m
 <script>[m
   $.widget.bridge('uibutton', $.ui.button)[m
[31m-</script>[m
[32m+[m[32m</script> --}}[m
 <!-- Bootstrap 4 -->[m
[31m-<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>[m
[32m+[m[32m<script src="/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>[m
 <!-- ChartJS -->[m
[31m-<script src="plugins/chart.js/Chart.min.js"></script>[m
[32m+[m[32m<script src="/plugins/chart.js/Chart.min.js"></script>[m
 <!-- Sparkline -->[m
[31m-<script src="plugins/sparklines/sparkline.js"></script>[m
[32m+[m[32m{{-- <script src="plugins/sparklines/sparkline.js"></script> --}}[m
 <!-- JQVMap -->[m
[31m-<script src="plugins/jqvmap/jquery.vmap.min.js"></script>[m
[31m-<script src="plugins/jqvmap/maps/jquery.vmap.usa.js"></script>[m
[32m+[m[32m{{-- <script src="plugins/jqvmap/jquery.vmap.min.js"></script>[m
[32m+[m[32m<script src="plugins/jqvmap/maps/jquery.vmap.usa.js"></script> --}}[m
 <!-- jQuery Knob Chart -->[m
[31m-<script src="plugins/jquery-knob/jquery.knob.min.js"></script>[m
[32m+[m[32m<script src="/plugins/jquery-knob/jquery.knob.min.js"></script>[m
 <!-- daterangepicker -->[m
[31m-<script src="plugins/moment/moment.min.js"></script>[m
[31m-<script src="plugins/daterangepicker/daterangepicker.js"></script>[m
[32m+[m[32m<script src="/plugins/moment/moment.min.js"></script>[m
[32m+[m[32m<script src="/plugins/daterangepicker/daterangepicker.js"></script>[m
 <!-- Tempusdominus Bootstrap 4 -->[m
[31m-<script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>[m
[32m+[m[32m<script src="/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>[m
 <!-- Summernote -->[m
[31m-<script src="plugins/summernote/summernote-bs4.min.js"></script>[m
[32m+[m[32m<script src="/plugins/summernote/summernote-bs4.min.js"></script>[m
 <!-- overlayScrollbars -->[m
[31m-<script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>[m
[32m+[m[32m<script src="/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>[m
 <!-- AdminLTE App -->[m
[31m-<script src="js/adminlte.js"></script>[m
[32m+[m[32m<script src="/js/adminlte.js"></script>[m
 <!-- AdminLTE for demo purposes -->[m
[31m-<script src="js/demo.js"></script>[m
[32m+[m[32m<script src="/js/demo.js"></script>[m
 <!-- AdminLTE dashboard demo (This is only for demo purposes) -->[m
[31m-<script src="js/pages/dashboard.js"></script>[m
[31m-[m
[32m+[m[32m<script src="/js/pages/dashboard.js"></script>[m
[32m+[m[32m<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>[m
[32m+[m[32m<script type="text/javascript" src="https://jeremyfagis.github.io/dropify/dist/js/dropify.min.js"></script>[m
[1mdiff --git a/resources/views/components/maincontent.blade.php b/resources/views/components/maincontent.blade.php[m
[1mdeleted file mode 100644[m
[1mindex e69de29..0000000[m
[1mdiff --git a/resources/views/components/navbar/navbar.blade.php b/resources/views/components/navbar/navbar.blade.php[m
[1mindex d3f8906..c6eb026 100644[m
[1m--- a/resources/views/components/navbar/navbar.blade.php[m
[1m+++ b/resources/views/components/navbar/navbar.blade.php[m
[36m@@ -1,140 +1,143 @@[m
 {{-- <body {{ $attributes->merge(['class' =>'sidebar-mini']) }}> --}}[m
[31m-    <nav class="main-header navbar navbar-expand navbar-white navbar-light">[m
[31m-        <!-- Left navbar links -->[m
[31m-        <ul class="navbar-nav">[m
[31m-            <li class="nav-item">[m
[31m-                <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>[m
[31m-            </li>[m
[31m-            <li class="nav-item d-none d-sm-inline-block">[m
[31m-                <a href="index3.html" class="nav-link">Home</a>[m
[31m-            </li>[m
[31m-            <li class="nav-item d-none d-sm-inline-block">[m
[31m-                <a href="#" class="nav-link">Contact</a>[m
[31m-            </li>[m
[31m-        </ul>[m
[32m+[m[32m<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"[m
[32m+[m[32m    integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="[m
[32m+[m[32m    crossorigin="anonymous" referrerpolicy="no-referrer" />[m
[32m+[m[32m<nav class="main-header navbar navbar-expand navbar-white navbar-light">[m
[32m+[m[32m    <!-- Left navbar links -->[m
[32m+[m[32m    <ul class="navbar-nav">[m
[32m+[m[32m        <li class="nav-item">[m
[32m+[m[32m            <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>[m
[32m+[m[32m        </li>[m
[32m+[m[32m        <li class="nav-item d-none d-sm-inline-block">[m
[32m+[m[32m            <a href="index3.html" class="nav-link">Home</a>[m
[32m+[m[32m        </li>[m
[32m+[m[32m        <li class="nav-item d-none d-sm-inline-block">[m
[32m+[m[32m            <a href="#" class="nav-link">Contact</a>[m
[32m+[m[32m        </li>[m
[32m+[m[32m    </ul>[m
 [m
[31m-        <!-- Right navbar links -->[m
[31m-        <ul class="navbar-nav ml-auto">[m
[31m-            <!-- Navbar Search -->[m
[31m-            <li class="nav-item">[m
[31m-                <a class="nav-link" data-widget="navbar-search" href="#" role="button">[m
[31m-                    <i class="fas fa-search"></i>[m
[31m-                </a>[m
[31m-                <div class="navbar-search-block">[m
[31m-                    <form class="form-inline">[m
[31m-                        <div class="input-group input-group-sm">[m
[31m-                            <input class="form-control form-control-navbar" type="search" placeholder="Search"[m
[31m-                                aria-label="Search">[m
[31m-                            <div class="input-group-append">[m
[31m-                                <button class="btn btn-navbar" type="submit">[m
[31m-                                    <i class="fas fa-search"></i>[m
[31m-                                </button>[m
[31m-                                <button class="btn btn-navbar" type="button" data-widget="navbar-search">[m
[31m-                                    <i class="fas fa-times"></i>[m
[31m-                                </button>[m
[31m-                            </div>[m
[32m+[m[32m    <!-- Right navbar links -->[m
[32m+[m[32m    <ul class="navbar-nav ml-auto">[m
[32m+[m[32m        <!-- Navbar Search -->[m
[32m+[m[32m        <li class="nav-item">[m
[32m+[m[32m            <a class="nav-link" data-widget="navbar-search" href="#" role="button">[m
[32m+[m[32m                <i class="fas fa-search"></i>[m
[32m+[m[32m            </a>[m
[32m+[m[32m            <div class="navbar-search-block">[m
[32m+[m[32m                <form class="form-inline">[m
[32m+[m[32m                    <div class="input-group input-group-sm">[m
[32m+[m[32m                        <input class="form-control form-control-navbar" type="search" placeholder="Search"[m
[32m+[m[32m                            aria-label="Search">[m
[32m+[m[32m                        <div class="input-group-append">[m
[32m+[m[32m                            <button class="btn btn-navbar" type="submit">[m
[32m+[m[32m                                <i class="fas fa-search"></i>[m
[32m+[m[32m                            </button>[m
[32m+[m[32m                            <button class="btn btn-navbar" type="button" data-widget="navbar-search">[m
[32m+[m[32m                                <i class="fas fa-times"></i>[m
[32m+[m[32m                            </button>[m
                         </div>[m
[31m-                    </form>[m
[31m-                </div>[m
[31m-            </li>[m
[32m+[m[32m                    </div>[m
[32m+[m[32m                </form>[m
[32m+[m[32m            </div>[m
[32m+[m[32m        </li>[m
 [m
[31m-            <!-- Messages Dropdown Menu -->[m
[31m-            <li class="nav-item dropdown">[m
[31m-                <a class="nav-link" data-toggle="dropdown" href="#">[m
[31m-                    <i class="far fa-comments"></i>[m
[31m-                    <span class="badge badge-danger navbar-badge">3</span>[m
[31m-                </a>[m
[31m-                <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">[m
[31m-                    <a href="#" class="dropdown-item">[m
[31m-                        <!-- Message Start -->[m
[31m-                        <div class="media">[m
[31m-                            <img src="dist/img/user1-128x128.jpg" alt="User Avatar" class="img-size-50 mr-3 img-circle">[m
[31m-                            <div class="media-body">[m
[31m-                                <h3 class="dropdown-item-title">[m
[31m-                                    Brad Diesel[m
[31m-                                    <span class="float-right text-sm text-danger"><i class="fas fa-star"></i></span>[m
[31m-                                </h3>[m
[31m-                                <p class="text-sm">Call me whenever you can...</p>[m
[31m-                                <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>[m
[31m-                            </div>[m
[32m+[m[32m        <!-- Messages Dropdown Menu -->[m
[32m+[m[32m        <li class="nav-item dropdown">[m
[32m+[m[32m            <a class="nav-link" data-toggle="dropdown" href="#">[m
[32m+[m[32m                <i class="far fa-comments"></i>[m
[32m+[m[32m                <span class="badge badge-danger navbar-badge">3</span>[m
[32m+[m[32m            </a>[m
[32m+[m[32m            <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">[m
[32m+[m[32m                <a href="#" class="dropdown-item">[m
[32m+[m[32m                    <!-- Message Start -->[m
[32m+[m[32m                    <div class="media">[m
[32m+[m[32m                        <img src="dist/img/user1-128x128.jpg" alt="User Avatar" class="img-size-50 mr-3 img-circle">[m
[32m+[m[32m                        <div class="media-body">[m
[32m+[m[32m                            <h3 class="dropdown-item-title">[m
[32m+[m[32m                                Brad Diesel[m
[32m+[m[32m                                <span class="float-right text-sm text-danger"><i class="fas fa-star"></i></span>[m
[32m+[m[32m                            </h3>[m
[32m+[m[32m                            <p class="text-sm">Call me whenever you can...</p>[m
[32m+[m[32m                            <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>[m
                         </div>[m
[31m-                        <!-- Message End -->[m
[31m-                    </a>[m
[31m-                    <div class="dropdown-divider"></div>[m
[31m-                    <a href="#" class="dropdown-item">[m
[31m-                        <!-- Message Start -->[m
[31m-                        <div class="media">[m
[31m-                            <img src="dist/img/user8-128x128.jpg" alt="User Avatar" class="img-size-50 img-circle mr-3">[m
[31m-                            <div class="media-body">[m
[31m-                                <h3 class="dropdown-item-title">[m
[31m-                                    John Pierce[m
[31m-                                    <span class="float-right text-sm text-muted"><i class="fas fa-star"></i></span>[m
[31m-                                </h3>[m
[31m-                                <p class="text-sm">I got your message bro</p>[m
[31m-                                <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>[m
[31m-                            </div>[m
[32m+[m[32m                    </div>[m
[32m+[m[32m                    <!-- Message End -->[m
[32m+[m[32m                </a>[m
[32m+[m[32m                <div class="dropdown-divider"></div>[m
[32m+[m[32m                <a href="#" class="dropdown-item">[m
[32m+[m[32m                    <!-- Message Start -->[m
[32m+[m[32m                    <div class="media">[m
[32m+[m[32m                        <img src="dist/img/user8-128x128.jpg" alt="User Avatar" class="img-size-50 img-circle mr-3">[m
[32m+[m[32m                        <div class="media-body">[m
[32m+[m[32m                            <h3 class="dropdown-item-title">[m
[32m+[m[32m                                John Pierce[m
[32m+[m[32m                                <span class="float-right text-sm text-muted"><i class="fas fa-star"></i></span>[m
[32m+[m[32m                            </h3>[m
[32m+[m[32m                            <p class="text-sm">I got your message bro</p>[m
[32m+[m[32m                            <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>[m
                         </div>[m
[31m-                        <!-- Message End -->[m
[31m-                    </a>[m
[31m-                    <div class="dropdown-divider"></div>[m
[31m-                    <a href="#" class="dropdown-item">[m
[31m-                        <!-- Message Start -->[m
[31m-                        <div class="media">[m
[31m-                            <img src="dist/img/user3-128x128.jpg" alt="User Avatar" class="img-size-50 img-circle mr-3">[m
[31m-                            <div class="media-body">[m
[31m-                                <h3 class="dropdown-item-title">[m
[31m-                                    Nora Silvester[m
[31m-                                    <span class="float-right text-sm text-warning"><i class="fas fa-star"></i></span>[m
[31m-                                </h3>[m
[31m-                                <p class="text-sm">The subject goes here</p>[m
[31m-                                <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>[m
[31m-                            </div>[m
[32m+[m[32m                    </div>[m
[32m+[m[32m                    <!-- Message End -->[m
[32m+[m[32m                </a>[m
[32m+[m[32m                <div class="dropdown-divider"></div>[m
[32m+[m[32m                <a href="#" class="dropdown-item">[m
[32m+[m[32m                    <!-- Message Start -->[m
[32m+[m[32m                    <div class="media">[m
[32m+[m[32m                        <img src="dist/img/user3-128x128.jpg" alt="User Avatar" class="img-size-50 img-circle mr-3">[m
[32m+[m[32m                        <div class="media-body">[m
[32m+[m[32m                            <h3 class="dropdown-item-title">[m
[32m+[m[32m                                Nora Silvester[m
[32m+[m[32m                                <span class="float-right text-sm text-warning"><i class="fas fa-star"></i></span>[m
[32m+[m[32m                            </h3>[m
[32m+[m[32m                            <p class="text-sm">The subject goes here</p>[m
[32m+[m[32m                            <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>[m
                         </div>[m
[31m-                        <!-- Message End -->[m
[31m-                    </a>[m
[31m-                    <div class="dropdown-divider"></div>[m
[31m-                    <a href="#" class="dropdown-item dropdown-footer">See All Messages</a>[m
[31m-                </div>[m
[31m-            </li>[m
[31m-            <!-- Notifications Dropdown Menu -->[m
[31m-            <li class="nav-item dropdown">[m
[31m-                <a class="nav-link" data-toggle="dropdown" href="#">[m
[31m-                    <i class="far fa-bell"></i>[m
[31m-                    <span class="badge badge-warning navbar-badge">15</span>[m
[32m+[m[32m                    </div>[m
[32m+[m[32m                    <!-- Message End -->[m
[32m+[m[32m                </a>[m
[32m+[m[32m                <div class="dropdown-divider"></div>[m
[32m+[m[32m                <a href="#" class="dropdown-item dropdown-footer">See All Messages</a>[m
[32m+[m[32m            </div>[m
[32m+[m[32m        </li>[m
[32m+[m[32m        <!-- Notifications Dropdown Menu -->[m
[32m+[m[32m        <li class="nav-item dropdown">[m
[32m+[m[32m            <a class="nav-link" data-toggle="dropdown" href="#">[m
[32m+[m[32m                <i class="far fa-bell"></i>[m
[32m+[m[32m                <span class="badge badge-warning navbar-badge">15</span>[m
[32m+[m[32m            </a>[m
[32m+[m[32m            <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">[m
[32m+[m[32m                <span class="dropdown-item dropdown-header">15 Notifications</span>[m
[32m+[m[32m                <div class="dropdown-divider"></div>[m
[32m+[m[32m                <a href="#" class="dropdown-item">[m
[32m+[m[32m                    <i class="fas fa-envelope mr-2"></i> 4 new messages[m
[32m+[m[32m                    <span class="float-right text-muted text-sm">3 mins</span>[m
                 </a>[m
[31m-                <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">[m
[31m-                    <span class="dropdown-item dropdown-header">15 Notifications</span>[m
[31m-                    <div class="dropdown-divider"></div>[m
[31m-                    <a href="#" class="dropdown-item">[m
[31m-                        <i class="fas fa-envelope mr-2"></i> 4 new messages[m
[31m-                        <span class="float-right text-muted text-sm">3 mins</span>[m
[31m-                    </a>[m
[31m-                    <div class="dropdown-divider"></div>[m
[31m-                    <a href="#" class="dropdown-item">[m
[31m-                        <i class="fas fa-users mr-2"></i> 8 friend requests[m
[31m-                        <span class="float-right text-muted text-sm">12 hours</span>[m
[31m-                    </a>[m
[31m-                    <div class="dropdown-divider"></div>[m
[31m-                    <a href="#" class="dropdown-item">[m
[31m-                        <i class="fas fa-file mr-2"></i> 3 new reports[m
[31m-                        <span class="float-right text-muted text-sm">2 days</span>[m
[31m-                    </a>[m
[31m-                    <div class="dropdown-divider"></div>[m
[31m-                    <a href="#" class="dropdown-item dropdown-footer">See All Notifications</a>[m
[31m-                </div>[m
[31m-            </li>[m
[31m-            <li class="nav-item">[m
[31m-                <a class="nav-link" data-widget="fullscreen" href="#" role="button">[m
[31m-                    <i class="fas fa-expand-arrows-alt"></i>[m
[32m+[m[32m                <div class="dropdown-divider"></div>[m
[32m+[m[32m                <a href="#" class="dropdown-item">[m
[32m+[m[32m                    <i class="fas fa-users mr-2"></i> 8 friend requests[m
[32m+[m[32m                    <span class="float-right text-muted text-sm">12 hours</span>[m
                 </a>[m
[31m-            </li>[m
[31m-            <li class="nav-item">[m
[31m-                <a class="nav-link" data-widget="control-sidebar" data-controlsidebar-slide="true" href="#"[m
[31m-                    role="button">[m
[31m-                    <i class="fas fa-th-large"></i>[m
[32m+[m[32m                <div class="dropdown-divider"></div>[m
[32m+[m[32m                <a href="#" class="dropdown-item">[m
[32m+[m[32m                    <i class="fas fa-file mr-2"></i> 3 new reports[m
[32m+[m[32m                    <span class="float-right text-muted text-sm">2 days</span>[m
                 </a>[m
[31m-            </li>[m
[31m-        </ul>[m
[31m-    </nav>[m
[31m-    <!-- /.navbar -->[m
[32m+[m[32m                <div class="dropdown-divider"></div>[m
[32m+[m[32m                <a href="#" class="dropdown-item dropdown-footer">See All Notifications</a>[m
[32m+[m[32m            </div>[m
[32m+[m[32m        </li>[m
[32m+[m[32m        <li class="nav-item">[m
[32m+[m[32m            <a class="nav-link" data-widget="fullscreen" href="#" role="button">[m
[32m+[m[32m                <i class="fas fa-expand-arrows-alt"></i>[m
[32m+[m[32m            </a>[m
[32m+[m[32m        </li>[m
[32m+[m[32m        <li class="nav-item">[m
[32m+[m[32m            <a class="nav-link"  href="/logout"[m
[32m+[m[32m                role="button">[m
[32m+[m[32m                <i class="fas fa-sign-out"></i>[m
[32m+[m[32m            </a>[m
[32m+[m[32m        </li>[m
[32m+[m[32m    </ul>[m
[32m+[m[32m</nav>[m
[32m+[m[32m<!-- /.navbar -->[m
 {{-- </body> --}}[m
[1mdiff --git a/resources/views/components/sidebar/sidebar.blade.php b/resources/views/components/sidebar/sidebar.blade.php[m
[1mindex f2d1904..19d63fe 100644[m
[1m--- a/resources/views/components/sidebar/sidebar.blade.php[m
[1m+++ b/resources/views/components/sidebar/sidebar.blade.php[m
[36m@@ -1,7 +1,7 @@[m
 {{-- <body {{ $attributes->merge(['class' => 'sidebar-mini']) }}> --}}[m
 <aside class="main-sidebar sidebar-dark-primary elevation-4">[m
     <!-- Brand Logo -->[m
[31m-    <a href="index3.html" class="brand-link">[m
[32m+[m[32m    <a href="/dashboard" class="brand-link">[m
       <img src="{{ asset('images/AdminLTELogo.png') }}" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">[m
       <span class="brand-text font-weight-light">AdminLTE 3</span>[m
     </a>[m
[36m@@ -35,12 +35,30 @@[m
         <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">[m
           <!-- Add icons to the links using the .nav-icon class[m
                with font-awesome or any other icon font library -->[m
[31m-          <li class="nav-item menu-open">[m
[31m-            <a href="/dashboard" class="nav-link active">[m
[32m+[m[32m          <li class="nav-item ">[m
[32m+[m[32m            <a href="/dashboard"[m
[32m+[m[32m            class="nav-link[m
[32m+[m[32m            {{ request()->is('dashboard') ? 'active' : '' }}[m
[32m+[m[32m            ">[m
               <i class="nav-icon fas fa-tachometer-alt"></i>[m
               <p>[m
                 Dashboard[m
[31m-                <i class="right fas fa-angle-left"></i>[m
[32m+[m[32m              </p>[m
[32m+[m[32m            </a>[m
[32m+[m[32m          </li>[m
[32m+[m[32m          <li class="nav-item">[m
[32m+[m[32m            <a href="{{ route("categories.index") }}" class="nav-link {{Route::is('categories.index') ? 'active' : ''}}">[m
[32m+[m[32m              <i class="nav-icon fas fa-chart-pie"></i>[m
[32m+[m[32m              <p>[m
[32m+[m[32m                Category[m
[32m+[m[32m              </p>[m
[32m+[m[32m            </a>[m
[32m+[m[32m          </li>[m
[32m+[m[32m          <li class="nav-item">[m
[32m+[m[32m            <a href="{{ route("posts.index") }}" class="nav-link {{Route::is('posts.index') ? 'active' : ''}}">[m
[32m+[m[32m              <i class="nav-icon fas fa-chart-pie"></i>[m
[32m+[m[32m              <p>[m
[32m+[m[32m                Post[m
               </p>[m
             </a>[m
           </li>[m
[36m@@ -53,7 +71,7 @@[m
               </p>[m
             </a>[m
           </li> --}}[m
[31m-          <li class="nav-item">[m
[32m+[m[32m          {{-- <li class="nav-item">[m
             <a href="#" class="nav-link">[m
               <i class="nav-icon fas fa-copy"></i>[m
               <p>[m
[36m@@ -61,7 +79,7 @@[m
                 <i class="fas fa-angle-left right"></i>[m
                 <span class="badge badge-info right">6</span>[m
               </p>[m
[31m-            </a>[m
[32m+[m[32m            </a> --}}[m
             <ul class="nav nav-treeview">[m
               <li class="nav-item">[m
                 <a href="/normal-sidebar" class="nav-link">[m
[1mdiff --git a/resources/views/login/forgot-password.blade.php b/resources/views/login/forgot-password.blade.php[m
[1mindex feea328..2602541 100644[m
[1m--- a/resources/views/login/forgot-password.blade.php[m
[1m+++ b/resources/views/login/forgot-password.blade.php[m
[36m@@ -4,10 +4,10 @@[m
         <div class="card-body login-card-body">[m
             <p class="login-box-msg">Here you can easily retrieve a new password.</p>[m
 [m
[31m-            <x-form.input name="email" type="email" class="fas fa-envelope"></x-form.input>[m
[32m+[m[32m            <x-form.input name="email" type="email" class="fas fa-envelope" value="{{ old('email') }}"></x-form.input>[m
             <div class="row">[m
                 <div class="col-12">[m
[31m-                    <x-form.button type="submit" name="Request New Password"></x-form.button>[m
[32m+[m[32m                    <x-form.button type="submit" name="Request New Password" value="{{ old('email') }}"></x-form.button>[m
                 </div>[m
                 <!-- /.col -->[m
             </div>[m
[1mdiff --git a/resources/views/login/login.blade.php b/resources/views/login/login.blade.php[m
[1mindex 85e5397..6ac5e96 100644[m
[1m--- a/resources/views/login/login.blade.php[m
[1m+++ b/resources/views/login/login.blade.php[m
[36m@@ -1,14 +1,22 @@[m
 [m
 <x-form.login-layout>[m
[31m-    @extends('components.form.form', ['action' => '#', 'method' => 'get'])[m
[32m+[m[32m    @extends('components.form.form', ['action' => '/login', 'method' => 'POST'])[m
[32m+[m
     @section('form-data')[m
[32m+[m[32m    @csrf[m
         <div class="card-body login-card-body">[m
             <p class="login-box-msg">Sign in to start your session</p>[m
 [m
[31m-            <x-form.input name="email" type="email" class="fas fa-envelope"/>[m
[31m-            <x-form.input name="password" type="password" class="fas fa-key"/>[m
[32m+[m[32m            <x-form.input name="email" type="email" class="fas fa-envelope" value="{{ old('email') }}"/>[m
[32m+[m[32m            @error('email')[m
[32m+[m[32m                <p class="text-sm text-danger">* {{ $message }}</p>[m
[32m+[m[32m            @enderror[m
[32m+[m[32m            <x-form.input name="password" type="password" class="fas fa-key" value="{{ old('password') }}"/>[m
[32m+[m[32m            @error('password')[m
[32m+[m[32m                <p class="text-sm text-danger">* {{ $message }}</p>[m
[32m+[m[32m            @enderror[m
             <div class="row">[m
[31m-                <x-form.checkbox name="remeber" type="checkbox"/>[m
[32m+[m[32m                {{-- <x-form.checkbox name="remeber" type="checkbox"/> --}}[m
                 <div class="col-4">[m
                     <x-form.button type="submit" name="login"/>[m
                 </div>[m
[1mdiff --git a/resources/views/login/recover-password.blade.php b/resources/views/login/recover-password.blade.php[m
[1mindex f97e0e0..587e7cb 100644[m
[1m--- a/resources/views/login/recover-password.blade.php[m
[1m+++ b/resources/views/login/recover-password.blade.php[m
[36m@@ -3,11 +3,11 @@[m
     @section('form-data')[m
         <div class="card-body login-card-body">[m
             <p class="login-box-msg">Recover your password now.</p>[m
[31m-            <x-form.input name="password" type="password" class="fas fa-key"></x-form.input>[m
[31m-            <x-form.input name="retype" type="password" class="fas fa-key"></x-form.input>[m
[32m+[m[32m            <x-form.input name="password" type="password" class="fas fa-key" value="{{ old('email') }}"></x-form.input>[m
[32m+[m[32m            <x-form.input name="retype" type="password" class="fas fa-key" value="{{ old('email') }}"></x-form.input>[m
             <div class="row">[m
                 <div class="col-12">[m
[31m-                    <x-form.button type="submit" name="Change password"></x-form.button>[m
[32m+[m[32m                    <x-form.button type="submit" name="Change password" ></x-form.button>[m
                 </div>[m
             </div>[m
             <p class="mt-3 mb-1">[m
[1mdiff --git a/resources/views/login/register.blade.php b/resources/views/login/register.blade.php[m
[1mindex 589874b..d3fa201 100644[m
[1m--- a/resources/views/login/register.blade.php[m
[1m+++ b/resources/views/login/register.blade.php[m
[36m@@ -1,16 +1,25 @@[m
 <x-form.login-layout>[m
[31m-    @extends('components.form.form', ['action' => '#', 'method' => 'get'])[m
[32m+[m[32m    @extends('components.form.form', ['action' => '/register', 'method' => 'POST'])[m
     @section('form-data')[m
[32m+[m[32m        @csrf[m
         <div class="card-body register-card-body">[m
             <p class="login-box-msg">Register a new membership</p>[m
 [m
[31m-            <x-form.input type="text" name="full-name" class="fas fa-user"></x-form.input>[m
[31m-            <x-form.input type="email" name="email" class="fas fa-envelope"></x-form.input>[m
[31m-      [m
[31m-            <x-form.input type="password" name="password" class="fas fa-key"></x-form.input>[m
[31m-            <x-form.input type="password" name="retype" class="fas fa-key"></x-form.input>[m
[32m+[m[32m            <x-form.input type="text" name="name" class="fas fa-user" value="{{ old('name') }}"></x-form.input>[m
[32m+[m[32m            @error('name')[m
[32m+[m[32m                <p class="text-sm text-danger">* {{ $message }}</p>[m
[32m+[m[32m            @enderror[m
[32m+[m[32m            <x-form.input type="email" name="email" class="fas fa-envelope" value="{{ old('email') }}"></x-form.input>[m
[32m+[m[32m            @error('email')[m
[32m+[m[32m                <p class="text-sm text-danger">* {{ $message }}</p>[m
[32m+[m[32m            @enderror[m
[32m+[m[32m            <x-form.input type="password" name="password" class="fas fa-key" value="{{ old('password') }}"></x-form.input>[m
[32m+[m[32m            @error('password')[m
[32m+[m[32m                <p class="text-sm text-danger">* {{ $message }}</p>[m
[32m+[m[32m            @enderror[m
[32m+[m[32m            <x-form.input type="password" name="retype" class="fas fa-key" value="{{ old('retype') }}"></x-form.input>[m
             <div class="row">[m
[31m-               <x-form.checkbox type="checkbox" name="remember"></x-form.checkbox>[m
[32m+[m[32m                {{-- <x-form.checkbox type="checkbox" name="remember"></x-form.checkbox> --}}[m
                 <div class="col-4">[m
                     <x-form.button type="submit" name="signup"></x-form.button>[m
                 </div>[m
[36m@@ -22,4 +31,4 @@[m
         </div>[m
         </div>[m
     @endsection[m
[31m-</x-form.layout>[m
[32m+[m[32m    </x-form.layout>[m
[1mdiff --git a/resources/views/pages/dashboard.blade.php b/resources/views/pages/dashboard.blade.php[m
[1mindex 7e08ef1..9070432 100644[m
[1m--- a/resources/views/pages/dashboard.blade.php[m
[1m+++ b/resources/views/pages/dashboard.blade.php[m
[36m@@ -1,4 +1,5 @@[m
 <x-link class="layout-navbar-fixed layout-fixed  layout-footer-fixed"></x-link>[m
[32m+[m
 {{-- Fixed Navbar = layout-navbar-fixed --}}[m
 {{-- Fixed Sidebar = layout-fixed --}}[m
 {{-- Fixed Footer = layout-footer-fixed --}}[m
[36m@@ -8,6 +9,7 @@[m
     <x-navbar.footer></x-navbar.footer>[m
     <section class="content-wrapper">[m
         <div class="container-fluid">[m
[32m+[m
             <h5 class="mb-2">Info Box</h5>[m
             <div class="row">[m
                 <x-cards.sm-card bgcolor='bg-info' icon="fas fa-home" msg1='Home' msg2='10001' />[m
[1mdiff --git a/routes/web.php b/routes/web.php[m
[1mindex dadbe3c..16770aa 100644[m
[1m--- a/routes/web.php[m
[1m+++ b/routes/web.php[m
[36m@@ -1,5 +1,9 @@[m
 <?php[m
 [m
[32m+[m[32muse App\Http\Controllers\CategoryController;[m
[32m+[m[32muse App\Http\Controllers\RegisterController;[m
[32m+[m[32muse App\Http\Controllers\LoginController;[m
[32m+[m[32muse App\Http\Controllers\PostController;[m
 use Illuminate\Support\Facades\Route;[m
 [m
 /*[m
[36m@@ -13,45 +17,36 @@[m
 |[m
 */[m
 [m
[31m-Route::get('/', function () {[m
[31m-    return view('welcome');[m
[31m-});[m
[32m+[m[32mRoute::get('/',[LoginController::class, 'load']);[m
 [m
 // LoginSystem Rotue[m
[31m-Route::get('login',function(){[m
[31m-    return view('login.login');[m
[31m-});[m
[32m+[m[32mRoute::get('/login',[LoginController::class, 'load'])->name('login');[m
[32m+[m[32mRoute::post('login',[LoginController::class,'check']);[m
[32m+[m
[32m+[m
 Route::get('register',function(){[m
     return view('login.register');[m
 });[m
[32m+[m[32mRoute::post('register',[RegisterController::class,'store']);[m
[32m+[m
[32m+[m[32mRoute::get('logout',[LoginController::class,'destroy']);[m
[32m+[m
 Route::get('forgot-password',function(){[m
     return view('login.forgot-password');[m
[31m-});[m
[32m+[m[32m})->middleware('guest');[m
 Route::get('recover-password',function(){[m
     return view('login.recover-password');[m
[31m-});[m
[32m+[m[32m})->middleware('guest');[m
 Route::get('dashboard',function(){[m
     return view('pages.dashboard');[m
[31m-});[m
[32m+[m[32m})->middleware('auth')[m
[32m+[m[32m->name('dashboard');[m
 [m
[31m-// Sidebar Navbar Footer[m
[31m-Route::get('normal-sidebar',function(){[m
[31m-        return view('pages.dynamic-page',[[m
[31m-            'data'=> "layout-navbar-fixed  layout-footer-fixed"[m
[31m-        ]);[m
[31m-});[m
[31m-Route::get('fixed-sidebar',function(){[m
[31m-    return view('pages.dynamic-page',[[m
[31m-        'data'=> "layout-fixed layout"[m
[32m+[m[32mRoute::group([[m
[32m+[m[32m    'middleware' => 'auth',[m
[32m+[m[32m], function () {[m
[32m+[m[32m    Route::resources([[m
[32m+[m[32m        'categories' => CategoryController::class,[m
[32m+[m[32m        'posts' => PostController::class,[m
     ]);[m
 });[m
[31m-Route::get('normal-navbar',function(){[m
[31m-    return view('pages.dynamic-page',[[m
[31m-        'data'=> "layout-footer-fixed"[m
[31m-    ]);[m
[31m-});[m
[31m-Route::get('fixed-navbar',function(){[m
[31m-    return view('pages.dynamic-page',[[m
[31m-        'data'=> "layout-navbar-fixed"[m
[31m-    ]);[m
[31m-});[m
\ No newline at end of file[m
[1mdiff --git a/vendor/composer/autoload_classmap.php b/vendor/composer/autoload_classmap.php[m
[1mindex cba7dec..72c6eb5 100644[m
[1m--- a/vendor/composer/autoload_classmap.php[m
[1m+++ b/vendor/composer/autoload_classmap.php[m
[36m@@ -9,6 +9,9 @@[m
     'App\\Console\\Kernel' => $baseDir . '/app/Console/Kernel.php',[m
     'App\\Exceptions\\Handler' => $baseDir . '/app/Exceptions/Handler.php',[m
     'App\\Http\\Controllers\\Controller' => $baseDir . '/app/Http/Controllers/Controller.php',[m
[32m+[m[32m    'App\\Http\\Controllers\\LoginController' => $baseDir . '/app/Http/Controllers/LoginController.php',[m
[32m+[m[32m    'App\\Http\\Controllers\\PostCategory' => $baseDir . '/app/Http/Controllers/PostCategory.php',[m
[32m+[m[32m    'App\\Http\\Controllers\\RegisterController' => $baseDir . '/app/Http/Controllers/RegisterController.php',[m
     'App\\Http\\Kernel' => $baseDir . '/app/Http/Kernel.php',[m
     'App\\Http\\Middleware\\Authenticate' => $baseDir . '/app/Http/Middleware/Authenticate.php',[m
     'App\\Http\\Middleware\\EncryptCookies' => $baseDir . '/app/Http/Middleware/EncryptCookies.php',[m
[36m@@ -19,12 +22,16 @@[m
     'App\\Http\\Middleware\\TrustProxies' => $baseDir . '/app/Http/Middleware/TrustProxies.php',[m
     'App\\Http\\Middleware\\ValidateSignature' => $baseDir . '/app/Http/Middleware/ValidateSignature.php',[m
     'App\\Http\\Middleware\\VerifyCsrfToken' => $baseDir . '/app/Http/Middleware/VerifyCsrfToken.php',[m
[32m+[m[32m    'App\\Models\\PostCategory' => $baseDir . '/app/Models/PostCategory.php',[m
[32m+[m[32m    'App\\Models\\RegisterModel' => $baseDir . '/app/Models/RegisterModel.php',[m
     'App\\Models\\User' => $baseDir . '/app/Models/User.php',[m
     'App\\Providers\\AppServiceProvider' => $baseDir . '/app/Providers/AppServiceProvider.php',[m
     'App\\Providers\\AuthServiceProvider' => $baseDir . '/app/Providers/AuthServiceProvider.php',[m
     'App\\Providers\\BroadcastServiceProvider' => $baseDir . '/app/Providers/BroadcastServiceProvider.php',[m
     'App\\Providers\\EventServiceProvider' => $baseDir . '/app/Providers/EventServiceProvider.php',[m
     'App\\Providers\\RouteServiceProvider' => $baseDir . '/app/Providers/RouteServiceProvider.php',[m
[32m+[m[32m    'App\\View\\Components\\cards\\SmCard' => $baseDir . '/app/View/Components/cards/SmCard.php',[m
[32m+[m[32m    'App\\View\\Components\\cards\\XlCard' => $baseDir . '/app/View/Components/cards/XlCard.php',[m
     'Attribute' => $vendorDir . '/symfony/polyfill-php80/Resources/stubs/Attribute.php',[m
     'Brick\\Math\\BigDecimal' => $vendorDir . '/brick/math/src/BigDecimal.php',[m
     'Brick\\Math\\BigInteger' => $vendorDir . '/brick/math/src/BigInteger.php',[m
[36m@@ -135,6 +142,7 @@[m
     'Cron\\HoursField' => $vendorDir . '/dragonmantank/cron-expression/src/Cron/HoursField.php',[m
     'Cron\\MinutesField' => $vendorDir . '/dragonmantank/cron-expression/src/Cron/MinutesField.php',[m
     'Cron\\MonthField' => $vendorDir . '/dragonmantank/cron-expression/src/Cron/MonthField.php',[m
[32m+[m[32m    'Database\\Factories\\PostCategoryFactory' => $baseDir . '/database/factories/PostCategoryFactory.php',[m
     'Database\\Factories\\UserFactory' => $baseDir . '/database/factories/UserFactory.php',[m
     'Database\\Seeders\\DatabaseSeeder' => $baseDir . '/database/seeders/DatabaseSeeder.php',[m
     'DeepCopy\\DeepCopy' => $vendorDir . '/myclabs/deep-copy/src/DeepCopy/DeepCopy.php',[m
[36m@@ -5781,5 +5789,21 @@[m
     'Whoops\\Util\\Misc' => $vendorDir . '/filp/whoops/src/Whoops/Util/Misc.php',[m
     'Whoops\\Util\\SystemFacade' => $vendorDir . '/filp/whoops/src/Whoops/Util/SystemFacade.php',[m
     'Whoops\\Util\\TemplateHelper' => $vendorDir . '/filp/whoops/src/Whoops/Util/TemplateHelper.php',[m
[32m+[m[32m    'Yajra\\DataTables\\ApiResourceDataTable' => $vendorDir . '/yajra/laravel-datatables-oracle/src/ApiResourceDataTable.php',[m
[32m+[m[32m    'Yajra\\DataTables\\CollectionDataTable' => $vendorDir . '/yajra/laravel-datatables-oracle/src/CollectionDataTable.php',[m
[32m+[m[32m    'Yajra\\DataTables\\Contracts\\DataTable' => $vendorDir . '/yajra/laravel-datatables-oracle/src/Contracts/DataTable.php',[m
[32m+[m[32m    'Yajra\\DataTables\\Contracts\\Formatter' => $vendorDir . '/yajra/laravel-datatables-oracle/src/Contracts/Formatter.php',[m
[32m+[m[32m    'Yajra\\DataTables\\DataTableAbstract' => $vendorDir . '/yajra/laravel-datatables-oracle/src/DataTableAbstract.php',[m
[32m+[m[32m    'Yajra\\DataTables\\DataTables' => $vendorDir . '/yajra/laravel-datatables-oracle/src/DataTables.php',[m
[32m+[m[32m    'Yajra\\DataTables\\DataTablesServiceProvider' => $vendorDir . '/yajra/laravel-datatables-oracle/src/DataTablesServiceProvider.php',[m
[32m+[m[32m    'Yajra\\DataTables\\EloquentDataTable' => $vendorDir . '/yajra/laravel-datatables-oracle/src/EloquentDataTable.php',[m
[32m+[m[32m    'Yajra\\DataTables\\Exceptions\\Exception' => $vendorDir . '/yajra/laravel-datatables-oracle/src/Exceptions/Exception.php',[m
[32m+[m[32m    'Yajra\\DataTables\\Facades\\DataTables' => $vendorDir . '/yajra/laravel-datatables-oracle/src/Facades/DataTables.php',[m
[32m+[m[32m    'Yajra\\DataTables\\Processors\\DataProcessor' => $vendorDir . '/yajra/laravel-datatables-oracle/src/Processors/DataProcessor.php',[m
[32m+[m[32m    'Yajra\\DataTables\\Processors\\RowProcessor' => $vendorDir . '/yajra/laravel-datatables-oracle/src/Processors/RowProcessor.php',[m
[32m+[m[32m    'Yajra\\DataTables\\QueryDataTable' => $vendorDir . '/yajra/laravel-datatables-oracle/src/QueryDataTable.php',[m
[32m+[m[32m    'Yajra\\DataTables\\Utilities\\Config' => $vendorDir . '/yajra/laravel-datatables-oracle/src/Utilities/Config.php',[m
[32m+[m[32m    'Yajra\\DataTables\\Utilities\\Helper' => $vendorDir . '/yajra/laravel-datatables-oracle/src/Utilities/Helper.php',[m
[32m+[m[32m    'Yajra\\DataTables\\Utilities\\Request' => $vendorDir . '/yajra/laravel-datatables-oracle/src/Utilities/Request.php',[m
     'voku\\helper\\ASCII' => $vendorDir . '/voku/portable-ascii/src/voku/helper/ASCII.php',[m
 );[m
[1mdiff --git a/vendor/composer/autoload_files.php b/vendor/composer/autoload_files.php[m
[1mindex f3dee51..4924cb0 100644[m
[1m--- a/vendor/composer/autoload_files.php[m
[1m+++ b/vendor/composer/autoload_files.php[m
[36m@@ -33,4 +33,5 @@[m
     'a1cfe24d14977df6878b9bf804af2d1c' => $vendorDir . '/nunomaduro/collision/src/Adapters/Phpunit/Autoload.php',[m
     'ec07570ca5a812141189b1fa81503674' => $vendorDir . '/phpunit/phpunit/src/Framework/Assert/Functions.php',[m
     '320163ac6b93aebe3dc25b60a0533d56' => $vendorDir . '/spatie/laravel-ignition/src/helpers.php',[m
[32m+[m[32m    '0b47d6d4a00ca9112ba3953b49e7c9a4' => $vendorDir . '/yajra/laravel-datatables-oracle/src/helper.php',[m
 );[m
[1mdiff --git a/vendor/composer/autoload_psr4.php b/vendor/composer/autoload_psr4.php[m
[1mindex 0f68b4c..98afce3 100644[m
[1m--- a/vendor/composer/autoload_psr4.php[m
[1m+++ b/vendor/composer/autoload_psr4.php[m
[36m@@ -7,6 +7,7 @@[m
 [m
 return array([m
     'voku\\' => array($vendorDir . '/voku/portable-ascii/src/voku'),[m
[32m+[m[32m    'Yajra\\DataTables\\' => array($vendorDir . '/yajra/laravel-datatables-oracle/src'),[m
     'Whoops\\' => array($vendorDir . '/filp/whoops/src/Whoops'),[m
     'Webmozart\\Assert\\' => array($vendorDir . '/webmozart/assert/src'),[m
     'TijsVerkoyen\\CssToInlineStyles\\' => array($vendorDir . '/tijsverkoyen/css-to-inline-styles/src'),[m
[36m@@ -48,7 +49,7 @@[m
     'Psy\\' => array($vendorDir . '/psy/psysh/src'),[m
     'Psr\\SimpleCache\\' => array($vendorDir . '/psr/simple-cache/src'),[m
     'Psr\\Log\\' => array($vendorDir . '/psr/log/src'),[m
[31m-    'Psr\\Http\\Message\\' => array($vendorDir . '/psr/http-message/src', $vendorDir . '/psr/http-factory/src'),[m
[32m+[m[32m    'Psr\\Http\\Message\\' => array($vendorDir . '/psr/http-factory/src', $vendorDir . '/psr/http-message/src'),[m
     'Psr\\Http\\Client\\' => array($vendorDir . '/psr/http-client/src'),[m
     'Psr\\EventDispatcher\\' => array($vendorDir . '/psr/event-dispatcher/src'),[m
     'Psr\\Container\\' => array($vendorDir . '/psr/container/src'),[m
[1mdiff --git a/vendor/composer/autoload_static.php b/vendor/composer/autoload_static.php[m
[1mindex 177f48c..34bde85 100644[m
[1m--- a/vendor/composer/autoload_static.php[m
[1m+++ b/vendor/composer/autoload_static.php[m
[36m@@ -34,6 +34,7 @@[m [mclass ComposerStaticInitc9212831b71d36055338fa3096fc3175[m
         'a1cfe24d14977df6878b9bf804af2d1c' => __DIR__ . '/..' . '/nunomaduro/collision/src/Adapters/Phpunit/Autoload.php',[m
         'ec07570ca5a812141189b1fa81503674' => __DIR__ . '/..' . '/phpunit/phpunit/src/Framework/Assert/Functions.php',[m
         '320163ac6b93aebe3dc25b60a0533d56' => __DIR__ . '/..' . '/spatie/laravel-ignition/src/helpers.php',[m
[32m+[m[32m        '0b47d6d4a00ca9112ba3953b49e7c9a4' => __DIR__ . '/..' . '/yajra/laravel-datatables-oracle/src/helper.php',[m
     );[m
 [m
     public static $prefixLengthsPsr4 = array ([m
[36m@@ -41,6 +42,10 @@[m [mclass ComposerStaticInitc9212831b71d36055338fa3096fc3175[m
         array ([m
             'voku\\' => 5,[m
         ),[m
[32m+[m[32m        'Y' =>[m[41m [m
[32m+[m[32m        array ([m
[32m+[m[32m            'Yajra\\DataTables\\' => 17,[m
[32m+[m[32m        ),[m
         'W' => [m
         array ([m
             'Whoops\\' => 7,[m
[36m@@ -174,6 +179,10 @@[m [mclass ComposerStaticInitc9212831b71d36055338fa3096fc3175[m
         array ([m
             0 => __DIR__ . '/..' . '/voku/portable-ascii/src/voku',[m
         ),[m
[32m+[m[32m        'Yajra\\DataTables\\' =>[m[41m [m
[32m+[m[32m        array ([m
[32m+[m[32m            0 => __DIR__ . '/..' . '/yajra/laravel-datatables-oracle/src',[m
[32m+[m[32m        ),[m
         'Whoops\\' => [m
         array ([m
             0 => __DIR__ . '/..' . '/filp/whoops/src/Whoops',[m
[36m@@ -340,8 +349,8 @@[m [mclass ComposerStaticInitc9212831b71d36055338fa3096fc3175[m
         ),[m
         'Psr\\Http\\Message\\' => [m
         array ([m
[31m-            0 => __DIR__ . '/..' . '/psr/http-message/src',[m
[31m-            1 => __DIR__ . '/..' . '/psr/http-factory/src',[m
[32m+[m[32m            0 => __DIR__ . '/..' . '/psr/http-factory/src',[m
[32m+[m[32m            1 => __DIR__ . '/..' . '/psr/http-message/src',[m
         ),[m
         'Psr\\Http\\Client\\' => [m
         array ([m
[36m@@ -508,6 +517,9 @@[m [mclass ComposerStaticInitc9212831b71d36055338fa3096fc3175[m
         'App\\Console\\Kernel' => __DIR__ . '/../..' . '/app/Console/Kernel.php',[m
         'App\\Exceptions\\Handler' => __DIR__ . '/../..' . '/app/Exceptions/Handler.php',[m
         'App\\Http\\Controllers\\Controller' => __DIR__ . '/../..' . '/app/Http/Controllers/Controller.php',[m
[32m+[m[32m        'App\\Http\\Controllers\\LoginController' => __DIR__ . '/../..' . '/app/Http/Controllers/LoginController.php',[m
[32m+[m[32m        'App\\Http\\Controllers\\PostCategory' => __DIR__ . '/../..' . '/app/Http/Controllers/PostCategory.php',[m
[32m+[m[32m        'App\\Http\\Controllers\\RegisterController' => __DIR__ . '/../..' . '/app/Http/Controllers/RegisterController.php',[m
         'App\\Http\\Kernel' => __DIR__ . '/../..' . '/app/Http/Kernel.php',[m
         'App\\Http\\Middleware\\Authenticate' => __DIR__ . '/../..' . '/app/Http/Middleware/Authenticate.php',[m
         'App\\Http\\Middleware\\EncryptCookies' => __DIR__ . '/../..' . '/app/Http/Middleware/EncryptCookies.php',[m
[36m@@ -518,12 +530,16 @@[m [mclass ComposerStaticInitc9212831b71d36055338fa3096fc3175[m
         'App\\Http\\Middleware\\TrustProxies' => __DIR__ . '/../..' . '/app/Http/Middleware/TrustProxies.php',[m
         'App\\Http\\Middleware\\ValidateSignature' => __DIR__ . '/../..' . '/app/Http/Middleware/ValidateSignature.php',[m
         'App\\Http\\Middleware\\VerifyCsrfToken' => __DIR__ . '/../..' . '/app/Http/Middleware/VerifyCsrfToken.php',[m
[32m+[m[32m        'App\\Models\\PostCategory' => __DIR__ . '/../..' . '/app/Models/PostCategory.php',[m
[32m+[m[32m        'App\\Models\\RegisterModel' => __DIR__ . '/../..' . '/app/Models/RegisterModel.php',[m
         'App\\Models\\User' => __DIR__ . '/../..' . '/app/Models/User.php',[m
         'App\\Providers\\AppServiceProvider' => __DIR__ . '/../..' . '/app/Providers/AppServiceProvider.php',[m
         'App\\Providers\\AuthServiceProvider' => __DIR__ . '/../..' . '/app/Providers/AuthServiceProvider.php',[m
         'App\\Providers\\BroadcastServiceProvider' => __DIR__ . '/../..' . '/app/Providers/BroadcastServiceProvider.php',[m
         'App\\Providers\\EventServiceProvider' => __DIR__ . '/../..' . '/app/Providers/EventServiceProvider.php',[m
         'App\\Providers\\RouteServiceProvider' => __DIR__ . '/../..' . '/app/Providers/RouteServiceProvider.php',[m
[32m+[m[32m        'App\\View\\Components\\cards\\SmCard' => __DIR__ . '/../..' . '/app/View/Components/cards/SmCard.php',[m
[32m+[m[32m        'App\\View\\Components\\cards\\XlCard' => __DIR__ . '/../..' . '/app/View/Components/cards/XlCard.php',[m
         'Attribute' => __DIR__ . '/..' . '/symfony/polyfill-php80/Resources/stubs/Attribute.php',[m
         'Brick\\Math\\BigDecimal' => __DIR__ . '/..' . '/brick/math/src/BigDecimal.php',[m
         'Brick\\Math\\BigInteger' => __DIR__ . '/..' . '/brick/math/src/BigInteger.php',[m
[36m@@ -634,6 +650,7 @@[m [mclass ComposerStaticInitc9212831b71d36055338fa3096fc3175[m
         'Cron\\HoursField' => __DIR__ . '/..' . '/dragonmantank/cron-expression/src/Cron/HoursField.php',[m
         'Cron\\MinutesField' => __DIR__ . '/..' . '/dragonmantank/cron-expression/src/Cron/MinutesField.php',[m
         'Cron\\MonthField' => __DIR__ . '/..' . '/dragonmantank/cron-expression/src/Cron/MonthField.php',[m
[32m+[m[32m        'Database\\Factories\\PostCategoryFactory' => __DIR__ . '/../..' . '/database/factories/PostCategoryFactory.php',[m
         'Database\\Factories\\UserFactory' => __DIR__ . '/../..' . '/database/factories/UserFactory.php',[m
         'Database\\Seeders\\DatabaseSeeder' => __DIR__ . '/../..' . '/database/seeders/DatabaseSeeder.php',[m
         'DeepCopy\\DeepCopy' => __DIR__ . '/..' . '/myclabs/deep-copy/src/DeepCopy/DeepCopy.php',[m
[36m@@ -6280,6 +6297,22 @@[m [mclass ComposerStaticInitc9212831b71d36055338fa3096fc3175[m
         'Whoops\\Util\\Misc' => __DIR__ . '/..' . '/filp/whoops/src/Whoops/Util/Misc.php',[m
         'Whoops\\Util\\SystemFacade' => __DIR__ . '/..' . '/filp/whoops/src/Whoops/Util/SystemFacade.php',[m
         'Whoops\\Util\\TemplateHelper' => __DIR__ . '/..' . '/filp/whoops/src/Whoops/Util/TemplateHelper.php',[m
[32m+[m[32m        'Yajra\\DataTables\\ApiResourceDataTable' => __DIR__ . '/..' . '/yajra/laravel-datatables-oracle/src/ApiResourceDataTable.php',[m
[32m+[m[32m        'Yajra\\DataTables\\CollectionDataTable' => __DIR__ . '/..' . '/yajra/laravel-datatables-oracle/src/CollectionDataTable.php',[m
[32m+[m[32m        'Yajra\\DataTables\\Contracts\\DataTable' => __DIR__ . '/..' . '/yajra/laravel-datatables-oracle/src/Contracts/DataTable.php',[m
[32m+[m[32m        'Yajra\\DataTables\\Contracts\\Formatter' => __DIR__ . '/..' . '/yajra/laravel-datatables-oracle/src/Contracts/Formatter.php',[m
[32m+[m[32m        'Yajra\\DataTables\\DataTableAbstract' => __DIR__ . '/..' . '/yajra/laravel-datatables-oracle/src/DataTableAbstract.php',[m
[32m+[m[32m        'Yajra\\DataTables\\DataTables' => __DIR__ . '/..' . '/yajra/laravel-datatables-oracle/src/DataTables.php',[m
[32m+[m[32m        'Yajra\\DataTables\\DataTablesServiceProvider' => __DIR__ . '/..' . '/yajra/laravel-datatables-oracle/src/DataTablesServiceProvider.php',[m
[32m+[m[32m        'Yajra\\DataTables\\EloquentDataTable' => __DIR__ . '/..' . '/yajra/laravel-datatables-oracle/src/EloquentDataTable.php',[m
[32m+[m[32m        'Yajra\\DataTables\\Exceptions\\Exception' => __DIR__ . '/..' . '/yajra/laravel-datatables-oracle/src/Exceptions/Exception.php',[m
[32m+[m[32m        'Yajra\\DataTables\\Facades\\DataTables' => __DIR__ . '/..' . '/yajra/laravel-datatables-oracle/src/Facades/DataTables.php',[m
[32m+[m[32m        'Yajra\\DataTables\\Processors\\DataProcessor' => __DIR__ . '/..' . '/yajra/laravel-datatables-oracle/src/Processors/DataProcessor.php',[m
[32m+[m[32m        'Yajra\\DataTables\\Processors\\RowProcessor' => __DIR__ . '/..' . '/yajra/laravel-datatables-oracle/src/Processors/RowProcessor.php',[m
[32m+[m[32m        'Yajra\\DataTables\\QueryDataTable' => __DIR__ . '/..' . '/yajra/laravel-datatables-oracle/src/QueryDataTable.php',[m
[32m+[m[32m        'Yajra\\DataTables\\Utilities\\Config' => __DIR__ . '/..' . '/yajra/laravel-datatables-oracle/src/Utilities/Config.php',[m
[32m+[m[32m        'Yajra\\DataTables\\Utilities\\Helper' => __DIR__ . '/..' . '/yajra/laravel-datatables-oracle/src/Utilities/Helper.php',[m
[32m+[m[32m        'Yajra\\DataTables\\Utilities\\Request' => __DIR__ . '/..' . '/yajra/laravel-datatables-oracle/src/Utilities/Request.php',[m
         'voku\\helper\\ASCII' => __DIR__ . '/..' . '/voku/portable-ascii/src/voku/helper/ASCII.php',[m
     );[m
 [m
[1mdiff --git a/vendor/composer/installed.json b/vendor/composer/installed.json[m
[1mindex 43c5655..2d90222 100644[m
[1m--- a/vendor/composer/installed.json[m
[1m+++ b/vendor/composer/installed.json[m
[36m@@ -8130,6 +8130,93 @@[m
                 "source": "https://github.com/webmozarts/assert/tree/1.11.0"[m
             },[m
             "install-path": "../webmozart/assert"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "yajra/laravel-datatables-oracle",[m
[32m+[m[32m            "version": "v10.4.0",[m
[32m+[m[32m            "version_normalized": "10.4.0.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/yajra/laravel-datatables.git",[m
[32m+[m[32m                "reference": "2e641c3a5d4414dc2b0fce89ab0c74d73fbf7eb3"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/yajra/laravel-datatables/zipball/2e641c3a5d4414dc2b0fce89ab0c74d73fbf7eb3",[m
[32m+[m[32m                "reference": "2e641c3a5d4414dc2b0fce89ab0c74d73fbf7eb3",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "illuminate/database": "^9|^10",[m
[32m+[m[32m                "illuminate/filesystem": "^9|^10",[m
[32m+[m[32m                "illuminate/http": "^9|^10",[m
[32m+[m[32m                "illuminate/support": "^9|^10",[m
[32m+[m[32m                "illuminate/view": "^9|^10",[m
[32m+[m[32m                "php": "^8.0.2"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "nunomaduro/larastan": "^2.4",[m
[32m+[m[32m                "orchestra/testbench": "^8",[m
[32m+[m[32m                "yajra/laravel-datatables-html": "^9.3.4|^10"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "yajra/laravel-datatables-buttons": "Plugin for server-side exporting of dataTables.",[m
[32m+[m[32m                "yajra/laravel-datatables-editor": "Plugin to use DataTables Editor (requires a license).",[m
[32m+[m[32m                "yajra/laravel-datatables-export": "Plugin for server-side exporting using livewire and queue worker.",[m
[32m+[m[32m                "yajra/laravel-datatables-fractal": "Plugin for server-side response using Fractal.",[m
[32m+[m[32m                "yajra/laravel-datatables-html": "Plugin for server-side HTML builder of dataTables."[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2023-03-28T07:33:58+00:00",[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "10.x-dev"[m
[32m+[m[32m                },[m
[32m+[m[32m                "laravel": {[m
[32m+[m[32m                    "providers": [[m
[32m+[m[32m                        "Yajra\\DataTables\\DataTablesServiceProvider"[m
[32m+[m[32m                    ],[m
[32m+[m[32m                    "aliases": {[m
[32m+[m[32m                        "DataTables": "Yajra\\DataTables\\Facades\\DataTables"[m
[32m+[m[32m                    }[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "installation-source": "dist",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "src/helper.php"[m
[32m+[m[32m                ],[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Yajra\\DataTables\\": "src/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Arjay Angeles",[m
[32m+[m[32m                    "email": "aqangeles@gmail.com"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "jQuery DataTables API for Laravel 4|5|6|7|8|9|10",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "datatables",[m
[32m+[m[32m                "jquery",[m
[32m+[m[32m                "laravel"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/yajra/laravel-datatables/issues",[m
[32m+[m[32m                "source": "https://github.com/yajra/laravel-datatables/tree/v10.4.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/sponsors/yajra",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "install-path": "../yajra/laravel-datatables-oracle"[m
         }[m
     ],[m
     "dev": true,[m
[1mdiff --git a/vendor/composer/installed.php b/vendor/composer/installed.php[m
[1mindex e32dbba..5453629 100644[m
[1m--- a/vendor/composer/installed.php[m
[1m+++ b/vendor/composer/installed.php[m
[36m@@ -1,9 +1,9 @@[m
 <?php return array([m
     'root' => array([m
         'name' => 'laravel/laravel',[m
[31m-        'pretty_version' => 'v10.1.1',[m
[31m-        'version' => '10.1.1.0',[m
[31m-        'reference' => NULL,[m
[32m+[m[32m        'pretty_version' => 'dev-main',[m
[32m+[m[32m        'version' => 'dev-main',[m
[32m+[m[32m        'reference' => 'a5174185946357d37c6c64b779d3f4a74ee3529a',[m
         'type' => 'project',[m
         'install_path' => __DIR__ . '/../../',[m
         'aliases' => array(),[m
[36m@@ -371,9 +371,9 @@[m
             'dev_requirement' => false,[m
         ),[m
         'laravel/laravel' => array([m
[31m-            'pretty_version' => 'v10.1.1',[m
[31m-            'version' => '10.1.1.0',[m
[31m-            'reference' => NULL,[m
[32m+[m[32m            'pretty_version' => 'dev-main',[m
[32m+[m[32m            'version' => 'dev-main',[m
[32m+[m[32m            'reference' => 'a5174185946357d37c6c64b779d3f4a74ee3529a',[m
             'type' => 'project',[m
             'install_path' => __DIR__ . '/../../',[m
             'aliases' => array(),[m
[36m@@ -715,8 +715,8 @@[m
         'psr/log-implementation' => array([m
             'dev_requirement' => false,[m
             'provided' => array([m
[31m-                0 => '1.0|2.0|3.0',[m
[31m-                1 => '3.0.0',[m
[32m+[m[32m                0 => '3.0.0',[m
[32m+[m[32m                1 => '1.0|2.0|3.0',[m
             ),[m
         ),[m
         'psr/simple-cache' => array([m
[36m@@ -1256,5 +1256,14 @@[m
             'aliases' => array(),[m
             'dev_requirement' => false,[m
         ),[m
[32m+[m[32m        'yajra/laravel-datatables-oracle' => array([m
[32m+[m[32m            'pretty_version' => 'v10.4.0',[m
[32m+[m[32m            'version' => '10.4.0.0',[m
[32m+[m[32m            'reference' => '2e641c3a5d4414dc2b0fce89ab0c74d73fbf7eb3',[m
[32m+[m[32m            'type' => 'library',[m
[32m+[m[32m            'install_path' => __DIR__ . '/../yajra/laravel-datatables-oracle',[m
[32m+[m[32m            'aliases' => array(),[m
[32m+[m[32m            'dev_requirement' => false,[m
[32m+[m[32m        ),[m
     ),[m
 );[m