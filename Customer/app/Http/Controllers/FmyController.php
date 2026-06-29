<?php

namespace App\Http\Controllers;

use App\Http\Requests\FmyRequest;
use App\Services\FmyService;
use Illuminate\Http\JsonResponse;

class FmyController extends Controller
{
    protected FmyService $service;

    public function __construct(FmyService $service)
    {
        $this->service = $service;
    }

    public function index(): JsonResponse
    {
        return $this->success([]);
    }

    public function store(FmyRequest $request): JsonResponse
    {
        return $this->success([]);
    }

    public function show(int $id): JsonResponse
    {
        return $this->success([]);
    }

    public function update(FmyRequest $request, int $id): JsonResponse
    {
        return $this->success([]);
    }

    public function destroy(int $id): JsonResponse
    {
        return $this->success([]);
    }

    // ====================== 客户知识产权信息 ======================
    public function ipRightIndex()
    {
        $req = app(FmyRequest::class);
        $req->setScene('ip-right-list');
        $data = $this->service->ipRightList($req->validated());
        return $this->success($data, '获取成功');
    }

    public function ipRightShow(int $id)
    {
        try {
            $data = $this->service->ipRightDetail($id);
            return $this->success($data, '获取成功');
        } catch (\Exception $e) {
            return $this->error($e->getMessage(), 400);
        }
    }

    public function ipRightStore()
    {
        try {
            $req = app(FmyRequest::class);
            $req->setScene('ip-right-store');
            $data = $this->service->ipRightCreate($req->validated());
            return $this->success($data, '创建成功');
        } catch (\Exception $e) {
            return $this->error($e->getMessage(), 400);
        }
    }

    public function ipRightUpdate(int $id)
    {
        try {
            $req = app(FmyRequest::class);
            $req->setScene('ip-right-update');
            $data = $this->service->ipRightUpdate($id, $req->validated());
            return $this->success($data, '更新成功');
        } catch (\Exception $e) {
            return $this->error($e->getMessage(), 400);
        }
    }

    public function ipRightDestroy(int $id)
    {
        try {
            $this->service->ipRightDelete($id);
            return $this->success(null, '删除成功');
        } catch (\Exception $e) {
            return $this->error($e->getMessage(), 400);
        }
    }

    // ====================== 客户文件信息 ======================
    public function customerFileIndex()
    {
        $req = app(FmyRequest::class);
        $req->setScene('customer-file-list');
        $valid = $req->validated();
        $data = $this->service->customerFileList($valid);
        return $this->success($data, '查询成功');
    }

    public function customerFileStore()
    {
        try {
            $req = app(FmyRequest::class);
            $req->setScene('customer-file-store');
            $valid = $req->validated();
            $model = $this->service->customerFileCreate($valid);
            return $this->success(['id' => (string) $model->id], '新增成功');
        } catch (\Illuminate\Validation\ValidationException $e) {
            return $this->error($e->validator->errors()->first(), 422);
        } catch (\Illuminate\Auth\Access\AuthorizationException $e) {
            return $this->error('无权操作，需要 LEVEL_A 角色', 403);
        } catch (\Exception $e) {
            return $this->error($e->getMessage(), 400);
        }
    }

    public function customerFileTree()
    {
        $req = app(FmyRequest::class);
        $req->setScene('customer-file-tree');
        $valid = $req->validated();
        $data = $this->service->customerFileTree($valid);
        return $this->success($data, '查询成功');
    }

    public function customerOptions()
    {
        $req = app(FmyRequest::class);
        $req->setScene('customer-options');
        $valid = $req->validated();
        $data = $this->service->customerOptions($valid);
        return $this->success($data, '查询成功');
    }

    public function customerFileView(int $id)
    {
        try {
            return $this->service->customerFileView($id);
        } catch (\Exception $e) {
            return $this->error($e->getMessage(), 400);
        }
    }

    public function customerFileDownload(int $id)
    {
        try {
            return $this->service->customerFileDownload($id);
        } catch (\Exception $e) {
            return $this->error($e->getMessage(), 400);
        }
    }

