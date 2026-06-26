<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\LXController;
use App\Http\Controllers\WJCController;

// WJCController 路由组
Route::resource('applicant', WJCController::class);
Route::resource('inventor', WJCController::class);
Route::resource('customer-business', WJCController::class);

// LXController 独立v1分组
Route::prefix('v1')->group(function () {
    Route::post('login', [LXController::class, 'login']);
    Route::apiResource('users', LXController::class)->only(['store', 'show', 'update']);// 新增用户、获取用户详情、修改用户
});