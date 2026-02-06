<?php

namespace App\Http\Controllers\Api\RolePermission;

use App\Http\Controllers\Controller;
use App\Models\Role;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class RoleController extends Controller
{
    // List roles
    public function index()
    {
        return response()->json([
            'success' => true,
            'data' => Role::latest()->get(),
        ], 200);
    }

    // Store role
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => [
                'required',
                'string',
                'max:255',
                Rule::unique('roles', 'name')->whereNull('deleted_at'),
            ],
            'guard_name' => 'required|string|max:255',
            'status' => 'nullable|in:0,1',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()->all(),
            ], 422);
        }

        try {
            $role = Role::create([
                'name' => $request->name,
                'guard_name' => $request->guard_name,
                'status' => $request->status ?? 1,
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Role created successfully',
                'data' => $role,
            ], 201);

        } catch (\Throwable $e) {
            Log::error('Role store error', [
                'message' => $e->getMessage(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Role creation failed',
            ], 500);
        }
    }

    // Show role
    public function show($id)
    {
        $role = Role::find($id);

        if (!$role) {
            return response()->json([
                'success' => false,
                'message' => 'Role not found',
            ], 404);
        }

        return response()->json([
            'success' => true,
            'data' => $role,
        ], 200);
    }

    // Update role
    public function update(Request $request, $id)
    {
        $role = Role::find($id);

        if (!$role) {
            return response()->json([
                'success' => false,
                'message' => 'Role not found',
            ], 404);
        }

        $validator = Validator::make($request->all(), [
            'name' => [
                'required',
                'string',
                'max:255',
                Rule::unique('roles', 'name')
                    ->ignore($id)
                    ->whereNull('deleted_at'),
            ],
            'guard_name' => 'required|string|max:255',
            'status' => 'nullable|in:0,1',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()->all(),
            ], 422);
        }

        $role->update([
            'name' => $request->name,
            'guard_name' => $request->guard_name,
            'status' => $request->status ?? $role->status,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Role updated successfully',
            'data' => $role,
        ], 200);
    }

    // Delete role (soft delete)
    public function destroy($id)
    {
        $role = Role::find($id);

        if (!$role) {
            return response()->json([
                'success' => false,
                'message' => 'Role not found',
            ], 404);
        }

        $role->delete();

        return response()->json([
            'success' => true,
            'message' => 'Role deleted successfully',
        ], 200);
    }
}
