#!/bin/bash

# Script de instalación para servidor propio
# Ejecutar con: bash install.sh

echo "🚀 Instalando Suma App en servidor propio..."

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función para imprimir mensajes
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Verificar si Node.js está instalado
if ! command -v node &> /dev/null; then
    print_warning "Node.js no está instalado. Instalando..."
    
    # Para Ubuntu/Debian
    if command -v apt &> /dev/null; then
        curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
        sudo apt-get install -y nodejs
    # Para CentOS/RHEL/Rocky
    elif command -v yum &> /dev/null; then
        curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
        sudo yum install -y nodejs
    else
        print_error "Sistema operativo no soportado. Instala Node.js manualmente."
        exit 1
    fi
fi

# Verificar versión de Node.js
NODE_VERSION=$(node --version)
print_status "Node.js versión: $NODE_VERSION"

# Instalar PM2 globalmente si no está instalado
if ! command -v pm2 &> /dev/null; then
    print_status "Instalando PM2..."
    sudo npm install -g pm2
fi

# Crear directorio para la aplicación
APP_DIR="/var/www/suma-app"
print_status "Creando directorio: $APP_DIR"
sudo mkdir -p $APP_DIR
sudo chown -R $USER:$USER $APP_DIR

# Clonar el repositorio
print_status "Clonando repositorio..."
cd /var/www
sudo rm -rf suma-app 2>/dev/null
git clone https://github.com/davidricardoarevalo-stack/suma-app.git
sudo chown -R $USER:$USER suma-app

cd suma-app

# Instalar dependencias del backend
print_status "Instalando dependencias del backend..."
cd backend
npm install --production

# Volver al directorio raíz
cd ..

# Instalar dependencias del frontend
print_status "Instalando dependencias del frontend..."
cd frontend
npm install

# Construir aplicación para producción
print_status "Construyendo aplicación para producción..."
npm run build

# Volver al directorio raíz
cd ..

# Crear archivo .env para producción
print_status "Configurando variables de entorno..."
cat > backend/.env << EOL
PORT=5000
NODE_ENV=production
FRONTEND_URL=http://localhost
EOL

# Configurar PM2
print_status "Configurando PM2..."
pm2 delete suma-app 2>/dev/null || true
pm2 start backend/server.js --name "suma-app" --env production

# Configurar PM2 para iniciar en boot
pm2 startup
pm2 save

print_status "✅ Instalación completada!"
print_status "La aplicación está ejecutándose en el puerto 5000"
print_status "Puedes verificar el estado con: pm2 status"
print_status "Ver logs con: pm2 logs suma-app"

# Mostrar información del estado
pm2 status