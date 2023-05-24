<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use PhpParser\Node\Scalar\String_;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class RoleController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $roles = Role::with('permissions')->get();
        $permissions = Permission::all();
        return view('user.role.index', compact('roles','permissions'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('user.role.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        // dd($request->all());
        $request->validate([
            'name' => 'required|unique:roles,name',
        ]);
        $role = Role::create(['name' => $request->name]);
        if ($request->permission != null) {
            $role->givePermissionTo($request->permission);
        }
        session()->flash('successRole', 'Add Role & it\'s Permissions');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {

    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Role $role)
    {
        $rolePer = $role->getAllPermissions();
        return view('user.role.edit',compact(['role','rolePer']));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Role $role)
    {
        // dd($request->all());
        $data = $request->validate([
            'name' => 'required'
        ]);
        $role->syncPermissions($request->permission);
        $role->update($data);
        session()->flash('successRole', 'Update Role & it\'s Permissions');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Role $role)
    {
        $users = User::role($role->name)->get();
        foreach ($users as $user) {
            $user->syncRoles('visitor');
        }
        $role->delete($role->name);
        session()->flash('successRole', 'Delete Roles');
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
        session()->flash('successRole', 'Update Permissions');
    }
}
