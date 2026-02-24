<?php

namespace App\Http\Controllers\Api\Attendance;

use App\Http\Controllers\Controller;
use App\Models\Attendance;
use App\Models\Employee;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Carbon\Carbon;
use Exception;
use Illuminate\Support\Facades\DB;

class AttendanceController extends Controller
{
    /* =========================================================
     * INDEX
     * ========================================================= */
    public function index(): JsonResponse
    {
        try {
            $attendances = Attendance::with([
                'employees:id,first_name,last_name,employee_code,department_id,shift_id',
                'employees.department:id,name',
                'employees.shift:id,name',
                'employees.shift.employeeShift'
            ])
                ->orderByDesc('date')
                ->get();

            return response()->json([
                'success' => true,
                'data' => $attendances,
            ]);
        } catch (\Throwable $e) {
            return response()->json([
                'error' => "something went wrong",
                'message' => $e->getMessage()
            ], 500);
        }
    }

    /* =========================================================
     * BULK UPLOAD
     * ========================================================= */
    // public function uploadAttendance(Request $request): JsonResponse
    // {
    //     $rows = $request->input('rows', []);

    //     if (empty($rows)) {
    //         return response()->json([
    //             'success' => false,
    //             'message' => 'No attendance data found'
    //         ], 422);
    //     }

    //     $result = [];

    //     DB::beginTransaction();

    //     try {
    //         foreach ($rows as $row) {

    //             // if (
    //             //     empty($row['EmployeeID']) ||
    //             //     empty($row['Date']) ||
    //             //     empty($row['SignIn']) ||
    //             //     empty($row['SignOut'])
    //             // ) {
    //             //     throw new \Exception('Required fields missing');
    //             // }

    //             $employee = Employee::where('employee_code', $row['EmployeeID'])->first();

    //             if (!$employee) {
    //                 throw new \Exception('Employee not found');
    //             }

    //             // ✅ Safe date format
    //             $date = Carbon::createFromFormat('d-m-Y', $row['Date'])->format('Y-m-d');

    //             if (
    //                 Attendance::where('employee_id', $employee->id)
    //                 ->whereDate('date', $date)
    //                 ->exists()
    //             ) {
    //                 throw new \Exception('Attendance already marked for this date');
    //             }


    //             $signIn  = Carbon::parse($row['SignIn']);
    //             $signOut = Carbon::parse($row['SignOut']);

    //             if ($signOut->lte($signIn)) {
    //                 throw new \Exception('Sign out must be after sign in');
    //             }

    //             $totalMinutes = $signIn->diffInMinutes($signOut);
    //             $totalHours   = round($totalMinutes / 60, 2);

    //             Attendance::create([
    //                 'employee_id' => $employee->id,
    //                 'date'        => $date,
    //                 'sign_in'     => $row['SignOut'] ? $signIn->format('H:i:s') : '',
    //                 'sign_out'    => $row['SignOut'] ?$signOut->format('H:i:s') : '',
    //                 'total_hours' => $totalHours?? '',
    //                 'status'      => $row['SignOut'] ? 'present' : 'absent',
    //             ]);

    //             $result[] = [
    //                 'rowNo'  => $row['rowNo'] ?? null,
    //                 'status' => 'Uploaded',
    //                 'error'  => null,
    //             ];
    //         }

    //         DB::commit();

    //         return response()->json([
    //             'success' => true,
    //             'message' => 'Attendance processed',
    //             'data'    => $result
    //         ]);
    //     } catch (\Throwable $e) {
    //         DB::rollBack();

    //         return response()->json([
    //             'success' => false,
    //             'message' => $e->getMessage()
    //         ], 422);
    //     }
    // }

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

        DB::beginTransaction();

