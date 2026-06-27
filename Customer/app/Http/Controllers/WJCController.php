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
        if (str_starts_with($name, 'customer-enterprise.')) return 'customer-enterprise';
        return '';
    }

    private function responseOk(mixed $data = null, string $message = ''): JsonResponse
    {
        return match ($this->getResourceType()) {
            'applicant', 'inventor' => response()->json(['code' => 200, 'msg' => $message, 'data' => $data]),
            'customer-business', 'customer-enterprise' => response()->json(['success' => true, 'message' => $message, 'data' => $data]),
            default => response()->json(['code' => 0, 'message' => $message, 'data' => $data]),
        };
    }

    private function responseFail(string $message = ''): JsonResponse
    {
        return match ($this->getResourceType()) {
            'applicant', 'inventor' => response()->json(['code' => 400, 'msg' => $message, 'data' => null]),
            'customer-business', 'customer-enterprise' => response()->json(['success' => false, 'message' => $message, 'data' => null]),
            default => response()->json(['code' => 1, 'message' => $message, 'data' => null]),
        };
    }

    private function handleFind(?object $item, string $message): JsonResponse
    {
        if (!$item) {
            return $this->responseFail('记录不存在');
        }
        return $this->responseOk($item, $message);
    }

    private function handleResult(bool $result, string $message): JsonResponse
    {
        if (!$result) {
            return $this->responseFail('记录不存在');
        }
        return $this->responseOk(null, $message);
    }

    public function index(Request $request): JsonResponse
    {
        return match ($this->getResourceType()) {
            'applicant'       => $this->responseOk($this->service->applicantList($request), '查询成功'),
            'inventor'        => $this->responseOk($this->service->inventorList($request), '查询成功'),
            'customer-business' => $this->responseOk($this->service->businessList($request), '获取成功'),
            'customer-enterprise' => $this->responseOk($this->service->enterpriseList($request), '获取成功'),
            default           => $this->responseFail('未知资源类型'),
        };
    }

    public function store(WJCRequest $request): JsonResponse
    {
        $data = $request->validated();

        return match ($this->getResourceType()) {
            'applicant'       => $this->responseOk(['id' => $this->service->applicantStore($data)->id], '新增成功'),
            'inventor'        => $this->responseOk(['id' => $this->service->inventorStore($data)->id], '新增成功'),
            'customer-business' => $this->responseOk(['id' => $this->service->businessStore($data)->id], '创建成功'),
            'customer-enterprise' => $this->responseOk(['id' => $this->service->enterpriseStore($data)->id], '创建成功'),
            default           => $this->responseFail('未知资源类型'),
        };
    }

    public function show(Request $request, string|int|null $id = null): JsonResponse
    {
        $id = (int) ($request->input('id') ?? $id);

        return match ($this->getResourceType()) {
            'applicant'       => $this->handleFind($this->service->applicantFind($id), '查询成功'),
            'inventor'        => $this->handleFind($this->service->inventorFind($id), '查询成功'),
            'customer-business' => $this->handleFind($this->service->businessFind($id), '获取成功'),
            'customer-enterprise' => $this->handleFind($this->service->enterpriseFind($id), '获取成功'),
            default           => $this->responseFail('未知资源类型'),
        };
    }

    public function update(WJCRequest $request, string|int|null $id = null): JsonResponse
    {
        $data = $request->validated();
        $id = (int) ($request->input('id') ?? $id);

        return match ($this->getResourceType()) {
            'applicant'       => $this->handleResult($this->service->applicantUpdate($id, $data), '编辑成功'),
            'inventor'        => $this->handleResult($this->service->inventorUpdate($id, $data), '编辑成功'),
            'customer-business' => $this->handleResult($this->service->businessUpdate($id, $data), '更新成功'),
            'customer-enterprise' => $this->handleResult($this->service->enterpriseUpdate($id, $data), '更新成功'),
            default           => $this->responseFail('未知资源类型'),
        };
    }

    public function destroy(Request $request, string|int|null $id = null): JsonResponse
    {
        $id = (int) ($request->input('id') ?? $id);

        return match ($this->getResourceType()) {
            'applicant'       => $this->handleResult($this->service->applicantDelete($id), '删除成功'),
            'inventor'        => $this->handleResult($this->service->inventorDelete($id), '删除成功'),
            'customer-business' => $this->handleResult($this->service->businessDelete($id), '删除成功'),
            'customer-enterprise' => $this->handleResult($this->service->enterpriseDelete($id), '删除成功'),
            default           => $this->responseFail('未知资源类型'),
        };
    }
}