<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CustomerEnterpriseInvestment extends Model
{
    protected $table = 'customer_enterprise_investments';

    protected $fillable = [
        'customer_id',
        'year',
        'has_audit_report',
        'rd_equipment_original_value',
        'equipment_investment',
        'informatization_investment',
        'has_imported_equipment',
        'asset_liability_ratio',
        'smart_equipment_investment',
        'filing_amount',
        'has_investment_filing',
        'fixed_asset_investment',
        'rd_equipment_investment',
        'filing_start_date',
        'filing_end_date',
        'created_by',
        'updated_by',
    ];

    protected $casts = [
        'has_audit_report' => 'boolean',
        'has_imported_equipment' => 'boolean',
        'has_investment_filing' => 'boolean',
        'rd_equipment_original_value' => 'decimal:2',
        'equipment_investment' => 'decimal:2',
        'informatization_investment' => 'decimal:2',
        'asset_liability_ratio' => 'decimal:2',
        'smart_equipment_investment' => 'decimal:2',
        'filing_amount' => 'decimal:2',
        'fixed_asset_investment' => 'decimal:2',
        'rd_equipment_investment' => 'decimal:2',
        'filing_start_date' => 'date',
        'filing_end_date' => 'date',
    ];

    public function customer()
    {
        return $this->belongsTo(CustomerBasic::class, 'customer_id');
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
