<?php

namespace App\View\Components;

use Closure;
use Illuminate\Contracts\View\View;
use Illuminate\View\Component;

class roleModal extends Component
{
    /**
     * Create a new component instance.
     */
    public $title = '';
    public $nameId = '';
    public $btnName = '';
    public $permissions;
    public function __construct($title,$nameId,$btnName,$permissions)
    {
        $this->title = $title;
        $this->nameId = $nameId;
        $this->btnName = $btnName;
        $this->permissions = $permissions;
    }

    /**
     * Get the view / contents that represent the component.
     */
    public function render(): View|Closure|string
    {
        return view('components.role-modal');
    }
}
