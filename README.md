# 🧮 Aplicación de Suma - React + Node.js

Una aplicación web simple que permite sumar dos números usando React para el frontend y Node.js/Express para el backend.

## 📁 Estructura del Proyecto

```
suma-app/
├── backend/          # Servidor Node.js
│   ├── package.json
│   └── server.js
├── frontend/         # Aplicación React
│   ├── package.json
│   ├── public/
│   │   └── index.html
│   └── src/
│       ├── App.js
│       ├── App.css
│       ├── index.js
│       └── index.css
└── README.md
```

## 🚀 Cómo ejecutar la aplicación

### Prerequisitos
- Node.js (versión 14 o superior)
- npm o yarn

### 1. Instalar dependencias del backend

```bash
cd backend
npm install
```

### 2. Instalar dependencias del frontend

```bash
cd ../frontend
npm install
```

### 3. Ejecutar el backend

```bash
cd ../backend
npm start
```

El servidor se ejecutará en `http://localhost:5000`

### 4. Ejecutar el frontend (en otra terminal)

```bash
cd frontend
npm start
```

La aplicación React se ejecutará en `http://localhost:3000`

## 🔧 Scripts disponibles

### Backend
- `npm start` - Ejecuta el servidor
- `npm run dev` - Ejecuta el servidor con nodemon (reinicio automático)

### Frontend
- `npm start` - Ejecuta la aplicación en modo desarrollo
- `npm run build` - Crea la build de producción
- `npm test` - Ejecuta las pruebas

## 📡 API Endpoints

### POST /api/sum
Suma dos números enviados en el body de la petición.

**Request:**
```json
{
  "num1": 5,
  "num2": 3
}
```

**Response:**
```json
{
  "num1": 5,
  "num2": 3,
  "resultado": 8,
  "mensaje": "5 + 3 = 8"
}
```

## ✨ Características

- ✅ Frontend moderno con React
- ✅ Backend con Node.js y Express
- ✅ Validación de entrada
- ✅ Manejo de errores
- ✅ Diseño responsivo
- ✅ Interfaz intuitiva
- ✅ CORS habilitado

## 🎨 Tecnologías utilizadas

- **Frontend:** React, CSS3, Axios
- **Backend:** Node.js, Express, CORS
- **Desarrollo:** Create React App, Nodemon

## 🧪 Cómo probar

1. Abre `http://localhost:3000` en tu navegador
2. Ingresa dos números en los campos
3. Haz clic en "Sumar"
4. Ve el resultado de la suma

¡Disfruta de tu aplicación de suma! 🎉

## 🚀 Despliegue en Producción

### Opción 1: Vercel (Recomendado)
```bash
# Instalar Vercel CLI
npm i -g vercel

# En el directorio raíz
vercel

# Configurar variables de entorno en Vercel Dashboard:
# NODE_ENV=production
# FRONTEND_URL=https://tu-dominio.vercel.app
```

### Opción 2: Heroku
```bash
# Instalar Heroku CLI
heroku create tu-suma-app

# Configurar variables de entorno
heroku config:set NODE_ENV=production
heroku config:set FRONTEND_URL=https://tu-suma-app.herokuapp.com

# Desplegar
git push heroku main
```

### Opción 3: Railway
1. Conecta tu repositorio GitHub en https://railway.app
2. Configura variables de entorno:
   - `NODE_ENV=production`
   - `FRONTEND_URL=https://tu-dominio.railway.app`
3. Railway detecta automáticamente Node.js

### Opción 4: DigitalOcean App Platform
1. Conecta tu repo en https://cloud.digitalocean.com/apps
2. Configura dos servicios:
   - **Backend:** Node.js service (backend/)
   - **Frontend:** Static site (frontend/build)

## 🛠️ Scripts Disponibles (Raíz)

- `npm run dev` - Ejecuta backend y frontend simultáneamente
- `npm run build` - Construye el frontend para producción
- `npm start` - Ejecuta solo el backend (producción)
- `npm run install-deps` - Instala dependencias de ambos proyectos

## 🌍 Variables de Entorno

### Backend (.env)
```
PORT=5000
NODE_ENV=production
FRONTEND_URL=https://tu-dominio.com
```

### Frontend (.env)
```
REACT_APP_API_URL=https://tu-api.com
REACT_APP_ENV=production
```

## 📦 Preparación para Producción

1. **Construir frontend:**
   ```bash
   cd frontend && npm run build
   ```

2. **Configurar variables de entorno según la plataforma**

3. **Verificar que el backend sirve archivos estáticos en producción**

## 🏠 Despliegue en Servidor Propio

