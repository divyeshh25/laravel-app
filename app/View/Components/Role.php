<?php

namespace App\View\Components;

use Closure;
use Illuminate\Contracts\View\View;
use Illuminate\View\Component;
use Spatie\Permission\Models\Permission;

class Role extends Component
{
    /**
     * Create a new component instance.
     */
    // public $permissions;
    public $find;
    public $role;
    public $pageName;
    public function __construct($find,$pagename,$role=null)
    {
        // $this->permissions = $permissions;
        $this->find = $find;
        $this->role = $role;
        $this->pageName = $pagename;
    }

    /**
     * Get the view / contents that represent the component.
     */
    public function render(): View|Closure|string
    {

        $permissions = Permission::all();
        return view('components.role',compact('permissions'));
    }
}
