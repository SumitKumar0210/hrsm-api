<?php

namespace App\Http\Controllers\Api\Template;

use App\Http\Controllers\Controller;
use App\Models\TemplateVariable;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class TemplateVariableController extends Controller
{
    /**
     * List template variables
     */
    public function index()
    {
        try {
            return response()->json([
                'success' => true,
                'data' => TemplateVariable::latest()->get()
            ], 200);
        } catch (Exception $e) {
            Log::error($e);

            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch template variables',
            ], 500);
        }
    }

    /**
     * Store template variable
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => [
                'required',
                'string',
                'max:255',
                Rule::unique('template_variables', 'name')->whereNull('deleted_at'),
            ],
            'value' => [
                'required',
                'string',
                'max:255',
                Rule::unique('template_variables', 'value')->whereNull('deleted_at'),
            ],
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors'  => $validator->errors(),
            ], 422);
        }

        try {
            $variable = TemplateVariable::create([
                'name'  => $request->name,
                'value' => $request->value,
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Template variable created successfully',
                'data'    => $variable,
            ], 201);
        } catch (Exception $e) {
            Log::error($e);

            return response()->json([
                'success' => false,
                'message' => 'Template variable creation failed',
            ], 500);
        }
    }

    /**
     * Show template variable
     */
    public function show($id)
    {
        $variable = TemplateVariable::find($id);

        if (!$variable) {
            return response()->json([
                'success' => false,
                'message' => 'Template variable not found',
            ], 404);
        }

        return response()->json([
            'success' => true,
            'data'    => $variable,
        ], 200);
    }

    /**
     * Update template variable
     */
    public function update(Request $request, $id)
    {
        $variable = TemplateVariable::find($id);

        if (!$variable) {
            return response()->json([
                'success' => false,
                'message' => 'Template variable not found',
            ], 404);
        }

        $validator = Validator::make($request->all(), [
            'name' => [
                'required',
                'string',
                'max:255',
                Rule::unique('template_variables', 'name')
                    ->ignore($variable->id)
                    ->whereNull('deleted_at'),
            ],
            'value' => [
                'required',
                'string',
                'max:255',
                Rule::unique('template_variables', 'value')
                    ->ignore($variable->id)
                    ->whereNull('deleted_at'),
            ],
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors'  => $validator->errors(),
            ], 422);
        }

        $variable->update([
            'name'  => $request->name,
            'value' => $request->value,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Template variable updated successfully',
            'data'    => $variable,
        ], 200);
    }

    /**
     * Delete template variable (soft delete)
     */
    public function destroy($id)
    {
        $variable = TemplateVariable::find($id);

        if (!$variable) {
            return response()->json([
                'success' => false,
                'message' => 'Template variable not found',
            ], 404);
        }

        $variable->delete();

        return response()->json([
            'success' => true,
            'message' => 'Template variable deleted successfully',
        ], 200);
    }
}
