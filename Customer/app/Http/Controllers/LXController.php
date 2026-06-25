<?php

namespace App\Http\Controllers;

use App\Http\Requests\LXRequest;
use App\Services\LXService;
use Illuminate\Http\JsonResponse;

class LXController extends Controller
{
    protected LXService $service;

    public function __construct(LXService $service)
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
    public function store(LXRequest $request): JsonResponse
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
    public function update(LXRequest $request, int $id): JsonResponse
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