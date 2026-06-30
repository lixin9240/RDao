<?php

namespace App\Services;

use App\Models\CustomerIpRight;
use App\Models\CustomerFile;
use App\Models\CustomerBasic;
use App\Models\FileCategory;
use App\Models\FileDescription;
use App\Models\SysUser;
use App\Models\CustomerContact;
use App\Repositories\EnterpriseInvestmentRepository;
use Illuminate\Support\Facades\Storage;
use Symfony\Component\HttpFoundation\StreamedResponse;

class FmyService
{
    protected ?OssService $ossService = null;
    protected bool $useOss;

    public function __construct()
    {
        $this->useOss = env('FILE_STORAGE_DRIVER') === 'oss';
    }

    protected function getOssService(): OssService
    {
        if ($this->ossService === null) {
            $this->ossService = new OssService();
        }
        return $this->ossService;
    }

    /**
     * 示例方法
     */
    public function example(): string
    {
        return 'Fmy Service';
    }

    // ====================== 客户知识产权信息 ======================
    public function ipRightList(array $params): array
    {
        $page = $params['page'] ?? 1;
        $perPage = $params['per_page'] ?? 15;
        $paginate = CustomerIpRight::search($params)
            ->paginate($perPage, ['*'], 'page', $page);
        return [
            'data' => $paginate->items(),
            'meta' => [
                'current_page' => $paginate->currentPage(),
                'per_page'     => $paginate->perPage(),
                'total'        => $paginate->total(),
                'last_page'    => $paginate->lastPage(),
            ],
        ];
    }

    public function ipRightDetail(int $id)
    {
        $row = CustomerIpRight::find($id);
        if (! $row) {
            throw new \Exception('记录不存在');
        }
        return $row;
    }

    public function ipRightCreate(array $data)
    {
        return CustomerIpRight::create($data);
    }

    public function ipRightUpdate(int $id, array $data)
    {
        $model = $this->ipRightDetail($id);
        $model->update($data);
        return $model;
    }

    public function ipRightDelete(int $id): void
    {
        $this->ipRightDetail($id)->delete();
    }

    // ====================== 客户文件信息 ======================
    public function customerFileList(array $params): array
    {
        $page = $params['page_num'] ?? $params['pageNum'] ?? 1;
        $perPage = $params['page_size'] ?? $params['pageSize'] ?? 10;

        $query = CustomerFile::with(['customer', 'creator', 'category'])
            ->search($params);

        $paginate = $query->paginate($perPage, ['*'], 'page', $page);
        $items = $paginate->items();
        $list = [];
        $startSerial = ($page - 1) * $perPage + 1;

        foreach ($items as $index => $item) {
            $creatorName = $item->creator?->real_name ?? '';
            $list[] = [
                'id'         => (string) $item->id,
                'serialNo'   => $startSerial + $index,
                'fileName'   => $item->original_name,
                'fileType'   => $item->category?->name ?? '',
                'uploadTime' => $item->created_at?->format('Y-m-d'),
                'uploader'   => $creatorName,
                'creator'    => $creatorName,
                'createTime' => $item->created_at?->format('Y-m-d'),
            ];
        }

        return [
            'total' => $paginate->total(),
            'list'  => $list,
        ];
    }

