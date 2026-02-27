<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <title>Salary Slip</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #ffffff;
            font-size: 12px;
            color: #1a1a1a;
        }

        .slip {
            width: 100%;
            background: #ffffff;
        }

        /* ── HEADER ── */
        .header-table {
            width: 100%;
            border-collapse: collapse;
            border-bottom: 3px solid #e05a4a;
        }

        .logo-cell {
            /* background: #e05a4a; */
            width: 160px;
            padding: 16px 20px;
            text-align: center;
            vertical-align: middle;
        }

        .logo-text {
            color: #ffffff;
            font-size: 17px;
            font-weight: bold;
            letter-spacing: 1px;
            line-height: 1.4;
        }

        .logo-text img {
            width: 50px;
        }

        .logo-icon {
            font-size: 26px;
            color: #ffffff;
            display: block;
            margin-bottom: 4px;
        }

        .company-cell {
            text-align: right;
            padding: 14px 22px;
            vertical-align: middle;
        }

        .company-cell h1 {
            font-size: 22px;
            font-weight: 800;
            letter-spacing: 2px;
            color: #1a1a1a;
            margin-bottom: 5px;
        }

        .company-cell p {
            font-size: 11.5px;
            color: #555;
            line-height: 1.7;
        }

        /* ── EMPLOYEE INFO ── */
        .employee-table {
            width: 100%;
            border-collapse: collapse;
            padding: 0 28px;
            margin-top: 16px;
        }

        .info-label {
            font-weight: 700;
            font-size: 12px;
            white-space: nowrap;
            width: 115px;
            padding: 0 0 8px 28px;
            vertical-align: bottom;
        }

        .info-value {
            font-size: 12px;
            color: #333;
            /* border-bottom: 1px solid #333; */
            padding: 0 4px 3px 4px;
            /* vertical-align: bottom; */
            /* width: 160px; */
        }

        .info-spacer {
            width: 30px;
        }

        /* ── SALARY TABLE ── */
        .table-wrap {
            padding: 10px 28px 4px;
        }

        .salary-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 12px;
        }

        .section-header-cell {
            padding: 6px 10px;
            font-weight: 800;
            font-size: 12.5px;
            color: #e05a4a;
            border-top: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
            background: #fff;
            letter-spacing: 0.5px;
        }

        .divider-cell {
            border-left: 1px solid #ccc;
        }

        .data-label {
            padding: 5px 10px;
            color: #333;
            border-bottom: 1px solid #f0f0f0;
            width: 38%;
        }

        .data-amount {
            padding: 5px 10px;
            color: #333;
            border-bottom: 1px solid #f0f0f0;
            text-align: right;
            width: 12%;
        }

        .data-label-r {
            padding: 5px 10px;
            color: #333;
            border-bottom: 1px solid #f0f0f0;
            border-left: 1px solid #ccc;
            width: 38%;
        }

        .data-amount-r {
            padding: 5px 10px;
            color: #333;
            border-bottom: 1px solid #f0f0f0;
            text-align: right;
            width: 12%;
        }

        .spacer-cell {
            padding: 5px 10px;
            border-bottom: 1px solid #f0f0f0;
        }

        .spacer-cell-r {
            padding: 5px 10px;
            border-bottom: 1px solid #f0f0f0;
            border-left: 1px solid #ccc;
        }

        .total-label {
            padding: 6px 10px;
            font-weight: 700;
            border-top: 1px solid #ccc;
            border-bottom: 1px solid #ccc;
            background: #fafafa;
        }

        .total-amount {
            padding: 6px 10px;
            font-weight: 700;
            border-top: 1px solid #ccc;
            border-bottom: 1px solid #ccc;
            background: #fafafa;
            text-align: right;
        }

        .total-label-r {
            padding: 6px 10px;
            font-weight: 700;
            border-top: 1px solid #ccc;
            border-bottom: 1px solid #ccc;
            background: #fafafa;
            border-left: 1px solid #ccc;
        }

        .total-amount-r {
            padding: 6px 10px;
            font-weight: 700;
            border-top: 1px solid #ccc;
            border-bottom: 1px solid #ccc;
            background: #fafafa;
            text-align: right;
        }

        .net-empty {
            padding: 6px 10px;
            border-bottom: 1px solid #ccc;
            background: #fafafa;
        }

        .net-label {
            padding: 6px 10px;
            font-weight: 800;
            color: #e05a4a;
            border-bottom: 1px solid #ccc;
            background: #fafafa;
            border-left: 1px solid #ccc;
        }

        .net-amount {
            padding: 6px 10px;
            font-weight: 800;
            color: #e05a4a;
            font-size: 13px;
            border-bottom: 1px solid #ccc;
            background: #fafafa;
            text-align: right;
        }

        /* ── TOTAL WORDS ── */
        .total-words {
            padding: 10px 28px 4px;
            font-size: 12.5px;
        }

        .total-words .label {
            color: #e05a4a;
            font-weight: 700;
            font-size: 13px;
        }

        .total-words .value {
            font-weight: 600;
            color: #333;
            margin-left: 4px;
        }

        /* ── BANK SECTION ── */
        .bank-table {
            width: 100%;
            border-collapse: collapse;
            padding: 0 28px;
            margin-top: 6px;
            margin-bottom: 10px;
        }

        .bank-label {
            font-weight: 700;
            font-size: 12px;
            white-space: nowrap;
            width: 115px;
            padding: 0 0 10px 28px;
            vertical-align: middle;
        }

        .bank-value {
            font-size: 12px;
            color: #333;
            /* border-bottom: 1px solid #333; */
            padding: 0 4px 10px 4px;
            /* vertical-align: bottom; */
            /* width: 160px; */
        }

        /* ── DISCLAIMER ── */
        .disclaimer {
            text-align: center;
            padding: 8px 28px 10px;
            border-top: 1px solid #f0f0f0;
            font-size: 11px;
            color: #888;
            font-style: italic;
        }

        /* ── FOOTER ── */
        .footer {
            background: #e05a4a;
            text-align: center;
            padding: 7px 20px;
        }

        .footer p {
            color: #ffffff;
            font-size: 11px;
            letter-spacing: 0.3px;
        }

        .signature-img {
            display: block;
            max-height: 48px;
            max-width: 150px;
            width: auto;
            height: auto;
            object-fit: contain;
        }

        td.logo-cell img {
            width: 50px;
        }
    </style>
