<?php
namespace App\Services;
use App\Models\{CustomerBasic,CustomerAddress,CustomerFee,CustomerStatistics,CustomerBusiness,CustomerFinancial};

class GyzService
{
    // 客户基础信息
    public function basicList(array $params): array
    {
        $page = $params['page'] ?? 1;
        $perPage = $params['per_page'] ?? 15;
        $paginate = CustomerBasic::search($params)
            ->paginate($perPage, ['*'], 'page', $page);
        return [
            'data' => $paginate->items(),
            'meta' => [
                'current_page' => $paginate->currentPage(),
                'per_page'     => $paginate->perPage(),
                'total'        => $paginate->total(),
                'last_page'    => $paginate->lastPage()
            ]
        ];
    }

    public function basicDetail(int $id)
    {
        $row = CustomerBasic::find($id);
        if (!$row) throw new \Exception('客户基础信息不存在');
        return $row;
    }

    public function basicCreate(array $data)
    {
        return CustomerBasic::create($data);
    }

    public function basicUpdate(int $id, array $data)
    {
        $model = $this->basicDetail($id);
        $model->update($data);
        return $model;
    }

    public function basicDelete(int $id): void
    {
        $this->basicDetail($id)->delete();
    }

    // 客户地址信息
    public function addressList(array $params): array
    {
        $page = $params['page'] ?? 1;
        $perPage = $params['per_page'] ?? 15;
        $paginate = CustomerAddress::search($params)
            ->paginate($perPage, ['*'], 'page', $page);
        return [
            'data' => $paginate->items(),
            'meta' => [
                'current_page' => $paginate->currentPage(),
                'per_page'     => $paginate->perPage(),
                'total'        => $paginate->total(),
                'last_page'    => $paginate->lastPage()
            ]
        ];
    }

    public function addressDetail(int $id)
    {
        $row = CustomerAddress::find($id);
        if (!$row) throw new \Exception('客户地址信息不存在');
        return $row;
    }

    public function addressCreate(array $data)
    {
        return CustomerAddress::create($data);
    }

    public function addressUpdate(int $id, array $data)
    {
        $model = $this->addressDetail($id);
        $model->update($data);
        return $model;
    }

    public function addressDelete(int $id): void
    {
        $this->addressDetail($id)->delete();
    }

    // 客户费用信息
    public function feeList(array $params): array
    {
        $page = $params['page'] ?? 1;
        $perPage = $params['per_page'] ?? 15;
        $paginate = CustomerFee::search($params)
            ->paginate($perPage, ['*'], 'page', $page);
        return [
            'data' => $paginate->items(),
            'meta' => [
                'current_page' => $paginate->currentPage(),
                'per_page'     => $paginate->perPage(),
                'total'        => $paginate->total(),
                'last_page'    => $paginate->lastPage()
            ]
        ];
    }

    public function feeDetail(int $id)
    {
        $row = CustomerFee::find($id);
        if (!$row) throw new \Exception('客户费用信息不存在');
        return $row;
    }

    public function feeCreate(array $data)
    {
        return CustomerFee::create($data);
    }

    public function feeUpdate(int $id, array $data)
    {
        $model = $this->feeDetail($id);
        $model->update($data);
        return $model;
    }

    public function feeDelete(int $id): void
    {
        $this->feeDetail($id)->delete();
    }

    // ========== 客户统计 ==========
    public function statisticsList(array $params): array
    {
        $page = $params['page'] ?? 1;
        $perPage = $params['per_page'] ?? 15;
        $paginate = CustomerStatistics::search($params)
            ->paginate($perPage, ['*'], 'page', $page);
        return [
            'data' => $paginate->items(),
            'meta' => [
                'current_page' => $paginate->currentPage(),
                'per_page'     => $paginate->perPage(),
                'total'        => $paginate->total(),
                'last_page'    => $paginate->lastPage()
            ]
        ];
    }

    public function statisticsDetail(int $id)
    {
        $row = CustomerStatistics::find($id);
        if (!$row) throw new \Exception('客户统计不存在');
        return $row;
    }

    public function statisticsCreate(array $data)
    {
        $basicId = $data['basic_id'] ?? null;
        if ($basicId) {
            $this->syncBusinessToStatistics($basicId);
            $existing = CustomerStatistics::where('basic_id', $basicId)->first();
            if ($existing) {
                $existing->update($data);
                return $existing;
            }
        }
        return CustomerStatistics::create($data);
    }

