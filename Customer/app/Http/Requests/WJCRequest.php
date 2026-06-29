<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class WJCRequest extends FormRequest
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
     * @return array<string, ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        $name = $this->route()->getName() ?? '';

        if (str_starts_with($name, 'inventor.')) {
            return [
                'customer_id'      => 'required|integer',
                'customer_name'    => 'required|string|max:100',
                'name'             => 'required|string|max:100',
                'phone'            => 'required|string|max:20',
                'email'            => 'required|string|email|max:100',
                'nationality'      => 'nullable|string|max:50',
                'id_type'          => 'nullable|string|max:50',
                'id_no'            => 'nullable|string|max:50',
                'english_name'     => 'nullable|string|max:100',
                'landline'         => 'nullable|string|max:20',
                'wechat'           => 'nullable|string|max:50',
                'region_id'        => 'nullable|integer',
                'street_address'   => 'nullable|string|max:200',
                'address_en'       => 'nullable|string|max:300',
                'zip_code'         => 'nullable|string|max:10',
                'inventor_remark'  => 'nullable|string',
                'operator_id'      => 'nullable|integer',
            ];
        }

        if (str_starts_with($name, 'applicant.')) {
            return [
                'customer_id'           => 'required|integer',
                'customer_name'         => 'required|string|max:100',
                'applicant_name_cn'     => 'required|string|max:100',
                'applicant_type'        => 'required|string|max:50',
                'entity_type'           => 'required|string|max:50',
                'nationality'           => 'nullable|string|max:50',
                'id_type'               => 'nullable|string|max:50',
                'id_no'                 => 'nullable|string|max:50',
                'fee_reduction_filing'  => 'nullable|integer|in:0,1',
                'fee_reduction_start'   => 'nullable|date',
                'fee_reduction_end'     => 'nullable|date',
                'region_id'             => 'nullable|integer',
                'street'                => 'nullable|string|max:200',
                'business_address'      => 'nullable|string|max:200',
                'address_en'            => 'nullable|string|max:300',
                'zip_code'              => 'nullable|string|max:10',
                'email'                 => 'nullable|string|email|max:100',
                'phone'                 => 'nullable|string|max:20',
                'attorney_power_no'     => 'nullable|string|max:50',
                'sync_date'             => 'nullable|date',
                'operator_id'           => 'nullable|integer',
                'applicant_remark'      => 'nullable|string',
            ];
        }

        return [
            '*' => 'sometimes',
        ];
    }
}
