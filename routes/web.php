<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\WikiController;
use Inertia\Inertia;

Route::get('/', function () {
    return Inertia::render('Welcome', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
});

Route::get('/', function () {
    return Inertia::render('Welcome');
})->name('welcome');


Route::get('/wiki', function () {
    return Inertia::render('Wiki/Index');
})->name('wiki.index');

Route::get('/faq', function () {
    return Inertia::render('Faq');
})->name('faq');

Route::get('/dashboard', function () {
    return Inertia::render('Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

// WIKI

Route::prefix('wiki')->group(function () {
    Route::get('/', [WikiController::class, 'index'])->name('wiki.index');
    Route::get('/search', [WikiController::class, 'search'])->name('wiki.search');
    Route::get('/{slug}', [WikiController::class, 'show'])->where('slug', '.*')->name('wiki.show');
});

require __DIR__.'/auth.php';
