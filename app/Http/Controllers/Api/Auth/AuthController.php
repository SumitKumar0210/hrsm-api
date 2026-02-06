<?php

namespace App\Http\Controllers\Api\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $credentials = $request->only('email', 'password');

        if (!$token = Auth::guard('api')->attempt($credentials)) {
            return response()->json([
                'status' => false,
                'message' => 'Invalid credentials'
            ], 401);
        }
        $user = auth('api')->user();

        // Store hash of token (single-device enforcement)
        $user->token = hash('sha256', $token);
        $user->save();

        return response()->json([
            'status' => true,
            'token' => $token,
            'type' => 'bearer',
            'expires_in' => auth('api')->factory()->getTTL() * (60*24*365)
        ]);
    }

    public function me()
    {
        return response()->json(auth('api')->user());
    }

    public function logout()
    {
        $user = auth('api')->user();

        $user->token = null;
        $user->save();

        auth('api')->logout(true);

        return response()->json([
            'message' => 'Successfully logged out'
        ]);
    }

    public function refresh()
    {
        $token = auth('api')->refresh();
        $user = auth('api')->user();

        // Store hash of token (single-device enforcement)
        $user->token = hash('sha256', $token);
        $user->save();

        return response()->json([
            'token' => $token
        ]);
    }
}
