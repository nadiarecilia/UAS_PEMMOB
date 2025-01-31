<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CompanyProfileController;

/* NOTE: Do Not Remove
/ Livewire asset handling if using sub folder in domain
*/
Livewire::setUpdateRoute(function ($handle) {
    return Route::post(env('ASSET_PREFIX', '').'/livewire/update', $handle);
});

Livewire::setScriptRoute(function ($handle) {
    return Route::get(env('ASSET_PREFIX', '').'/livewire/livewire.js', $handle);
});
/*
/ END
*/

// Route untuk halaman utama
Route::get('/', function () {
    return view('welcome');
});

// Route untuk halaman profil perusahaan
Route::get('/company-profile', [CompanyProfileController::class, 'index']);
