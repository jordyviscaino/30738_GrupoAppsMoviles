# Proyecto Restaurante con Pedidos

Aplicación de restaurante con **backend en Node.js + Express**, base de datos **PostgreSQL** y frontend móvil/web en **Flutter**.

## Estructura

TAREA21_RESTAURANTE/
├── backend/                 # API REST
└── pry_tarea_consumo_apis/  # Aplicación Flutter

## Base de datos
Base usada:

Database: restaurante
Host: localhost
Port: 5432
User: tu_user
Password: tu_password

Ejecutar el script:

backend/database/script.sql

Este script crea las tablas platos y pedidos.

## Configurar backend

Dentro de backend/, crear un archivo .env:

PORT=3000
DB_HOST=localhost
DB_PORT=5432
DB_NAME=restaurante
DB_USER=tu_user
DB_PASSWORD=tu_password

Instalar dependencias y ejecutar:

cd backend
npm install
npm run dev

http://localhost:3000

## Configurar frontend

cd pry_tarea_consumo_apis
flutter pub get
flutter run -d chrome

Antes de abrir Flutter, el backend debe estar encendido con npm run dev.