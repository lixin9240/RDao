<?php

namespace App\Http\Controllers;

use App\Http\Requests\GyzRequest;
use App\Services\GyzService;
use Illuminate\Http\JsonResponse;

class GyzController extends Controller
{
    protected GyzService $service;

    public function __construct(GyzService $service)
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
    public function store(GyzRequest $request): JsonResponse
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
    public function update(GyzRequest $request, int $id): JsonResponse
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