    public function customerFileCreate(array $data)
    {
        /** @var \Illuminate\Http\UploadedFile $file */
        $file = $data['file'] ?? $data['file'] ?? null;

        if (!$file) {
            throw new \Exception('请上传文件');
        }

        if ($this->useOss) {
            $uploadResult = $this->getOssService()->upload($file, 'customer_files');
            $ossKey = $uploadResult['path'];
            $fileUrl = $this->getOssService()->getUrl($ossKey);
            $fileSize = $uploadResult['size'];
            $originalName = $uploadResult['original_name'];
        } else {
            $ossKey = $file->store('customer_files', 'local');
            $fileUrl = Storage::url($ossKey);
            $fileSize = $file->getSize();
            $originalName = $file->getClientOriginalName();
        }

        $salespersonId = is_numeric($data['businessPerson'] ?? $data['business_person'] ?? '') 
            ? (int) ($data['businessPerson'] ?? $data['business_person']) 
            : auth('api')->id();

        $record = CustomerFile::create([
            'category_id'    => $data['fileTypeId'] ?? $data['file_type_id'] ?? null,
            'customer_id'    => $data['customerId'] ?? $data['customer_id'] ?? null,
            'salesperson_id' => $salespersonId,
            'remarks'        => $data['remark'] ?? $data['remarks'] ?? '',
            'file_url'       => $ossKey,
            'file_size'      => $fileSize,
            'original_name'  => $originalName,
            'created_by'     => auth('api')->id(),
            'updated_by'     => auth('api')->id(),
        ]);

        return [
            'id'        => (string) $record->id,
            'fileId'    => (string) $record->id,
            'fileName'  => $originalName,
            'fileUrl'   => $fileUrl,
            'fileSize'  => $fileSize,
        ];
    }

    public function customerFileTree(array $params): array
    {
        $keyword = $params['keyword'] ?? '';

        $categories = FileCategory::where('status', 1)
            ->orderBy('sort_order')
            ->get();

        $descriptions = FileDescription::where('status', 1)
            ->when($keyword, function ($q) use ($keyword) {
                $q->where('file_name_template', 'like', "%{$keyword}%");
            })
            ->orderBy('sort_order')
            ->get();

        // 构建 big -> small 映射
        $bigMap = [];
        $smallMap = [];
        foreach ($categories as $cat) {
            if ($cat->parent_id == 0) {
                $bigMap[$cat->id] = [
                    'id'       => (string) $cat->id,
                    'name'     => $cat->name,
                    'type'     => 'big',
                    'children' => [],
                ];
            } else {
                $smallMap[$cat->id] = [
                    'id'       => $cat->id,
                    'name'     => $cat->name,
                    'type'     => 'small',
                    'children' => [],
                ];
            }
        }

        // 将 description 挂到 small 下
        foreach ($descriptions as $desc) {
            $subId = $desc->file_subcategory_id;
            if (! isset($smallMap[$subId])) {
                continue;
            }
            $smallMap[$subId]['children'][] = [
                'id'   => "{$subId}-{$desc->id}",
                'name' => $desc->file_name_template ?: $desc->internal_code ?: '未命名',
                'type' => 'file',
            ];
        }

        // 将 small 挂到 big 下
        foreach ($categories as $cat) {
            if ($cat->parent_id != 0 && isset($bigMap[$cat->parent_id])) {
                if (! empty($smallMap[$cat->id]['children'])) {
                    $bigMap[$cat->parent_id]['children'][] = $smallMap[$cat->id];
                }
            }
        }

        // 过滤：如果有关键词，只返回包含匹配文件的 big 节点
        $result = [];
        foreach ($bigMap as $big) {
            if ($keyword) {
                $hasMatch = false;
                foreach ($big['children'] as $small) {
                    if (! empty($small['children'])) {
                        $hasMatch = true;
                        break;
                    }
                }
                if ($hasMatch) {
                    $result[] = $big;
                }
            } else {
                $result[] = $big;
            }
        }

        return $result;
    }

    public function customerOptions(array $params): array
    {
        $keyword = $params['keyword'] ?? '';
        $query = CustomerBasic::query();

        if ($keyword) {
            $query->where('innovation_subject', 'like', "%{$keyword}%")
                ->orWhere('customer_no', 'like', "%{$keyword}%");
        }

        return $query->limit(50)
            ->get()
            ->map(fn ($item) => [
                'id'   => (string) $item->id,
                'name' => $item->innovation_subject ?: $item->customer_no,
            ])
            ->toArray();
    }

