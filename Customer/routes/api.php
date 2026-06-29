<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\LXController;
use App\Http\Controllers\WJCController;
use App\Http\Controllers\GyzController;
use App\Http\Controllers\FmyController;

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

    Route::middleware('auth:api')->group(function () {
        Route::apiResource('users', LXController::class)->only(['index', 'store', 'show', 'update', 'destroy']);
        // 用户列表、新增用户、获取用户详情、修改用户、删除用户

        // 部门管理
        Route::get('depts/tree', [LXController::class, 'deptTree']);// 获取部门树形结构
        Route::post('depts', [LXController::class, 'storeDept']);// 新增部门
        Route::get('depts/{id}', [LXController::class, 'showDept']);// 获取部门详情
        Route::put('depts/{id}', [LXController::class, 'updateDept']);// 修改部门

        // 菜单管理
        Route::post('menus', [LXController::class, 'storeMenu']);// 创建菜单
        Route::get('menus/tree', [LXController::class, 'menuTree']);// 获取菜单树形结构

        // 角色管理、菜单分配
        Route::post('roles', [LXController::class, 'storeRole']);// 创建角色
        Route::get('roles', [LXController::class, 'roleList']);// 获取角色列表
        Route::get('roles/{id}/menus', [LXController::class, 'roleMenus']);// 获取角色菜单列表
        Route::put('roles/{id}/menus', [LXController::class, 'assignMenus']);// 分配角色菜单
        Route::get('roles/{id}', [LXController::class, 'roleDetail']);// 获取角色详情
        Route::put('roles/{id}', [LXController::class, 'updateRole']);// 修改角色
        Route::delete('roles/{id}', [LXController::class, 'destroyRole']);// 删除角色

        // 字典管理
        // 客户等级
        Route::get('customer-levels', [LXController::class, 'customerLevelList']);// 获取客户等级列表
        Route::post('customer-levels', [LXController::class, 'customerLevelStore']);// 创建客户等级
        Route::put('customer-levels/{id}', [LXController::class, 'customerLevelUpdate']);// 修改客户等级
        Route::delete('customer-levels/{id}', [LXController::class, 'customerLevelDestroy']);// 删除客户等级

        // 客户规模
        Route::get('customer-scales', [LXController::class, 'customerScaleList']);// 获取客户规模列表
        Route::post('customer-scales', [LXController::class, 'customerScaleStore']);// 创建客户规模
        Route::put('customer-scales/{id}', [LXController::class, 'customerScaleUpdate']);// 修改客户规模
        Route::delete('customer-scales/{id}', [LXController::class, 'customerScaleDestroy']);// 删除客户规模

        // 文件描述
        Route::get('file-descriptions', [LXController::class, 'fileDescriptionList']);// 获取文件描述列表
        Route::post('file-descriptions', [LXController::class, 'fileDescriptionStore']);// 创建文件描述
        Route::put('file-descriptions/{id}', [LXController::class, 'fileDescriptionUpdate']);// 修改文件描述
        Route::delete('file-descriptions/{id}', [LXController::class, 'fileDescriptionDestroy']);// 删除文件描述

        // 文件分类
        Route::get('file-categories', [LXController::class, 'fileCategoryList']);// 获取文件分类列表
        Route::post('file-categories', [LXController::class, 'fileCategoryStore']);// 创建文件分类
        Route::put('file-categories/{id}', [LXController::class, 'fileCategoryUpdate']);// 修改文件分类
        Route::delete('file-categories/{id}', [LXController::class, 'fileCategoryDestroy']);// 删除文件分类

        // 价格指数
        Route::get('price-indexes', [LXController::class, 'priceIndexList']);// 获取价格指数列表
        Route::post('price-indexes', [LXController::class, 'priceIndexStore']);// 创建价格指数
        Route::put('price-indexes/{id}', [LXController::class, 'priceIndexUpdate']);// 修改价格指数
        Route::delete('price-indexes/{id}', [LXController::class, 'priceIndexDestroy']);// 删除价格指数

        // 创新指数
        Route::get('innovation-indexes', [LXController::class, 'innovationIndexList']);// 获取创新指数列表
        Route::post('innovation-indexes', [LXController::class, 'innovationIndexStore']);// 创建创新指数
        Route::put('innovation-indexes/{id}', [LXController::class, 'innovationIndexUpdate']);// 修改创新指数
        Route::delete('innovation-indexes/{id}', [LXController::class, 'innovationIndexDestroy']);// 删除创新指数

        // 工业园区
        Route::get('industrial-parks', [LXController::class, 'industrialParkList']);// 获取工业园区列表
        Route::post('industrial-parks', [LXController::class, 'industrialParkStore']);// 创建工业园区
        Route::put('industrial-parks/{id}', [LXController::class, 'industrialParkUpdate']);// 修改工业园区
        Route::delete('industrial-parks/{id}', [LXController::class, 'industrialParkDestroy']);// 删除工业园区

        // 国家/地区
        Route::get('countries', [LXController::class, 'countryList']);// 获取国家/地区列表

        // 行业分类
        Route::get('industry-categories', [LXController::class, 'industryCategoryList']);// 获取行业分类列表

        // 企业类型
        Route::get('enterprise-types', [LXController::class, 'enterpriseTypeList']);// 获取企业类型列表

        // 省市区
        Route::get('regions', [LXController::class, 'regionList']);// 获取省市区列表
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

    // 客户统计
    Route::get('customer-statistics', [GyzController::class, 'statisticsIndex']);
    Route::get('customer-statistics/{id}', [GyzController::class, 'statisticsShow']);
    Route::post('customer-statistics', [GyzController::class, 'statisticsStore']);
    Route::put('customer-statistics/{id}', [GyzController::class, 'statisticsUpdate']);
    Route::delete('customer-statistics/{id}', [GyzController::class, 'statisticsDestroy']);

    // 公司资质
    Route::get('customer-qualifications', [GyzController::class, 'qualificationIndex']);
    Route::get('customer-qualifications/{id}', [GyzController::class, 'qualificationShow']);
    Route::post('customer-qualifications', [GyzController::class, 'qualificationStore']);
    Route::put('customer-qualifications/{id}', [GyzController::class, 'qualificationUpdate']);
    Route::delete('customer-qualifications/{id}', [GyzController::class, 'qualificationDestroy']);
});

