<?php

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;

abstract class Controller
{
    /**
     * 成功响应
     */
    protected function success(mixed $data = null, string $message = 'success'): JsonResponse
    {
        return response()->json([
            'code' => 0,
            'message' => $message,
            'data' => $data,
        ]);
    }

    /**
     * 错误响应
     */
    protected function error(string $message = 'error', int $code = 1, mixed $data = null): JsonResponse
    {
        return response()->json([
            'code' => $code,
            'message' => $message,
            'data' => $data,
        ]);
    }
}