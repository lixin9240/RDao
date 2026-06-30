<?php

namespace App\Repositories;

use App\Models\FileCategory;
use Illuminate\Database\Eloquent\Collection;

class FileCategoryRepository
{
    public function getActiveOrdered(): Collection
    {
        return FileCategory::where('status', 1)
            ->orderBy('sort_order')
            ->get();
    }
}
