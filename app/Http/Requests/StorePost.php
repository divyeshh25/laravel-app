<?php

namespace App\Http\Requests;

use GuzzleHttp\Psr7\Response;
use Illuminate\Database\Eloquent\Casts\Json;
use Illuminate\Foundation\Http\FormRequest;

class StorePost extends FormRequest
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
        return[
            'name' => 'required|unique:categories,name',
            'status' => 'in:0,1'
        ];
    }
    public function messages(): array
    {
        return [
            'name.unique' => 'This Category Is Already Exists.'
        ];
    }
}
