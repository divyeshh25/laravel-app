<?php

namespace App\View\Components\cards;

use Closure;
use Illuminate\Contracts\View\View;
use Illuminate\View\Component;

class SmCard extends Component
{
    public $icon = '';
    public $bgcolor = '';
    public $msg1 = '';
    public $msg2 = '';
    public function __construct($icon,$bgcolor,$msg1,$msg2)
    {

        $this->icon = $icon;
        $this->bgcolor = $bgcolor;
        $this->msg1 = $msg1;
        $this->msg2 = $msg2;
    }

    /**
     * Get the view / contents that represent the component.
     */
    public function render(): View|Closure|string
    {
        return view('components.cards.sm-card');
    }
}
