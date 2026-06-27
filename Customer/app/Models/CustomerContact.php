<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CustomerContact extends Model
{
    protected $table = 'customer_contacts';

    protected $fillable = [
        'innovation_entity_id',
        'contact_type',
        'name',
        'phone',
        'landline',
        'is_active',
        'position',
        'email',
        'sales_rep_id',
        'sales_assistant_id',
        'tech_lead_dept',
        'tech_lead_id',
        'work_address',
        'notes',
        'created_by',
        'updated_by',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    public function scopeSearch($query, $params)
    {
        if (! empty($params['contactName'])) {
            $query->where('name', 'like', "%{$params['contactName']}%");
        }

        if (! empty($params['customerName'])) {
            $query->whereHas('customer', function ($q) use ($params) {
                $q->where('innovation_subject', 'like', "%{$params['customerName']}%");
            });
        }

        if (! empty($params['contactType'])) {
            $query->where('contact_type', $params['contactType']);
        }

        if (! empty($params['businessPerson'])) {
            $query->whereHas('businessPerson', function ($q) use ($params) {
                $q->where('real_name', 'like', "%{$params['businessPerson']}%");
            });
        }

        return $query->orderBy('created_at', 'desc');
    }

    public function customer()
    {
        return $this->belongsTo(CustomerBasic::class, 'innovation_entity_id');
    }

    public function businessPerson()
    {
        return $this->belongsTo(SysUser::class, 'sales_rep_id');
    }

    public function assistant()
    {
        return $this->belongsTo(SysUser::class, 'sales_assistant_id');
    }

    public function techLeader()
    {
        return $this->belongsTo(SysUser::class, 'tech_lead_id');
    }

    public function creator()
    {
        return $this->belongsTo(SysUser::class, 'created_by');
    }

    public function updater()
    {
        return $this->belongsTo(SysUser::class, 'updated_by');
    }
}
