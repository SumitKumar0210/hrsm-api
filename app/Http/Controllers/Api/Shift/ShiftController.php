<?php

namespace App\Http\Controllers\Api\Shift;

use App\Http\Controllers\Controller;
use App\Models\Shift;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class ShiftController extends Controller
{
    // List shifts
    public function index()
    {
        return response()->json([
            'success' => true,
            'data' => Shift::latest()->get()
        ], 200);
    }

    public function activeShift()
    {
        return response()->json([
            'success' => true,
            'data' => Shift::latest()->where('status','active')->get()
        ], 200);
    }

    // Store shift
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => [
                'required',
                'string',
                'max:255',
                Rule::unique('shifts', 'name')->whereNull('deleted_at'),
            ],
            'check_in_timing'  => 'required|string|max:50',
            'check_out_timing' => 'required|string|max:50',
            'default_time'      => 'nullable|boolean',
            'status'           => 'nullable|in:active,inactive',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()->all(),
            ], 422);
        }

        try {
            $shift = Shift::create([
                'name' => $request->name,
                'sign_in' => $request->check_in_timing,
                'sign_out' => $request->check_out_timing,
                'rotational_time' => $request->default_time ?? false,
                'status' => $request->status ?? 'active',
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Shift created successfully',
                'data' => $shift,
            ], 201);

        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return response()->json([
                'success' => false,
                'message' => 'Shift creation failed',
            ], 500);
        }
    }

    // Show shift
    public function show($id)
    {
        $shift = Shift::find($id);

        if (!$shift) {
            return response()->json([
                'success' => false,
                'message' => 'Shift not found',
            ], 404);
        }

        return response()->json([
            'success' => true,
            'data' => $shift,
        ], 200);
    }

    // Update shift
    public function update(Request $request, $id)
    {
        $shift = Shift::find($id);

        if (!$shift) {
            return response()->json([
                'success' => false,
                'message' => 'Shift not found',
            ], 404);
        }

        $validator = Validator::make($request->all(), [
            'name' => [
                'required',
                'string',
                'max:255',
                Rule::unique('shifts', 'name')
                    ->ignore($id)
                    ->whereNull('deleted_at'),
            ],
            'check_in_timing'  => 'required|string|max:50',
            'check_out_timing' => 'required|string|max:50',
            'default_time'      => 'nullable|boolean',
            'status'           => 'nullable|in:active,inactive',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()->all(),
            ], 422);
        }

        $shift->update([
            'name' => $request->name,
            'sign_in' => $request->check_in_timing,
            'sign_out' => $request->check_out_timing,
            'rotational_time' => $request->default_time === true || $request->default_time === 1 ? 1 : 0,
            'status' => $request->status ?? $shift->status,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Shift updated successfully',
            'data' => $shift,
            'request' => $request->all(),
        ], 200);
    }

    // Delete shift (soft delete)
    public function destroy($id)
    {
        $shift = Shift::find($id);

        if (!$shift) {
            return response()->json([
                'success' => false,
                'message' => 'Shift not found',
            ], 404);
        }

        $shift->delete();

        return response()->json([
            'success' => true,
            'message' => 'Shift deleted successfully',
        ], 200);
    }
}
