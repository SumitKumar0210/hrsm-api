<?php

namespace App\Http\Controllers\Api\Mail;

use App\Http\Controllers\Controller;
use App\Mail\MailWithTemplate;
use App\Models\Employee;
use App\Models\Payroll;
use App\Models\Setting;
use App\Models\Template;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\DB;
use Barryvdh\DomPDF\Facade\Pdf;
use NumberFormatter;

class SendTemplateMailController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | SINGLE PAYROLL MAIL
    |--------------------------------------------------------------------------
    */
    public function payrollSingleMail(Request $request)
    {
        $request->validate([
            'templateId' => 'required|exists:templates,id',
            'empId'      => 'required|exists:employees,id',
            'id'         => 'required|exists:payrolls,id',
        ]);

        $this->payrollMail(
            $request->templateId,
            $request->empId,
            $request->id
        );

        return response()->json([
            'success' => true,
            'message' => 'Mail sent successfully.',
        ]);
    }

    /*
    |--------------------------------------------------------------------------
    | BULK PAYROLL MAIL
    |--------------------------------------------------------------------------
    */
    public function bulkMailSendOfPayroll(Request $request)
    {
        $request->validate([
            'templateId' => 'required|exists:templates,id',
            'rows'       => 'required|array',
        ]);

        foreach ($request->rows as $row) {

            $this->payrollMail(
                $request->templateId,
                $row['empId'],
                $row['payrollId']
            );
        }

        return response()->json([
            'success' => true,
            'message' => 'Bulk mail sent successfully.',
        ]);
    }

    /*
    |--------------------------------------------------------------------------
    | CORE MAIL FUNCTION
    |--------------------------------------------------------------------------
    */
    private function payrollMail($templateId, $employeeId, $payrollId)
    {
        DB::transaction(function () use ($templateId, $employeeId, $payrollId) {

            $employee = Employee::with([
                'department',
                'shift',
                'shift.employeeShift',
                'designation',
                'salaries'
            ])->findOrFail($employeeId);

            $template = Template::findOrFail($templateId);

            $payroll = Payroll::findOrFail($payrollId);
            $setting = Setting::latest()->first();

            $netSalary = $payroll?->net_salary ?? 0;

            $formatter = new NumberFormatter('en_IN', NumberFormatter::SPELLOUT);

            $amountInWords = ucfirst($formatter->format($netSalary)) . ' only';
            $companyDetail = [
                'logo' => $setting->logo,
                'application_name' => $setting->application_name,
                'address' => $setting->address . ' ' . $setting->city . ' ' . $setting->state . ' ' . $setting->zip . ' ' . $setting->country,
                'contact' => $setting->contact,
                'themeColor' => $setting->theme_color,
                'total_amount_words' => $amountInWords
            ];


            $pdf = Pdf::loadView('pdf.salary_slip', [
                'employee' => $employee,
                'payroll'  => $payroll,
                'companyDetail'  => $companyDetail,
            ])->setPaper('a4', 'landscape');
   

            Mail::to('sumitkrtechie@gmail.com')
                // Mail::to($employee->email)
                ->send(new MailWithTemplate($employee, $template, $payroll, $pdf->output()));

            // Optional: mark payroll mail sent
            $payroll->update([
                'mail_sent_at' => now()
            ]);
        });
    }
}
