<?php

namespace App\Services;

use App\Models\Applicant;
use App\Models\CustomerBusiness;
use App\Models\Inventor;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;

class WJCService
{
    private function paginate(Builder $query, int $page, int $limit): array
    {
        $total = $query->count();
        $pages = max(1, (int) ceil($total / $limit));

        $list = $query->orderByDesc('id')
            ->offset(($page - 1) * $limit)
            ->limit($limit)
            ->get();

        return [
            'total'        => $total,
            'pages'        => $pages,
            'current_page' => $page,
            'list'         => $list,
        ];
    }

    private function updateModel(string $modelClass, int $id, array $data): bool
    {
        $item = $modelClass::find($id);
        return $item ? $item->update($data) : false;
    }

    private function softDelete(string $modelClass, int $id): bool
    {
        $item = $modelClass::find($id);
        return $item ? $item->update(['is_deleted' => 1]) : false;
    }

    public function applicantList(Request $request): array
    {
        $query = Applicant::query()->where('is_deleted', $request->input('is_deleted', 0));

        if ($request->filled('customer_name')) {
            $query->where('customer_name', 'like', '%' . $request->input('customer_name') . '%');
        }
        if ($request->filled('applicant_name_cn')) {
            $query->where('applicant_name_cn', 'like', '%' . $request->input('applicant_name_cn') . '%');
        }
        if ($request->filled('applicant_type')) {
            $query->where('applicant_type', $request->input('applicant_type'));
        }

        return $this->paginate(
            $query,
            (int) $request->input('page', 1),
            (int) $request->input('limit', 10)
        );
    }

    public function applicantStore(array $data): Applicant
    {
        $data['applicant_no'] = 'AP-' . date('Ymd') . '-' . mt_rand(10000, 99999);
        return Applicant::create($data);
    }

    public function applicantFind(int $id): ?Applicant
    {
        return Applicant::find($id);
    }

    public function applicantUpdate(int $id, array $data): bool
    {
        return $this->updateModel(Applicant::class, $id, $data);
    }

    public function applicantDelete(int $id): bool
    {
        return $this->softDelete(Applicant::class, $id);
    }

    public function inventorList(Request $request): array
    {
        $query = Inventor::query()->where('is_deleted', $request->input('is_deleted', 0));

        if ($request->filled('customer_name')) {
            $query->where('customer_name', 'like', '%' . $request->input('customer_name') . '%');
        }
        if ($request->filled('name')) {
            $query->where('name', 'like', '%' . $request->input('name') . '%');
        }

        return $this->paginate(
            $query,
            (int) $request->input('page', 1),
            (int) $request->input('limit', 10)
        );
    }

    public function inventorStore(array $data): Inventor
    {
        $data['inventor_no'] = 'IV-' . date('Ymd') . '-' . mt_rand(10000, 99999);
        return Inventor::create($data);
    }

    public function inventorFind(int $id): ?Inventor
    {
        return Inventor::find($id);
    }

    public function inventorUpdate(int $id, array $data): bool
    {
        return $this->updateModel(Inventor::class, $id, $data);
    }

    public function inventorDelete(int $id): bool
    {
        return $this->softDelete(Inventor::class, $id);
    }

    public function businessList(Request $request): array
    {
        $query = CustomerBusiness::query();

        if ($request->filled('search')) {
            $search = $request->input('search');
            $query->where(function (Builder $q) use ($search) {
                $q->where('economy_category_code', 'like', "%{$search}%")
                  ->orWhere('main_business_product', 'like', "%{$search}%")
                  ->orWhere('business_scope', 'like', "%{$search}%");
            });
        }

        $page    = (int) $request->input('page', 1);
        $perPage = (int) $request->input('per_page', 15);
        $sort    = $request->input('sort', 'created_at');
        $order   = $request->input('order', 'desc');

        $data = $query->orderBy($sort, $order)->paginate($perPage, ['*'], 'page', $page);

        return [
            'data' => $data->items(),
            'meta' => [
                'current_page' => $data->currentPage(),
                'per_page'     => $data->perPage(),
                'total'        => $data->total(),
                'last_page'    => $data->lastPage(),
            ],
        ];
    }

    public function businessStore(array $data): CustomerBusiness
    {
        return CustomerBusiness::create($data);
    }

    public function businessFind(int $id): ?CustomerBusiness
    {
        return CustomerBusiness::find($id);
    }

    public function businessUpdate(int $id, array $data): bool
    {
        return $this->updateModel(CustomerBusiness::class, $id, $data);
    }

    public function businessDelete(int $id): bool
    {
        $item = CustomerBusiness::find($id);
        return $item ? $item->delete() : false;
    }
}
