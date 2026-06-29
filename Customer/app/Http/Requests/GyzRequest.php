<?php
namespace App\Http\Requests;
use Illuminate\Foundation\Http\FormRequest;

class GyzRequest extends FormRequest
{
    protected string $scene;

    public function __construct(array $query = [], array $request = [], array $attributes = [], array $cookies = [], array $files = [], array $server = [], $content = null)
    {
        parent::__construct($query, $request, $attributes, $cookies, $files, $server, $content);
        $this->scene = $query['scene'] ?? $this->query('scene') ?? $this->input('scene') ?? '';
    }

    public function authorize(): bool
    {
        return auth('api')->check();
    }

    public function rules(): array
    {
        return match ($this->scene) {
            // 客户基础信息
            'basic-list'    => $this->basicList(),
            'basic-store'   => $this->basicStore(),
            'basic-update'  => $this->basicUpdate(),
            // 客户地址
            'address-list'   => $this->addressList(),
            'address-store'  => $this->addressStore(),
            'address-update' => $this->addressUpdate(),
            // 客户费用
            'fee-list'      => $this->feeList(),
            'fee-store'     => $this->feeStore(),
            'fee-update'    => $this->feeUpdate(),
            // 客户统计
            'statistics-list'    => $this->statisticsList(),
            'statistics-store'   => $this->statisticsStore(),
            'statistics-update'  => $this->statisticsUpdate(),
            default => [],
        };
    }

    protected function prepareForValidation()
    {
        // 全局去空格
        $data = $this->all();
        array_walk_recursive($data, function (&$v) {
            if (is_string($v)) $v = trim($v);
        });
        $this->merge($data);
        // 新增自动填充创建人
        if (in_array($this->scene, ['basic-store','address-store','fee-store','statistics-store'])) {
            $this->merge(['creator' => auth('api')->user()->real_name]);
        }
    }

    // ========== CustomerBasic 校验规则 ==========
    protected function basicList(): array
    {
        return [
            'page'     => 'integer|min:1',
            'per_page' => 'integer|min:1|max:100',
            'search'   => 'string|nullable',
            'sort'     => 'string|nullable',
            'order'    => 'in:asc,desc|nullable'
        ];
    }
    protected function basicStore(): array
    {
        return [
            'customer_no'           => 'string|nullable|max:50',
            'innovation_subject'    => 'string|nullable|max:255',
            'innovation_subject_en' => 'string|nullable|max:255',
            'credit_code'           => 'string|nullable|max:50',
            'legal_representative'  => 'string|nullable|max:100',
            'company_contact'       => 'string|nullable|max:100',
            'customer_level'        => 'string|nullable|max:50',
            'customer_scale'        => 'string|nullable|max:100',
            'price_index'           => 'numeric|nullable',
            'innovation_index'      => 'numeric|nullable',
            'contract_count'        => 'integer|nullable|min:0',
            'latest_contract_date'  => 'date|nullable',
            'remark'                => 'string|nullable'
        ];
    }
    protected function basicUpdate(): array
    {
        return $this->basicStore();
    }

    // ========== CustomerAddress 校验规则 ==========
    protected function addressList(): array
    {
        return [
            'page'     => 'integer|min:1',
            'per_page' => 'integer|min:1|max:100',
            'search'   => 'string|nullable',
            'sort'     => 'string|nullable',
            'order'    => 'in:asc,desc|nullable'
        ];
    }
    protected function addressStore(): array
    {
        return [
            'nationality'     => 'string|nullable|max:100',
            'province'        => 'string|nullable|max:100',
            'city'            => 'string|nullable|max:100',
            'district'        => 'string|nullable|max:100',
            'street_address'  => 'string|nullable|max:500',
            'address_en'      => 'string|nullable|max:500',
            'other_address'   => 'string|nullable|max:500',
            'industrial_park' => 'string|nullable|max:255',
            'postal_code'     => 'string|nullable|max:20',
            'company_website' => 'string|nullable|max:255'
        ];
    }
    protected function addressUpdate(): array
    {
        return $this->addressStore();
    }

    // ========== CustomerFee 校验规则 ==========
    protected function feeList(): array
    {
        return [
            'page'     => 'integer|min:1',
            'per_page' => 'integer|min:1|max:100',
            'search'   => 'string|nullable',
            'sort'     => 'string|nullable',
            'order'    => 'in:asc,desc|nullable'
        ];
    }
    protected function feeStore(): array
    {
        return [
            'account_name'   => 'string|nullable|max:255',
            'bank_name'      => 'string|nullable|max:255',
            'bank_account'    => 'string|nullable|max:50',
            'invoice_address' => 'string|nullable|max:500',
            'invoice_phone'  => 'string|nullable|max:20',
            'taxpayer_type'   => 'string|nullable|max:50',
            'billing_address' => 'string|nullable|max:500'
        ];
    }
    protected function feeUpdate(): array
    {
        return $this->feeStore();
    }

    // ========== 客户统计 校验规则 ==========
    protected function statisticsList(): array
    {
        return [
            'page'     => 'integer|min:1',
            'per_page' => 'integer|min:1|max:100',
            'search'   => 'string|nullable',
            'basic_id' => 'integer|nullable',
            'basic_ids' => 'string|nullable',
            'sort'     => 'string|nullable',
            'order'    => 'in:asc,desc|nullable'
        ];
    }
    protected function statisticsStore(): array
    {
        return [
            'basic_id'                  => 'integer|nullable',
            'economy_category'         => 'string|nullable|max:50',
            'economy_sub_category'     => 'string|nullable|max:50',
            'economy_large_category'   => 'string|nullable|max:50',
            'economy_mid_category'      => 'string|nullable|max:50',
            'sales_2021'               => 'numeric|nullable',
            'sales_2020'               => 'numeric|nullable',
            'sales_2019'               => 'numeric|nullable',
            'rd_fee_2021'              => 'numeric|nullable',
            'rd_fee_2020'              => 'numeric|nullable',
            'rd_fee_2019'              => 'numeric|nullable',
            'loan_2021'                => 'numeric|nullable',
            'loan_2020'                => 'numeric|nullable',
            'loan_2019'                => 'numeric|nullable',
            'tech_verified'            => 'boolean|nullable',
            'is_high_tech'             => 'boolean|nullable',
            'is_provincial_enterprise' => 'boolean|nullable',
            'is_municipal_enterprise'  => 'boolean|nullable',
            'is_engineering_center'   => 'boolean|nullable',
            'ip_index'                 => 'string|nullable|max:50',
            'integration_standard'    => 'string|nullable|max:50',
        ];
    }
    protected function statisticsUpdate(): array
    {
        return $this->statisticsStore();
    }
}