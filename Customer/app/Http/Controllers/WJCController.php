<?php

namespace App\Http\Controllers;

use App\Http\Requests\WJCRequest;
use App\Services\WJCService;
use Illuminate\Http\JsonResponse;

class WJCController extends Controller
{
    protected WJCService $service;

    public function __construct(WJCService $service)
    {
        $this->service = $service;
    }

    /**
     * Display a listing of the resource.
     */
    public function index(): JsonResponse
    {
        return response()->json([]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(WJCRequest $request): JsonResponse
    {
        return response()->json([]);
    }

    /**
     * Display the specified resource.
     */
    public function show(int $id): JsonResponse
    {
        return response()->json([]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(WJCRequest $request, int $id): JsonResponse
    {
        return response()->json([]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(int $id): JsonResponse
    {
        return response()->json([]);
    }
}
