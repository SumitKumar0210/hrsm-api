<?php
namespace App\Http\Controllers\Api\Payroll;

use App\Http\Controllers\Controller;
use App\Models\Payroll;
use Exception;
use Illuminate\Http\Request;

class PayrollController extends Controller
{
    public function index(Request $request)
    {
        try{
            return response()->json([
                'success' => true,
                'data' => Payroll::get()
            ]);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
                'error' => 'Something went wrong'
            ],442);
        }
    }
}