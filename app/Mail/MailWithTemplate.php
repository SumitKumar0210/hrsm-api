<?php

namespace App\Mail;

use App\Models\TemplateVariable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Carbon\Carbon;

class MailWithTemplate extends Mailable
{
    use SerializesModels;

    protected $employee;
    protected $template;
    protected $context; // generic context (payroll, offer, termination etc.)

    public function __construct($employee, $template, $context = null)
    {
        $this->employee = $employee;
        $this->template = $template;
        $this->context  = $context; // can be Payroll / OfferLetter / Termination etc.
    }

    public function build()
    {
        $subject = $this->replaceVariables($this->template->subject);
        $content = $this->replaceVariables($this->template->body);

        return $this->subject($subject)
            ->html($content);
    }

    private function replaceVariables($content)
    {
        if (!$content) return '';

        $variables = TemplateVariable::whereNull('deleted_at')
            ->pluck('value', 'name'); // optimized query

        foreach ($variables as $name => $valueKey) {

            $placeholder = '{{' . $name . '}}';

            $value = $this->getDynamicValue($valueKey);

            $content = str_replace($placeholder, $value ?? '', $content);
        }

        return $content;
    }

    private function getDynamicValue($key)
    {
        $employee = $this->employee;
        $context  = $this->context;

        $key = strtolower(trim($key));

        switch ($key) {

            /* ================= EMPLOYEE FIELDS ================= */

            case 'name':
                return trim(($employee->first_name ?? '') . ' ' . ($employee->last_name ?? ''));

            case 'employee_code':
                return $employee->employee_code ?? '';

            case 'blood_group':
                return $employee->blood_group ?? '';

            case 'aadhar_number':
                return $employee->aadhar_number ?? '';

            case 'designation':
                return $employee->designation->name ?? '';

            case 'department':
                return $employee->department->name ?? '';

            case 'basic_salary':
                return number_format($employee->salaries[0]->basic_salary ?? 0);

            case 'hra':
                return number_format($employee->salaries[0]->hra ?? 0);

            case 'special_allowance':
                return number_format($employee->salaries[0]->special_allowance ?? 0);

            /* ================= PAYROLL FIELDS ================= */

            case 'month':
                if ($context && isset($context->month)) {
                    return Carbon::createFromDate(
                        $context->year,
                        $context->month,
                        1
                    )->format('F');
                }
                return '';

            case 'year':
                return $context->year ?? '';

            case 'gross_salary':
                return number_format($context->gross_salary ?? 0);

            case 'net_salary':
                return number_format($context->net_salary ?? 0);

            case 'total_deduction':
                return number_format($context->total_deduction ?? 0);

            /* ================= GENERIC CONTEXT FIELDS ================= */
            // Works for OfferLetter, Termination etc.
            default:
                if ($context && isset($context->{$key})) {
                    return $context->{$key};
                }

                return '';
        }
    }
}