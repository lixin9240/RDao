<?php

namespace App\Repositories;

use App\Models\CustomerEnterpriseInvestment;

class EnterpriseInvestmentRepository
{
    public function find(int $id): ?CustomerEnterpriseInvestment
    {
        return CustomerEnterpriseInvestment::find($id);
    }

    public function list(array $params)
    {
        $page = $params['page'] ?? 1;
        $perPage = $params['per_page'] ?? 15;

        $query = CustomerEnterpriseInvestment::with('customer');

        if (! empty($params['customerId'])) {
            $query->where('customer_id', $params['customerId']);
        }

        if (! empty($params['year'])) {
            $query->where('year', $params['year']);
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

    public function create(array $data): CustomerEnterpriseInvestment
    {
        return CustomerEnterpriseInvestment::create($data);
    }

    public function update(int $id, array $data): CustomerEnterpriseInvestment
    {
        $model = $this->find($id);
        if (! $model) {
            throw new \Exception('记录不存在');
        }
        $model->update($data);
        return $model;
    }

    public function delete(int $id): void
    {
        $model = $this->find($id);
        if (! $model) {
            throw new \Exception('记录不存在');
        }
        $model->delete();
    }
}
