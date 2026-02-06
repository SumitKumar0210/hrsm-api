<?php

namespace App\Http\Controllers\Api\Employee;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Employee;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Mail;
use App\Mail\OnboardingMail;

class OnboardingController extends Controller
{
    /**
     * Store new employee (Onboarding)
     */
    public function store(Request $request)
    {
        // return response()->json([
        //         'success' => true,
        //         'message' => 'Employee onboarded successfully',
        //         'data'    => $request->all()
        //     ], 201);

        $validator = Validator::make($request->all(), [
            'first_name' => 'required|string|max:100',
            'last_name'  => 'required|string|max:100',
            'email'     => 'required|email|unique:users,email',
            'phone'     => 'required|string|max:15',

            'source'      => 'required|string',
            'job_role'     => 'required|string',
            'department'  => 'required|string',
            'shift_type'   => 'required|string',
            'shift_timing' => 'required|string',

            'idProof'        => 'nullable|file|mimes:jpg,jpeg,png,pdf|max:2048',
            'addressProof'   => 'nullable|file|mimes:jpg,jpeg,png,pdf|max:2048',
            'bankDetails'    => 'nullable|file|mimes:jpg,jpeg,png,pdf|max:2048',
            'contractLetter' => 'nullable|file|mimes:jpg,jpeg,png,pdf|max:2048',
            'profileImage'   => 'nullable|image|max:2048',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors'  => $validator->errors()->all()
            ], 422);
        }

        DB::beginTransaction();

        try {
            // Create user
            $user = User::create([
                'name'     => trim($request->firstName . ' ' . $request->lastName),
                'email'    => $request->email,
                'password' => Hash::make('12345678'), // default password
            ]);

            // Generate employee code (year-wise reset)
            $empCode = $this->generateEmployeeCode();

            // Upload documents
            $uploads = $this->handleUploads($request, $user->id);

            // Create employee
            $employee = Employee::create([
                'user_id'       => $user->id,
                'mobile'        => $request->phone,
                'first_name'        => $request->first_name,
                'last_name'        => $request->last_name,
                'email'    => $request->email,
                'department_id'    => $request->department_id?? 2,
                'employee_code' => $empCode,
                'source'        => $request->source,
                'job_role'      => $request->job_role,
                'department'    => $request->department,
                'shift_type'    => $request->shift_type,
                'shift_timing'  => $request->shift_timing,

                'id_proof'        => $uploads['idProof'] ?? null,
                'address_proof'   => $uploads['addressProof'] ?? null,
                'bank_details'    => $uploads['bankDetails'] ?? null,
                'contract_letter' => $uploads['contractLetter'] ?? null,
                'profile_image'   => $uploads['profileImage'] ?? null,
            ]);

            Mail::to('sumitkrtechie@gmail.com')->send(new OnboardingMail($employee));
            // Mail::to($employee->email)->send(new OnboardingMail($employee));
            DB::commit();


            return response()->json([
                'success' => true,
                'message' => 'Employee onboarded successfully',
                'data'    => $employee
            ], 201);

        } catch (\Throwable $e) {

            DB::rollBack();

            Log::error('Employee onboarding error', [
                'message' => $e->getMessage(),
                'line'    => $e->getLine(),
                'file'    => $e->getFile(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Employee onboarding failed'
            ], 500);
        }
    }

    /**
     * List employees
     */
    public function index()
    {
        // $employee = Employee::first();
        // if($employee){
        //     $mail = Mail::to('sumitkrtechie@gmail.com')->send(new OnboardingMail($employee));
        // }
        return response()->json([
            'success' => true,
            'data' => Employee::with('user')->latest()->get()
        ], 200);
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
        $files = [
            'idProof',
            'addressProof',
            'bankDetails',
            'contractLetter',
            'profileImage',
        ];

        $uploads = [];

        foreach ($files as $field) {
            if ($request->hasFile($field)) {
                $uploads[$field] = $request
                    ->file($field)
                    ->store("employees/{$userId}", 'public');
            }
        }

        return $uploads;
    }
}
