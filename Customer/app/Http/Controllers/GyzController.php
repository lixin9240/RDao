<?php
namespace App\Http\Controllers;

use App\Http\Requests\GyzRequest;
use App\Models\CustomerStatistics;
use App\Services\GyzService;
use Illuminate\Http\Request;

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

    public function statisticsIndex()
    {
        $req = app(GyzRequest::class, ['query' => ['scene' => 'statistics-list']]);
        $valid = $req->validated();
        if (!empty($valid['basic_id'])) {
            $this->service->syncBusinessToStatistics($valid['basic_id']);
        }
        if (!empty($valid['basic_ids'])) {
            $basicIds = is_array($valid['basic_ids']) ? $valid['basic_ids'] : explode(',', $valid['basic_ids']);
            unset($valid['basic_ids']);
            $data = $this->service->statisticsListByBasicIds($basicIds, $valid);
        } else {
            $data = $this->service->statisticsList($valid);
        }
        return response()->json(['success' => true, 'message' => '查询成功', 'data' => $data]);
    }
    public function statisticsShow(Request $request)
    {
        try {
            $id = $request->route('id');
            // 支持 basic_id 或 统计记录id
            $info = CustomerStatistics::where('basic_id', $id)->first();
            if (!$info) {
                $info = CustomerStatistics::find($id);
            }
            if (!$info) {
                return response()->json(['success' => false, 'message' => '客户统计不存在'], 404);
            }
            if ($info->basic_id) {
                $this->service->syncBusinessToStatistics($info->basic_id);
                $info->refresh();
            }
            return response()->json(['success' => true, 'message' => '查询成功', 'data' => $info]);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 400);
        }
    }

    // 公司资质
    public function qualificationList()
    {
        $req = app(GyzRequest::class, ['query' => ['scene' => 'qualification-list']]);
        $valid = $req->validated();
        $data = $this->service->qualificationList($valid);
        return response()->json(['success' => true, 'message' => '查询成功', 'data' => $data]);
    }
    public function qualificationShow(int $id)
    {
        try {
            $info = $this->service->qualificationDetail($id);
            return response()->json(['success' => true, 'message' => '查询成功', 'data' => $info]);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 400);
        }
    }

    public function qualificationStore()
    {
        $req = app(GyzRequest::class, ['query' => ['scene' => 'qualification-store']]);
        $model = $this->service->qualificationCreate($req->validated());
        return response()->json(['success' => true, 'message' => '新增成功', 'data' => $model]);
    }
    public function qualificationUpdate(int $id)
    {
        $req = app(GyzRequest::class, ['query' => ['scene' => 'qualification-update']]);
        $model = $this->service->qualificationUpdate($id, $req->validated());
        return response()->json(['success' => true, 'message' => '更新成功', 'data' => $model]);
    }
    public function qualificationDestroy(int $id)
    {
        $this->service->qualificationDelete($id);
        return response()->json(['success' => true, 'message' => '删除成功']);
    }

 // ========== 客户财务 ==========
    public function financialIndex()
    {
        $req = app(GyzRequest::class, ['query' => ['scene' => 'financial-list']]);
        $valid = $req->validated();
        $data = $this->service->financialList($valid);
        return response()->json(['success' => true, 'message' => '查询成功', 'data' => $data]);
    }

    public function financialShow(int $id)
    {
        try {
            $info = $this->service->financialDetail($id);
            return response()->json(['success' => true, 'message' => '查询成功', 'data' => $info]);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 400);
        }
    }

    public function financialStore()
    {
        $req = app(GyzRequest::class, ['query' => ['scene' => 'financial-store']]);
        $model = $this->service->financialCreate($req->validated());
        return response()->json(['success' => true, 'message' => '新增成功', 'data' => $model]);
    }

    public function financialUpdate(int $id)
    {
        $req = app(GyzRequest::class, ['query' => ['scene' => 'financial-update']]);
        $model = $this->service->financialUpdate($id, $req->validated());
        return response()->json(['success' => true, 'message' => '更新成功', 'data' => $model]);
    }

    public function financialDestroy(int $id)
    {
        $this->service->financialDelete($id);
        return response()->json(['success' => true, 'message' => '删除成功']);
    }
}