        try {

            foreach ($rows as $row) {

                try {

                    if (empty($row['EmployeeID']) || empty($row['Date'])) {
                        throw new \Exception('EmployeeID and Date are required');
                    }

                    $employee = Employee::where('employee_code', $row['EmployeeID'])->first();

                    if (!$employee) {
                        throw new \Exception('Employee not found');
                    }

                    $date = Carbon::createFromFormat('d-m-Y', $row['Date'])->format('Y-m-d');

                    $attendance = Attendance::where('employee_id', $employee->id)
                        ->whereDate('date', $date)
                        ->first();

                    $signIn  = !empty($row['SignIn']) ? Carbon::parse($row['SignIn']) : null;
                    $signOut = !empty($row['SignOut']) ? Carbon::parse($row['SignOut']) : null;

                    // ❌ SignOut without SignIn (First Upload)
                    if (!$attendance && !$signIn && $signOut) {
                        throw new \Exception('Sign in required before sign out');
                    }

                    // =============================
                    // CASE 1: RECORD NOT EXIST
                    // =============================
                    if (!$attendance) {

                        if (!$signIn) {
                            throw new \Exception('Sign in required');
                        }

                        $totalHours = 0;

                        if ($signOut) {

                            if ($signOut->lte($signIn)) {
                                throw new \Exception('Sign out must be after sign in');
                            }

                            $totalMinutes = $signIn->diffInMinutes($signOut);
                            $totalHours   = round($totalMinutes / 60, 2);
                        }

                        Attendance::create([
                            'employee_id' => $employee->id,
                            'date'        => $date,
                            'sign_in'     => $signIn->format('H:i:s'),
                            'sign_out'    => $signOut ? $signOut->format('H:i:s') : null,
                            'total_hours' => $totalHours,
                            'status'      => 'present'
                        ]);
                    }
                    // =============================
                    // CASE 2: RECORD EXISTS
                    // =============================
                    else {

                        if ($attendance->sign_out) {
                            throw new \Exception('Attendance already completed for this date');
                        }

                        if (!$signOut) {
                            throw new \Exception('Sign out required');
                        }

                        $existingSignIn = Carbon::parse($attendance->sign_in);

                        if ($signOut->lte($existingSignIn)) {
                            throw new \Exception('Sign out must be after sign in');
                        }

                        $totalMinutes = $existingSignIn->diffInMinutes($signOut);
                        $totalHours   = round($totalMinutes / 60, 2);

                        $attendance->update([
                            'sign_out'    => $signOut->format('H:i:s'),
                            'total_hours' => $totalHours,
                        ]);
                    }

                    $result[] = [
                        'rowNo'  => $row['rowNo'] ?? null,
                        'status' => 'Uploaded',
                        'error'  => null,
                    ];
                } catch (\Exception $rowError) {

                    $result[] = [
                        'rowNo'  => $row['rowNo'] ?? null,
                        'status' => 'Error',
                        'error'  => $rowError->getMessage(),
                    ];
                }
            }

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Attendance processed successfully',
                'data'    => $result
            ]);
        } catch (\Throwable $e) {

            DB::rollBack();

            return response()->json([
                'success' => false,
                'message' => $e->getMessage()
            ], 500);
        }
    }


    /* =========================================================
     * SINGLE EMPLOYEE ATTENDANCE
     * ========================================================= */
    public function employeeAttendance(Request $request, $id): JsonResponse
    {
        try {

            $attendance = Attendance::where('employee_id', $id)
                ->whereDate('date', $request->date)
                ->first();

            if (!$attendance) {
                return response()->json([
                    'success' => false,
                    'message' => 'No attendance found for this date'
                ], 404);
            }

            $histories = Attendance::with('user:id,name')
                ->where('employee_id', $id)
                ->where('is_corrected', 'yes')
                ->orderBy('date', 'desc')
                ->get();

            return response()->json([
                'success' => true,
                'data' => $attendance,
                'histories' => $histories
            ]);
        } catch (\Throwable $e) {
            return response()->json([
                'error' => "something went wrong",
                'message' => $e->getMessage()
            ], 500);
        }
    }

    /* =========================================================
     * CORRECTION
     * ========================================================= */
    public function correction(Request $request): JsonResponse
    {
        try {

            $request->validate([
                'employee_id' => 'required|integer',
                'date'        => 'required|date_format:Y-m-d',
                'sign_in'     => 'required',
                'sign_out'    => 'required',
                'status'      => 'required|string'
            ]);

            $attendance = Attendance::where('employee_id', $request->employee_id)
                ->whereDate('date', $request->date)
                ->first();

            if (!$attendance) {
                return response()->json([
                    'success' => false,
                    'message' => 'No attendance found for this date'
                ], 404);
            }

            $signIn  = Carbon::parse($request->sign_in);
            $signOut = Carbon::parse($request->sign_out);

            if ($signOut->lte($signIn)) {
                throw new \Exception('Sign out must be after sign in');
            }

            $totalMinutes = $signIn->diffInMinutes($signOut);
            $totalHours   = round($totalMinutes / 60, 2);

            $attendance->update([
                'action_by'    => auth()->id(),
                'reason'       => $request->reason,
                'sign_in'      => $signIn->format('H:i:s'),
                'sign_out'     => $signOut->format('H:i:s'),
                'status'       => $request->status,
                'total_hours'  => $totalHours,
                'is_corrected' => 'yes',
            ]);

            return response()->json([
                'success' => true,
                'data' => $attendance,
            ]);
        } catch (\Throwable $e) {
            return response()->json([
                'error' => "something went wrong",
                'message' => $e->getMessage()
            ], 422);
        }
    }

    private function getState($status)
    {
        $arr = [
            'earned_leave'        => 'EL',
            'casual_leave'        => 'CL',
            'sick_leave'          => 'SL',
            'maternity_leave'     => 'ML',
            'paternity_leave'     => 'PL',
            'public_holiday'      => 'PH',
            'compensatory_off'    => 'CO',
            'leave_without_pay'   => 'LWP',
            'half_day'   => 'HL',
            'present'   => 'present',
        ];

        return $arr[$status];
    }

    public function update(Request $request)
    {
        try {

            $rows = collect($request->rows);

            if ($rows->isEmpty()) {
                return response()->json([
                    'success' => false,
                    'message' => 'No data provided.'
                ], 422);
            }

            $attendanceIds = $rows->pluck('attendance_id')->unique();

            $attendances = Attendance::whereIn('id', $attendanceIds)
                ->get()
                ->keyBy('id');

            $data = [];

            foreach ($rows as $row) {

                if (!isset($attendances[$row['attendance_id']])) {
                    continue;
                }

                $attendance = $attendances[$row['attendance_id']];

                if (
                    $attendance->employee_id != $row['employee_id'] ||
                    $attendance->date != $row['date']
                ) {
                    continue;
                }

                $attendance->update([
                    'sign_in'  => $row['sign_in'],
                    'sign_out' => $row['sign_out'],
                    'status'   => $row['status'],
                ]);

                // Correct way to push data
                $data[] = [
                    'id'       => $row['attendance_id'],
                    'sign_in'  => $row['sign_in'],
                    'sign_out' => $row['sign_out'],
                    'status'   => $row['status'],
                ];
            }

            return response()->json([
                'success' => true,
                'data' => $data,
                'message' => 'Attendance updated successfully.'
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
