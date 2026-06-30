<?php

namespace App\Repositories;

use App\Models\CustomerBasic;
use Illuminate\Database\Eloquent\Collection;

class CustomerBasicRepository
{
    public function searchOptions(string $keyword, int $limit = 50): Collection
    {
        $query = CustomerBasic::query();

        if ($keyword) {
            $query->where('innovation_subject', 'like', "%{$keyword}%")
                ->orWhere('customer_no', 'like', "%{$keyword}%");
        }

        return $query->limit($limit)->get();
    }

    public function searchByKeyword(string $keyword, int $limit = 50): Collection
    {
        $query = CustomerBasic::query();

        if ($keyword) {
            $query->where('innovation_subject', 'like', "%{$keyword}%");
        }

        return $query->limit($limit)->get();
    }
}
