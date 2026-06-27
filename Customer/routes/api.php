<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\LXController;
use App\Http\Controllers\WJCController;
use App\Http\Controllers\GyzController;

// WJCController
Route::middleware('auth:api')->group(function () {
    // 申请人接口（自定义路径，匹配文档）
    Route::get('applicant/list', [WJCController::class, 'index'])->name('applicant.index');
    Route::post('applicant/add', [WJCController::class, 'store'])->name('applicant.store');
    Route::put('applicant/edit', [WJCController::class, 'update'])->name('applicant.update');
    Route::get('applicant/info', [WJCController::class, 'show'])->name('applicant.show');
    Route::delete('applicant/del', [WJCController::class, 'destroy'])->name('applicant.destroy');

    // 发明人接口（自定义路径，匹配文档）
    Route::get('inventor/list', [WJCController::class, 'index'])->name('inventor.index');
    Route::post('inventor/add', [WJCController::class, 'store'])->name('inventor.store');
    Route::put('inventor/edit', [WJCController::class, 'update'])->name('inventor.update');
    Route::get('inventor/info', [WJCController::class, 'show'])->name('inventor.show');
    Route::delete('inventor/del', [WJCController::class, 'destroy'])->name('inventor.destroy');

    // 工商信息接口（RESTful，与文档一致）
    Route::resource('customer-business', WJCController::class)->names([
        'index'   => 'customer-business.index',
        'store'   => 'customer-business.store',
        'show'    => 'customer-business.show',
        'update'  => 'customer-business.update',
        'destroy' => 'customer-business.destroy',
    ])->parameters(['customer-business' => 'id']);

    // 企业信息接口（RESTful，与文档一致）
    Route::resource('customer-enterprises', WJCController::class)->names([
        'index'   => 'customer-enterprise.index',
        'store'   => 'customer-enterprise.store',
        'show'    => 'customer-enterprise.show',
        'update'  => 'customer-enterprise.update',
        'destroy' => 'customer-enterprise.destroy',
    ])->parameters(['customer-enterprises' => 'id']);
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

//GyzController
Route::middleware('auth:api')->group(function () {
    // 基本信息表
    Route::get('customer-basic', [GyzController::class, 'basicIndex']);
    Route::get('customer-basic/{id}', [GyzController::class, 'basicShow']);
    Route::post('customer-basic', [GyzController::class, 'basicStore']);
    Route::put('customer-basic/{id}', [GyzController::class, 'basicUpdate']);
    Route::delete('customer-basic/{id}', [GyzController::class, 'basicDestroy']);

    // 地址信息表
    Route::get('customer-address', [GyzController::class, 'addressIndex']);
    Route::get('customer-address/{id}', [GyzController::class, 'addressShow']);
    Route::post('customer-address', [GyzController::class, 'addressStore']);
    Route::put('customer-address/{id}', [GyzController::class, 'addressUpdate']);
    Route::delete('customer-address/{id}', [GyzController::class, 'addressDestroy']);

    // 费用信息表
    Route::get('customer-fee', [GyzController::class, 'feeIndex']);
    Route::get('customer-fee/{id}', [GyzController::class, 'feeShow']);
    Route::post('customer-fee', [GyzController::class, 'feeStore']);
    Route::put('customer-fee/{id}', [GyzController::class, 'feeUpdate']);
    Route::delete('customer-fee/{id}', [GyzController::class, 'feeDestroy']);
});

