<?php

namespace App\Http\Controllers\Api\Employee;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Employee;
use App\Models\EmployeeShiftLog;
use App\Models\Document;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Exception;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Mail;
use App\Mail\OnboardingMail;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Str;
use Illuminate\Validation\Rule;
use Illuminate\Validation\ValidationException;

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
        // Validate request
        $validator = Validator::make($request->all(), [
            // Basic Info
            'first_name'      => 'required|string|max:100',
            'last_name'       => 'required|string|max:100',
            'email'           => 'required|email|unique:users,email|unique:employees,email',
            'phone'           => 'required|string|max:15',

            // Address
            'address'         => 'required|string|max:255',
            'city'            => 'required|string|max:100',
            'state'           => 'required|string|max:100',
            'pin_code'        => 'required|string|max:10',

            // Work Details
            'source'          => 'required|string|in:referral,walk-in,online',
            'job_role'        => 'required|exists:designations,id',
            'department'      => 'required|exists:departments,id',
            'shift_id'        => 'required|exists:shifts,id',

            // Shift Timings (for rotational shifts)
            'shift_check_in_timing'  => 'nullable|date_format:H:i',
            'shift_check_out_timing' => 'nullable|date_format:H:i|after:shift_check_in_timing',

            // Personal Details
            'blood_group'     => 'nullable|string|in:A+,A-,B+,B-,O+,O-,AB+,AB-',
            'aadhar_no'       => 'nullable|string|size:12|regex:/^[2-9][0-9]{11}$/',

            // Application User
            'is_application_user' => 'nullable|boolean',

            // Documents
            'idProof'         => 'nullable|file|mimes:jpg,jpeg,png,pdf|max:10240',
            'addressProof'    => 'nullable|file|mimes:jpg,jpeg,png,pdf|max:10240',
            'bankDetails'     => 'nullable|file|mimes:jpg,jpeg,png,pdf|max:10240',
            'contractLetter'  => 'nullable|file|mimes:jpg,jpeg,png,pdf|max:10240',
            'profileImage'    => 'nullable|image|mimes:jpg,jpeg,png|max:5120',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors'  => $validator->errors()
            ], 422);
        }

        $validated = $validator->validated();

        DB::beginTransaction();

        try {
            $user = null;

            // Create User if is_application_user is true
            if ($request->boolean('is_application_user')) {
                $temporaryPassword = Str::random(10);

                $user = User::create([
                    'name'     => trim($validated['first_name'] . ' ' . $validated['last_name']),
                    'email'    => $validated['email'],
                    'password' => Hash::make($temporaryPassword),
                ]);

                // TODO: Send password to user via email or SMS
            }

            // Create Employee
            $employee = Employee::create([
                'user_id'         => $user?->id,
                'employee_code'   => $this->generateEmployeeCode(),

                // Basic Info
                'first_name'      => $validated['first_name'],
                'last_name'       => $validated['last_name'],
                'email'           => $validated['email'],
                'mobile'          => $validated['phone'],

                // Address
                'address'         => $validated['address'],
                'city'            => $validated['city'],
                'state'           => $validated['state'],
                'zip_code'        => $validated['pin_code'],

                // Work Details
                'source'          => $validated['source'],
                'designation_id'  => $validated['job_role'],
                'department_id'   => $validated['department'],
                'shift_id'        => $validated['shift_id'],

                // Personal Details
                'blood_group'     => $validated['blood_group'] ?? null,
                'aadhar_number'   => $validated['aadhar_no'] ?? null,

            ]);

            // Handle document uploads AFTER employee is created
            $uploads = $this->handleUploads($request, $employee->id);

            // Update employee with document paths
            $employee->update([
                'id_proof'        => $uploads['idProof'] ?? null,
                'address_proof'   => $uploads['addressProof'] ?? null,
                'bank_details'    => $uploads['bankDetails'] ?? null,
                'contract_letter' => $uploads['contractLetter'] ?? null,
                'profile_image'   => $uploads['profileImage'] ?? null,
            ]);

            // Create document records in documents table
            $this->createDocumentRecords($employee->id, $uploads);

            // Create Shift Log
            EmployeeShiftLog::create([
                'employee_id' => $employee->id,
                'shift_id'    => $employee->shift_id,
                'sign_in'     => $validated['shift_check_in_timing'] ?? null,
                'sign_out'    => $validated['shift_check_out_timing'] ?? null,
                'action_by'   => auth()->id() ?? null,
            ]);

            DB::commit();

            // Send Email (after transaction success) - Run in background
            try {
                Mail::to($employee->email)->queue(new OnboardingMail($employee));
            } catch (\Exception $e) {
                Log::warning('Failed to send onboarding email', [
                    'employee_id' => $employee->id,
                    'error' => $e->getMessage()
                ]);
            }

            return response()->json([
                'success' => true,
                'message' => 'Employee onboarded successfully',
                'data'    => $employee->load(['user', 'department', 'designation', 'shift'])
            ], 201);
        } catch (ValidationException $e) {
            DB::rollBack();

            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors'  => $e->errors()
            ], 422);
        } catch (\Throwable $e) {
            DB::rollBack();

            Log::error('Employee onboarding error', [
                'message' => $e->getMessage(),
                'line'    => $e->getLine(),
                'file'    => $e->getFile(),
                'trace'   => $e->getTraceAsString(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Employee onboarding failed',
                'error'   => config('app.debug') ? $e->getMessage() : 'An error occurred during onboarding'
            ], 500);
        }
    }

    /**
     * List employees with filters and pagination
     */
    public function index(Request $request): JsonResponse
    {
        try {
            $query = Employee::with(['user', 'department', 'shift', 'shift.employeeShift', 'designation', 'documents', 'salaries']);

            // Apply filters
            if ($request->filled('search')) {
                $search = $request->search;
                $query->where(function ($q) use ($search) {
                    $q->where('first_name', 'like', "%{$search}%")
                        ->orWhere('last_name', 'like', "%{$search}%")
                        ->orWhere('email', 'like', "%{$search}%")
                        ->orWhere('mobile', 'like', "%{$search}%")
                        ->orWhere('employee_code', 'like', "%{$search}%");
                });
            }

            if ($request->filled('department')) {
                $query->where('department_id', $request->department);
            }

            if ($request->filled('status')) {
                $query->where('status', $request->status);
            }

            // Pagination
            $perPage = min($request->get('limit', 10), 100); // Max 100 per page
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
        } catch (\Throwable $e) {
            Log::error('Employee list error', [
                'message' => $e->getMessage(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch employees'
            ], 500);
        }
    }
    /**
     * List employees with filters 
     */
    public function search(Request $request): JsonResponse
    {
        try {
            $query = Employee::with(['user', 'department', 'designation', 'salary']);

            // Apply filters
            if ($request->filled('search')) {
                $search = $request->search;
                $query->where(function ($q) use ($search) {
                    $q->where('first_name', 'like', "%{$search}%")
                        ->orWhere('last_name', 'like', "%{$search}%")
                        ->orWhere('email', 'like', "%{$search}%")
                        ->orWhere('mobile', 'like', "%{$search}%")
                        ->orWhere('employee_code', 'like', "%{$search}%");
                });
            }

            if ($request->filled('department')) {
                $query->where('department_id', $request->department);
            }

            if ($request->filled('status')) {
                $query->where('status', $request->status);
            }

            $employees = $query->latest()->get();

            return response()->json([
                'success' => true,
                'data' => $employees,
            ], 200);
        } catch (\Throwable $e) {
            Log::error('Employee list error', [
                'message' => $e->getMessage(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch employees'
            ], 500);
        }
    }

    /**
     * Show single employee
     */
    public function show(int $id): JsonResponse
    {
        try {
            $employee = Employee::with([
                'user',
                'department',
                'shift',
                'shift.employeeShift',
                'designation',
                'documents'
            ])->findOrFail($id);

            return response()->json([
                'success' => true,
                'data' => $employee
            ], 200);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Employee not found'
            ], 404);
        } catch (\Throwable $e) {
            Log::error('Employee show error', [
                'employee_id' => $id,
                'message' => $e->getMessage(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch employee'
            ], 500);
        }
    }

    /**
     * Update employee
     */
    public function update(Request $request, int $id): JsonResponse
    {
        try {
            $employee = Employee::with('user')->findOrFail($id);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException) {
            return response()->json([
                'success' => false,
                'message' => 'Employee not found',
            ], 404);
        }

        // ── Validation ────────────────────────────────────────────────────────────
        $validator = Validator::make($request->all(), [
            // Basic Info
            'first_name' => 'sometimes|string|max:100',
            'last_name'  => 'sometimes|string|max:100',
            'email'      => [
                'sometimes',
                'email',

                Rule::unique('employees', 'email')->ignore($employee->id),
            ],
            'phone'      => 'sometimes|string|max:15',

            // Address
            'address'    => 'sometimes|string|max:255',
            'city'       => 'sometimes|string|max:100',
            'state'      => 'sometimes|string|max:100',
            'pin_code'   => 'sometimes|string|max:10',

            // Work Details
            'source'     => 'sometimes|string|in:referral,walk-in,online',
            'job_role'   => 'sometimes|exists:designations,id',
            'department' => 'sometimes|exists:departments,id',
            'shift_id'   => 'sometimes|exists:shifts,id',

            // Shift Timings
            'shift_check_in_timing'  => 'nullable|date_format:H:i',
            'shift_check_out_timing' => 'nullable|date_format:H:i|after:shift_check_in_timing',

            // Personal Details
            'blood_group' => 'sometimes|string|in:A+,A-,B+,B-,O+,O-,AB+,AB-',
            'aadhar_no'   => 'sometimes|string|size:12|regex:/^[2-9][0-9]{11}$/',

            // Documents
            'idProof'        => 'nullable|file|mimes:jpg,jpeg,png,pdf|max:10240',
            'addressProof'   => 'nullable|file|mimes:jpg,jpeg,png,pdf|max:10240',
            'bankDetails'    => 'nullable|file|mimes:jpg,jpeg,png,pdf|max:10240',
            'contractLetter' => 'nullable|file|mimes:jpg,jpeg,png,pdf|max:10240',
            'profileImage'   => 'nullable|image|mimes:jpg,jpeg,png|max:5120',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors'  => $validator->errors(),
            ], 422);
        }


        $fieldMap = [
            'first_name'     => 'first_name',
            'last_name'      => 'last_name',
            'email'          => 'email',
            'phone'          => 'mobile',
            'address'        => 'address',
            'city'           => 'city',
            'state'          => 'state',
            'pin_code'       => 'zip_code',
            'source'         => 'source',
            'job_role'       => 'designation_id',
            'department'     => 'department_id',
            'shift_id'       => 'shift_id',
            'blood_group'    => 'blood_group',
            'aadhar_no'      => 'aadhar_number',
        ];

        $updateData = [];
        foreach ($fieldMap as $requestKey => $column) {
            if ($request->has($requestKey)) {
                $updateData[$column] = $request->input($requestKey);
            }
        }

        try {
            DB::beginTransaction();

            if ($employee->user && $request->hasAny(['first_name', 'last_name', 'email'])) {
                $employee->user->update([
                    'name'  => trim(
                        ($updateData['first_name'] ?? $employee->first_name) . ' ' .
                            ($updateData['last_name']  ?? $employee->last_name)
                    ),
                    'email' => $updateData['email'] ?? $employee->user->email,
                ]);
            }

            // ── Document uploads ──────────────────────────────────────────────────
            if ($request->hasAny(array_keys(self::DOCUMENT_TYPES))) {
                $uploads = $this->handleUploads($request, $employee->id);

                $docMap = [
                    'idProof'        => 'id_proof',
                    'addressProof'   => 'address_proof',
                    'bankDetails'    => 'bank_details',
                    'contractLetter' => 'contract_letter',
                    'profileImage'   => 'profile_image',
                ];

                foreach ($docMap as $inputKey => $column) {
                    if (isset($uploads[$inputKey])) {
                        $updateData[$column] = $uploads[$inputKey];
                    }
                }

                $this->createDocumentRecords($employee->id, $uploads);
            }

            // ── Persist employee changes ──────────────────────────────────────────
            if (!empty($updateData)) {
                $employee->update($updateData);
            }

            // ── Shift log ─────────────────────────────────────────────────────────

            if ($request->hasAny(['shift_check_in_timing', 'shift_check_out_timing'])) {

                EmployeeShiftLog::where('employee_id', $employee->id)
                    ->where('status', 'active')
                    ->update(['status' => 'inactive']);

                EmployeeShiftLog::create([
                    'employee_id' => $employee->id,
                    'shift_id'    => $employee->shift_id,
                    'sign_in'     => $request->shift_check_in_timing,
                    'sign_out'    => $request->shift_check_out_timing,
                    'status'      => 'active',
                    'action_by'   => auth()->id(),
                ]);
            }

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Employee updated successfully',
                // FIX: match the same relations as index() for a consistent response shape
                'data'    => $employee->fresh(['user', 'department', 'designation', 'shift', 'salaries', 'documents']),
            ], 200);
        } catch (\Throwable $e) {
            DB::rollBack();

            Log::error('Employee update error', [
                'employee_id' => $id,
                'message'     => $e->getMessage(),
                'trace'       => $e->getTraceAsString(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Employee update failed',
                'error'   => config('app.debug') ? $e->getMessage() : 'An error occurred',
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

            // Delete associated records
            EmployeeShiftLog::where('employee_id', $id)->delete();
            Document::where('employee_id', $id)->delete();

            // Soft delete or hard delete employee
            $employee->delete();

            // Optionally delete user account
            // if ($employee->user) {
            //     $employee->user->delete();
            // }

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Employee deleted successfully'
            ], 200);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Employee not found'
            ], 404);
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
                'errors' => $validator->errors()
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
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Employee not found'
            ], 404);
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
            ->lockForUpdate() // Prevent race condition
            ->first();

        $nextNumber = $lastEmployee
            ? ((int) substr($lastEmployee->employee_code, -5)) + 1
            : 1;

        return 'EMP' . $year . str_pad($nextNumber, 5, '0', STR_PAD_LEFT);
    }

    /**
     * Handle document uploads
     */
    private function handleUploads(Request $request, int $employeeId): array
    {
        $uploads = [];

        foreach (array_keys(self::DOCUMENT_TYPES) as $field) {
            if ($request->hasFile($field)) {
                try {
                    $file = $request->file($field);
                    $extension = $file->getClientOriginalExtension();
                    $filename = $field . '_' . time() . '_' . Str::random(8) . '.' . $extension;

                    $path = $file->storeAs(
                        "employees/{$employeeId}",
                        $filename,
                        'public'
                    );

                    $uploads[$field] = $path;
                } catch (\Exception $e) {
                    Log::error("Failed to upload {$field}", [
                        'employee_id' => $employeeId,
                        'error' => $e->getMessage()
                    ]);
                }
            }
        }

        return $uploads;
    }

    /**
     * Create document records in database
     */
    private function createDocumentRecords(int $employeeId, array $uploads): void
    {
        if (empty($uploads)) {
            return;
        }

        $documents = [];
        $now = now();

        foreach ($uploads as $key => $path) {
            if ($path) {
                $documents[] = [
                    'employee_id' => $employeeId,
                    'document_type' => self::DOCUMENT_TYPES[$key],
                    'file_path' => $path,
                    'created_at' => $now,
                    'updated_at' => $now,
                ];
            }
        }

        if (!empty($documents)) {
            // Use updateOrCreate to avoid duplicates
            foreach ($documents as $doc) {
                Document::updateOrCreate(
                    [
                        'employee_id' => $doc['employee_id'],
                        'document_type' => $doc['document_type']
                    ],
                    $doc
                );
            }
        }
    }
}
