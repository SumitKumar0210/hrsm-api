<?php

namespace App\Http\Controllers\Api\Employee;

use App\Http\Controllers\Controller;
use App\Models\EmployeeOTConfiguration;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;

class OTConfigurationController extends Controller
{
    // List OT configurations
    public function index()
    {
        return response()->json([
            'success' => true,
            'data' => EmployeeOTConfiguration::with('employee', 'employee.department')->latest()->get()
        ], 200);
    }

    // Store OT configuration
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'employee_id' => 'required|integer|exists:employees,id',
            'ot_rate'     => 'required',
            'min_time'    => 'required',
            'max_time'    => 'required',
            'status'      => 'nullable|in:active,inactive',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors'  => $validator->errors()->all(),
            ], 422);
        }

        DB::beginTransaction();

        try {
            // Deactivate previous active config for this employee only
            EmployeeOTConfiguration::where('employee_id', $request->employee_id)
                ->where('status', 'active')
                ->update(['status' => 'inactive']);

            $config = EmployeeOTConfiguration::create([
                'employee_id' => $request->employee_id,
                'ot_rate'     => $request->ot_rate,
                'min_time'    => $request->min_time,
                'max_time'    => $request->max_time,
                'status'      => $request->status ?? 'active',
            ]);

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'OT configuration created successfully',
                'data'    => $config,
            ], 201);
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('OT Config Store Error: ' . $e->getMessage());

            return response()->json([
                'success' => false,
                'message' => 'OT configuration creation failed',
            ], 500);
        }
    }

    // Show single OT configuration
    public function show($id)
    {
        $config = EmployeeOTConfiguration::find($id);

        if (!$config) {
            return response()->json([
                'success' => false,
                'message' => 'OT configuration not found',
            ], 404);
        }

        return response()->json([
            'success' => true,
            'data'    => $config,
        ], 200);
    }

    // Update OT configuration
    public function update(Request $request, $id)
    {
        $config = EmployeeOTConfiguration::find($id);

        if (!$config) {
            return response()->json([
                'success' => false,
                'message' => 'OT configuration not found',
            ], 404);
        }

        $validator = Validator::make($request->all(), [
            'employee_id' => 'required|integer|exists:employees,id',
            'ot_rate'     => 'required',
            'min_time'    => 'required',
            'max_time'    => 'required',
            'status'      => 'nullable|in:active,inactive',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors'  => $validator->errors()->all(),
            ], 422);
        }

        DB::beginTransaction();

        try {
            // If activating, deactivate previous active configs for this employee
            if (($request->status ?? 'active') === 'active') {
                EmployeeOTConfiguration::where('employee_id', $request->employee_id)
                    ->where('id', '!=', $config->id)
                    ->where('status', 'active')
                    ->update(['status' => 'inactive']);
            }

            $config->update([
                'employee_id' => $request->employee_id,
                'ot_rate'     => $request->ot_rate,
                'min_time'    => $request->min_time,
                'max_time'    => $request->max_time,
                'status'      => $request->status ?? 'active',
            ]);

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'OT configuration updated successfully',
                'data'    => $config,
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('OT Config Update Error: ' . $e->getMessage());

            return response()->json([
                'success' => false,
                'message' => 'OT configuration update failed',
            ], 500);
        }
    }

    // Delete OT configuration (soft delete)
    public function destroy($id)
    {
        $config = EmployeeOTConfiguration::find($id);

        if (!$config) {
            return response()->json([
                'success' => false,
                'message' => 'OT configuration not found',
            ], 404);
        }

        $config->delete();

        return response()->json([
            'success' => true,
            'message' => 'OT configuration deleted successfully',
        ], 200);
    }
}
