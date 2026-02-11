<?php

namespace App\Http\Controllers\Api\Employee;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Employee;
use App\Models\EmployeeShiftLog;
use App\Models\Document;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Mail;
use App\Mail\OnboardingMail;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Str;

class OnboardingController extends Controller
{
    /**
     * Document types mapping
     */
    private const DOCUMENT_TYPES = [
        'idProof' => 'id_proof',
        'addressProof' => 'address_proof',
        'bankDetails' => 'bank_details',
        'contractLetter' => 'contract_letter',
        'profileImage' => 'profile_image',
    ];

    /**
     * Store new employee (Onboarding)
     */
    public function store(Request $request): JsonResponse
    {
        // return response()->json([
        //         'success' => true,
        //         'message' => 'Employee onboarded successfully',
        //         'data'    => $request->all()
        //     ], 200);
        $validated = $request->validate([
            'first_name'      => 'required|string|max:100',
            'last_name'       => 'required|string|max:100',
            'email'           => 'required|email|unique:users,email',
            'phone'           => 'required|string|max:15',

            'source'          => 'required|string',
            'job_role'        => 'required|string',
            'department'      => 'required|string',
            'department_id'   => 'nullable|integer|exists:departments,id',
            'shift_id'      => 'required|string',
            'shift_timing'    => 'nullable|string',

            'blood_group'     => 'nullable|string|max:5',
            'aadhar_no'   => 'nullable|string|max:20',

            'idProof'         => 'nullable|file|mimes:jpg,jpeg,png,pdf|max:2048',
            'addressProof'    => 'nullable|file|mimes:jpg,jpeg,png,pdf|max:2048',
            'bankDetails'     => 'nullable|file|mimes:jpg,jpeg,png,pdf|max:2048',
            'contractLetter'  => 'nullable|file|mimes:jpg,jpeg,png,pdf|max:2048',
            'profileImage'    => 'nullable|image|mimes:jpg,jpeg,png|max:2048',
        ]);

        try {

            $employee = DB::transaction(function () use ($validated, $request) {

                // Create User
                $user = User::create([
                    'name'     => trim($validated['first_name'] . ' ' . $validated['last_name']),
                    'email'    => $validated['email'],
                    'password' => Hash::make(Str::random(10)), // secure random password
                ]);

                // Upload Files
                $uploads = $this->handleUploads($request, $user->id);

                // Create Employee
                $employee = Employee::create([
                    'user_id'         => $user->id,
                    'mobile'          => $validated['phone'],
                    'first_name'      => $validated['first_name'],
                    'last_name'       => $validated['last_name'],
                    'email'           => $validated['email'],
                    'department_id'   => $validated['department_id'] ?? 2,
                    'employee_code'   => $this->generateEmployeeCode(),
                    'source'          => $validated['source'],
                    'designation_id'        => $validated['job_role'],
                    'department'      => $validated['department'],
                    'shift_id'      => $validated['shift_id'],
                    'shift_timing'    => $validated['shift_timing'] ?? null,
                    'blood_group'     => $validated['blood_group'] ?? null,
                    'aadhar_number'   => $validated['aadhar_no'] ?? null,
                    'id_proof'        => $uploads['idProof'] ?? null,
                    'address_proof'   => $uploads['addressProof'] ?? null,
                    'bank_details'    => $uploads['bankDetails'] ?? null,
                    'contract_letter' => $uploads['contractLetter'] ?? null,
                    'profile_image'   => $uploads['profileImage'] ?? null,
                ]);

                // Create Shift Log
                EmployeeShiftLog::create([
                    'employee_id' => $employee->id,
                    'shift_id' => $employee->shift_id,
                    'sign_in'     => $request->shift_check_in_timing ?? null,
                    'sign_out'    => $request->shift_check_out_timing ?? null,
                    'action_by'   => auth()->id(),
                ]);

                return $employee;
            });

            // Send Email (after transaction success)
            Mail::to($employee->email)->queue(new OnboardingMail($employee));

            return response()->json([
                'success' => true,
                'message' => 'Employee onboarded successfully',
                'data'    => $employee->load(['user', 'department'])
            ], 201);
        } catch (\Throwable $e) {

            Log::error('Employee onboarding error', [
                'message' => $e->getMessage(),
                'line'    => $e->getLine(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Employee onboarding failed',
                'error'   => config('app.debug') ? $e->getMessage() : null
            ], 500);
        }
    }


    /**
     * List employees with filters and pagination
     */
    public function index(Request $request): JsonResponse
    {
        $query = Employee::with(['user', 'department', 'shift', 'shift.employeeShift', 'designation']);

        // Apply filters
        if ($request->filled('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('first_name', 'like', "%{$search}%")
                    ->orWhere('last_name', 'like', "%{$search}%")
                    ->orWhere('email', 'like', "%{$search}%")
                    ->orWhere('employee_code', 'like', "%{$search}%");
            });
        }

        if ($request->filled('department')) {
            $query->where('department', $request->department);
        }

        if ($request->filled('status')) {
            $query->where('status', $request->status);
        }

        // Pagination
        $perPage = $request->get('limit', 10);
        $employees = $query->latest()->paginate($perPage);

        return response()->json([
            'success' => true,
            'data' => $employees->items(),
            'pagination' => [
                'total' => $employees->total(),
                'per_page' => $employees->perPage(),
                'current_page' => $employees->currentPage(),
                'last_page' => $employees->lastPage(),
                'from' => $employees->firstItem(),
                'to' => $employees->lastItem(),
            ]
        ], 200);
    }

