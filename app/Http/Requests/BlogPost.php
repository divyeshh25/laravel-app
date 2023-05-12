<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class BlogPost extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array|string>
     */
    public function rules(): array
    {
        return [
                'addTitle' => 'required',
                'addExcerpt' => 'required|min:10|max:255',
                'addBody' => 'required',
                'addStatus' => 'required|in:0,1',
                'addCat'=>'required|numeric',
                'addImg' => 'required|image|mimes:png,jpg,jpeg'
        ];
    }
    public function messages(): array
    {
        return [
            'addTitle' => 'Title Field Is Required.',
            'addExcerpt' => 'Excerpt Field Is Required.',
            'addExcerpt.min' => 'Excerpt Field Required Minimum 8 Character.',
            'addExcerpt.max' => 'Excerpt Field Required Maximum 255 Character.',
            'addBody' => 'Body Field Is Required.',
            'addCat.numeric' => 'Please Select Post Category',
            'addImg' => 'Please Select Valid Image',
            'addImg.image' =>'Please Select Image',
            'addImg.mimer' => 'Please Select Valid Image Type'
        ];
    }
}
