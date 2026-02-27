<?php

namespace App\Http\Controllers\Api\Payroll;

use App\Http\Controllers\Controller;
use App\Models\Attendance;
use App\Models\Employee;
use App\Models\Payroll;
use Exception;
use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class PayrollController extends Controller
{
    public function index(Request $request)
    {
        try {
            return response()->json([
                'success' => true,
                'data' => Payroll::get()
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
                'error' => 'Something went wrong'
            ], 442);
        }
    }

    // public function processPayroll(Request $request)
    // {
    //     DB::beginTransaction();

    //     try {

    //         // $monthString = 'Jan 2026';
    //         // $date = Carbon::createFromFormat('M Y', $monthString);
    //         // $startOfMonth = $date->copy()->startOfMonth();
    //         // $endOfMonth   = $date->copy()->endOfMonth();
    //         // $daysInMonth  = $date->daysInMonth;

    //         $month = $request->input('month.month');
    //         $year  = $request->input('month.year');

    //         $date = Carbon::createFromDate($year, $month, 1);

    //         $startOfMonth = $date->copy()->startOfMonth();
    //         $endOfMonth   = $date->copy()->endOfMonth();
    //         $daysInMonth  = $date->daysInMonth;

    //         $totalWeeks = ceil($daysInMonth / 7);

    //         $employees = Employee::with('salaries', 'shift', 'shift.employeeShift')
    //             ->where('status', 'active')
    //             // ->whereIn('id', ['2'])
    //             ->get();
    //         foreach ($employees as $employee) {
    //             $salary = $employee->salaries;
    //             if ($salary->isEmpty()) {
    //                 continue;
    //             }

    //             $attendances = Attendance::whereBetween('date', [$startOfMonth, $endOfMonth])
    //                 ->where('employee_id', $employee->id)
    //                 ->get();

    //             $presentDays = $attendances->where('status', 'present')->count();
    //             $absentDays = $attendances->where('status', 'absent')->count();

    //             // Weekoff calculation
    //             $weekOffDay = $employee->week_off; // 0=Sunday, 6=Saturday

    //             $weekOffCount = 0;

    //             for ($date = $startOfMonth->copy(); $date <= $endOfMonth; $date->addDay()) {
    //                 if ($date->dayOfWeek == $weekOffDay) {
    //                     $weekOffCount++;
    //                 }
    //             }
    //             $empWeekoff = $weekOffCount;

    //             $totalWorkingDays = $daysInMonth - $empWeekoff;

    //             if ($totalWorkingDays <= 0) {
    //                 continue;
    //             }

    //             $basicSalary = $salary[0]->basic_salary ?? 0;
    //             $monthlyReward =
    //                 ($salary[0]->hra ?? 0) +
    //                 ($salary[0]->medical ?? 0) +
    //                 ($salary[0]->conveyance_allowance ?? 0) +
    //                 ($salary[0]->special_allowance ?? 0);

    //             $monthlyGross = $basicSalary + $monthlyReward;

    //             $perDaySalary = $basicSalary / $daysInMonth;

    //             $grossAmount = round($perDaySalary * ($presentDays + $empWeekoff), 2);

    //             $netAmount = $grossAmount + $monthlyReward;
    //             Payroll::updateOrCreate(
    //                 [
    //                     'employee_id' => $employee->id,
    //                     'month' => $month,
    //                     'year' => $year,
    //                 ],
    //                 [
    //                     'total_days' => $daysInMonth,
    //                     'present_days' => $presentDays,
    //                     'paid_leaves' => 0,
    //                     'lop' => 0,
    //                     'half_days' => 0,
    //                     'gross_salary' => $grossAmount,
    //                     'deductions' => 0,
    //                     'net_salary' => $netAmount,
    //                 ]
    //             );
    //         }


    //         DB::commit();

    //         return response()->json([
    //             'message' => 'Payroll processed successfully'
    //         ]);
    //     } catch (\Exception $e) {

    //         DB::rollBack();

    //         return response()->json([
    //             'error' => $e->getMessage()
    //         ], 500);
    //     }
    // }


    public function processPayroll(Request $request)
    {
        DB::beginTransaction();

        try {
            $month = $request->input('month.month');
            $year  = $request->input('month.year');

            $date         = Carbon::createFromDate($year, $month, 1);
            $startOfMonth = $date->copy()->startOfMonth();
            $endOfMonth   = $date->copy()->endOfMonth();
            $daysInMonth  = $date->daysInMonth;

            $employees = Employee::with(['salaries', 'shift', 'shift.employeeShift'])
                ->where('status', 'active')
                ->get();

            foreach ($employees as $employee) {
                $salary = $employee->salaries->first(); // ✅ use first() not array index

                if (!$salary) continue;

                // ── ATTENDANCE ────────────────────────────────────────────────
                $attendances = Attendance::whereBetween('date', [$startOfMonth, $endOfMonth])
                    ->where('employee_id', $employee->id)
                    ->get();

                $presentDays = $attendances->where('status', 'present')->count();
                $halfDays    = $attendances->where('status', 'half_day')->count();
                $lopDays     = $attendances->where('status', 'absent')->count();

                // ── WEEK-OFFS IN MONTH ────────────────────────────────────────
                $weekOffDay   = $employee->week_off; // 0=Sunday … 6=Saturday
                $weekOffCount = 0;

                for ($d = $startOfMonth->copy(); $d <= $endOfMonth; $d->addDay()) {
                    if ($d->dayOfWeek == $weekOffDay) {
                        $weekOffCount++;
                    }
                }

                $totalWorkingDays = $daysInMonth - $weekOffCount;

                if ($totalWorkingDays <= 0) continue;

                // ── SALARY COMPONENTS (from salary table schema) ──────────────
                $basicSalary         = (float) ($salary->basic_salary          ?? 0);
                $hra                 = (float) ($salary->hra                    ?? 0);
                $medical             = (float) ($salary->medical                ?? 0);
                $conveyanceAllowance = (float) ($salary->conveyance_allowance   ?? 0);
                $specialAllowance    = (float) ($salary->special_allowance      ?? 0);
                $overtimeRate        = (float) ($salary->overtime_rate          ?? 0); // hourly
                $pfApplicable        = (bool)  ($salary->pf_applicable          ?? false);
                $esicApplicable      = (bool)  ($salary->esic_applicable        ?? false);

                $totalAllowances = $hra + $medical + $conveyanceAllowance + $specialAllowance;
                $monthlyGross    = $basicSalary + $totalAllowances;

                // ── PER-DAY RATE (based on total working days, not calendar days) ──
                $perDaySalary = $monthlyGross / $totalWorkingDays;

                // ── EFFECTIVE PAID DAYS ───────────────────────────────────────
                // present + week-offs are paid; half-days count as 0.5; LOP = deducted
                $effectivePaidDays = $presentDays + $weekOffCount + ($halfDays * 0.5);

                // ── GROSS (what employee earned this month) ───────────────────
                $grossSalary = round($perDaySalary * $effectivePaidDays, 2);

                // ── LOP DEDUCTION ─────────────────────────────────────────────
                $lopDeduction = round($perDaySalary * $lopDays, 2);

                // ── OVERTIME ──────────────────────────────────────────────────
                $overtimeHours  = $attendances->sum('overtime_hours') ?? 0;
                $overtimeAmount = round($overtimeRate * $overtimeHours, 2);

                // ── STATUTORY DEDUCTIONS ──────────────────────────────────────
                // PF: 12% of basic (only if applicable and basic >= 15000 threshold is optional)
                // $pfAmount = $pfApplicable
                //     ? round(($basicSalary / $totalWorkingDays * $effectivePaidDays) * 0.12, 2)
                //     : 0;
                $pfAmount = $pfApplicable
                    ? round($basicSalary * 0.12, 2)
                    : 0;

                // ESIC: 0.75% of gross (applicable if gross <= 21000/month)
                $esicAmount = ($esicApplicable && $grossSalary <= 21000)
                    ? round($grossSalary * 0.0075, 2)
                    : 0;

                $totalDeductions =  $pfAmount + $esicAmount;
                // $totalDeductions = $lopDeduction + $pfAmount + $esicAmount;

                // ── NET SALARY ────────────────────────────────────────────────
                $netSalary = round(($grossSalary + $overtimeAmount) - $totalDeductions, 2);

                // ── SAVE ──────────────────────────────────────────────────────
                return response()->json(
                    [
                        'employee_id' => $employee->id,
                        'month'       => $month,
                        'year'        => $year,

                        'present_days'         => $presentDays,
                        'paid_leaves'          => 0,
                        'lop'                  => $lopDays,
                        'half_days'            => $halfDays,
                        'basic_amount'         => round($basicSalary, 2),
                        'hra_allowance'        => round($hra, 2),
                        'medical_allowance'    => round($medical, 2),
                        'conveyance_allowance' => round($conveyanceAllowance, 2),
                        'special_allowance'    => round($specialAllowance, 2),
                        'overtime'             => $overtimeAmount,
                        'gross_salary'         => $grossSalary,
                        'pf_amount'            => $pfAmount,
                        'esic_amount'          => $esicAmount,
                        'deductions'           => $totalDeductions,
                        'net_salary'           => $netSalary,
                    ]
                );
                Payroll::updateOrCreate(
                    [
                        'employee_id' => $employee->id,
                        'month'       => $month,
                        'year'        => $year,
                    ],
                    [
                        'present_days'         => $presentDays,
                        'paid_leaves'          => 0,
                        'lop'                  => $lopDays,
                        'half_days'            => $halfDays,
                        'basic_amount'         => round($basicSalary, 2),
                        'hra_allowance'        => round($hra, 2),
                        'medical_allowance'    => round($medical, 2),
                        'conveyance_allowance' => round($conveyanceAllowance, 2),
                        'special_allowance'    => round($specialAllowance, 2),
                        'overtime'             => $overtimeAmount,
                        'gross_salary'         => $grossSalary,
                        'pf_amount'            => $pfAmount,
                        'esic_amount'          => $esicAmount,
                        'deductions'           => $totalDeductions,
                        'net_salary'           => $netSalary,
                    ]
                );
            }

            DB::commit();

            return response()->json(['message' => 'Payroll processed successfully']);
        } catch (\Exception $e) {
            DB::rollBack();

            return response()->json(['error' => $e->getMessage()], 500);
        }
    }
    public function historyWithEmpId(Request $request)
    {
        DB::beginTransaction();

        try {

            $employeeId = $request->input('id');
            $employee = Employee::find($employeeId);
            if (!$employee) {
                return response()->json([
                    'error' => 'Employee not found'
                ], 404);
            }

            $histories = Payroll::where('employee_id', $employeeId)->get();

            return response()->json([
                'message' => 'Payroll history retrieved successfully',
                'data' => $histories
            ]);
        } catch (\Exception $e) {

            DB::rollBack();

            return response()->json([
                'error' => $e->getMessage()
            ], 500);
        }
    }

    // public function processAttendance(Request $request)
    // {
    //     $month = $request->month;
    //     $year = $month->year;
    //     try {
    //         $attendace = Attendance::whereMonth('date', $month->month)
    //             ->whereYear('date', $year)->get();
    //         $employeeIds = (clone $attendace)->pluck('employee_id');
    //         $employees = Employee::whereIn('employee_id', $employeeIds)
    //             ->get(['id', 'first_name', 'last_name', 'employee_code']);

    //         return response()->json([
    //             'success' => true,
    //             'attendace' => $attendace,
    //             'employees' => $employees
    //         ]);
    //     } catch (Exception $e) {
    //     }
    // }

    public function processAttendance(Request $request)
    {
        try {

            $month = $request->input('month.month');
            $year  = $request->input('month.year');

            if (!$month || !$year) {
                return response()->json([
                    'success' => false,
                    'message' => 'Month and Year are required.'
                ], 422);
            }

            $attendace = Attendance::whereMonth('date', $month)
                ->whereYear('date', $year)->get();
            $employeeIds = (clone $attendace)->pluck('employee_id')->unique();
            $employees = Employee::whereIn('id', $employeeIds)
                ->get(['id', 'first_name', 'last_name', 'employee_code']);

            return response()->json([
                'success' => true,
                'attendace' => $attendace,
                'employees' => $employees
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Something went wrong.',
                'error'   => $e->getMessage()
            ], 500);
        }
    }
}
