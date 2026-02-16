<?php

namespace App\Http\Controllers\Api\Salary;

use App\Http\Controllers\Controller;
use App\Models\Employee;
use App\Models\EmployeeSalary;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;

class SalaryManagementController extends Controller
{
    /**
     * Get employee salary (latest)
     */
    public function show($employeeId)
    {
        $salary = EmployeeSalary::where('employee_id', $employeeId)
            ->latest()
            ->first();

        return response()->json([
            'success' => true,
            'data' => $salary
        ]);
    }

    /**
     * Store / Revise salary structure
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'employee_id' => 'required|exists:employees,id',

            'basic_salary' => 'required|numeric|min:0',
            'hra' => 'nullable|numeric|min:0',
            'medical_allowance' => 'nullable|numeric|min:0',
            'special_allowance' => 'nullable|numeric|min:0',
            'overtime_rate' => 'nullable|numeric|min:0',

            'pf_applicable' => 'boolean',
            'uan_number' => 'nullable:pf_applicable,1|string|nullable',
            'pf_amount' => 'nullable|numeric|min:0',

            'esic_applicable' => 'boolean',
            'esic_ip_number' => 'nullable:esic_applicable,1|string|nullable',
            'esic_amount' => 'nullable|numeric|min:0',

            'effective_from' => 'nullable|date',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()->all()
            ], 422);
        }

        DB::beginTransaction();

        try {
            // Get latest active salary (MODEL)
            $previousSalary = EmployeeSalary::where('employee_id', $request->employee_id)
                ->where('status', 'active')
                ->latest()
                ->first();

            //  Deactivate previous salary
            if ($previousSalary) {
                $previousSalary->update(['status' => 'inactive']);
            }

            // Store previous salary snapshot
            $previous = $previousSalary ? [
                'basic_salary' => $previousSalary->basic_salary,
                'hra' => $previousSalary->hra,
                'medical_allowance' => $previousSalary->medical_allowance,
                'special_allowance' => $previousSalary->special_allowance,
                'overtime_rate' => $previousSalary->overtime_rate,
                'gross_salary' => $previousSalary->gross_salary,
                'pf_applicable' => $previousSalary->pf_applicable,
                'uan_number' => $previousSalary->uan_number,
                'pf_amount' => $previousSalary->pf_amount,
                'esic_applicable' => $previousSalary->esic_applicable,
                'esic_number' => $previousSalary->esic_number,
                'esic_amount' => $previousSalary->esic_amount,
                'effective_from' => $previousSalary->effective_from,
            ] : null;

            // 🔹 Gross salary calculation
            $gross =
                $request->basic_salary +
                ($request->hra ?? 0) +
                ($request->medical_allowance ?? 0) +
                ($request->special_allowance ?? 0);

            // 🔹 Create new salary
            $salary = EmployeeSalary::create([
                'employee_id' => $request->employee_id,

                'basic_salary' => $request->basic_salary,
                'hra' => $request->hra,
                'medical_allowance' => $request->medical_allowance,
                'special_allowance' => $request->special_allowance,
                'overtime_rate' => $request->overtime_rate,

                'gross_salary' => $gross,

                'pf_applicable' => $request->pf_applicable ?? false,
                'uan_number' => $request->uan_number,
                'pf_amount' => $request->pf_amount,

                'esic_applicable' => $request->esic_applicable ?? false,
                'esic_number' => $request->esic_number,
                'esic_amount' => $request->esic_amount,

                'effective_from' => $request->effective_from,
                'previous_salary' => json_encode($previous),
                'status' => 'active'
            ]);

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Salary structure saved successfully',
                'data' => $salary
            ], 201);
        } catch (\Throwable $e) {

            DB::rollBack();
            Log::error('Salary save error', [
                'message' => $e->getMessage()
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Salary structure failed'
            ], 500);
        }
    }


    /**
     * Salary revision history
     */
    public function history($employeeId)
    {
        $history = EmployeeSalary::where('employee_id', $employeeId)
            ->orderByDesc('effective_from')
            ->get();

        return response()->json([
            'success' => true,
            'data' => $history
        ]);
    }
}
