<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\LXController;
use App\Http\Controllers\WJCController;

// WJCController 路由组（需认证）
Route::middleware('auth:api')->group(function () {
    Route::resource('applicant', WJCController::class);
    Route::resource('inventor', WJCController::class);
    Route::resource('customer-business', WJCController::class);
});

// LXController 独立v1分组
Route::prefix('v1')->group(function () {
    // 登录（无需认证）
    Route::post('login', [LXController::class, 'login']);

    // 以下接口均需 JWT 认证
    Route::middleware('auth:api')->group(function () {
        Route::apiResource('users', LXController::class)->only(['store', 'show', 'update']);// 新增用户、获取用户详情、修改用户

        // 部门管理
        Route::get('depts/tree', [LXController::class, 'deptTree']);// 获取部门树形结构
        Route::post('depts', [LXController::class, 'storeDept']);// 新增部门
        Route::put('depts/{id}', [LXController::class, 'updateDept']);// 修改部门

        // 菜单管理
        Route::get('menus/tree', [LXController::class, 'menuTree']);// 获取菜单树形结构

        // 角色管理、菜单分配
        Route::post('roles', [LXController::class, 'storeRole']);// 创建角色
        Route::get('roles', [LXController::class, 'roleList']);// 获取角色列表
        Route::get('roles/{id}/menus', [LXController::class, 'roleMenus']);// 获取角色菜单列表
        Route::put('roles/{id}/menus', [LXController::class, 'assignMenus']);// 分配角色菜单
        Route::get('roles/{id}', [LXController::class, 'roleDetail']);// 获取角色详情
        Route::put('roles/{id}', [LXController::class, 'updateRole']);// 修改角色
        Route::delete('roles/{id}', [LXController::class, 'destroyRole']);// 删除角色
    });
});