    public function customerFileDestroy(int $id)
    {
        try {
            $this->service->customerFileDelete($id);
            return $this->success(null, '删除成功');
        } catch (\Exception $e) {
            return $this->error($e->getMessage(), 400);
        }
    }

    public function fileUpload()
    {
        $req = app(FmyRequest::class);
        $req->setScene('customer-file-upload');
        $valid = $req->validated();
        $data = $this->service->fileUpload($valid);
        return $this->success($data, '上传成功');
    }

    // ====================== 联系人信息 ======================
    public function contactIndex()
    {
        $req = app(FmyRequest::class);
        $req->setScene('contact-list');
        $data = $this->service->contactList($req->validated());
        return $this->success($data, '查询成功');
    }

    public function contactStore()
    {
        $req = app(FmyRequest::class);
        $req->setScene('contact-store');
        $this->service->contactCreate($req->validated());
        return $this->success(null, '创建成功');
    }

    public function contactShow(int $id)
    {
        try {
            $data = $this->service->contactDetail($id);
            return $this->success($data, '查询成功');
        } catch (\Exception $e) {
            return $this->error($e->getMessage(), 400);
        }
    }

    public function contactUpdate(int $id)
    {
        try {
            $req = app(FmyRequest::class);
            $req->setScene('contact-update');
            $model = $this->service->contactUpdate($id, $req->validated());
            return $this->success(['id' => (string) $model->id], '更新成功');
        } catch (\Exception $e) {
            return $this->error($e->getMessage(), 400);
        }
    }

    public function innovationSubjectsOptions()
    {
        $req = app(FmyRequest::class);
        $req->setScene('innovation-subjects-options');
        $data = $this->service->innovationSubjectsOptions($req->validated());
        return $this->success($data, '查询成功');
    }

    public function contactTypesOptions()
    {
        $req = app(FmyRequest::class);
        $req->setScene('contact-types-options');
        $data = $this->service->contactTypesOptions($req->validated());
        return $this->success($data, '查询成功');
    }

    public function staffOptions()
    {
        $req = app(FmyRequest::class);
        $req->setScene('staff-options');
        $data = $this->service->staffOptions($req->validated());
        return $this->success($data, '查询成功');
    }

    public function assistantOptions()
    {
        $req = app(FmyRequest::class);
        $req->setScene('assistant-options');
        $data = $this->service->assistantOptions($req->validated());
        return $this->success($data, '查询成功');
    }

    public function techLeadersOptions()
    {
        $req = app(FmyRequest::class);
        $req->setScene('tech-leaders-options');
        $data = $this->service->techLeadersOptions($req->validated());
        return $this->success($data, '查询成功');
    }

    // ====================== 企业投资情况 ======================
    public function enterpriseInvestmentIndex()
    {
        $req = app(FmyRequest::class);
        $req->setScene('enterprise-investment-list');
        $data = $this->service->enterpriseInvestmentList($req->validated());
        return $this->success($data, '获取成功');
    }

    public function enterpriseInvestmentShow(int $id)
    {
        try {
            $data = $this->service->enterpriseInvestmentDetail($id);
            return $this->success($data, '获取成功');
        } catch (\Exception $e) {
            return $this->error($e->getMessage(), 400);
        }
    }

    public function enterpriseInvestmentStore()
    {
        try {
            $req = app(FmyRequest::class);
            $req->setScene('enterprise-investment-store');
            $data = $this->service->enterpriseInvestmentCreate($req->validated());
            return $this->success($data, '创建成功');
        } catch (\Exception $e) {
            return $this->error($e->getMessage(), 400);
        }
    }

    public function enterpriseInvestmentUpdate(int $id)
    {
        try {
            $req = app(FmyRequest::class);
            $req->setScene('enterprise-investment-update');
            $data = $this->service->enterpriseInvestmentUpdate($id, $req->validated());
            return $this->success($data, '更新成功');
        } catch (\Exception $e) {
            return $this->error($e->getMessage(), 400);
        }
    }

    public function enterpriseInvestmentDestroy(int $id)
    {
        try {
            $this->service->enterpriseInvestmentDelete($id);
            return $this->success(null, '删除成功');
        } catch (\Exception $e) {
            return $this->error($e->getMessage(), 400);
        }
    }
}
