<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('name'); // nombre
            $table->string('email')->unique(); // correo
            $table->string('password'); // contraseña
            $table->enum('estado', ['activo', 'inactivo'])->default('activo'); // estado
            $table->string('rol')->default('usuario'); // rol
            $table->timestamp('ultima_conexion')->nullable(); // ultima_conexion
            $table->string('telefono')->nullable(); // telefono
            $table->timestamp('email_verified_at')->nullable(); // email_verified_at
            $table->rememberToken();
            $table->timestamps(); // created_at y updated_at
            $table->softDeletes(); // deleted_at
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('users');
    }
}
