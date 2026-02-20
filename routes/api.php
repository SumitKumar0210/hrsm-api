<?php

use App\Http\Controllers\Api\Attendance\AttendanceController;
use App\Http\Controllers\Api\Auth\AuthController;
use App\Http\Controllers\Api\Department\DepartmentController;
use App\Http\Controllers\Api\Designation\DesignationController;
use App\Http\Controllers\Api\Employee\OnboardingController;
use App\Http\Controllers\Api\Employee\OTConfigurationController;
use App\Http\Controllers\Api\Leave\LeaveController;
use App\Http\Controllers\Api\Payroll\PayrollController;
use App\Http\Controllers\Api\RolePermission\RoleController;
use App\Http\Controllers\Api\Salary\SalaryManagementController;
use App\Http\Controllers\Api\Setting\SettingController;
use App\Http\Controllers\Api\Shift\ShiftController;
use App\Http\Controllers\Api\Template\MailTemplateController;
use App\Http\Controllers\Api\Template\TemplateVariableController;
use App\Models\Setting;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::post('/login', [AuthController::class, 'login']);

Route::middleware('auth:api')->group(function () {
    Route::post('/me', [AuthController::class, 'me']);
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::post('/refresh', [AuthController::class, 'refresh']);
});

Route::middleware('auth:api', 'single.device')->group(function () {
    Route::get('/me', [AuthController::class, 'me']);
    Route::post('/logout', [AuthController::class, 'logout']);

    Route::prefix('departments')->group(function () {
        Route::get('/', [DepartmentController::class, 'index']);
        Route::get('/active', [DepartmentController::class, 'activeDepartment']);
        Route::post('/', [DepartmentController::class, 'store']);
        Route::get('{id}', [DepartmentController::class, 'show']);
        Route::post('{id}', [DepartmentController::class, 'update']);
        Route::delete('{id}', [DepartmentController::class, 'destroy']);
    });

    Route::prefix('designation')->group(function () {
        Route::get('/', [DesignationController::class, 'index']);
        Route::get('/active', [DesignationController::class, 'activeDesignation']);
        Route::post('/', [DesignationController::class, 'store']);
        Route::get('{id}', [DesignationController::class, 'show']);
        Route::post('{id}', [DesignationController::class, 'update']);
        Route::delete('{id}', [DesignationController::class, 'destroy']);
    });

    Route::prefix('employees')->group(function () {
        Route::get('/', [OnboardingController::class, 'index']);
        Route::get('/{id}', [OnboardingController::class, 'show']);
        Route::post('/{id}', [OnboardingController::class, 'update']);
        // Route::post('/{id}', function (){return response()->json(['success'=>true,'message'=> 'pass']);});
        Route::patch('/{id}/status', [OnboardingController::class, 'toggleStatus']);
        Route::post('/search', [OnboardingController::class, 'search']);
        Route::post('/onboarding', [OnboardingController::class, 'store']);
    });

    Route::prefix('attendance')->group(function () {
        Route::post('/upload-csv', [AttendanceController::class, 'uploadAttendance']);
        Route::post('/', [AttendanceController::class, 'index']);
        Route::post('/employee/{id}', [AttendanceController::class, 'employeeAttendance']);
        Route::post('/correct', [AttendanceController::class, 'correction']);
    });

    Route::prefix('shifts')->group(function () {
        Route::get('/', [ShiftController::class, 'index']);
        Route::get('/active', [ShiftController::class, 'activeShift']);
        Route::post('/', [ShiftController::class, 'store']);
        Route::get('{id}', [ShiftController::class, 'show']);
        Route::post('{id}', [ShiftController::class, 'update']);
        Route::delete('{id}', [ShiftController::class, 'destroy']);
    });

    Route::prefix('roles')->group(function () {
        Route::get('/', [RoleController::class, 'index']);
        Route::post('/', [RoleController::class, 'store']);
        Route::get('{id}', [RoleController::class, 'show']);
        Route::post('{id}', [RoleController::class, 'update']);
        Route::delete('{id}', [RoleController::class, 'destroy']);
    });

    Route::prefix('salary')->group(function () {
        Route::get('{employeeId}', [SalaryManagementController::class, 'show']);
        Route::post('/', [SalaryManagementController::class, 'store']);
        // Route::get('history/{employeeId}', [SalaryManagementController::class, 'history']);
    });

    Route::prefix('leaves')->group(function () {
        Route::get('/', [LeaveController::class, 'index']);
        Route::post('/', [LeaveController::class, 'store']);
        Route::post('{id}/approve', [LeaveController::class, 'approve']);
        Route::post('{id}/reject', [LeaveController::class, 'reject']);
        Route::post('{id}/cancel', [LeaveController::class, 'cancel']);
        Route::delete('{id}', [LeaveController::class, 'destroy']);
    });

    Route::prefix('emp-config')->group(function () {
        Route::get('/',  [OTConfigurationController::class, 'index']);
        Route::post('/', [OTConfigurationController::class, 'store']);
        Route::get('{id}', [OTConfigurationController::class, 'show']);
        Route::post('{id}', [OTConfigurationController::class, 'update']);
        Route::delete('{id}', [OTConfigurationController::class, 'destroy']);
    });

    Route::prefix('template-variables')->group(function () {
        // Route::get('/', function(){return response()->json(['success' => true, 'data' => []]);});
        Route::get('/', [TemplateVariableController::class, 'index']);
        Route::get('/table-variable', [TemplateVariableController::class, 'tableVariables']);
        Route::post('/', [TemplateVariableController::class, 'store']);
        Route::delete('{id}', [TemplateVariableController::class, 'destroy']);
    });

    Route::prefix('templates')->group(function () {
        Route::get('/', [MailTemplateController::class, 'index']);
        Route::post('/', [MailTemplateController::class, 'store']);
        Route::get('{id}', [MailTemplateController::class, 'show']);
        Route::post('{id}', [MailTemplateController::class, 'update']);
        Route::delete('{id}', [MailTemplateController::class, 'destroy']);
    });

    Route::prefix('payroll')->group(function () {
        Route::get('/', [PayrollController::class, 'index']);
        Route::post('/process', [PayrollController::class, 'processPayroll']);
        Route::post('/', [MailTemplateController::class, 'store']);
        Route::get('{id}', [MailTemplateController::class, 'show']);
        Route::post('{id}', [MailTemplateController::class, 'update']);
        Route::delete('{id}', [MailTemplateController::class, 'destroy']);
    });

    Route::prefix('setting')->group(function () {
        Route::get('/', [SettingController::class, 'index']);
        Route::post('/', [SettingController::class, 'update']);
        Route::post('/upload-logo', [SettingController::class, 'uploadLogo']);
    });
});
