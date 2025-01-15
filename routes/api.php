<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
use App\Http\Controllers\API\UserController;

// Rutas protegidas con autenticación (auth:sanctum)
Route::middleware('auth:sanctum',"IsAdmin")->group(function () {
    // Rutas para usuarios
    Route::get('users', [UserController::class, 'GetAll']); // Obtener todos los usuarios NO eliminados
    Route::get('users/{id}', [UserController::class, 'FindById']); // Obtener un usuario por ID (NO eliminado)

    Route::get('trash', [UserController::class, 'FindAllTrash']); // Obtener todos los usuarios eliminados
    Route::get('trash/{id}', [UserController::class, 'FindByTrash']); // Obtener un usuario eliminado por ID
    Route::get('with-trash', [UserController::class, 'FindWithTrash']); // Obtener todos los usuarios, incluyendo los eliminados

    Route::post('users', [UserController::class, 'Create']); // Crear un nuevo usuario
    Route::put('users/{id}', [UserController::class, 'Update']); // Actualizar un usuario existente
    Route::put('users/restore/{id}', [UserController::class, 'Restore']); // Restaurar un usuario eliminado

    Route::delete('users/{id}', [UserController::class, 'Delete']); // Eliminar un usuario (Soft Delete)
    Route::delete('users/force-delete/{id}', [UserController::class, 'ForceDelete']); // Eliminar un usuario permanentemente (Hard Delete)
});

Route::post('login', [AuthController::class, 'login']);
Route::post('register', [AuthController::class, 'register']);
Route::middleware('auth:sanctum')->post('logout', [AuthController::class, 'logout']);
Route::middleware('auth:sanctum')->get('info/{id}', [AuthController::class, 'info']);
Route::middleware('auth:sanctum')->get('infoall', [AuthController::class, 'getUser']);
Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
