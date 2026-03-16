<?php

namespace App\Http\Controllers\Api\RolePermission;

use App\Http\Controllers\Controller;
use App\Models\Role;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\Rule;
use Spatie\Permission\PermissionRegistrar;

class RoleController extends Controller
{

    // List roles
    public function index(Request $request)
    {
        $query = Role::query();

        if ($request->has('status')) {
            $query->where('status', $request->status);
        }

        $roles = $query->orderBy('name')->get();

        return response()->json([
            'status' => true,
            'data' => $roles
        ]);
    }


    // Store role
    public function store(Request $request)
    {
        $request->validate([
            'name' => [
                'required',
                'string',
                'max:255',
                Rule::unique('roles', 'name')->whereNull('deleted_at')
            ],
            'guard_name' => 'required|string|max:255',
            'status' => 'nullable|in:0,1'
        ]);

        try {

            $role = Role::create([
                'name' => $request->name,
                'guard_name' => $request->guard_name,
                'status' => $request->status ?? 1
            ]);

            app(PermissionRegistrar::class)->forgetCachedPermissions();

            return response()->json([
                'status' => true,
                'message' => 'Role created successfully',
                'data' => $role
            ], 201);

        } catch (Exception $e) {

            Log::error('Role create failed: '.$e->getMessage());

            return response()->json([
                'status' => false,
                'message' => 'Role creation failed'
            ], 500);
        }
    }


    // Show role
    public function show($id)
    {
        try {

            $role = Role::with('permissions')->findOrFail($id);

            return response()->json([
                'status' => true,
                'data' => $role
            ]);

        } catch (Exception $e) {

            return response()->json([
                'status' => false,
                'message' => 'Role not found'
            ], 404);
        }
    }


    // Update role
    public function update(Request $request, $id)
    {

        $role = Role::findOrFail($id);

        $request->validate([
            'name' => [
                'required',
                'string',
                'max:255',
                Rule::unique('roles', 'name')
                    ->ignore($id)
                    ->whereNull('deleted_at')
            ],
            'guard_name' => 'required|string|max:255',
            'status' => 'nullable|in:0,1'
        ]);

        $role->update([
            'name' => $request->name,
            'guard_name' => $request->guard_name,
            'status' => $request->status ?? $role->status
        ]);

        app(PermissionRegistrar::class)->forgetCachedPermissions();

        return response()->json([
            'status' => true,
            'message' => 'Role updated successfully',
            'data' => $role
        ]);
    }


    // Delete role
    public function destroy($id)
    {
        try {

            $role = Role::findOrFail($id);

            $role->delete();

            app(PermissionRegistrar::class)->forgetCachedPermissions();

            return response()->json([
                'status' => true,
                'message' => 'Role deleted successfully'
            ]);

        } catch (Exception $e) {

            return response()->json([
                'status' => false,
                'message' => 'Role not found'
            ], 404);
        }
    }


    // Assign permissions
    public function assignPermission(Request $request)
    {

        $request->validate([
            'id' => 'required|exists:roles,id',
            'permissionNames' => 'required|array',
            'permissionNames.*' => 'exists:permissions,name'
        ]);

        DB::beginTransaction();

        try {

            $role = Role::findOrFail($request->id);

            $role->syncPermissions($request->permissionNames);

            DB::commit();

            app(PermissionRegistrar::class)->forgetCachedPermissions();

            return response()->json([
                'status' => true,
                'message' => 'Permissions assigned successfully',
                'data' => $role->load('permissions')
            ]);

        } catch (Exception $e) {

            DB::rollBack();

            Log::error('Permission assign error: '.$e->getMessage());

            return response()->json([
                'status' => false,
                'message' => 'Failed to assign permissions'
            ], 500);
        }
    }
}