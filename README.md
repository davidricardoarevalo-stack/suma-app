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