    public function customerFileView(int $id): array
    {
        $file = CustomerFile::with('category')->find($id);
        if (! $file) {
            throw new \Exception('文件不存在');
        }

        $fileUrl = null;
        $ossKey = $file->file_url;

        if (empty($ossKey) || str_starts_with($ossKey, 'https://via.placeholder')) {
            return [
                'fileName' => $file->original_name,
                'fileUrl'  => null,
                'fileType' => $file->category?->name ?? '',
                'message'  => '无预览地址',
            ];
        }

        if (str_starts_with($ossKey, 'http')) {
            $ossKey = parse_url($ossKey, PHP_URL_PATH);
            $ossKey = ltrim($ossKey, '/');
        }

        try {
            if ($this->useOss) {
                $fileUrl = $this->getOssService()->getPreviewUrl($ossKey, 3600);
            } else {
                $fileUrl = Storage::url($file->file_url);
            }
        } catch (\Exception $e) {
            return [
                'fileName' => $file->original_name,
                'fileUrl'  => null,
                'fileType' => $file->category?->name ?? '',
                'message'  => '无预览地址',
            ];
        }

        return [
            'fileName' => $file->original_name,
            'fileUrl'  => $fileUrl,
            'fileType' => $file->category?->name ?? '',
        ];
    }

    public function customerFileDownload(int $id): mixed
    {
        $file = CustomerFile::find($id);
        if (! $file) {
            throw new \Exception('文件不存在');
        }

        $ossKey = $file->file_url;
        if (str_starts_with($ossKey, 'http')) {
            $ossKey = parse_url($ossKey, PHP_URL_PATH);
            $ossKey = ltrim($ossKey, '/');
        }

        if ($this->useOss) {
            $downloadUrl = $this->getOssService()->getDownloadUrl(
                $ossKey,
                $file->original_name,
                3600
            );
            return redirect($downloadUrl);
        }

        $path = storage_path('app/' . $file->file_url);
        if (! file_exists($path)) {
            throw new \Exception('文件已失效');
        }

        return response()->streamDownload(function () use ($path) {
            readfile($path);
        }, $file->original_name);
    }

    public function customerFileDelete(int $id): void
    {
        $file = CustomerFile::find($id);
        if (! $file) {
            throw new \Exception('文件不存在');
        }

        // 删除物理文件
        if ($file->file_url) {
            if ($this->useOss) {
                $this->getOssService()->delete($file->file_url);
            } elseif (Storage::exists($file->file_url)) {
                Storage::delete($file->file_url);
            }
        }

        $file->delete();
    }

    public function fileUpload(array $data): array
    {
        /** @var \Illuminate\Http\UploadedFile $file */
        $file = $data['file'];

        // 使用 OSS 或本地存储
        if ($this->useOss) {
            $uploadResult = $this->getOssService()->upload($file, 'uploads');
            $ossKey = $uploadResult['path'];
            $fileUrl = $this->getOssService()->getUrl($ossKey);
        } else {
            $uploadResult = [
                'path' => $file->store('uploads', 'local'),
                'original_name' => $file->getClientOriginalName(),
                'size' => $file->getSize(),
            ];
            $ossKey = $uploadResult['path'];
            $fileUrl = Storage::url($uploadResult['path']);
        }

        $record = \App\Models\CustomerFile::create([
            'category_id' => $data['category_id'] ?? null,
            'customer_id' => $data['customer_id'] ?? null,
            'salesperson_id' => auth('api')->id(),
            'remarks' => $data['remarks'] ?? null,
            'file_url' => $ossKey,
            'file_size' => $uploadResult['size'],
            'original_name' => $uploadResult['original_name'],
            'created_by' => auth('api')->id(),
            'updated_by' => auth('api')->id(),
        ]);

        return [
            'fileId'   => (string) $record->id,
            'fileName' => $uploadResult['original_name'],
            'fileUrl'  => $fileUrl,
            'fileSize' => $uploadResult['size'],
        ];
    }