</head>

<body>
    <div class="slip">

        <!-- HEADER -->
        <table class="header-table">
            <tr>
                <td class="logo-cell">
                    @php $logoPath = 'http://localhost:8000/storage/' . ($companyDetail['logo'] ?? ''); @endphp
                    @if (!empty($companyDetail['logo']))
                        <img src="{{ $logoPath }}" alt="{{ $companyDetail['application_name'] ?? 'Logo' }}">
                    @else
                        <span style="font-weight:bold; font-size:15px; color:#555;">
                            {{ $companyDetail['application_name'] ?? 'YOUR LOGO' }}
                        </span>
                    @endif
                </td>
                <td class="company-cell">
                    <h1>SALARY SLIP</h1>
                    <p>{{ $companyDetail['address'] }}</p>
                    <p>{{ $companyDetail['contact'] }}</p>
                </td>
            </tr>
        </table>

        <!-- EMPLOYEE INFO -->
        <table class="employee-table" style="margin-top:16px;">
            <tr>
                <td class="info-label">Name:</td>
                <td class="info-value"> {{ $employee->first_name }}  {{ $employee->last_name }} </td>
                <td class="info-spacer"></td>
                <td class="info-label">Joining Date</td>
                <td class="info-value"> {{$employee->date_of_joining ? date('d-m-Y',strtotime($employee->date_of_joining)) : '' }} </td>
            </tr>
            <tr>
                <td colspan="5" style="height:8px;"></td>
            </tr>
            <tr>
                <td class="info-label">Designation:</td>
                <td class="info-value"> {{ $employee->designation?->name?? '' }} </td>
                <td class="info-spacer"></td>
                <td class="info-label">Department:</td>
                <td class="info-value"> {{ $employee->department?->name?? '' }} </td>
            </tr>
        </table>

        <!-- EARNINGS & DEDUCTIONS TABLE -->
        <div class="table-wrap">
            <table class="salary-table">

                <!-- Section Headers -->
                <tr>
                    <td class="section-header-cell" colspan="2">EARNINGS</td>
                    <td class="section-header-cell divider-cell" colspan="2">DEDUCTIONS</td>
                </tr>

                <!-- Row 1 -->
                <tr>
                    <td class="data-label">BASIC</td>
                    <td class="data-amount"> {{ $employee->paroll?->basic_amount ?? 0 }} </td>
                    <td class="data-label-r">Personal</td>
                    <td class="data-amount-r"> 0 </td>
                </tr>

                <!-- Row 2 -->
                <tr>
                    <td class="data-label">HRA</td>
                    <td class="data-amount"> {{$payroll?->hra_allowance ?? 0}} </td>
                    <td class="data-label-r">Phone Charges</td>
                    <td class="data-amount-r"> 0 </td>
                </tr>

                <!-- Row 3 -->
                <tr>
                    <td class="data-label">Conveyance</td>
                    <td class="data-amount"> {{$payroll?->conveyance_allowance ?? 0}} </td>
                    <td class="data-label-r">Misc. Value</td>
                    <td class="data-amount-r"> 0 </td>
                </tr>

                <tr>
                    <td class="data-label">MEDICAL ALLOWANCE</td>
                    <td class="data-amount"> {{$payroll?->medical_allowance ?? 0}} </td>
                    <td class="data-label-r">PF </td>
                    <td class="data-amount-r"> {{ $payroll?->pf_amount ?? 0 }} </td>
                </tr>

                <tr>
                    <td class="data-label">SPECIAL ALLOWANCE</td>
                    <td class="data-amount"> {{$payroll?->special_allowance ?? 0}} </td>
                    <td class="data-label-r">ESIC</td>
                    <td class="data-amount-r"> {{ $payroll?->esic_amount ?? 0 }} </td>
                </tr>

                <tr>
                    <td class="data-label">CHILDREN EDUCATION ALLOWANCE</td>
                    <td class="data-amount"> 0 </td>
                    <td class="data-label-r">PROF TAX </td>
                    <td class="data-amount-r"> 0 </td>
                </tr>

                <tr>
                    <td class="data-label">TELEPHONE REIMBURSEMENT</td>
                    <td class="data-amount"> 0 </td>
                    <td class="data-label-r">INCOME TAX </td>
                    <td class="data-amount-r"> 0 </td>
                </tr>

                <tr>
                    <td class="data-label">NEWSPAPER AND JOURNAL ALLOWANCE </td>
                    <td class="data-amount"> 0 </td>
                    <td class="data-label-r">SALARY ADVANCE</td>
                    <td class="data-amount-r"> 0 </td>
                </tr>

                <tr>
                    <td class="data-label">LEAVE TRAVEL ALLOWANCE </td>
                    <td class="data-amount"> 0 </td>
                    <td class="data-label-r"></td>
                    <td class="data-amount-r"> </td>
                </tr>

                <!-- Spacer rows -->
                <tr>
                    <td class="spacer-cell">&nbsp;</td>
                    <td class="spacer-cell"></td>
                    <td class="spacer-cell-r"></td>
                    <td class="spacer-cell"></td>
                </tr>
                <tr>
                    <td class="spacer-cell">&nbsp;</td>
                    <td class="spacer-cell"></td>
                    <td class="spacer-cell-r"></td>
                    <td class="spacer-cell"></td>
                </tr>

                <!-- Totals -->
                <tr>
                    <td class="total-label">Total Earnings</td>
                    <td class="total-amount"> {{ $payroll?->gross_salary ?? 0 }} </td>
                    <td class="total-label-r">Total Deductions</td>
                    <td class="total-amount-r"> {{ $payroll?->deductions ?? 0 }} </td>
                </tr>

                <!-- Net Salary -->
                <tr>
                    <td class="net-empty" colspan="2"></td>
                    <td class="net-label">Net Salary</td>
                    <td class="net-amount"> {{ $payroll?->net_salary ?? 0 }} </td>
                </tr>

            </table>
        </div>

        <!-- TOTAL AMOUNT IN WORDS -->
        <div class="total-words">
            <span class="label">({{ $payroll?->net_salary ?? 0 }})</span>
            <span class="value"> {{ $companyDetail['total_amount_words'] }} </span>
        </div>

        <!-- BANK DETAILS -->
        <table class="bank-table" style="margin-top:10px;">
            <tr>
                <td class="bank-label">Transaction Date:</td>
                <td class="bank-value"> $transaction_date </td>
                <td class="info-spacer"></td>
                <td class="bank-label">Signatures:</td>
                <td class="bank-value">
                    @if (file_exists(public_path('storage/signature/signature.png')))
                        <img src="{{ asset('/storage/signature/signature.png') }}" class="signature-img"
                            alt="Signature">
                    @else
                        &nbsp;
                    @endif
                </td>
            </tr>
        </table>

        <!-- DISCLAIMER -->


        <!-- FOOTER -->
        <div class="footer">
            <p>{{ $companyDetail['application_name']?? '' }}</p>
        </div>
        <div class="disclaimer">
            This is a system-generated salary slip and does not require a signature.
        </div>

    </div>
</body>

</html>
