<?php

namespace App\Repositories;

use App\Models\CustomerEnterpriseInvestment;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class EnterpriseInvestmentRepository
{
    public function find(int $id): ?CustomerEnterpriseInvestment
    {
        return CustomerEnterpriseInvestment::find($id);
    }

    public function findWithRelations(int $id): ?CustomerEnterpriseInvestment
    {
        return CustomerEnterpriseInvestment::with(['customer', 'creator', 'updater'])->find($id);
    }

    public function paginateWithRelations(array $params, int $perPage, int $page): LengthAwarePaginator
    {
        $query = CustomerEnterpriseInvestment::with('customer');

        if (! empty($params['customerId'])) {
            $query->where('customer_id', (int) $params['customerId']);
        }

        if (! empty($params['year'])) {
            $query->where('year', (int) $params['year']);
        }

        if (! empty($params['search'])) {
            $query->whereHas('customer', function ($q) use ($params) {
                $q->where('innovation_subject', 'like', "%{$params['search']}%")
                    ->orWhere('customer_no', 'like', "%{$params['search']}%");
            });
        }

        $sort = $params['sort'] ?? 'created_at';
        $order = $params['order'] ?? 'desc';

        return $query->orderBy($sort, $order)
            ->paginate($perPage, ['*'], 'page', $page);
    }

    public function existsByCustomerAndYear(int $customerId, int $year, ?int $excludeId = null): bool
    {
        $query = CustomerEnterpriseInvestment::query()
            ->where('customer_id', $customerId)
            ->where('year', $year);

        if ($excludeId) {
            $query->where('id', '!=', $excludeId);
        }

        return $query->exists();
    }

    public function create(array $data): CustomerEnterpriseInvestment
    {
        return CustomerEnterpriseInvestment::create($data);
    }

    public function update(CustomerEnterpriseInvestment $model, array $data): CustomerEnterpriseInvestment
    {
        $model->update($data);
        return $model;
    }

    public function delete(CustomerEnterpriseInvestment $model): void
    {
        $model->delete();
    }
}