    // ====================== 联系人信息 ======================
    public function contactList(array $params): array
    {
        $page = $params['pageNum'] ?? 1;
        $perPage = $params['pageSize'] ?? 10;

        $query = CustomerContact::with(['customer', 'businessPerson'])
            ->search($params);

        $paginate = $query->paginate($perPage, ['*'], 'page', $page);
        $items = $paginate->items();
        $list = [];
        $startSerial = ($page - 1) * $perPage + 1;

        foreach ($items as $index => $item) {
            $list[] = [
                'id'             => $item->id,
                'serialNo'       => $startSerial + $index,
                'name'           => $item->name,
                'customerName'   => $item->customer?->innovation_subject ?? '',
                'contactType'    => $item->contact_type,
                'phone'          => $item->phone,
                'gender'         => '未知',
                'isEmployed'     => $item->is_active ? 1 : 0,
                'position'       => $item->position,
                'email'          => $item->email,
                'businessPerson' => $item->businessPerson?->real_name ?? '',
            ];
        }

        return [
            'total' => $paginate->total(),
            'list'  => $list,
        ];
    }

    public function contactCreate(array $data)
    {
        $model = CustomerContact::create([
            'innovation_entity_id' => $data['innovation_entity_id'],
            'contact_type'         => $data['contact_type'],
            'name'                 => $data['name'],
            'phone'                => $data['phone'],
            'landline'             => $data['landline'] ?? null,
            'is_active'            => (bool) $data['is_active'],
            'position'             => $data['position'] ?? null,
            'email'                => $data['email'] ?? null,
            'sales_rep_id'         => $data['sales_rep_id'] ?? null,
            'sales_assistant_id'   => $data['sales_assistant_id'] ?? null,
            'tech_lead_dept'       => $data['tech_lead_dept'] ?? null,
            'tech_lead_id'         => $data['tech_lead_id'] ?? null,
            'work_address'         => $data['work_address'] ?? null,
            'notes'                => $data['notes'] ?? null,
        ]);
        $model->forceFill([
            'created_by' => auth('api')->id(),
            'updated_by' => auth('api')->id(),
        ]);
        $model->save();
        return $model;
    }

    public function contactDetail(int $id): array
    {
        $contact = CustomerContact::with(['customer', 'businessPerson', 'assistant', 'techLeader', 'creator', 'updater'])->find($id);
        if (! $contact) {
            throw new \Exception('联系人不存在');
        }

        return [
            'innovationSubjectId' => $contact->innovation_entity_id,
            'contactType'         => $contact->contact_type,
            'name'                => $contact->name,
            'phone'               => $contact->phone,
            'landline'            => $contact->landline,
            'isEmployed'          => $contact->is_active ? 1 : 0,
            'position'            => $contact->position,
            'email'               => $contact->email,
            'businessPersonId'    => $contact->sales_rep_id,
            'assistantId'         => $contact->sales_assistant_id,
            'techDepartment'      => $contact->tech_lead_dept,
            'techLeaderId'        => $contact->tech_lead_id,
            'workAddress'         => $contact->work_address,
            'remark'              => $contact->notes,
            'createBy'            => $contact->creator?->real_name ?? '',
            'createTime'          => $contact->created_at?->format('Y-m-d H:i:s'),
            'updateBy'            => $contact->updater?->real_name ?? '',
            'updateTime'          => $contact->updated_at?->format('Y-m-d H:i:s'),
        ];
    }

