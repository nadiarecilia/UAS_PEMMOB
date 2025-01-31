<?php

use App\Filament\Admin\Resources\ProductResource\Api\Handlers\CreateHandler;
use App\Filament\Admin\Resources\ProductResource\Api\Handlers\DeleteHandler;
use App\Filament\Admin\Resources\ProductResource\Api\Handlers\DetailHandler;
use App\Filament\Admin\Resources\ProductResource\Api\Handlers\PaginationHandler;
use App\Filament\Admin\Resources\ProductResource\Api\Handlers\UpdateHandler;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;

Route::post('/login', [AuthController::class, 'login'])->name('api.login');

Route::middleware('auth:sanctum')->group(function () {
// Rute untuk mendapatkan data user (contoh)
    Route::get('/user', function (Request $request) {
        return $request->user();
    });

    // Rute untuk resource "products"
    Route::prefix('products')->group(function () {
        Route::post('/', [CreateHandler::class, 'handler'])->name('api.products.create'); // Membuat produk baru
        Route::get('/', [PaginationHandler::class, 'handler'])->name('api.products.pagination'); // Pagination produk
        Route::get('/{id}', [DetailHandler::class, 'handler'])->name('api.products.detail'); // Mendapatkan detail produk
        Route::put('/{id}', [UpdateHandler::class, 'handler'])->name('api.products.update'); // Update produk
        Route::delete('/{id}', [DeleteHandler::class, 'handler'])->name('api.products.delete'); // Hapus produk
    });

});