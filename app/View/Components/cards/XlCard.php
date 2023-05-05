<?php

namespace App\View\Components\cards;

use Closure;
use Illuminate\Contracts\View\View;
use Illuminate\View\Component;

class XlCard extends Component
{
    public $total = '';
    public $text1 = '';
    public $icon = '';
    public $bgcolor = '';
    public function __construct($icon,$total,$text1,$bgcolor)
    {
        $this->icon = $icon;
        $this->total = $total;
        $this->text1 = $text1;
        $this->bgcolor = $bgcolor;
    }

    /**
     * Get the view / contents that represent the component.
     */
    public function render(): View|Closure|string
    {
        return view('components.cards.xl-card');
    }
}