    /**
     * Show single employee
     */
    public function show(int $id): JsonResponse
    {
        $employee = Employee::with(['user', 'department', 'shift', 'documents'])
            ->findOrFail($id);

        return response()->json([
            'success' => true,
            'data' => $employee
        ], 200);
    }

    /**
     * Update employee
     */
    public function update(Request $request, int $id): JsonResponse
    {
        $employee = Employee::findOrFail($id);

        $validator = Validator::make($request->all(), [
            'first_name' => 'sometimes|string|max:100',
            'last_name'  => 'sometimes|string|max:100',
            'email'      => 'sometimes|email|unique:users,email,' . $employee->user_id,
            'phone'      => 'sometimes|string|max:15',
            'source'       => 'sometimes|string',
            'job_role'     => 'sometimes|string',
            'department'   => 'sometimes|string',
            'shift_type'   => 'sometimes|string',
            'shift_timing' => 'sometimes|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors'  => $validator->errors()->all()
            ], 422);
        }

        DB::beginTransaction();

        try {
            // Update user if email/name changed
            if ($request->filled(['first_name', 'last_name', 'email'])) {
                $employee->user->update([
                    'name' => trim(($request->first_name ?? $employee->first_name) . ' ' .
                        ($request->last_name ?? $employee->last_name)),
                    'email' => $request->email ?? $employee->email,
                ]);
            }

            // Update employee
            $employee->update($request->only([
                'mobile',
                'first_name',
                'last_name',
                'email',
                'source',
                'job_role',
                'department',
                'shift_type',
                'shift_timing',
                'department_id'
            ]));

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Employee updated successfully',
                'data' => $employee->fresh(['user', 'department'])
            ], 200);
        } catch (\Throwable $e) {
            DB::rollBack();

            Log::error('Employee update error', [
                'employee_id' => $id,
                'message' => $e->getMessage(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Employee update failed'
            ], 500);
        }
    }

    /**
     * Delete employee
     */
    public function destroy(int $id): JsonResponse
    {
        try {
            $employee = Employee::findOrFail($id);

            DB::beginTransaction();

            // Delete associated documents
            $employee->documents()->delete();

            // Delete employee
            $employee->delete();

            // Optionally delete user
            // $employee->user->delete();

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Employee deleted successfully'
            ], 200);
        } catch (\Throwable $e) {
            DB::rollBack();

            Log::error('Employee deletion error', [
                'employee_id' => $id,
                'message' => $e->getMessage(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Employee deletion failed'
            ], 500);
        }
    }

    /**
     * Toggle employee status
     */
    public function toggleStatus(Request $request, int $id): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'status' => 'required|string|in:On Duty,Leave,Inactive'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Invalid status',
                'errors' => $validator->errors()->all()
            ], 422);
        }

        try {
            $employee = Employee::findOrFail($id);
            $employee->update(['status' => $request->status]);

            return response()->json([
                'success' => true,
                'message' => 'Employee status updated successfully',
                'data' => $employee
            ], 200);
        } catch (\Throwable $e) {
            Log::error('Employee status toggle error', [
                'employee_id' => $id,
                'message' => $e->getMessage(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Status update failed'
            ], 500);
        }
    }

    /**
     * Generate employee code (EMP2600001)
     */
    private function generateEmployeeCode(): string
    {
        $year = date('y');

        $lastEmployee = Employee::where('employee_code', 'like', "EMP{$year}%")
            ->orderByDesc('id')
            ->first();

        $nextNumber = $lastEmployee
            ? ((int) substr($lastEmployee->employee_code, -5)) + 1
            : 1;

        return 'EMP' . $year . str_pad($nextNumber, 5, '0', STR_PAD_LEFT);
    }

    /**
     * Handle document uploads
     */
    private function handleUploads(Request $request, int $userId): array
    {
        $uploads = [];

        foreach (array_keys(self::DOCUMENT_TYPES) as $field) {
            if ($request->hasFile($field)) {
                $file = $request->file($field);
                $extension = $file->getClientOriginalExtension();
                $filename = $field . '_' . time() . '.' . $extension;

                $uploads[$field] = $file->storeAs(
                    "employees/{$userId}",
                    $filename,
                    'public'
                );
            }
        }

        return $uploads;
    }

    /**
     * Create document records in database
     */
    private function createDocumentRecords(int $employeeId, array $uploads): void
    {
        $documents = [];

        foreach ($uploads as $key => $path) {
            if ($path) {
                $documents[] = [
                    'employee_id' => $employeeId,
                    'document_type' => self::DOCUMENT_TYPES[$key],
                    'file_path' => $path,
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            }
        }

        if (!empty($documents)) {
            Document::insert($documents);
        }
    }
}