    public function contactUpdate(int $id, array $data)
    {
        $contact = CustomerContact::find($id);
        if (! $contact) {
            throw new \Exception('联系人不存在');
        }

        $salesRepId   = is_numeric($data['sales_rep_id'] ?? '') ? (int) $data['sales_rep_id'] : $contact->sales_rep_id;
        $techLeadId   = is_numeric($data['tech_lead_id'] ?? '') ? (int) $data['tech_lead_id'] : $contact->tech_lead_id;
        $assistantId  = is_numeric($data['sales_assistant_id'] ?? '') ? (int) $data['sales_assistant_id'] : $contact->sales_assistant_id;

        $contact->update([
            'innovation_entity_id' => $data['customer_id'] ?? $contact->innovation_entity_id,
            'contact_type'         => $data['contact_type'],
            'name'                 => $data['name'],
            'phone'                => $data['phone'] ?? $contact->phone,
            'landline'             => $data['landline'] ?? $contact->landline,
            'is_active'            => (bool) $data['is_active'],
            'position'             => $data['position'] ?? $contact->position,
            'email'                => $data['email'] ?? $contact->email,
            'sales_rep_id'         => $salesRepId,
            'sales_assistant_id'   => $assistantId,
            'tech_lead_dept'       => $data['tech_lead_dept'] ?? $contact->tech_lead_dept,
            'tech_lead_id'         => $techLeadId,
            'work_address'         => $data['work_address'] ?? $contact->work_address,
            'notes'                => $data['notes'] ?? $contact->notes,
        ]);
        $contact->forceFill(['updated_by' => auth('api')->id()]);
        $contact->save();

        return $contact;
    }

    public function innovationSubjectsOptions(array $params): array
    {
        $keyword = $params['keyword'] ?? '';
        $query = CustomerBasic::query();

        if ($keyword) {
            $query->where('innovation_subject', 'like', "%{$keyword}%");
        }

        return $query->limit(50)
            ->get()
            ->map(fn ($item) => [
                'id'   => (string) $item->id,
                'name' => $item->innovation_subject ?: $item->customer_no,
            ])
            ->toArray();
    }

    public function contactTypesOptions(array $params): array
    {
        $keyword = $params['keyword'] ?? '';
        $query = CustomerContact::query()
            ->select('contact_type')
            ->distinct();

        if ($keyword) {
            $query->where('contact_type', 'like', "%{$keyword}%");
        }

        return $query->get()
            ->map(fn ($item, $index) => [
                'id'   => (string) ($index + 1),
                'name' => $item->contact_type,
            ])
            ->toArray();
    }

    public function staffOptions(array $params): array
    {
        return $this->userOptions($params);
    }

    public function assistantOptions(array $params): array
    {
        return $this->userOptions($params);
    }

    public function techLeadersOptions(array $params): array
    {
        return $this->userOptions($params);
    }

    // ====================== 企业投资情况 ======================

    protected function investmentRepo(): EnterpriseInvestmentRepository
    {
        return new EnterpriseInvestmentRepository();
    }

    public function enterpriseInvestmentList(array $params): array
    {
        $paginate = $this->investmentRepo()->list($params);
        return [
            'data' => $paginate->items(),
            'meta' => [
                'current_page' => $paginate->currentPage(),
                'per_page'     => $paginate->perPage(),
                'total'        => $paginate->total(),
                'last_page'    => $paginate->lastPage(),
            ],
        ];
    }

    public function enterpriseInvestmentDetail(int $id)
    {
        $row = $this->investmentRepo()->find($id);
        if (! $row) {
            throw new \Exception('记录不存在');
        }
        return $row;
    }

    public function enterpriseInvestmentCreate(array $data)
    {
        return $this->investmentRepo()->create($data);
    }

    public function enterpriseInvestmentUpdate(int $id, array $data)
    {
        return $this->investmentRepo()->update($id, $data);
    }

    public function enterpriseInvestmentDelete(int $id): void
    {
        $this->investmentRepo()->delete($id);
    }

    protected function userOptions(array $params): array
    {
        $keyword = $params['keyword'] ?? '';
        $query = SysUser::query()
            ->where('account_status', 1)
            ->where('employment_status', 1);

        if ($keyword) {
            $query->where(function ($q) use ($keyword) {
                $q->where('real_name', 'like', "%{$keyword}%")
                    ->orWhere('username', 'like', "%{$keyword}%");
            });
        }

        return $query->limit(50)
            ->get()
            ->map(fn ($item) => [
                'id'   => (string) $item->id,
                'name' => $item->real_name,
            ])
            ->toArray();
    }
}
