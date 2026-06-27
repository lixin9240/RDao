<?php

namespace App\Http\Controllers;

use App\Http\Requests\FmyRequest;
use App\Services\FmyService;
use Illuminate\Http\JsonResponse;

class FmyController extends Controller
{
    protected FmyService $service;

    public function __construct(FmyService $service)
    {
        $this->service = $service;
    }

    public function index(): JsonResponse
    {
        return $this->success([]);
    }

    public function store(FmyRequest $request): JsonResponse
    {
        return $this->success([]);
    }

    public function show(int $id): JsonResponse
    {
        return $this->success([]);
    }

    public function update(FmyRequest $request, int $id): JsonResponse
    {
        return $this->success([]);
    }

    public function destroy(int $id): JsonResponse
    {
        return $this->success([]);
    }
}
