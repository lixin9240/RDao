<?php

namespace App\Repositories;

use App\Models\CustomerFile;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class CustomerFileRepository
{
    public function find(int $id): ?CustomerFile
    {
        return CustomerFile::find($id);
    }

    public function findWithRelations(int $id): ?CustomerFile
    {
        return CustomerFile::with(['customer', 'creator', 'category'])->find($id);
    }

    public function paginateWithRelations(array $params, int $perPage, int $page): LengthAwarePaginator
    {
        return CustomerFile::with(['customer', 'creator', 'category'])
            ->search($params)
            ->paginate($perPage, ['*'], 'page', $page);
    }

    public function create(array $data): CustomerFile
    {
        return CustomerFile::create($data);
    }

    public function update(CustomerFile $model, array $data): CustomerFile
    {
        $model->update($data);
        return $model;
    }

    public function delete(CustomerFile $model): void
    {
        $model->delete();
    }
}
