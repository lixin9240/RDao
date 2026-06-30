<?php
// 工业园区模型
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class IndustrialPark extends Model
{
    use Traits\DictModelTrait;

    protected $table = 'sys_industrial_park';

    protected $fillable = [
        'sort_order',      // 排序权重
        'park_name',       // 园区名称
        'park_code',       // 园区编码
        'address',         // 园区地址
        'contact_person',  // 联系人
        'contact_phone',   // 联系电话
        'description',     // 描述
        'status',          // 状态：1-有效，0-无效
        'updated_by',      // 更新人ID
    ];
}
