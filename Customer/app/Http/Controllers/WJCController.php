<?php

namespace App\Http\Controllers;

use App\Http\Requests\WJCRequest;
use App\Services\WJCService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class WJCController extends Controller
{
    protected WJCService $service;

    public function __construct(WJCService $service)
    {
        $this->service = $service;
    }

    private function getResourceType(): string
    {
        $name = request()->route()->getName() ?? '';
        if (str_starts_with($name, 'applicant.')) return 'applicant';
        if (str_starts_with($name, 'inventor.')) return 'inventor';
        if (str_starts_with($name, 'customer-business.')) return 'customer-business';
        return '';
    }

    private function handleFind(?object $item, string $message): JsonResponse
    {
        if (!$item) {
            return $this->error('记录不存在');
        }
        return $this->success($item, $message);
    }

    private function handleResult(bool $result, string $message): JsonResponse
    {
        if (!$result) {
            return $this->error('记录不存在');
        }
        return $this->success(null, $message);
    }

    public function index(Request $request): JsonResponse
    {
        return match ($this->getResourceType()) {
            'applicant'       => $this->success($this->service->applicantList($request), '查询成功'),
            'inventor'        => $this->success($this->service->inventorList($request), '查询成功'),
            'customer-business' => $this->success($this->service->businessList($request), '获取成功'),
            default           => $this->error('未知资源类型'),
        };
    }

    public function store(WJCRequest $request): JsonResponse
    {
        $data = $request->validated();

        return match ($this->getResourceType()) {
            'applicant'       => $this->success(['id' => $this->service->applicantStore($data)->id], '新增成功'),
            'inventor'        => $this->success(['id' => $this->service->inventorStore($data)->id], '新增成功'),
            'customer-business' => $this->success($this->service->businessStore($data), '创建成功'),
            default           => $this->error('未知资源类型'),
        };
    }

    public function show(int $id): JsonResponse
    {
        return match ($this->getResourceType()) {
            'applicant'       => $this->handleFind($this->service->applicantFind($id), '查询成功'),
            'inventor'        => $this->handleFind($this->service->inventorFind($id), '查询成功'),
            'customer-business' => $this->handleFind($this->service->businessFind($id), '获取成功'),
            default           => $this->error('未知资源类型'),
        };
    }

    public function update(WJCRequest $request, int $id): JsonResponse
    {
        $data = $request->validated();

        return match ($this->getResourceType()) {
            'applicant'       => $this->handleResult($this->service->applicantUpdate($id, $data), '编辑成功'),
            'inventor'        => $this->handleResult($this->service->inventorUpdate($id, $data), '编辑成功'),
            'customer-business' => $this->handleResult($this->service->businessUpdate($id, $data), '更新成功'),
            default           => $this->error('未知资源类型'),
        };
    }

    public function destroy(int $id): JsonResponse
    {
        return match ($this->getResourceType()) {
            'applicant'       => $this->handleResult($this->service->applicantDelete($id), '删除成功'),
            'inventor'        => $this->handleResult($this->service->inventorDelete($id), '删除成功'),
            'customer-business' => $this->handleResult($this->service->businessDelete($id), '删除成功'),
            default           => $this->error('未知资源类型'),
        };
    }
}
