<?php
namespace App\Http\Controllers;
use App\Http\Requests\GyzRequest;
use App\Services\GyzService;

class GyzController extends Controller
{
    protected $service;
    public function __construct(GyzService $service)
    {
        $this->service = $service;
        $this->middleware('auth');
    }

    // 客户基础
    public function basicIndex()
    {
        $req = app(GyzRequest::class, ['query' => ['scene' => 'basic-list']]);
        $valid = $req->validated();
        $data = $this->service->basicList($valid);
        return response()->json(['success' => true, 'message' => '查询成功', 'data' => $data]);
    }
    public function basicShow(int $id)
    {
        try {
            $info = $this->service->basicDetail($id);
            return response()->json(['success' => true, 'message' => '查询成功', 'data' => $info]);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 400);
        }
    }
    public function basicStore()
    {
        $req = app(GyzRequest::class, ['query' => ['scene' => 'basic-store']]);
        $model = $this->service->basicCreate($req->validated());
        return response()->json(['success' => true, 'message' => '新增成功', 'data' => $model]);
    }
    public function basicUpdate(int $id)
    {
        $req = app(GyzRequest::class, ['query' => ['scene' => 'basic-update']]);
        $model = $this->service->basicUpdate($id, $req->validated());
        return response()->json(['success' => true, 'message' => '更新成功', 'data' => $model]);
    }
    public function basicDestroy(int $id)
    {
        $this->service->basicDelete($id);
        return response()->json(['success' => true, 'message' => '删除成功']);
    }

    // 客户地址
    public function addressIndex()
    {
        $req = app(GyzRequest::class, ['query' => ['scene' => 'address-list']]);
        $valid = $req->validated();
        $data = $this->service->addressList($valid);
        return response()->json(['success' => true, 'message' => '查询成功', 'data' => $data]);
    }
    public function addressShow(int $id)
    {
        try {
            $info = $this->service->addressDetail($id);
            return response()->json(['success' => true, 'message' => '查询成功', 'data' => $info]);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 400);
        }
    }
    public function addressStore()
    {
        $req = app(GyzRequest::class, ['query' => ['scene' => 'address-store']]);
        $model = $this->service->addressCreate($req->validated());
        return response()->json(['success' => true, 'message' => '新增成功', 'data' => $model]);
    }
    public function addressUpdate(int $id)
    {
        $req = app(GyzRequest::class, ['query' => ['scene' => 'address-update']]);
        $model = $this->service->addressUpdate($id, $req->validated());
        return response()->json(['success' => true, 'message' => '更新成功', 'data' => $model]);
    }
    public function addressDestroy(int $id)
    {
        $this->service->addressDelete($id);
        return response()->json(['success' => true, 'message' => '删除成功']);
    }

    // 客户费用
    public function feeIndex()
    {
        $req = app(GyzRequest::class, ['query' => ['scene' => 'fee-list']]);
        $valid = $req->validated();
        $data = $this->service->feeList($valid);
        return response()->json(['success' => true, 'message' => '查询成功', 'data' => $data]);
    }
    public function feeShow(int $id)
    {
        try {
            $info = $this->service->feeDetail($id);
            return response()->json(['success' => true, 'message' => '查询成功', 'data' => $info]);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 400);
        }
    }
    public function feeStore()
    {
        $req = app(GyzRequest::class, ['query' => ['scene' => 'fee-store']]);
        $model = $this->service->feeCreate($req->validated());
        return response()->json(['success' => true, 'message' => '新增成功', 'data' => $model]);
    }
    public function feeUpdate(int $id)
    {
        $req = app(GyzRequest::class, ['query' => ['scene' => 'fee-update']]);
        $model = $this->service->feeUpdate($id, $req->validated());
        return response()->json(['success' => true, 'message' => '更新成功', 'data' => $model]);
    }
    public function feeDestroy(int $id)
    {
        $this->service->feeDelete($id);
        return response()->json(['success' => true, 'message' => '删除成功']);
    }

    // 客户统计
    public function statisticsIndex()
    {
        $req = app(GyzRequest::class, ['query' => ['scene' => 'statistics-list']]);
        $data = $this->service->statisticsList($req->validated());
        return response()->json(['success' => true, 'message' => '查询成功', 'data' => $data]);
    }
    public function statisticsShow(int $id)
    {
        try {
            $info = $this->service->statisticsDetail($id);
            return response()->json(['success' => true, 'message' => '查询成功', 'data' => $info]);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 400);
        }
    }
    public function statisticsStore()
    {
        $req = app(GyzRequest::class, ['query' => ['scene' => 'statistics-store']]);
        $model = $this->service->statisticsCreate($req->validated());
        return response()->json(['success' => true, 'message' => '新增成功', 'data' => $model]);
    }
    public function statisticsUpdate(int $id)
    {
        $req = app(GyzRequest::class, ['query' => ['scene' => 'statistics-update']]);
        $model = $this->service->statisticsUpdate($id, $req->validated());
        return response()->json(['success' => true, 'message' => '更新成功', 'data' => $model]);
    }
    public function statisticsDestroy(int $id)
    {
        $this->service->statisticsDelete($id);
        return response()->json(['success' => true, 'message' => '删除成功']);
    }
}
