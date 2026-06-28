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
            default => [],
        };
    }

    protected function prepareForValidation()
    {
        $data = $this->all();
        array_walk_recursive($data, function (&$v) {
            if (is_string($v)) $v = trim($v);
        });
        $this->merge($data);
    }

    // ========== CustomerIpRight 校验规则 ==========
    protected function ipRightList(): array
    {
        return [
            'page'     => 'nullable|integer|min:1',
            'per_page' => 'nullable|integer|min:1|max:100',
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
            'fileName'     => 'string|nullable',
            'fileType'     => 'string|nullable',
            'customerName' => 'string|nullable',
            'startTime'    => 'date|nullable',
            'endTime'      => 'date|nullable',
            'pageNum'      => 'nullable|integer|min:1',
            'pageSize'     => 'nullable|integer|min:1|max:100',
        ];
    }

    protected function customerFileStore(): array
    {
        return [
            'fileTypeId'     => 'required|string',
            'customerId'     => 'required|string',
            'businessPerson' => 'integer|nullable',
            'remark'         => 'string|nullable|max:1000',
            'file'           => 'required|file|max:20480',
        ];
    }

    public function messages(): array
    {
        return [
            'businessPerson.integer' => '业务人员必须是有效的数字',
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
            'file' => 'required|file|max:20480',
        ];
    }

    // ========== CustomerContact 校验规则 ==========
    protected function contactList(): array
    {
        return [
            'contactName'    => 'string|nullable',
            'customerName'   => 'string|nullable',
            'contactType'    => 'string|nullable',
            'businessPerson' => 'string|nullable',
            'pageNum'        => 'nullable|integer|min:1',
            'pageSize'       => 'nullable|integer|min:1|max:100',
        ];
    }

    protected function contactStore(): array
    {
        return [
            'innovationSubjectId' => 'required|integer',
            'contactType'         => 'required|string|max:50',
            'name'                => 'required|string|max:255',
            'phone'               => 'required|string|max:20',
            'landline'            => 'string|nullable|max:20',
            'isEmployed'          => 'required|in:0,1',
            'position'            => 'string|nullable|max:10',
            'email'               => 'email|nullable|max:255',
            'businessPersonId'    => 'integer|nullable',
            'assistantId'         => 'integer|nullable',
            'techDepartment'      => 'string|nullable|max:255',
            'techLeaderId'        => 'integer|nullable',
            'workAddress'         => 'string|nullable',
            'remark'              => 'string|nullable',
        ];
    }

    protected function contactUpdate(): array
    {
        return [
            'customerId'     => 'integer|nullable',
            'contactType'    => 'required|string|max:50',
            'contactName'    => 'required|string|max:255',
            'gender'         => 'string|nullable|max:10',
            'mobile'         => 'string|nullable|max:20',
            'telephone'      => 'string|nullable|max:20',
            'isActive'       => 'required|in:0,1',
            'position'       => 'string|nullable|max:10',
            'email'          => 'email|nullable|max:255',
            'businessPerson' => 'string|nullable|max:255',
            'businessAssistant' => 'string|nullable|max:255',
            'techLeadDept'   => 'string|nullable|max:255',
            'techLead'       => 'string|nullable|max:255',
            'workAddress'    => 'string|nullable',
            'remark'         => 'string|nullable',
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
}
