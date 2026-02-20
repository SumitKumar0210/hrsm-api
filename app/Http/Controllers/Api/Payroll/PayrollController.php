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

    public function processPayroll(Request $request)
    {
        DB::beginTransaction();

        try {

            $monthString = 'Jan 2026';
            $date = Carbon::createFromFormat('M Y', $monthString);

            $month = $date->month;
            $year  = $date->year;

            $startOfMonth = $date->copy()->startOfMonth();
            $endOfMonth   = $date->copy()->endOfMonth();
            $daysInMonth  = $date->daysInMonth;

            $totalWeeks = ceil($daysInMonth / 7);

            $employees = Employee::with('salaries', 'shift', 'shift.employeeShift')
                ->where('status', 'active')
                // ->whereIn('id', ['2'])
                ->get();
            foreach ($employees as $employee) {
                $salary = $employee->salaries;
                if ($salary->isEmpty()) {
                    continue;
                }

                $attendances = Attendance::whereBetween('date', [$startOfMonth, $endOfMonth])
                    ->where('employee_id', $employee->id)
                    ->get();

                $presentDays = $attendances->where('status', 'present')->count();

                // Weekoff calculation
                $weekOffDay = $employee->week_off; // 0=Sunday, 6=Saturday

                $weekOffCount = 0;

                for ($date = $startOfMonth->copy(); $date <= $endOfMonth; $date->addDay()) {
                    if ($date->dayOfWeek == $weekOffDay) {
                        $weekOffCount++;
                    }
                }
                $empWeekoff = $weekOffCount;

                $totalWorkingDays = $daysInMonth - $empWeekoff;

                if ($totalWorkingDays <= 0) {
                    continue;
                }

                $basicSalary = $salary[0]->basic_salary ?? 0;
                $monthlyReward =
                    ($salary[0]->hra ?? 0) +
                    ($salary[0]->medical ?? 0) +
                    ($salary[0]->conveyance_allowance ?? 0) +
                    ($salary[0]->special_allowance ?? 0);

                $monthlyGross = $basicSalary + $monthlyReward;

                $perDaySalary = $basicSalary / $daysInMonth;

                $grossAmount = round($perDaySalary * ($presentDays + $empWeekoff), 2);

                $netAmount = $grossAmount + $monthlyReward;
                Payroll::updateOrCreate(
                    [
                        'employee_id' => $employee->id,
                        'month' => $month,
                        'year' => $year,
                    ],
                    [
                        'total_days' => $daysInMonth,
                        'present_days' => $presentDays,
                        'paid_leaves' => 0,
                        'lop' => 0,
                        'half_days' => 0,
                        'gross_salary' => $grossAmount,
                        'deductions' => 0,
                        'net_salary' => $netAmount,
                    ]
                );
            }


            DB::commit();

            return response()->json([
                'message' => 'Payroll processed successfully'
            ]);
        } catch (\Exception $e) {

            DB::rollBack();

            return response()->json([
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
