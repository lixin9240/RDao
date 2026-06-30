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

        if (str_starts_with($name, 'customer-rd-investment.')) {
            return [
                'basic_id' => 'required|integer',
                'year'     => 'required|integer|min:2000|max:2099',
                'projects' => 'nullable',
                'amount'   => 'nullable|numeric',
            ];
        }

        if (str_starts_with($name, 'inventor.')) {
            $isUpdate = str_ends_with($name, '.update');

            return [
                'customer_id'      => $isUpdate ? 'sometimes|integer'         : 'required|integer',
                'customer_name'    => $isUpdate ? 'sometimes|string|max:100'   : 'required|string|max:100',
                'name'             => $isUpdate ? 'sometimes|string|max:100'   : 'required|string|max:100',
                'phone'            => $isUpdate ? 'sometimes|string|max:20'    : 'required|string|max:20',
                'email'            => $isUpdate ? 'sometimes|email|max:100'    : 'required|email|max:100',
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
            $isUpdate = str_ends_with($name, '.update');

            return [
                'customer_id'           => $isUpdate ? 'sometimes|integer'         : 'required|integer',
                'customer_name'         => $isUpdate ? 'sometimes|string|max:100'   : 'required|string|max:100',
                'applicant_name_cn'     => $isUpdate ? 'sometimes|string|max:100'   : 'required|string|max:100',
                'applicant_type'        => $isUpdate ? 'sometimes|string|max:50'    : 'required|string|max:50',
                'entity_type'           => $isUpdate ? 'sometimes|string|max:50'    : 'required|string|max:50',
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
                'email'                 => 'nullable|email|max:100',
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
