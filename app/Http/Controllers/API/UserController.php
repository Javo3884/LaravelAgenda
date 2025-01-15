<?php

namespace App\Http\Controllers\API;

use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    // Obtener todos los usuarios NO eliminados (SoftDelete)
    public function GetAll()
    {
        // Solo los usuarios NO eliminados (sin soft delete)
        $users = User::all();
        return response()->json(["success" => true,"users" =>$users]);
    }

    // Buscar usuarios eliminados (Soft Deleted)
    public function FindAllTrash()
    {
        // Solo los usuarios que han sido eliminados (soft delete)
        $users = User::onlyTrashed()->get();
        return response()->json(["success" => true,"users" =>$users]);
    }

    // Obtener un usuario por ID que no esté eliminado
    public function FindById($id)
    {
        $user = User::find($id); // Solo busca usuarios que no estén eliminados

        if (!$user) {
            return response()->json(['error' => 'Usuario no encontrado'], 404);
        }

        return response()->json(["success" => true,"user" =>$user]);
    }

    // Buscar usuarios eliminados por ID (Soft Deleted)
    public function FindByTrash($id)
    {
        $user = User::onlyTrashed()->find($id); // Busca entre los eliminados

        if (!$user) {
            return response()->json(['error' => 'Usuario eliminado no encontrado'], 404);
        }

        return response()->json(["success" => true,"user" =>$user]);
    }

    // Buscar todos los usuarios, incluyendo eliminados (Soft Deleted)
    public function FindWithTrash()
    {
        // Todos los usuarios, incluidos los eliminados (soft delete)
        $users = User::withTrashed()->get();
        return response()->json(["success" => true,"users" =>$users]);
    }

    // Restaurar un usuario eliminado (Soft Delete)
    public function Restore($id)
    {
        $user = User::withTrashed()->find($id); // Incluye eliminados

        if (!$user) {
            return response()->json(['error' => 'Usuario no encontrado'], 404);
        }

        // Restaurar el usuario
        $user->restore();

        return response()->json(['message' => 'Usuario restaurado exitosamente', 'success' => true]);
    }

    // Crear un nuevo usuario
    public function Create(Request $request)
    {
        // Validación de los datos
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:100',
            'email' => 'required|string|email|max:150|unique:users,email',
            'password' => 'required|string|min:6|confirmed',
            'estado' => 'required|in:activo,inactivo',
            'rol' => 'required|string|max:50',
            'telefono' => 'nullable|string|max:20',
            'admin' => 'nullable|in:0,1',
            'anexo' => 'nullable|string|max:20',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 422);
        }

        // Crear el usuario
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'estado' => $request->estado,
            'rol' => $request->rol,
            'telefono' => $request->telefono,
            'admin' => $request->admin ?? 0, // Default no admin
            'anexo' => $request->anexo,
        ]);

        return response()->json(['message' => 'Usuario creado exitosamente', 'user' => $user], 201);
    }

    // Actualizar un usuario existente
    public function Update(Request $request, $id)
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json(['error' => 'Usuario no encontrado'], 404);
        }

        // Validación de los datos
        $validator = Validator::make($request->all(), [
            'name' => 'nullable|string|max:100',
            'email' => 'nullable|string|email|max:150|unique:users,email,' . $id,
            'password' => 'nullable|string|min:6|confirmed',
            'estado' => 'nullable|in:activo,inactivo',
            'rol' => 'nullable|string|max:50',
            'telefono' => 'nullable|string|max:20',
            'admin' => 'nullable|in:0,1',
            'anexo' => 'nullable|string|max:20',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 422);
        }


        // Actualizar los datos del usuario
        $user->update([
            'name' => $request->name ?? $user->name,
            'email' => $request->email ?? $user->email,
            'password' => $request->password ? Hash::make($request->password) : $user->password,
            'estado' => $request->estado ?? $user->estado,
            'rol' => $request->rol ?? $user->rol,
            'telefono' => $request->telefono ?? $user->telefono,
            'admin' => $request->admin ?? $user->admin,
            'anexo' => $request->anexo ?? $user->anexo,
        ]);

        return response()->json(['message' => 'Usuario actualizado exitosamente', 'user' => $user]);
    }

    // Eliminar un usuario (Soft Delete)
    public function Delete($id)
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json(['error' => 'Usuario no encontrado'], 404);
        }

        // Realizar Soft Delete
        $user->delete();

        return response()->json(['message' => 'Usuario eliminado exitosamente']);
    }

    // Eliminar un usuario permanentemente (Hard Delete)
    public function ForceDelete($id)
    {
        $user = User::withTrashed()->find($id); // Incluye los eliminados

        if (!$user) {
            return response()->json(['error' => 'Usuario no encontrado'], 404);
        }

        // Eliminar permanentemente
        $user->forceDelete();

        return response()->json(['message' => 'Usuario eliminado permanentemente']);
    }
}