### Requisitos del Servidor
- **OS:** Ubuntu 20.04+ / CentOS 8+ / Debian 11+
- **Node.js:** v16.0.0 o superior
- **RAM:** Mínimo 1GB (recomendado 2GB+)
- **Almacenamiento:** 10GB libres
- **Acceso:** SSH con privilegios sudo

### 🚀 Instalación Automática (Recomendado)

```bash
# 1. Conectar al servidor
ssh usuario@tu-servidor.com

# 2. Descargar y ejecutar script de instalación
wget https://raw.githubusercontent.com/davidricardoarevalo-stack/suma-app/main/install.sh
chmod +x install.sh
bash install.sh
```

### 📋 Instalación Manual

#### 1. Preparar el Servidor
```bash
# Actualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar Node.js 18.x
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Instalar PM2, Nginx y Git
sudo npm install -g pm2
sudo apt install nginx git -y
```

#### 2. Clonar y Configurar la Aplicación
```bash
# Crear directorio
sudo mkdir -p /var/www
cd /var/www

# Clonar repositorio
sudo git clone https://github.com/davidricardoarevalo-stack/suma-app.git
sudo chown -R $USER:$USER suma-app
cd suma-app

# Instalar dependencias del backend
cd backend
npm install --production
cd ..

# Instalar dependencias y construir frontend
cd frontend
npm install
npm run build
cd ..
```

#### 3. Configurar Variables de Entorno
```bash
# Copiar y editar archivo de configuración
cp backend/.env.production backend/.env

# Editar con tu dominio
nano backend/.env
```

Cambiar `tu-dominio.com` por tu dominio real.

#### 4. Configurar PM2
```bash
# Crear directorio de logs
sudo mkdir -p /var/log/suma-app
sudo chown $USER:$USER /var/log/suma-app

# Iniciar con PM2
pm2 start ecosystem.config.js --env production

# Configurar inicio automático
pm2 startup
pm2 save
```

#### 5. Configurar Nginx
```bash
# Copiar configuración
sudo cp nginx.conf /etc/nginx/sites-available/suma-app

# Editar configuración con tu dominio
sudo nano /etc/nginx/sites-available/suma-app

# Habilitar sitio
sudo ln -s /etc/nginx/sites-available/suma-app /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default

# Verificar configuración
sudo nginx -t

# Reiniciar Nginx
sudo systemctl restart nginx
```

#### 6. Configurar SSL con Let's Encrypt (Opcional pero Recomendado)
```bash
# Instalar Certbot
sudo apt install certbot python3-certbot-nginx -y

# Obtener certificado SSL
sudo certbot --nginx -d tu-dominio.com -d www.tu-dominio.com

# Configurar renovación automática
sudo crontab -e
# Agregar línea:
# 0 12 * * * /usr/bin/certbot renew --quiet
```

### 🔄 Actualización de la Aplicación

Para futuras actualizaciones, usa el script de despliegue:

```bash
cd /var/www/suma-app
bash deploy.sh
```

### 📊 Monitoreo y Mantenimiento

```bash
# Ver estado de la aplicación
pm2 status

# Ver logs en tiempo real
pm2 logs suma-app

# Reiniciar aplicación
pm2 restart suma-app

# Ver uso de recursos
pm2 monit

# Estado de Nginx
sudo systemctl status nginx

# Logs de Nginx
sudo tail -f /var/log/nginx/suma-app.access.log
sudo tail -f /var/log/nginx/suma-app.error.log
```

### 🔧 Solución de Problemas

#### Aplicación no responde
```bash
pm2 restart suma-app
pm2 logs suma-app --lines 50
```

#### Error 502 Bad Gateway
```bash
# Verificar que la app esté ejecutándose
pm2 status

# Verificar configuración de Nginx
sudo nginx -t
sudo systemctl restart nginx
```

#### Problemas de permisos
```bash
sudo chown -R $USER:$USER /var/www/suma-app
sudo chmod -R 755 /var/www/suma-app
```

### 🚨 Respaldo y Seguridad

#### Crear respaldo
```bash
# Respaldo automático (agregar a crontab)
tar -czf /backups/suma-app-$(date +%Y%m%d).tar.gz /var/www/suma-app
```

#### Configurar Firewall
```bash
# Permitir puertos necesarios
sudo ufw allow ssh
sudo ufw allow 80
sudo ufw allow 443
sudo ufw enable
```

### 📈 Optimización para Producción

#### Para mayor tráfico:
- Usar múltiples instancias con PM2 cluster mode
- Configurar load balancing con Nginx
- Implementar Redis para cache
- Usar CDN para archivos estáticos

#### Configuración PM2 optimizada:
```bash
pm2 start ecosystem.config.js --env production
```

El archivo `ecosystem.config.js` ya está configurado para usar múltiples instancias.