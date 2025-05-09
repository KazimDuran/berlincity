<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class FiveMController extends Controller
{
    public function kickPlayer(Request $request)
    {
        $request->validate([
            'player_id' => 'required|integer',
            'reason' => 'nullable|string',
        ]);

        $response = Http::withHeaders([
            'x-api-key' => env('FIVEM_API_KEY'),
        ])->post(env('FIVEM_SERVER_URL') . '/berlincity/kick', [
            'player_id' => $request->player_id,
            'reason' => $request->reason ?? 'Kein Grund',
        ]);

        return response()->json([
            'fivem_response' => $response->json(),
            'status' => $response->status(),
        ]);
    }
}
