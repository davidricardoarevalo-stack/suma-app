#!/bin/bash

# Script para preparar aplicación para Bluehost
# Ejecutar con: bash build-bluehost.sh

echo "🔵 Preparando aplicación para Bluehost..."

# Colores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_info() {
    echo -e "${BLUE}[BLUEHOST]${NC} $1"
}

# Crear directorio de distribución
print_status "Creando directorio de distribución..."
rm -rf dist-bluehost 2>/dev/null
mkdir -p dist-bluehost/public_html
mkdir -p dist-bluehost/nodejs

# Copiar archivos del backend
print_status "Preparando backend para Bluehost..."
cp -r backend/* dist-bluehost/nodejs/
cp backend/.env.bluehost dist-bluehost/nodejs/.env

# Limpiar archivos innecesarios del backend
rm -f dist-bluehost/nodejs/server.js
mv dist-bluehost/nodejs/server-bluehost.js dist-bluehost/nodejs/app.js

# Construir frontend
print_status "Construyendo frontend para producción..."
cd frontend

# Usar configuración específica de Bluehost
cp .env.bluehost .env.production.local

# Construir aplicación
npm run build

# Copiar archivos del frontend construido
print_status "Copiando archivos del frontend..."
cp -r build/* ../dist-bluehost/public_html/

# Volver al directorio raíz
cd ..

# Copiar .htaccess
cp .htaccess dist-bluehost/public_html/

# Crear package.json simplificado para Bluehost
print_status "Creando package.json optimizado..."
cat > dist-bluehost/nodejs/package.json << EOL
{
  "name": "suma-app-bluehost",
  "version": "1.0.0",
  "description": "Aplicación de suma optimizada para Bluehost",
  "main": "app.js",
  "scripts": {
    "start": "node app.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "cors": "^2.8.5",
    "dotenv": "^16.0.3"
  },
  "engines": {
    "node": ">=16.0.0"
  }
}
EOL

# Crear archivo de instrucciones
print_status "Creando archivo de instrucciones..."
cat > dist-bluehost/INSTRUCCIONES-BLUEHOST.txt << EOL
INSTRUCCIONES PARA SUBIR A BLUEHOST
===================================

1. SUBIR ARCHIVOS:
   - Subir contenido de 'public_html/' al directorio public_html de tu cPanel
   - Subir contenido de 'nodejs/' a un directorio como 'suma-app' en tu hosting

2. CONFIGURAR NODE.JS EN CPANEL:
   - Ir a cPanel > Software > Node.js
   - Crear nueva aplicación Node.js
   - Directorio de la aplicación: suma-app (o donde subiste los archivos)
   - Archivo de inicio: app.js
   - Versión de Node.js: 16.x o superior

3. CONFIGURAR VARIABLES DE ENTORNO:
   - En cPanel Node.js, agregar variables:
     * NODE_ENV=production
     * PORT=3000 (o el puerto asignado por Bluehost)

4. INSTALAR DEPENDENCIAS:
   - En el terminal de cPanel Node.js, ejecutar: npm install

5. CONFIGURAR DOMINIO:
   - Editar el archivo .env en nodejs/
   - Cambiar tu-dominio.com por tu dominio real

6. INICIAR APLICACIÓN:
   - En cPanel Node.js, hacer clic en "Restart"

7. VERIFICAR:
   - Visitar https://tu-dominio.com/health
   - Debería mostrar estado OK

¡Tu aplicación estará funcionando en tu dominio de Bluehost!
EOL

# Crear archivo ZIP para fácil subida
print_status "Creando archivo ZIP..."
cd dist-bluehost
zip -r ../suma-app-bluehost.zip . -x "*.DS_Store" "*/node_modules/*"
cd ..

print_info "✅ Preparación completada!"
print_info "📁 Archivos listos en: dist-bluehost/"
print_info "📦 Archivo ZIP: suma-app-bluehost.zip"
print_info "📋 Lee las instrucciones en: dist-bluehost/INSTRUCCIONES-BLUEHOST.txt"

# Mostrar estructura de archivos
print_status "Estructura de archivos preparada:"
tree dist-bluehost -L 2 2>/dev/null || find dist-bluehost -type d -name "node_modules" -prune -o -type f -print | head -20