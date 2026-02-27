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
use Carbon\Carbon;

class FinalizePayrollController extends Controller
{
    /**
     * Parse month/year from a date string request param.
     */
    private function parseMonthYear(string $date): array
    {
        $parsed = Carbon::parse($date);
        return [$parsed->month, $parsed->year];
    }

    /**
     * Aggregate payroll summary for a given month/year.
     */
    private function getPayrollSummary(int $month, int $year): object
    {
        return Payroll::where('month', $month)
            ->where('year', $year)
            ->selectRaw('
                COALESCE(SUM(gross_salary), 0) AS gross_amount,
                COALESCE(SUM(pf_amount),    0) AS pf_amount,
                COALESCE(SUM(esic_amount),  0) AS esic_amount,
                COALESCE(SUM(net_salary),   0) AS net_amount
            ')
            ->first();
    }

    /**
     * GET — Check finalization status for a given month.
     */
    public function finalizingMonth(Request $request)
    {
        try {
            $request->validate([
                'month' => 'required|date',
            ]);

            [$month, $year] = $this->parseMonthYear($request->month);

            $finalized      = FinalizedPayroll::where('month', $month)->where('year', $year)->first();
            $payrollSummary = $this->getPayrollSummary($month, $year);

            return response()->json([
                'success' => true,
                'data'    => $finalized,
                'payroll' => $payrollSummary,
            ]);

        } catch (Throwable $e) {
            Log::error('finalizingMonth failed', ['error' => $e->getMessage()]);

            return response()->json([
                'success' => false,
                'message' => 'Something went wrong.',
            ], 500);
        }
    }

    /**
     * POST — Finalize payroll for a given month (prevent duplicate finalization).
     */
    public function store(Request $request)
    {
        DB::beginTransaction();

        try {
            $request->validate([
                'month'                      => 'required|date',
                'attendance_approval_status' => 'nullable|boolean',
                'pf_calculation_status'      => 'nullable|boolean',
                'esic_calculation_status'    => 'nullable|boolean',
                'payslip_generation_status'  => 'nullable|boolean',
                'compliance_status'          => 'nullable|boolean',
                'management_approval_status' => 'nullable|boolean',
            ]);

            [$month, $year] = $this->parseMonthYear($request->month);

            // Prevent duplicate finalization
            $alreadyFinalized = FinalizedPayroll::where('month', $month)
                ->where('year', $year)
                ->exists();

            if ($alreadyFinalized) {
                return response()->json([
                    'success' => false,
                    'message' => "Payroll for {$month}/{$year} has already been finalized.",
                ], 409);
            }

            // Ensure payroll records exist before finalizing
            $payrollSummary = $this->getPayrollSummary($month, $year);

            if ((float) $payrollSummary->net_amount === 0.0) {
                return response()->json([
                    'success' => false,
                    'message' => 'No payroll records found for this month. Please process payroll first.',
                ], 422);
            }
            

            // return response()->json([
            //     'month'                      => $month,
            //     'year'                       => $year,
            //     'gross_amount'               => $payrollSummary->gross_amount,
            //     'pf_amount'                  => $payrollSummary->pf_amount,
            //     'esic_amount'                => $payrollSummary->esic_amount,
            //     'net_amount'                 => $payrollSummary->net_amount,
            //     'action_by'                  => auth()->id(),
            //     'attendance_approval_status' => $request->attendance_approval_status,
            //     'pf_calculation_status'      => $request->pf_calculation_status,
            //     'esic_calculation_status'    => $request->esic_calculation_status??$request->pf_calculation_status,
            //     'payslip_generation_status'  => $request->payslip_generation_status,
            //     'compliance_status'          => $request->compliance_status,
            //     // 'management_approval_status' => $request->management_approval_status?? 0,
            //     'date_time'                  => now(),
            // ]);
            $finalized = FinalizedPayroll::create([
                'month'                      => $month,
                'year'                       => $year,
                'total_amount'               => $payrollSummary->gross_amount,
                'pf_amount'                  => $payrollSummary->pf_amount,
                'esic_amount'                => $payrollSummary->esic_amount,
                'net_amount'                 => $payrollSummary->net_amount,
                'action_by'                  => auth()->id(),
                'attendance_approval_status' => $request->attendance_approval_status ? 1 : 0,
                'pf_calculation_status'      => $request->pf_calculation_status ? 1 : 0,
                'esic_calculation_status'    => $request->esic_calculation_status??$request->pf_calculation_status,
                'payslip_generation_status'  => $request->payslip_generation_status ? 1 : 0,
                'compliance_status'          => $request->compliance_status ? 1 : 0,
                // 'management_approval_status' => $request->management_approval_status?? 0,
                'date_time'                  => now(),
            ]);

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Payroll finalized successfully.',
                'data'    => $finalized,
                'payroll' => $payrollSummary,
            ]);

        } catch (ValidationException $e) {
            DB::rollBack();

            return response()->json([
                'success' => false,
                'errors'  => $e->errors(),
            ], 422);

        } catch (Throwable $e) {
            DB::rollBack();

            Log::error('Payroll Finalization Failed', [
                'error' => $e->getMessage(),
                'month' => $request->month ?? null,
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Something went wrong while finalizing payroll.',
            ], 500);
        }
    }
}