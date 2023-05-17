<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Spatie\Permission\Models\Role;

class RoleController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $roles = Role::with('permissions')->get();
        return view('user.role.index', compact('roles'));
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
        // dd($request->all());
        $request->validate([
            'name'=>'required|unique:roles,name'
        ]);
        $role = Role::create(['name'=>$request->name]);
        if($request->permission != null)
        {
            $role->givePermissionTo($request->permission);
        }
        session()->flash('successRole','Add Role & it\'s Permissions');
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
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Role $role)
    {
        $role->delete();
        session()->flash('successRole','Delete Roles');
        // $role->removeRole();
    }

    public function updatePermission(Request $request, string $id)
    {
        // dd($request->all());
        $role = Role::findOrFail($id);
        if ($request->status == 'add') {
            $role->givePermissionTo($request->value);
        } else {
            $role->revokePermissionTo($request->value);
        }
        session()->flash('successRole','Update Permissions');
    }
}
