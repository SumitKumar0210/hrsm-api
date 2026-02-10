<?php

namespace App\Http\Controllers\Api\Attendance;

use App\Http\Controllers\Controller;
use App\Models\Attendance;
use App\Models\Employee;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Carbon\Carbon;

class AttendanceController extends Controller
{
    public function uploadAttendance(Request $request): JsonResponse
    {
        $rows = $request->input('rows', []);

        if (empty($rows)) {
            return response()->json([
                'success' => false,
                'message' => 'No attendance data found'
            ], 422);
        }

        $result = [];

        foreach ($rows as $row) {
            try {
                /* ================= REQUIRED FIELDS ================= */
                if (
                    empty($row['EmployeeID']) ||
                    empty($row['Date']) ||
                    empty($row['SignIn']) ||
                    empty($row['SignOut'])
                ) {
                    throw new \Exception('Required fields missing');
                }

                /* ================= EMPLOYEE ================= */
                $employee = Employee::where('employee_code', $row['EmployeeID'])->first();
                if (!$employee) {
                    throw new \Exception('Employee not found');
                }

                /* ================= DATE ================= */
                $date = Carbon::createFromFormat('d-m-Y', $row['Date'])->toDateString();

                /* ================= DUPLICATE CHECK ================= */
                $exists = Attendance::where('employee_id', $employee->id)
                    ->whereDate('date', $date)
                    ->exists();

                if ($exists) {
                    throw new \Exception('Attendance already marked for this date');
                }

                /* ================= TIME ================= */
                $signIn  = Carbon::createFromFormat('H:i', $row['SignIn']);
                $signOut = Carbon::createFromFormat('H:i', $row['SignOut']);

                if ($signOut->lessThanOrEqualTo($signIn)) {
                    throw new \Exception('Sign out must be after sign in');
                }

                /* ================= HOURS ================= */
                $totalMinutes = $signIn->diffInMinutes($signOut); // ✅ correct order
                $totalHours   = round($totalMinutes / 60, 2);

                /* ================= SAVE ================= */
                Attendance::create([
                    'employee_id' => $employee->id,
                    'date'        => $date,
                    'sign_in'     => $signIn->format('H:i:s'),   // TIME only
                    'sign_out'    => $signOut->format('H:i:s'),  // TIME only
                    'total_hours' => $totalHours,
                ]);

                $result[] = [
                    'rowNo'  => $row['rowNo'],
                    'status' => 'Uploaded',
                    'error'  => null,
                ];
            } catch (\Exception $e) {
                $result[] = [
                    'rowNo'  => $row['rowNo'],
                    'status' => 'Error',
                    'error'  => $e->getMessage(),
                ];
            }
        }

        return response()->json([
            'success' => true,
            'message' => 'Attendance processed',
            'data'    => $result
        ]);
    }
}
