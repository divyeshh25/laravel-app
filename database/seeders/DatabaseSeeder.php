<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\Category;
use App\Models\User;
use Database\Factories\PostFactory;
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
        Permission::create(['name' => 'list post']);
        Permission::create(['name' => 'write post']);
        Permission::create(['name' => 'edit post']);
        Permission::create(['name' => 'delete post']);
        Permission::create(['name' => 'list category']);
        Permission::create(['name' => 'add category']);
        Permission::create(['name' => 'edit category']);
        Permission::create(['name' => 'delete category']);
        Permission::create(['name' => 'list user']);
        Permission::create(['name' => 'add user']);
        Permission::create(['name' => 'edit user']);
        Permission::create(['name' => 'delete user']);
        Permission::create(['name' => 'list role']);
        Permission::create(['name' => 'add role']);
        Permission::create(['name' => 'edit role']);
        Permission::create(['name' => 'delete role']);
        $role = Role::create(['name' => 'admin']);
        $role->givePermissionTo('list post');
        $role->givePermissionTo('write post');
        $role->givePermissionTo('edit post');
        $role->givePermissionTo('publish post');
        $role->givePermissionTo('list category');
        $role->givePermissionTo('add category');
        $role->givePermissionTo('edit category');
        $role->givePermissionTo('delete category');
        $role->givePermissionTo('list user');
        $role->givePermissionTo('add user');
        $role->givePermissionTo('edit user');
        $role->givePermissionTo('delete user');
        $role->givePermissionTo('list role');
        $role->givePermissionTo('add role');
        $role->givePermissionTo('edit role');
        $role->givePermissionTo('delete role');

        // Craete User With Role
        $user = \App\Models\User::factory()->create([
            'name' => 'admin',
            'email' => 'admin@gmail.com',
            'password' => '12345678',
        ]);
        $user->assignRole('admin');
        //Create Categories
        \App\Models\Category::create([
            'name' => 'Food Blog',
            'user_id' => User::with('roles')->where('name',['admin'])->get()->pluck('id')->implode('/'),
        ]);
        \App\Models\Category::create([
            'name' => 'Travel Blog',
            'user_id' => User::with('roles')->where('name',['admin'])->get()->pluck('id')->implode('/'),
        ]);
        \App\Models\Category::create([
            'name' => 'Photography Blog',
            'user_id' => User::with('roles')->where('name',['admin'])->get()->pluck('id')->implode('/'),
        ]);
        \App\Models\Category::create([
            'name' => 'Personal Blog',
            'user_id' => User::with('roles')->where('name',['admin'])->get()->pluck('id')->implode('/'),
        ]);
        \App\Models\Category::create([
            'name' => 'LifeStyle Blog',
            'user_id' => User::with('roles')->where('name',['admin'])->get()->pluck('id')->implode('/'),
        ]);
        // \App\Models\Post::factory();

        \App\Models\Post::create([
            'title' => 'Inspired Taste',
            'excerpt' => "All you need is love But a little chocolate now and then does not hurt",
            'body' => '<p><span style="font-family: &quot;Source Sans Pro&quot;, Arial, Helvetica, sans-serif; font-size: 22px; background-color: rgb(255, 255, 0);"><font color="#000000">Inspired Taste is a food blogging website and channel. </font></span><span style="color: rgb(0, 0, 0); font-family: &quot;Source Sans Pro&quot;, Arial, Helvetica, sans-serif; font-size: 22px;">Adam and Joanne are the creator and publishers of this website. They make delicious recipes and post them on their channel. They make vegetarian, low-carb, dairy-free, light, and vegan food. Both of them have an obsession with food, and they both take great pride in their full-time jobs as food bloggers. They aim to encourage others to use their healthy recipes in the kitchen.</span></p>',
            'status' => '0',
            'category_id' =>  Category::where('name','Food Blog')->first()->id,
            'user_id' => User::with('roles')->where('name',['admin'])->get()->pluck('id')->implode('/'),
            'image' => 'BlogImage/post-3.jpg'
        ]);
        \App\Models\Post::create([
            'title' => 'A Traveler\'s Mindset',
            'excerpt' => "Jobs fill your pockets, adventures fill your soul",
            'body' => '<p><span style="font-family: &quot;Source Sans Pro&quot;, Arial, Helvetica, sans-serif; font-size: 22px; background-color: rgb(255, 255, 0);"><font color="#000000">Inspired Taste is a food blogging website and channel. </font></span><span style="color: rgb(0, 0, 0); font-family: &quot;Source Sans Pro&quot;, Arial, Helvetica, sans-serif; font-size: 22px;">Adam and Joanne are the creator and publishers of this website. They make delicious recipes and post them on their channel. They make vegetarian, low-carb, dairy-free, light, and vegan food. Both of them have an obsession with food, and they both take great pride in their full-time jobs as food bloggers. They aim to encourage others to use their healthy recipes in the kitchen.</span></p>',
            'status' => '0',
            'category_id' => Category::where('name','Travel Blog')->first()->id,
            'user_id' => User::with('roles')->where('name',['admin'])->get()->pluck('id')->implode('/'),
            'image' => 'BlogImage/post-6.jpg'
        ]);
        \App\Models\Post::create([
            'title' => 'The Road Best Pic',
            'excerpt' => "Not only does Creative Boom provide tutorials on technical photography skills, but it also offers career tips, the best gear to use, and books you can use to enhance your skills.",
            'body' => '<p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 25px; margin-left: 0px; padding: 0px; overflow-wrap: break-word; font-size: 14px; line-height: 1.5; color: rgb(77, 92, 109); font-family: -apple-system, BlinkMacSystemFont, &quot;segoe ui&quot;, Roboto, Oxygen-Sans, Ubuntu, Cantarell, &quot;helvetica neue&quot;, sans-serif; letter-spacing: -0.24px; background-color: rgb(250, 251, 253);"><span style="box-sizing: inherit;"><span style="box-sizing: inherit; font-weight: bolder;">This blog uses psychology along with&nbsp;<keyword data-keyword-id="5067" style="box-sizing: inherit;">photography</keyword></span>. This provokes the reader to explore their creativity through a series of reviews, tutorials, and articles published on the site. This site allows readers to explore other photographers’ work, read on the newest gear, and explore the world through new perspectives.</span></p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 25px; margin-left: 0px; padding: 0px; overflow-wrap: break-word; font-size: 14px; line-height: 1.5; color: rgb(77, 92, 109); font-family: -apple-system, BlinkMacSystemFont, &quot;segoe ui&quot;, Roboto, Oxygen-Sans, Ubuntu, Cantarell, &quot;helvetica neue&quot;, sans-serif; letter-spacing: -0.24px; background-color: rgb(250, 251, 253);"><span style="box-sizing: inherit; font-weight: bolder;">Now, here are some blogs that provoke inspiration through food, fashion, and photojournalism. These blogs are visually stunning and creative, with thought-provoking stories that will keep readers busy for hours.</span></p>',
            'status' => '0',
            'category_id' => Category::where('name','Photography Blog')->first()->id,
            'user_id' => User::with('roles')->where('name',['admin'])->get()->pluck('id')->implode('/'),
            'image' => 'BlogImage/post-4.jpg'
        ]);
        \App\Models\Post::create([
            'title' => 'My Life, My Experience!',
            'excerpt' => "I am not what happened to me, I am what I choose to become",
            'body' => '<p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 25px; margin-left: 0px; padding: 0px; overflow-wrap: break-word; font-size: 14px; line-height: 1.5; color: rgb(77, 92, 109); font-family: -apple-system, BlinkMacSystemFont, &quot;segoe ui&quot;, Roboto, Oxygen-Sans, Ubuntu, Cantarell, &quot;helvetica neue&quot;, sans-serif; letter-spacing: -0.24px; background-color: rgb(250, 251, 253);"><span style="box-sizing: inherit;"><span style="box-sizing: inherit; font-weight: bolder;">This blog uses psychology along with&nbsp;<keyword data-keyword-id="5067" style="box-sizing: inherit;">photography</keyword></span>. This provokes the reader to explore their creativity through a series of reviews, tutorials, and articles published on the site. This site allows readers to explore other photographers’ work, read on the newest gear, and explore the world through new perspectives.</span></p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 25px; margin-left: 0px; padding: 0px; overflow-wrap: break-word; font-size: 14px; line-height: 1.5; color: rgb(77, 92, 109); font-family: -apple-system, BlinkMacSystemFont, &quot;segoe ui&quot;, Roboto, Oxygen-Sans, Ubuntu, Cantarell, &quot;helvetica neue&quot;, sans-serif; letter-spacing: -0.24px; background-color: rgb(250, 251, 253);"><span style="box-sizing: inherit; font-weight: bolder;">Now, here are some blogs that provoke inspiration through food, fashion, and photojournalism. These blogs are visually stunning and creative, with thought-provoking stories that will keep readers busy for hours.</span></p>',
            'status' => '0',
            'category_id' => Category::where('name','Personal Blog')->first()->id,
            'user_id' => User::with('roles')->where('name',['admin'])->get()->pluck('id')->implode('/'),
            'image' => 'BlogImage/post-5.jpg'
        ]);
        \App\Models\Post::create([
            'title' => 'You will face many defeats in life, but never let yourself be defeated.',
            'excerpt' => "In the end, it is not the years in your life that count Never let the fear of striking out keep you from playing the game",
            'body' => '<p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 1.3em; margin-left: 0px; padding: 0px; border: 0px; color: rgb(99, 101, 107); font-family: -apple-system, system-ui, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 22px;"><b><span style="font-family: Arial;">A lifestyle blog is a type of blog someone creates to share their everyday life, activities, and interests.</span></b></p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 1.3em; margin-left: 0px; padding: 0px; border: 0px; color: rgb(99, 101, 107); font-family: -apple-system, system-ui, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 22px;"><b><span style="font-family: Arial;">These bloggers often share this information through stories and high-quality images that showcase their activities and interests.</span></b></p><p style="box-sizing: inherit; margin-right: 0px; margin-bottom: 1.3em; margin-left: 0px; padding: 0px; border: 0px; color: rgb(99, 101, 107); font-family: -apple-system, system-ui, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 22px;"><b><span style="font-family: Arial;">Lifestyle blogs are often highly personalized to the author’s location, life stage, and current interests.</span></b></p>',
            'status' => '0',
            'category_id' => Category::where('name','LifeStyle Blog')->first()->id,
            'user_id' => User::with('roles')->where('name',['admin'])->get()->pluck('id')->implode('/'),
            'image' => 'BlogImage/post.jpg'
        ]);

    }
}
