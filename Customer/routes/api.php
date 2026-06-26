<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\WJCController;
use App\Http\Controllers\InventorController;
use App\Http\Controllers\CustomerBusinessController;

// 申请人接口
Route::resource('applicant', WJCController::class)->names([
    'index'   => 'applicant.index',
    'store'   => 'applicant.store',
    'show'    => 'applicant.show',
    'update'  => 'applicant.update',
    'destroy' => 'applicant.destroy',
]);

// 发明人接口
Route::resource('inventor', WJCController::class)->names([
    'index'   => 'inventor.index',
    'store'   => 'inventor.store',
    'show'    => 'inventor.show',
    'update'  => 'inventor.update',
    'destroy' => 'inventor.destroy',
]);

// 工商信息接口
Route::resource('customer-business', WJCController::class)->names([
    'index'   => 'customer-business.index',
    'store'   => 'customer-business.store',
    'show'    => 'customer-business.show',
    'update'  => 'customer-business.update',
    'destroy' => 'customer-business.destroy',
]);