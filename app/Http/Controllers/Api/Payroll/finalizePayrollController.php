<?php

namespace App\Http\Controllers\Api\Payroll;

use App\Http\Controllers\Controller;
use App\Models\FinalizedPayroll;
use App\Models\Payroll;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;
use Throwable;

class FinalizePayrollController extends Controller
{

    public function finalizingMonth(Request $request)
    {
        try {

            $request->validate([
                'month' => 'required|integer|min:1|max:12',
                'year'  => 'required|integer|min:2000',
            ]);

            $data = FinalizedPayroll::where('month', $request->month)
                ->where('year', $request->year)
                ->first();

            return response()->json([
                'success' => true,
                'data'    => $data
            ]);

        } catch (Throwable $e) {

            return response()->json([
                'success' => false,
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function store(Request $request)
    {
        try {

            $request->validate([
                'month' => 'required|integer|min:1|max:12',
                'year'  => 'required|integer|min:2000',
            ]);

            $month = $request->month;
            $year  = $request->year;

            $exists = FinalizedPayroll::where('month', $month)
                ->where('year', $year)
                ->exists();

            if ($exists) {
                throw ValidationException::withMessages([
                    'month' => 'This month is already finalized.'
                ]);
            }

            DB::beginTransaction();

            $totals = Payroll::where('month', $month)
                ->where('year', $year)
                ->selectRaw('
                    SUM(net_salary) as total_amount,
                    SUM(pf_amount) as pf_amount,
                    SUM(esic_amount) as esic_amount
                ')
                ->first();

            $data = FinalizedPayroll::create([
                'month' => $month,
                'year'  => $year,
                'total_amount' => $totals->total_amount ?? 0,
                'pf_amount'    => $totals->pf_amount ?? 0,
                'esic_amount'  => $totals->esic_amount ?? 0,
                'action_by'    => auth()->id(),
                'attendance_approval_status' => $request->attendance_approval_status,
                'pf_calculation_status'      => $request->pf_calculation_status,
                'esic_calculation_status'    => $request->esic_calculation_status,
                'payslip_generation_status'  => $request->payslip_generation_status,
                'compliance_status'          => $request->compliance_status,
                'management_approval_status' => $request->management_approval_status,
                'date_time' => now(),
            ]);

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Payroll finalized successfully.',
                'data'    => $data
            ]);

        } catch (ValidationException $e) {

            return response()->json([
                'success' => false,
                'errors'  => $e->errors()
            ], 422);

        } catch (Throwable $e) {

            DB::rollBack();

            Log::error('Payroll Finalization Failed', [
                'error' => $e->getMessage(),
                'month' => $request->month ?? null,
                'year'  => $request->year ?? null,
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Something went wrong while finalizing payroll.'
            ], 500);
        }
    }
}