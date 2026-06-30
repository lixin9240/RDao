<?php

namespace App\Repositories;

use App\Models\CustomerIpRight;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class CustomerIpRightRepository
{
    public function find(int $id): ?CustomerIpRight
    {
        return CustomerIpRight::find($id);
    }

    public function paginate(array $params, int $perPage, int $page): LengthAwarePaginator
    {
        return CustomerIpRight::search($params)
            ->paginate($perPage, ['*'], 'page', $page);
    }

    public function create(array $data): CustomerIpRight
    {
        return CustomerIpRight::create($data);
    }

    public function update(CustomerIpRight $model, array $data): CustomerIpRight
    {
        $model->update($data);
        return $model;
    }

    public function delete(CustomerIpRight $model): void
    {
        $model->delete();
    }
}
