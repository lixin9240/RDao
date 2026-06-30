<?php

namespace App\Repositories;

use App\Models\SysUser;
use Illuminate\Database\Eloquent\Collection;

class SysUserRepository
{
    public function find(int $id): ?SysUser
    {
        return SysUser::find($id);
    }

    public function searchActiveUsers(string $keyword, int $limit = 50): Collection
    {
        $query = SysUser::query()
            ->where('account_status', 1)
            ->where('employment_status', 1);

        if ($keyword) {
            $query->where(function ($q) use ($keyword) {
                $q->where('real_name', 'like', "%{$keyword}%")
                    ->orWhere('username', 'like', "%{$keyword}%");
            });
        }

        return $query->limit($limit)->get();
    }
}
