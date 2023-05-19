<?php

namespace App\View\Components;

use App\Models\Category;
use Closure;
use Illuminate\Contracts\View\View;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\View\Component;
use Symfony\Contracts\Service\Attribute\Required;

class PostForm extends Component
{
    /**
     * Create a new component instance.
     */
    public $btnType='';
    public $iDName='';
    public $otherMethod = null;
    public $categories;
    public $post;
    public function __construct($btnType, $iDName,$data,$otherMethod=null,$post=null)
    {
        $this->btnType = $btnType;
        $this->iDName = $iDName;
        $this->otherMethod = $otherMethod;
        $this->categories = $data;
        $this->post = $post;
        // dd($this->data);
    }

    /**
     * Get the view / contents that represent the component.
     */
    public function render(): View|Closure|string
    {
        return view('components.post-form');
    }
}
