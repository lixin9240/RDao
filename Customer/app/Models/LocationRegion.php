<?php
// 位置区域模型
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class LocationRegion extends Model
{
    protected $table = 'sys_location_region';

    protected $fillable = [
        'parent_id',    // 父级区域ID
        'region_name',  // 区域名称
        'region_type',  // 区域类型：1-省份，2-城市，3-区县，4-园区
        'region_code',  // 区域编码
        'level',        // 层级深度
        'status',       // 状态：1-有效，0-无效
        'sort_order',   // 排序权重
    ];
}
