#!/bin/bash

# Script de despliegue/actualización
# Ejecutar con: bash deploy.sh

echo "🔄 Actualizando Suma App..."

# Colores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Ir al directorio de la aplicación
cd /var/www/suma-app

# Respaldar la aplicación actual
print_status "Creando respaldo..."
cp -r . ../suma-app-backup-$(date +%Y%m%d-%H%M%S)

# Obtener últimos cambios
print_status "Obteniendo últimos cambios del repositorio..."
git pull origin main

# Instalar/actualizar dependencias del backend
print_status "Actualizando dependencias del backend..."
cd backend
npm install --production

# Volver al directorio raíz
cd ..

# Instalar/actualizar dependencias del frontend
print_status "Actualizando dependencias del frontend..."
cd frontend
npm install

# Construir aplicación para producción
print_status "Construyendo aplicación para producción..."
npm run build

# Volver al directorio raíz
cd ..

# Reiniciar aplicación con PM2
print_status "Reiniciando aplicación..."
pm2 restart suma-app

# Verificar estado
print_status "Verificando estado de la aplicación..."
sleep 5
pm2 status

print_status "✅ Despliegue completado!"
print_status "Puedes verificar los logs con: pm2 logs suma-app"