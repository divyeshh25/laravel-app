<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // \App\Models\User::factory(10)->create();

        //Create Role & Permission:

        Permission::create(['name'=> 'write post']);
        Permission::create(['name'=> 'edit post']);
        Permission::create(['name'=> 'publish post']);
        $role = Role::create(['name'=>'admin']);
        $role->givePermissionTo('write post');
        $role->givePermissionTo('edit post');
        $role->givePermissionTo('publish post');
        $role = Role::create(['name'=>'writer']);
        $role->givePermissionTo('write post');
        $role = Role::create(['name'=>'editor']);
        $role->givePermissionTo('edit post');
        $role = Role::create(['name'=>'publisher']);
        $role->givePermissionTo('publish post');
        $role = Role::create(['name'=>'visitor']);


        $user = \App\Models\User::factory()->create([
            'name' => 'admin',
            'email' => 'admin@gmail.com',
            'password'=> '12345678',

        ]);
        $user->assignRole('admin');
        $user = \App\Models\User::factory()->create([
            'name' => 'john',
            'email' => 'john@gmail.com',
            'password'=> '12345678'
        ]);
        $user->assignRole('editor');
        $user = \App\Models\User::factory()->create([
            'name' => 'alex',
            'email' => 'alex@gmail.com',
            'password'=> '12345678'
        ]);
        $user->assignRole('writer');
        $user = \App\Models\User::factory()->create([
            'name' => 'divyesh',
            'email' => 'divyesh@gmail.com',
            'password'=> '12345678'
        ]);
        $user->assignRole('publisher');
        // \App\Models\PostCategory::factory(2)->create();
    }
}
