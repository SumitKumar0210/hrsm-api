<?php

namespace App\Http\Controllers\Api\Designation;

use App\Http\Controllers\Controller;
use App\Models\Designation;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class DesignationController extends Controller
{
    public function index()
    {
        try {
            $designations = Designation::latest()->get(['id', 'name', 'status']);

            return response()->json([
                'success' => true,
                'data' => $designations
            ], 200);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch designations'
            ], 500);
        }
    }

    public function activeDesignation()
    {
        try {
            $designations = Designation::latest()->where('status','active')->get(['id', 'name', 'status']);

            return response()->json([
                'success' => true,
                'data' => $designations
            ], 200);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch designations'
            ], 500);
        }
    }

    public function store(Request $request)
    {

        $validator = Validator::make($request->all(), [
            'name' => [
                'required',
                'string',
                'max:255',
                Rule::unique('designations', 'name')->whereNull('deleted_at'),
            ],
            'status' => 'nullable|in:active,inactive'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()->all()
            ], 422);
        }

        try {
            $designation = Designation::create([
                'name' => $request->name,
                'status' => $request->status ?? 1,
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Designation created successfully',
                'data' => $designation
            ], 201);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return response()->json([
                'success' => false,
                'message' => 'Designation creation failed'
            ], 500);
        }
    }

    public function show($id)
    {
        try {
            $designation = Designation::findOrFail($id);

            return response()->json([
                'success' => true,
                'data' => $designation
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Designation not found'
            ], 404);
        }
    }

    public function update(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'name' => [
                'required',
                'string',
                'max:255',
                'unique:designations,name,' . $id,
                Rule::unique('designations', 'name')
                    ->ignore($id)
                    ->whereNull('deleted_at')
                // ->whereRaw('LOWER(name) = LOWER(?)', [$request->name])
            ],
            'status' => 'nullable|in:active,inactive'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()->all()
            ], 422);
        }

        try {
            $designation = Designation::findOrFail($id);

            $designation->update([
                'name' => $request->name,
                'status' => $request->status ?? $designation->status
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Designation updated successfully',
                'data' => $designation
            ], 200);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return response()->json([
                'success' => false,
                'message' => 'Designation update failed'
            ], 500);
        }
    }

    public function destroy($id)
    {
        try {
            $designation = Designation::findOrFail($id);
            $designation->delete();

            return response()->json([
                'success' => true,
                'message' => 'Designation deleted successfully'
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Designation not found'
            ], 404);
        }
    }
}
