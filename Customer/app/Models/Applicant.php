<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;

class Applicant extends Model
{
    use HasFactory;

    protected $table = 'applicant';

    public $timestamps = true;

    const CREATED_AT = 'create_time';
    const UPDATED_AT = 'update_time';

    protected $guarded = [];

    protected $casts = [
        'fee_reduction_filing' => 'integer',
        'fee_reduction_start'  => 'date',
        'fee_reduction_end'    => 'date',
        'sync_date'            => 'date',
        'create_time'          => 'datetime',
        'update_time'          => 'datetime',
    ];

    protected static function booted(): void
    {
        static::addGlobalScope('notDeleted', function (Builder $builder) {
            $builder->where('is_deleted', 0);
        });
    }
}