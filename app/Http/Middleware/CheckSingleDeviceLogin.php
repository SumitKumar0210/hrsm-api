<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class CheckSingleDeviceLogin
{
    public function handle(Request $request, Closure $next)
    {
        $user = auth('api')->user();

        if (! $user) {
            return response()->json([
                'message' => 'Unauthenticated'
            ], 401);
        }

        $token = auth('api')->getToken();

        if (! $token) {
            return response()->json([
                'message' => 'Token missing'
            ], 401);
        }

        $hashedToken = hash('sha256', $token->get());
        

        if ($user->token !== $hashedToken) {
            return response()->json([
                'message' => 'Session expired or new login detected'
            ], 401);
        }

        return $next($request);
    }
}
