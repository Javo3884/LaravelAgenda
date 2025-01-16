<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    /**
     * Registra un nuevo usuario y retorna un token de acceso.
     *
    @param  \Illuminate\Http\Request  $request
    @return \Illuminate\Http\Response
     */
    public function register(Request $request)
    {
        // Validación de los datos de la solicitud
        $validator = Validator::make($request->all(), [
            'name' => 'nullable|string|max:100',
            'email' => 'required|string|email|max:150|unique:users,email',
            'password' => 'required|string|min:1|confirmed', // Confirmación de la contraseña
            'rol' => 'nullable|string|max:50',
            'telefono' => 'nullable|string|max:20',
            'anexo' => 'nullable|string|max:20',
        ]);

        // Si la validación falla, se retorna un mensaje con los errores
        if ($validator->fails()) {
            return response()->json([
                'error' => $validator->errors(),
                'message' => $validator->errors(),
                "success" => false,
            ], 422);
        }

        // Crear el usuario
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'rol' => $request->rol,
            'telefono' => $request->telefono,
            'estado' => 'activo', // Estado por defecto
            'ultima_conexion' => now(), // Fecha de última conexión (actual)
            'admin' => 0, // Por defecto, admin es 0 (no admin)
            'anexo' => $request->anexo,
        ]);

        // Generar el token de acceso usando Sanctum
        $token = $user->createToken('MiAppToken')->plainTextToken;

        // Respuesta con el token generado y la información del usuario
        return response()->json([
            "success" => true,
            'message' => 'Usuario registrado exitosamente',
            'user' => $user,
            'token' => $token
        ], 201);
    }

    public function login(Request $request)
    {
        // Validación de las credenciales proporcionadas
        $request->validate([
            'email' => 'required|string|email|max:150', // Email del usuario
            'password' => 'required|string|min:2',    // Contraseña del usuario
        ]);

        // Verificar si el correo electrónico existe
        if (!User::where('email', $request->email)->exists()) {
            return response()->json([
                'message' => 'Correo electrónico inválido',
                "success" => false,
            ], 404);
        }
        // Buscar el usuario por correo electrónico
        $user = User::where('email', $request->email)->first();


        // Verificar que el usuario existe y que la contraseña es correcta
        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json([
                'message' => 'Contraseña incorrecta',
                "success" => false,
            ], 401);
        }

        // Actualizar la última conexión del usuario
        $user->ultima_conexion = now();
        $user->save();

        // Generar un token de acceso usando Sanctum
        $token = $user->createToken('MiAppToken')->plainTextToken;

        // Respuesta con el token y la información del usuario
        return response()->json([
            "success" => true,
            'message' => 'Inicio de sesión exitoso',
            'user' => $user,
            'token' => $token
        ], 200);
    }

    public function info(Request $request, $id)
    {
        // Obtener el usuario autenticado a través del token Bearer
        $authenticatedUser = $request->user();

        // Verificar si el ID del usuario autenticado coincide con el ID solicitado
        if ($authenticatedUser->id != $id) {
            return response()->json([
                'message' => 'Usuario no autorizado.',
                'success' => false,
                'error' => 'Acceso no autorizado. Este recurso no pertenece al usuario autenticado.',
            ], 403); // Código HTTP 403: Forbidden
        }

        // Retornar la información personal del usuario autenticado
        return response()->json([
            'success' => true,
            'user' => $authenticatedUser,
        ], 200);
    }

    public function updateInfo(Request $request, $id)
    {
        // Obtener el usuario autenticado
        $authenticatedUser = $request->user();

        // Verificar si el ID del usuario autenticado coincide con el ID solicitado
        if ($authenticatedUser->id != $id) {
            return response()->json([
                'message' => 'Usuario no autorizado.',
                'success' => false,
                'error' => 'Acceso no autorizado. Este recurso no pertenece al usuario autenticado.',
            ], 403); // Código HTTP 403: Forbidden
        }

        // Validación de los datos enviados
        $validator = Validator::make($request->all(), [
            'name' => 'nullable|string|max:100',
            'email' => 'nullable|string|email|max:150|unique:users,email,' . $authenticatedUser->id,
            'password' => 'nullable|string|min:8|confirmed', // Confirmación de la nueva contraseña
            'telefono' => 'nullable|string|max:20',
            'anexo' => 'nullable|string|max:20',
        ]);

        // Si la validación falla, se retorna un mensaje con los errores
        if ($validator->fails()) {
            return response()->json([
                'error' => $validator->errors(),
                'message' => $validator->errors(),
                'success' => false,
            ], 422);
        }

        // Actualizar los datos del usuario autenticado
        $authenticatedUser->name = $request->name ?? $authenticatedUser->name;
        $authenticatedUser->email = $request->email ?? $authenticatedUser->email;
        if ($request->password) {
            $authenticatedUser->password = Hash::make($request->password);
        }
        $authenticatedUser->telefono = $request->telefono ?? $authenticatedUser->telefono;
        $authenticatedUser->anexo = $request->anexo ?? $authenticatedUser->anexo;

        // Guardar los cambios
        $authenticatedUser->save();

        // Respuesta con la información actualizada
        return response()->json([
            'success' => true,
            'message' => 'Información actualizada exitosamente.',
            'user' => $authenticatedUser,
        ], 200);
    }


    public function getUser(Request $request)
    {
        // Obtiene al usuario autenticado mediante el token
        $authenticatedUser = auth('sanctum')->user();

        // Verifica si no hay un usuario autenticado
        if (!$authenticatedUser) {
            return response()->json(["success" => false, "message" => "Token inválido o usuario no autenticado."], 401);
        }

        // Recupera y formatea los usuarios
        $users = User::all()->map(function ($user) {
            return [
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
                'telefono' => $user->telefono,
                'anexo' => $user->anexo,
            ];
        });

        // Devuelve los datos formateados
        return response()->json([
            "success" => true,
            "users" => $users
        ]);
    }

    public function logout(Request $request)
    {
        // Obtener el usuario autenticado
        $user = Auth::user();

        if (!$user) {
            return response()->json(["success" => false, "message" => "No hay usuario autenticado."]);
        }

        // Revocar el token actual
        $user->tokens->each(function ($token) {
            $token->delete();
        });

        return response()->json([
            "success" => true,
            "message" => "Sesión cerrada correctamente."
        ]);
    }


}