// FmyController
Route::middleware('auth:api')->group(function () {
    // 知识产权信息表
    Route::get('customer-ip-rights', [FmyController::class, 'ipRightIndex']);
    Route::get('customer-ip-rights/{id}', [FmyController::class, 'ipRightShow']);
    Route::post('customer-ip-rights', [FmyController::class, 'ipRightStore']);
    Route::put('customer-ip-rights/{id}', [FmyController::class, 'ipRightUpdate']);
    Route::delete('customer-ip-rights/{id}', [FmyController::class, 'ipRightDestroy']);

    // 客户文件信息表
    Route::get('customer/files', [FmyController::class, 'customerFileIndex']);
    Route::post('customer/files', [FmyController::class, 'customerFileStore']);
    Route::get('customer/files/types/tree', [FmyController::class, 'customerFileTree']);
    Route::get('customer/files/view/{id}', [FmyController::class, 'customerFileView']);
    Route::get('customer/files/download/{id}', [FmyController::class, 'customerFileDownload']);
    Route::delete('customer/files/{id}', [FmyController::class, 'customerFileDestroy']);

    // 客户下拉选项
    Route::get('customer/options', [FmyController::class, 'customerOptions']);

    // 通用文件上传
    Route::post('file/upload', [FmyController::class, 'fileUpload']);

    // 联系人信息表
    Route::get('contacts', [FmyController::class, 'contactIndex']);
    Route::post('contacts', [FmyController::class, 'contactStore']);
    Route::get('contacts/{id}', [FmyController::class, 'contactShow']);
    Route::put('customer/contact/{id}', [FmyController::class, 'contactUpdate']);

    // 各类下拉查询
    Route::get('innovation-subjects/options', [FmyController::class, 'innovationSubjectsOptions']);
    Route::get('contact-types/options', [FmyController::class, 'contactTypesOptions']);
    Route::get('staff/options', [FmyController::class, 'staffOptions']);
    Route::get('assistant/options', [FmyController::class, 'assistantOptions']);
    Route::get('tech-leaders/options', [FmyController::class, 'techLeadersOptions']);
});

