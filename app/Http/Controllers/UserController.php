<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Spatie\Permission\Models\Role;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $roles = Role::all();
        $users = User::where('id', '!=', auth()->id())
            ->with('roles')
            ->get();
        return view('user.index', compact('users', 'roles'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'email' => 'email|required|unique:users,email',
            'password' => 'required|min:8',
            'status' => 'required'
        ]);
        $user = User::create($request->all());
        $user->assignRole([$request->status]);
        session()->flash('successUser', "User Added");
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(User $user)
    {
        $user->getRoleNames();
        return $user;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(User $user)
    {
        // dd(request());
        $data = request()->validate([
            'name' => 'required',
            'email' => 'required|email',
            'status' => 'required',
        ]);
        // dd($data);
        $user->syncRoles([request()->status]);
        $user->update($data);
        session()->flash('successUser', 'User Updated');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(User $user)
    {
        $user->removeRole($user->getRoleNames()[0]);
        $user->delete();
        // session()->flash('success', "Category Delete");
    }
    public function updateStatus(User $user)
    {
        $user->verified = 1;
        $user->update();
        return redirect('/login');
    }
}
