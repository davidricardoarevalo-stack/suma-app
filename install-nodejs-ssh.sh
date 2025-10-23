#!/bin/bash

# Script para instalar Node.js en Bluehost via SSH
echo "🔵 Instalando Node.js en Bluehost..."

# Ir al directorio home
cd ~

# Crear directorio para Node.js
mkdir -p nodejs
cd nodejs

# Descargar Node.js LTS (v18.18.0)
echo "📥 Descargando Node.js v18.18.0..."
wget https://nodejs.org/dist/v18.18.0/node-v18.18.0-linux-x64.tar.xz

# Extraer
echo "📦 Extrayendo Node.js..."
tar -xf node-v18.18.0-linux-x64.tar.xz

# Crear enlace simbólico para facilitar uso
ln -sf node-v18.18.0-linux-x64 current

# Agregar al PATH permanentemente
echo "🔧 Configurando PATH..."
echo 'export PATH=~/nodejs/current/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# Verificar instalación
echo "✅ Verificando instalación..."
~/nodejs/current/bin/node --version
~/nodejs/current/bin/npm --version

echo "🎉 Node.js instalado correctamente!"
echo "📋 Para usar Node.js, usa la ruta completa:"
echo "   ~/nodejs/current/bin/node"
echo "   ~/nodejs/current/bin/npm"