<?php

namespace App\Http\Controllers\Api\Template;

use App\Http\Controllers\Controller;
use App\Models\Template;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class MailTemplateController extends Controller
{
    /**
     * List templates
     */
    public function index()
    {
        try {
            return response()->json([
                'success' => true,
                'data' => Template::latest()->get()
            ], 200);
        } catch (Exception $e) {
            Log::error($e);

            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch templates'
            ], 500);
        }
    }

    /**
     * Store template
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => [
                'required',
                'string',
                'max:255',
                Rule::unique('templates', 'name')->whereNull('deleted_at'),
            ],
            'subject' => 'required|string|max:255',
            'draft'   => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors'  => $validator->errors(),
            ], 422);
        }

        $template = Template::create([
            'name'    => $request->name,
            'subject' => $request->subject,
            'draft'   => $request->draft,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Template created successfully',
            'data'    => $template,
        ], 201);
    }

    /**
     * Show template
     */
    public function show($id)
    {
        $template = Template::find($id);

        if (!$template) {
            return response()->json([
                'success' => false,
                'message' => 'Template not found',
            ], 404);
        }

        return response()->json([
            'success' => true,
            'data'    => $template,
        ], 200);
    }

    /**
     * Update template
     */
    public function update(Request $request, $id)
    {
        $template = Template::find($id);

        if (!$template) {
            return response()->json([
                'success' => false,
                'message' => 'Template not found',
            ], 404);
        }

        $validator = Validator::make($request->all(), [
            'name' => [
                'required',
                'string',
                'max:255',
                Rule::unique('templates', 'name')
                    ->ignore($template->id)
                    ->whereNull('deleted_at'),
            ],
            'subject' => 'required|string|max:255',
            'draft'   => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors'  => $validator->errors(),
            ], 422);
        }

        $template->update([
            'name'    => $request->name,
            'subject' => $request->subject,
            'draft'   => $request->draft,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Template updated successfully',
            'data'    => $template,
        ], 200);
    }

    /**
     * Delete template (soft delete)
     */
    public function destroy($id)
    {
        $template = Template::find($id);

        if (!$template) {
            return response()->json([
                'success' => false,
                'message' => 'Template not found',
            ], 404);
        }

        $template->delete();

        return response()->json([
            'success' => true,
            'message' => 'Template deleted successfully',
        ], 200);
    }
}
