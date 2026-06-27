<?php
namespace App\Services;
use App\Models\{CustomerBasic,CustomerAddress,CustomerFee};

class GyzService
{
    // ====================== 客户基础信息 ======================
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

    // ====================== 客户地址信息 ======================
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

    // ====================== 客户费用信息 ======================
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
}
