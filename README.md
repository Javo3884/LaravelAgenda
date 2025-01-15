<p align="center"><a href="https://laravel.com" target="_blank"><img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400"></a></p>

<p align="center">
<a href="https://travis-ci.org/laravel/framework"><img src="https://travis-ci.org/laravel/framework.svg" alt="Build Status"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/dt/laravel/framework" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/v/laravel/framework" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/l/laravel/framework" alt="License"></a>
</p>

# API

## Versiones

- **PHP**: 7.4.28
- **Laravel**: 8.83.29

## ¿Qué es una API?

Una **API** (Interfaz de Programación de Aplicaciones, por sus siglas en inglés) es un conjunto de reglas y protocolos que permite que diferentes aplicaciones se comuniquen entre sí. En el contexto de una API RESTful, las solicitudes HTTP se utilizan para interactuar con recursos que pueden ser representados en formato JSON.

Esta API está diseñada para gestionar usuarios y sus roles, así como proporcionar autenticación para las operaciones. A continuación, se describen las rutas disponibles para interactuar con la API.

## Uso de la Base de Datos

### Script `safeapi.sql`

El archivo `safeapi.sql` es un script de base de datos que puedes usar para crear la estructura de la base de datos directamente, en lugar de utilizar el comando `php artisan migrate`. Esto es útil en caso de que no puedas ejecutar las migraciones por alguna razón.

# Sobre los endpoints de la api

## Rutas de la API

### 1. **Obtener todos los usuarios**
- **Método**: `GET`
- **Ruta**: `/api/users`
- **Descripción**: Obtiene una lista de todos los usuarios registrados en el sistema.
- **Autenticación requerida**: Sí, necesita un Bearer Token.

### 2. **Obtener información de todos los usuarios**
- **Método**: `GET`
- **Ruta**: `/api/infoall`
- **Descripción**: Obtiene información de los usuarios (usando tokens de usuarios sin admin).
- **Autenticación requerida**: Sí, necesita un Bearer Token.

### 3. **Obtener usuarios en la papelera**
- **Método**: `GET`
- **Ruta**: `/api/trash`
- **Descripción**: Obtiene una lista de usuarios que han sido eliminados pero no eliminados permanentemente.
- **Autenticación requerida**: Sí, necesita un Bearer Token.

### 4. **Obtener usuarios con papelera**
- **Método**: `GET`
- **Ruta**: `/api/with-trash`
- **Descripción**: Obtiene una lista de usuarios, tanto activos como en la papelera.
- **Autenticación requerida**: Sí, necesita un Bearer Token.

### 5. **Obtener información de un usuario específico**
- **Método**: `GET`
- **Ruta**: `/api/users/{id}`
- **Descripción**: Obtiene la información de un usuario específico.
- **Autenticación requerida**: Sí, necesita un Bearer Token.

### 6. **Obtener información de un recurso específico**
- **Método**: `GET`
- **Ruta**: `/api/info/{id}`
- **Descripción**: Obtiene información detallada sobre un usuario (usando tokens de usuarios sin admin y solo sobre el usuario registrado en el momento).
- **Autenticación requerida**: Sí, necesita un Bearer Token.

### 7. **Obtener un usuario específico de la papelera**
- **Método**: `GET`
- **Ruta**: `/api/trash/{id}`
- **Descripción**: Obtiene un usuario específico de la papelera.
- **Autenticación requerida**: Sí, necesita un Bearer Token.

### 8. **Crear un nuevo usuario**
- **Método**: `POST`
- **Ruta**: `/api/users`
- **Descripción**: Crea un nuevo usuario en el sistema.
- **Cuerpo de la solicitud**:
  ```json
  {
    "name": "melisa123",
    "email": "melisa123@example.com",
    "password": "melisa123",
    "password_confirmation": "melisa123",
    "rol": "Editor",
    "telefono": "123123123",
    "admin": "1",
    "anexo": "7777",
    "estado": "activo"
  }
  ```
- **Autenticación requerida**: Sí, necesita un Bearer Token.

### 9. **Actualizar la información de un usuario**
- **Método**: `PUT`
- **Ruta**: `/api/users/{id}`
- **Descripción**: Actualiza los detalles de un usuario específico.
- **Cuerpo de la solicitud**:
  ```json
  {
    "name": "Juan Pérez",
    "email": "juan.perez@example.com",
    "password": "nueva123",
    "password_confirmation": "nueva123",
    "rol": "Super Admin",
    "telefono": "1122334455",
    "anexo": "5555"
  }
  ```
- **Autenticación requerida**: Sí, necesita un Bearer Token.

### 10. **Restaurar un usuario de la papelera**
- **Método**: `POST`
- **Ruta**: `/api/users/restore/{id}`
- **Descripción**: Restaura un usuario desde la papelera a su estado original.
- **Autenticación requerida**: Sí, necesita un Bearer Token.

### 11. **Eliminar un usuario**
- **Método**: `DELETE`
- **Ruta**: `/api/users/{id}`
- **Descripción**: Elimina un usuario de forma lógica (moviéndolo a la papelera).
- **Autenticación requerida**: Sí, necesita un Bearer Token.

### 12. **Eliminar un usuario permanentemente**
- **Método**: `DELETE`
- **Ruta**: `/api/users/force-delete/{id}`
- **Descripción**: Elimina un usuario de forma permanente.
- **Autenticación requerida**: Sí, necesita un Bearer Token.

### 13. **Iniciar sesión**
- **Método**: `POST`
- **Ruta**: `/api/login`
- **Descripción**: Inicia sesión en la API y devuelve un Bearer Token.
- **Cuerpo de la solicitud**:
  ```json
  {
    "email": "almendra@gmail.com",
    "password": "almendra"
  }
  ```
- **Autenticación requerida**: No.

### 14. **Cerrar sesión**
- **Método**: `POST`
- **Ruta**: `/api/logout`
- **Descripción**: Cierra sesión y revoca el Bearer Token.
- **Autenticación requerida**: Sí, necesita un Bearer Token.

### 15. **Registrar un nuevo usuario**
- **Método**: `POST`
- **Ruta**: `/api/register`
- **Descripción**: Registra un nuevo usuario en el sistema.
- **Cuerpo de la solicitud**:
  ```json
  {
    "name": "almendra",
    "email": "almendra@gmail.com",
    "password": "almendra",
    "password_confirmation": "almendra",
    "rol": "Editor",
    "telefono": "123123123",
    "anexo": "1234"
  }
  ```
- **Autenticación requerida**: No.

---

## Autenticación

Todas las rutas de la API, excepto **`POST /api/login`** y **`POST /api/register`**, requieren un **Bearer Token** en el encabezado de la solicitud para poder ser utilizadas.

Los tokens son entregados cada que un usuario se registra o inicia sesion.

La mayoria de las rutas necesitan un token de admin solo pocas rutas son accesible por tokens de usuario.

### Autor
Javier Choque Flores

Correo: jchoque0@gmail.com

GitHub: Javo3884

