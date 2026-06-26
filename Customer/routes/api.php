<?php

use App\Http\Controllers\LXController;
use Illuminate\Support\Facades\Route;

Route::prefix('v1')->group(function () {
    Route::apiResource('users', LXController::class)->only(['store', 'show', 'update']);
});
