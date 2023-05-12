<?php

namespace App\View\Components;

use Closure;
use Illuminate\Contracts\View\View;
use Illuminate\View\Component;

class modal extends Component
{
    /**
     * Create a new component instance.
     */
    public $id = '';
    public $title, $action, $method,$btnname;
    public function __construct($id, $title, $action, $method,$btnname)
    {
        $this->id =$id;
        $this->title = $title;
        $this->action = $action;
        $this->method = $method;
        $this->btnname = $btnname;
    }

    /**
     * Get the view / contents that represent the component.
     */
    public function render(): View|Closure|string
    {
        return view('components.modal');
    }
}
