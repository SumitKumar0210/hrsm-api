<?php

namespace App\Http\Controllers\Api\Leave;

use App\Http\Controllers\Controller;
use App\Models\Leave;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;

class LeaveController extends Controller
{
    /**
     * List leaves
     */
    public function index(Request $request)
    {
        $query = Leave::latest();

        if ($request->employee_id) {
            $query->where('employee_id', $request->employee_id);
        }

        return response()->json([
            'success' => true,
            'data' => $query->get(),
        ], 200);
    }

    /**
     * Apply for leave
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'employee_id' => 'required|exists:employees,id',
            'leave_type'  => 'required|string|max:191',
            'from_date'   => 'required|date',
            'to_date'     => 'required|date|after_or_equal:from_date',
            'reason'      => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()->all(),
            ], 422);
        }

        try {
            $totalDays =
                now()->parse($request->from_date)
                    ->diffInDays(now()->parse($request->to_date)) + 1;

            $leave = Leave::create([
                'employee_id' => $request->employee_id,
                'leave_type'  => $request->leave_type,
                'from_date'   => $request->from_date,
                'to_date'     => $request->to_date,
                'total_days'  => $totalDays,
                'reason'      => $request->reason,
                'status'      => 'pending',
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Leave applied successfully',
                'data' => $leave,
            ], 201);

        } catch (\Throwable $e) {
            Log::error('Leave apply error', ['msg' => $e->getMessage()]);

            return response()->json([
                'success' => false,
                'message' => 'Leave application failed',
            ], 500);
        }
    }

    /**
     * Approve leave
     */
    public function approve($id)
    {
        $leave = Leave::find($id);

        if (!$leave) {
            return response()->json([
                'success' => false,
                'message' => 'Leave not found',
            ], 404);
        }

        $leave->update([
            'status' => 'approved',
            'rejected_reason' => null,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Leave approved successfully',
        ]);
    }

    /**
     * Reject leave
     */
    public function reject(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'rejected_reason' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()->all(),
            ], 422);
        }

        $leave = Leave::find($id);

        if (!$leave) {
            return response()->json([
                'success' => false,
                'message' => 'Leave not found',
            ], 404);
        }

        $leave->update([
            'status' => 'rejected',
            'rejected_reason' => $request->rejected_reason,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Leave rejected successfully',
        ]);
    }

    /**
     * Cancel leave (by employee)
     */
    public function cancel($id)
    {
        $leave = Leave::find($id);

        if (!$leave) {
            return response()->json([
                'success' => false,
                'message' => 'Leave not found',
            ], 404);
        }

        if ($leave->status === 'approved') {
            return response()->json([
                'success' => false,
                'message' => 'Approved leave cannot be cancelled',
            ], 400);
        }

        $leave->update(['status' => 'cancelled']);

        return response()->json([
            'success' => true,
            'message' => 'Leave cancelled successfully',
        ]);
    }

    /**
     * Delete leave (soft delete)
     */
    public function destroy($id)
    {
        $leave = Leave::find($id);

        if (!$leave) {
            return response()->json([
                'success' => false,
                'message' => 'Leave not found',
            ], 404);
        }

        $leave->delete();

        return response()->json([
            'success' => true,
            'message' => 'Leave deleted successfully',
        ]);
    }
}
