<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class FmyRequest extends FormRequest
{
    protected string $scene = '';

    public function __construct(array $query = [], array $request = [], array $attributes = [], array $cookies = [], array $files = [], array $server = [], $content = null)
    {
        parent::__construct($query, $request, $attributes, $cookies, $files, $server, $content);
        $this->scene = $this->query('scene') ?? '';
    }

    public function setScene(string $scene): void
    {
        $this->scene = $scene;
        $this->validator = null; // 重置验证器，使下次 validated() 重新按新场景创建
    }

    /**
     * 重写 validated，防止 validator 为 null 时报错
     */
    public function validated($key = null, $default = null)
    {
        if (is_null($this->validator)) {
            $this->getValidatorInstance();
        }

        return parent::validated($key, $default);
    }

    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return auth('api')->check();
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return match ($this->scene) {
            'ip-right-list'                 => $this->ipRightList(),
            'ip-right-store'                => $this->ipRightStore(),
            'ip-right-update'               => $this->ipRightUpdate(),
            'customer-file-list'            => $this->customerFileList(),
            'customer-file-store'           => $this->customerFileStore(),
            'customer-file-tree'            => $this->customerFileTree(),
            'customer-options'              => $this->customerOptions(),
            'customer-file-upload'          => $this->customerFileUpload(),
            'contact-list'                  => $this->contactList(),
            'contact-store'                 => $this->contactStore(),
            'contact-update'                => $this->contactUpdate(),
            'innovation-subjects-options'   => $this->innovationSubjectsOptions(),
            'contact-types-options'         => $this->contactTypesOptions(),
            'staff-options'                 => $this->staffOptions(),
            'assistant-options'             => $this->assistantOptions(),
            'tech-leaders-options'          => $this->techLeadersOptions(),
            'enterprise-investment-list'    => $this->enterpriseInvestmentList(),
            'enterprise-investment-store'   => $this->enterpriseInvestmentStore(),
            'enterprise-investment-update'  => $this->enterpriseInvestmentUpdate(),
            default => [],
        };
    }

    protected function prepareForValidation()
    {
        $data = $this->all();
        array_walk_recursive($data, function (&$v) {
            if (is_string($v)) $v = trim($v);
        });

        $specialMaps = [
            'innovationSubjectId' => 'innovation_entity_id',
            'isEmployed'          => 'is_active',
            'businessPersonId'    => 'sales_rep_id',
            'assistantId'         => 'sales_assistant_id',
            'techDepartment'      => 'tech_lead_dept',
            'techLeaderId'        => 'tech_lead_id',
            'workAddress'         => 'work_address',
            'remark'              => 'notes',
        ];

        $converted = [];
        foreach ($data as $key => $value) {
            if (isset($specialMaps[$key])) {
                $converted[$specialMaps[$key]] = $value;
            } else {
                $snakeKey = \Illuminate\Support\Str::snake($key);
                $converted[$snakeKey] = $value;
            }
        }

        $this->replace($converted);
    }

    // ========== CustomerIpRight 校验规则 ==========
    protected function ipRightList(): array
    {
        return [
            'page'     => 'integer|min:1',
            'per_page' => 'integer|min:1|max:100',
            'search'   => 'string|nullable',
            'sort'     => 'string|nullable',
            'order'    => 'in:asc,desc|nullable',
        ];
    }

    protected function ipRightStore(): array
    {
        return [
            'trademark_count'                     => 'integer|nullable|min:0',
            'patent_count'                        => 'integer|nullable|min:0',
            'authorized_invention_patent_count'   => 'integer|nullable|min:0',
            'copyright_count'                     => 'integer|nullable|min:0',
            'has_enjoyed_additional_deduction'    => 'boolean|nullable',
            'has_school_enterprise_cooperation'   => 'boolean|nullable',
            'cooperative_university_name'         => 'string|nullable|max:255',
        ];
    }

    protected function ipRightUpdate(): array
    {
        return $this->ipRightStore();
    }

    // ========== CustomerFile 校验规则 ==========
    protected function customerFileList(): array
    {
        return [
            'file_name'     => 'string|nullable',
            'file_type'     => 'string|nullable',
            'customer_name' => 'string|nullable',
            'start_time'    => 'date|nullable',
            'end_time'      => 'date|nullable',
            'page_num'      => 'integer|min:1',
            'page_size'     => 'integer|min:1|max:100',
        ];
    }

    protected function customerFileStore(): array
    {
        return [
            'file_type_id'     => 'required|string',
            'customer_id'      => 'required|string',
            'business_person'  => 'integer|nullable',
            'remark'           => 'string|nullable|max:1000',
            'file'             => 'required|file|max:20480',
        ];
    }

    public function messages(): array
    {
        return [
            'business_person.integer' => '业务人员必须是有效的数字',
        ];
    }

    protected function customerFileTree(): array
    {
        return [
            'keyword' => 'string|nullable',
        ];
    }

    protected function customerOptions(): array
    {
        return [
            'keyword' => 'string|nullable',
        ];
    }

    protected function customerFileUpload(): array
    {
        return [
            'file'        => 'required|file|max:20480',
            'customer_id' => 'integer',
            'category_id' => 'integer|nullable',
        ];
    }

    // ========== CustomerContact 校验规则 ==========
    protected function contactList(): array
    {
        return [
            'contact_name'    => 'string|nullable',
            'customer_name'   => 'string|nullable',
            'contact_type'    => 'string|nullable',
            'business_person' => 'string|nullable',
            'page_num'        => 'integer|min:1',
            'page_size'       => 'integer|min:1|max:100',
        ];
    }

    protected function contactStore(): array
    {
        return [
            'innovation_entity_id' => 'required|integer',
            'contact_type'         => 'required|string|max:50',
            'name'                 => 'required|string|max:255',
            'phone'                => 'required|string|max:20',
            'landline'             => 'string|nullable|max:20',
            'is_active'            => 'required|in:0,1',
            'position'             => 'string|nullable|max:10',
            'email'                => 'email|nullable|max:255',
            'sales_rep_id'         => 'integer|nullable',
            'sales_assistant_id'   => 'integer|nullable',
            'tech_lead_dept'       => 'string|nullable|max:255',
            'tech_lead_id'         => 'integer|nullable',
            'work_address'         => 'string|nullable',
            'notes'                => 'string|nullable',
        ];
    }

    protected function contactUpdate(): array
    {
        return [
            'customer_id'         => 'integer|nullable',
            'contact_type'        => 'required|string|max:50',
            'name'                => 'required|string|max:255',
            'phone'               => 'string|nullable|max:20',
            'landline'            => 'string|nullable|max:20',
            'is_active'           => 'required|in:0,1',
            'position'            => 'string|nullable|max:10',
            'email'               => 'email|nullable|max:255',
            'sales_rep_id'        => 'integer|nullable',
            'sales_assistant_id'  => 'integer|nullable',
            'tech_lead_dept'      => 'string|nullable|max:255',
            'tech_lead_id'        => 'integer|nullable',
            'work_address'        => 'string|nullable',
            'notes'               => 'string|nullable',
        ];
    }

    protected function innovationSubjectsOptions(): array
    {
        return [
            'keyword' => 'string|nullable',
        ];
    }

    protected function contactTypesOptions(): array
    {
        return [
            'keyword' => 'string|nullable',
        ];
    }

    protected function staffOptions(): array
    {
        return [
            'keyword' => 'string|nullable',
        ];
    }

    protected function assistantOptions(): array
    {
        return [
            'keyword' => 'string|nullable',
        ];
    }

    protected function techLeadersOptions(): array
    {
        return [
            'keyword' => 'string|nullable',
        ];
    }

    // ========== CustomerEnterpriseInvestment 校验规则 ==========
    protected function enterpriseInvestmentList(): array
    {
        return [
            'customerId' => 'integer|nullable',
            'year'       => 'integer|nullable',
            'search'     => 'string|nullable',
            'page'       => 'integer|min:1',
            'per_page'   => 'integer|min:1|max:100',
            'sort'       => 'string|nullable',
            'order'      => 'in:asc,desc|nullable',
        ];
    }

    protected function enterpriseInvestmentStore(): array
    {
        return [
            'customer_id'                => 'required|integer',
            'year'                       => 'required|integer|min:2000|max:2100',
            'has_audit_report'           => 'boolean|nullable',
            'rd_equipment_original_value'=> 'numeric|nullable|min:0',
            'equipment_investment'       => 'numeric|nullable|min:0',
            'informatization_investment' => 'numeric|nullable|min:0',
            'has_imported_equipment'     => 'boolean|nullable',
            'asset_liability_ratio'      => 'numeric|nullable|min:0|max:100',
            'smart_equipment_investment' => 'numeric|nullable|min:0',
            'filing_amount'              => 'numeric|nullable|min:0',
            'has_investment_filing'      => 'boolean|nullable',
            'fixed_asset_investment'     => 'numeric|nullable|min:0',
            'rd_equipment_investment'    => 'numeric|nullable|min:0',
            'filing_start_date'          => 'date|nullable',
            'filing_end_date'            => 'date|nullable|after_or_equal:filing_start_date',
        ];
    }

    protected function enterpriseInvestmentUpdate(): array
    {
        return $this->enterpriseInvestmentStore();
    }
}