    /**
     * 将工商信息表的数据同步到客户统计表
     */
    public function syncBusinessToStatistics(int $basicId): void
    {
        $business = CustomerBusiness::where('basic_id', $basicId)->first();
        if (!$business) {
            return;
        }
        $statistics = CustomerStatistics::where('basic_id', $basicId)->first();
        $statisticsData = $this->buildStatisticsFromBusiness($business);
        if ($statistics) {
            $statistics->update($statisticsData);
        } else {
            CustomerStatistics::create(array_merge($statisticsData, [
                'basic_id' => $basicId,
                'creator' => auth('api')->user()->real_name ?? 'system',
            ]));
        }
    }

    /**
     * 从工商信息构建统计数据
     */
    protected function buildStatisticsFromBusiness(CustomerBusiness $business): array
    {
        return [
            'economy_category'       => $business->economy_category,
            'economy_large_category' => $business->economy_large_category,
            'economy_mid_category'   => $business->economy_mid_category,
            'economy_sub_category'   => $business->economy_sub_category,
        ];
    }

    /**
     * 根据客户ID获取或创建统计记录（带工商数据同步）
     */
    public function getOrCreateStatistics(int $basicId): CustomerStatistics
    {
        $this->syncBusinessToStatistics($basicId);
        return CustomerStatistics::where('basic_id', $basicId)->first();
    }

    /**
     * 根据客户ID列表获取统计列表（支持工商数据筛选）
     */
    public function statisticsListByBasicIds(array $basicIds, array $params = []): array
    {
        $page = $params['page'] ?? 1;
        $perPage = $params['per_page'] ?? 15;
        $query = CustomerStatistics::whereIn('basic_id', $basicIds);
        if (!empty($params['search'])) {
            $term = $params['search'];
            $query->where(function ($q) use ($term) {
                $q->where('economy_category', 'like', "%{$term}%")
                    ->orWhere('economy_sub_category', 'like', "%{$term}%")
                    ->orWhere('economy_large_category', 'like', "%{$term}%")
                    ->orWhere('economy_mid_category', 'like', "%{$term}%");
            });
        }
        $sort = $params['sort'] ?? 'created_at';
        $order = $params['order'] ?? 'desc';
        $paginate = $query->orderBy($sort, $order)->paginate($perPage, ['*'], 'page', $page);
        return [
            'data' => $paginate->items(),
            'meta' => [
                'current_page' => $paginate->currentPage(),
                'per_page'     => $paginate->perPage(),
                'total'        => $paginate->total(),
                'last_page'    => $paginate->lastPage()
            ]
        ];
    }

    public function statisticsUpdate(int $id, array $data)
    {
        $model = $this->statisticsDetail($id);
        $model->update($data);
        return $model;
    }

    public function statisticsDelete(int $id): void
    {
        $this->statisticsDetail($id)->delete();
    }

    // ========== 客户财务 ==========
    public function financialList(array $params): array
    {
        $page = $params['page'] ?? 1;
        $perPage = $params['per_page'] ?? 15;
        $query = CustomerFinancial::query();
        if (!empty($params['basic_id'])) {
            $query->where('basic_id', $params['basic_id']);
        }
        $sort = $params['sort'] ?? 'created_at';
        $order = $params['order'] ?? 'desc';
        $paginate = $query->orderBy($sort, $order)->paginate($perPage, ['*'], 'page', $page);
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

    public function financialDetail(int $id)
    {
        // 支持按 basic_id 或主键 id 查询
        $row = CustomerFinancial::where('basic_id', $id)->first()
            ?? CustomerFinancial::find($id);
        if (!$row) throw new \Exception('客户财务信息不存在');
        return $row;
    }

    public function financialCreate(array $data)
    {
        $basicId = $data['basic_id'] ?? null;
        if ($basicId) {
            $existing = CustomerFinancial::where('basic_id', $basicId)->first();
            if ($existing) {
                $existing->update($data);
                return $existing;
            }
        }
        return CustomerFinancial::create($data);
    }

    public function financialUpdate(int $id, array $data)
    {
        $model = $this->financialDetail($id);
        $model->update($data);
        return $model;
    }

    public function financialDelete(int $id): void
    {
        $this->financialDetail($id)->delete();
    }
}
