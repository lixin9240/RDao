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
        $valid = $req->validated();
        $data = $this->service->ipRightList($valid);
        return response()->json(['success' => true, 'message' => '获取成功', 'data' => $data]);
    }

    public function ipRightShow(int $id)
    {
        try {
            $info = $this->service->ipRightDetail($id);
            return response()->json(['success' => true, 'message' => '获取成功', 'data' => $info]);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage(), 'errors' => []], 400);
        }
    }

    public function ipRightStore()
    {
        try {
            $req = app(FmyRequest::class);
            $req->setScene('ip-right-store');
            $model = $this->service->ipRightCreate($req->validated());
            return response()->json(['success' => true, 'message' => '创建成功', 'data' => $model]);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage(), 'errors' => []], 400);
        }
    }

    public function ipRightUpdate(int $id)
    {
        try {
            $req = app(FmyRequest::class);
            $req->setScene('ip-right-update');
            $model = $this->service->ipRightUpdate($id, $req->validated());
            return response()->json(['success' => true, 'message' => '更新成功', 'data' => $model]);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage(), 'errors' => []], 400);
        }
    }

    public function ipRightDestroy(int $id)
    {
        try {
            $this->service->ipRightDelete($id);
            return response()->json(['success' => true, 'message' => '删除成功', 'data' => null]);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage(), 'errors' => []], 400);
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
        $valid = $req->validated();
        $data = $this->service->contactList($valid);
        return response()->json(['code' => 200, 'msg' => 'success', 'data' => $data]);
    }

    public function contactStore()
    {
        $req = app(FmyRequest::class);
        $req->setScene('contact-store');
        $valid = $req->validated();
        $this->service->contactCreate($valid);
        return response()->json(['code' => 200, 'msg' => 'success', 'data' => null]);
    }

    public function contactShow(int $id)
    {
        try {
            $data = $this->service->contactDetail($id);
            return response()->json(['code' => 200, 'msg' => 'success', 'data' => $data]);
        } catch (\Exception $e) {
            return response()->json(['code' => 400, 'msg' => $e->getMessage(), 'data' => null], 400);
        }
    }

    public function contactUpdate(int $id)
    {
        try {
            $req = app(FmyRequest::class);
            $req->setScene('contact-update');
            $valid = $req->validated();
            $model = $this->service->contactUpdate($id, $valid);
            return response()->json(['code' => 200, 'msg' => 'success', 'data' => ['id' => (string) $model->id]]);
        } catch (\Exception $e) {
            return response()->json(['code' => 400, 'msg' => $e->getMessage(), 'data' => null], 400);
        }
    }

    public function innovationSubjectsOptions()
    {
        $req = app(FmyRequest::class);
        $req->setScene('innovation-subjects-options');
        $valid = $req->validated();
        $data = $this->service->innovationSubjectsOptions($valid);
        return response()->json(['code' => 200, 'msg' => 'success', 'data' => $data]);
    }

    public function contactTypesOptions()
    {
        $req = app(FmyRequest::class);
        $req->setScene('contact-types-options');
        $valid = $req->validated();
        $data = $this->service->contactTypesOptions($valid);
        return response()->json(['code' => 200, 'msg' => 'success', 'data' => $data]);
    }

    public function staffOptions()
    {
        $req = app(FmyRequest::class);
        $req->setScene('staff-options');
        $valid = $req->validated();
        $data = $this->service->staffOptions($valid);
        return response()->json(['code' => 200, 'msg' => 'success', 'data' => $data]);
    }

    public function assistantOptions()
    {
        $req = app(FmyRequest::class);
        $req->setScene('assistant-options');
        $valid = $req->validated();
        $data = $this->service->assistantOptions($valid);
        return response()->json(['code' => 200, 'msg' => 'success', 'data' => $data]);
    }

    public function techLeadersOptions()
    {
        $req = app(FmyRequest::class);
        $req->setScene('tech-leaders-options');
        $valid = $req->validated();
        $data = $this->service->techLeadersOptions($valid);
        return response()->json(['code' => 200, 'msg' => 'success', 'data' => $data]);
    }
}
