<?php

namespace App\Repositories;

use App\Models\CustomerContact;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class CustomerContactRepository
{
    public function find(int $id): ?CustomerContact
    {
        return CustomerContact::find($id);
    }

    public function findWithRelations(int $id): ?CustomerContact
    {
        return CustomerContact::with([
            'customer', 'businessPerson', 'assistant', 'techLeader', 'creator', 'updater',
        ])->find($id);
    }

    public function paginateWithRelations(array $params, int $perPage, int $page): LengthAwarePaginator
    {
        return CustomerContact::with(['customer', 'businessPerson'])
            ->search($params)
            ->paginate($perPage, ['*'], 'page', $page);
    }

    public function create(array $data): CustomerContact
    {
        return CustomerContact::create($data);
    }

    public function update(CustomerContact $model, array $data): CustomerContact
    {
        $model->update($data);
        return $model;
    }

    public function delete(CustomerContact $model): void
    {
        $model->delete();
    }

    public function distinctContactTypes(?string $keyword = null): array
    {
        $query = CustomerContact::query()
            ->select('contact_type')
            ->distinct();

        if ($keyword) {
            $query->where('contact_type', 'like', "%{$keyword}%");
        }

        return $query->get()->pluck('contact_type')->toArray();
    }
}
