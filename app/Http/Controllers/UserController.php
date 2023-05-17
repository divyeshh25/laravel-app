<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $users = User::where('id','!=',auth()->id())->with('roles')->get();
        return view('user.index', compact('users'));
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
        // $user = User::create($request->all());
        // dd($user);
        // session()->flash('success', "Category Added");
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
            'name'=> 'required',
            'email'=>'required|email',
            'status' => 'required'
        ]);
        // dd($data);
        $user->syncRoles([request()->status]);
        $user->update($data);
        session()->flash('successUser','User Updated');
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
    public function updateStatus(Request $request, string $id)
    {
        $user = User::find($id);
        if ($request->status == 'add') {
            $user->givePermissionTo($request->value);
            session()->flash('successUser', ucfirst($user->name) . ' have permission to ' . strtoupper($request->value));
        } else {
            $user->revokePermissionTo($request->value);
            session()->flash('successUser', ucfirst($user->name) . ' have remove permission to ' . strtoupper($request->value));
        }
    }
}
