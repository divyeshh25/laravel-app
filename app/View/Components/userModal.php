<?php

namespace App\View\Components;

use Closure;
use Illuminate\Contracts\View\View;
use Illuminate\View\Component;

class userModal extends Component
{
    public $title ='';
    public $nameId = '';
    public $emailId = '';
    public $statusName = '';
    public $btnname = '';
    public $roles;
    // public $passId = '';
    public function __construct($title,$nameId,$emailId,$statusName,$btnname,$roles)
    {
        dd($title);
        $this->title = $title;
        $this->nameId = $nameId;
        $this->emailId= $emailId;
        $this->statusName = $statusName;
        $this->btnname = $btnname;
        $this->roles = $roles;
        // $this->passId = $passId;
    }

    /**
     * Get the view / contents that represent the component.
     */
    public function render(): View|Closure|string
    {
        return view('components.user-modal');
    }
}
