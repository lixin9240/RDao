<?php

namespace App\Repositories;

use App\Models\FileDescription;
use Illuminate\Database\Eloquent\Collection;

class FileDescriptionRepository
{
    public function getActiveOrdered(?string $keyword = null): Collection
    {
        return FileDescription::where('status', 1)
            ->when($keyword, function ($q) use ($keyword) {
                $q->where('file_name_template', 'like', "%{$keyword}%");
            })
            ->orderBy('sort_order')
            ->get();
    }
}
