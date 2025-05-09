<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\FiveMController;

Route::prefix('berlincity')->group(function () {
    Route::post('/kick', [FiveMController::class, 'kickPlayer']);
});

Route::post('/berlincity/kick', [FiveMController::class, 'kickPlayer']);
