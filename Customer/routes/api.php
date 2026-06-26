<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\LXController;
use App\Http\Controllers\WJCController;
use App\Http\Controllers\GyzController;


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

// LXController 独立v1分组
Route::prefix('v1')->group(function () {
    Route::apiResource('users', LXController::class)->only(['store', 'show', 'update']);

});

// 客户基础信息
Route::resource('customer-basics', GyzController::class)
    ->only(['index','show','store','update','destroy'])
    ->names([
        'index'   => 'customer-basics.index',
        'show'    => 'customer-basics.show',
        'store'   => 'customer-basics.store',
        'update'  => 'customer-basics.update',
        'destroy' => 'customer-basics.destroy'
    ]);

// 客户地址
Route::resource('customer-addresses', GyzController::class)
    ->only(['index','show','store','update','destroy'])
    ->names([
        'index'   => 'customer-addresses.index',
        'show'    => 'customer-addresses.show',
        'store'   => 'customer-addresses.store',
        'update'  => 'customer-addresses.update',
        'destroy' => 'customer-addresses.destroy'
    ]);

// 客户费用
Route::resource('customer-fees', GyzController::class)
    ->only(['index','show','store','update','destroy'])
    ->names([
        'index'   => 'customer-fees.index',
        'show'    => 'customer-fees.show',
        'store'   => 'customer-fees.store',
        'update'  => 'customer-fees.update',
        'destroy' => 'customer-fees.destroy'
    ]);
