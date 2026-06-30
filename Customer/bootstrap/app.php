<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Http\Request;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Validation\ValidationException;
use Illuminate\Auth\Access\AuthorizationException;
use App\Exceptions\NotFoundException;
use App\Exceptions\BusinessException;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: __DIR__.'/../routes/api.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function ($middleware): void {
        $middleware->redirectGuestsTo(fn () => null);
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        $exceptions->shouldRenderJsonWhen(
            fn (Request $request) => $request->is('api/*'),
        );

        $exceptions->render(function (AuthenticationException $e, Request $request) {
            if ($request->is('api/*')) {
                return response()->json([
                    'code' => 401,
                    'message' => '未登录或登录已过期',
                    'data' => null,
                ], 401);
            }
        });

        $exceptions->render(function (ValidationException $e, Request $request) {
            if ($request->is('api/*')) {
                return response()->json([
                    'code' => 422,
                    'message' => $e->validator->errors()->first(),
                    'data' => null,
                ], 422);
            }
        });

        $exceptions->render(function (AuthorizationException $e, Request $request) {
            if ($request->is('api/*')) {
                return response()->json([
                    'code' => 403,
                    'message' => '无权操作',
                    'data' => null,
                ], 403);
            }
        });

        $exceptions->render(function (NotFoundException $e, Request $request) {
            if ($request->is('api/*')) {
                return response()->json([
                    'code' => 404,
                    'message' => $e->getMessage(),
                    'data' => null,
                ], 404);
            }
        });

        $exceptions->render(function (BusinessException $e, Request $request) {
            if ($request->is('api/*')) {
                return response()->json([
                    'code' => 400,
                    'message' => $e->getMessage(),
                    'data' => null,
                ], 400);
            }
        });

        $exceptions->render(function (\Exception $e, Request $request) {
            if ($request->is('api/*')
                && !($e instanceof AuthenticationException)
                && !($e instanceof ValidationException)
                && !($e instanceof AuthorizationException)
                && !($e instanceof NotFoundException)
                && !($e instanceof BusinessException)
            ) {
                return response()->json([
                    'code' => 400,
                    'message' => $e->getMessage(),
                    'data' => null,
                ], 400);
            }
        });
    })->create();
