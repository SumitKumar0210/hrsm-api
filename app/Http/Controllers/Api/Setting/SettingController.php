<?php

namespace App\Http\Controllers\Api\Setting;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Setting;
use Illuminate\Support\Facades\Storage;

class SettingController extends Controller
{
    public function index()
    {
        return response()->json([
            'success' => true,
            'data' => Setting::first() ?? [],
        ]);
    }

    public function update(Request $request)
    {
        $validated = $request->validate([
            'companyName'      => 'required|string|max:255',
            'phone'            => 'required|string|max:20',
            'email'            => 'required|email',
            'address'          => 'required|string',
            'city'             => 'required|string',
            'state'            => 'required|string',
            'country'          => 'required|string',
            'zip'              => 'required|string',
            'about'            => 'required|string',
            'shortDescription' => 'required|string',
            'apiKey'           => 'required|string',
            'brandColor'       => 'nullable|string',
            'logo'             => 'nullable|image|mimes:png,jpg,jpeg,svg|max:2048',
            'favicon'          => 'nullable|image|mimes:png,jpg,jpeg,ico|max:1024',
        ]);

        $setting = Setting::first();

        $data = [
            'application_name'  => $validated['companyName'],
            'contact'           => $validated['phone'],
            'email'             => $validated['email'],
            'address'           => $validated['address'],
            'city'              => $validated['city'],
            'state'             => $validated['state'],
            'country'           => $validated['country'],
            'zip'               => $validated['zip'],
            'about'             => $validated['about'],
            'short_description' => $validated['shortDescription'],
            'api_key'           => $validated['apiKey'],
            'theme_color'       => $validated['brandColor'],
        ];

        $setting = $setting
            ? tap($setting)->update($data)
            : Setting::create($data);

        return response()->json([
            'success' => true,
            'message' => 'Settings updated successfully',
            'data' => $setting,
        ]);
    }

    public function uploadLogo(Request $request)
    {
        $validated = $request->validate([
            'logo'             => 'nullable|image|mimes:png,jpg,jpeg,svg|max:2048',
            'favicon'          => 'nullable|image|mimes:png,jpg,jpeg,ico|max:1024',
        ]);

        $setting = Setting::first();

        /** Handle uploads */
        $logoPath = $this->uploadFile($request, 'logo', $setting?->logo);
        $faviconPath = $this->uploadFile($request, 'favicon', $setting?->favicon);

        $data = [
            'logo'              => $logoPath,
            'favicon'           => $faviconPath,
        ];

        $setting = $setting
            ? tap($setting)->update($data)
            : Setting::create($data);

        return response()->json([
            'success' => true,
            'message' => 'Settings updated successfully',
            'data' => $setting,
        ]);
    }

    private function uploadFile(Request $request, string $field, ?string $oldFile = null)
    {
        if (!$request->hasFile($field)) {
            return $oldFile;
        }

        // Delete old file
        if ($oldFile && Storage::disk('public')->exists($oldFile)) {
            Storage::disk('public')->delete($oldFile);
        }

        return $request->file($field)
            ->store('settings', 'public');
    }
}
