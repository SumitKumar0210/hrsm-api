<?php

use Illuminate\Support\Facades\Route;
use Barryvdh\DomPDF\Facade\Pdf;
use App\Http\Controllers\Api\Mail\SendTemplateMailController;
// Route::get('/', function () {
//    $pdf = Pdf::loadView('pdf.salary_slip', [
//             'employee' => 'test',
//             'payroll'  => 'tyuyu',
//         ])->setPaper('a4', 'landscape');
       
//         // return $pdf->stream();
//         return view('pdf.salary_slip');
// });
Route::get('/', [SendTemplateMailController::class, 'payrollSingleMail']);
// Route::get('/', function () {
//     return view('welcome');
// });

Route::middleware([
    'auth:sanctum',
    config('jetstream.auth_session'),
    'verified',
])->group(function () {
    Route::get('/dashboard', function () {
        return view('dashboard');
    })->name('dashboard');
});
