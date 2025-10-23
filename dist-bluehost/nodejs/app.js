require('dotenv').config();
const express = require('express');
const cors = require('cors');
const path = require('path');

const app = express();

// Puerto específico para Bluehost (usar variables de entorno o puerto por defecto)
const PORT = process.env.PORT || process.env.BLUEHOST_PORT || 3000;
const NODE_ENV = process.env.NODE_ENV || 'production';

// Configuración CORS específica para Bluehost
const corsOptions = {
    origin: [
        'https://tu-dominio.com',
        'https://www.tu-dominio.com',
        'http://tu-dominio.com',
        'http://www.tu-dominio.com'
    ],
    credentials: true,
    optionsSuccessStatus: 200
};

app.use(cors(corsOptions));
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// Servir archivos estáticos del frontend (BUILD)
app.use(express.static(path.join(__dirname, '../frontend/build')));

// Headers de seguridad
app.use((req, res, next) => {
    res.setHeader('X-Content-Type-Options', 'nosniff');
    res.setHeader('X-Frame-Options', 'DENY');
    res.setHeader('X-XSS-Protection', '1; mode=block');
    next();
});

// Ruta de salud para verificar que el servidor funciona
app.get('/health', (req, res) => {
    res.json({ 
        status: 'OK', 
        message: 'Servidor de suma funcionando correctamente en Bluehost',
        timestamp: new Date().toISOString(),
        environment: NODE_ENV
    });
});

// Ruta para sumar dos números
app.post('/api/sum', (req, res) => {
    try {
        console.log('Petición recibida:', req.body);
        
        const { num1, num2 } = req.body;
        
        // Validar que los valores existan
        if (num1 === undefined || num2 === undefined) {
            return res.status(400).json({ 
                error: 'Se requieren ambos números (num1 y num2)' 
            });
        }
        
        // Convertir a números
        const numero1 = parseFloat(num1);
        const numero2 = parseFloat(num2);
        
        // Validar que sean números válidos
        if (isNaN(numero1) || isNaN(numero2)) {
            return res.status(400).json({ 
                error: 'Los valores deben ser números válidos' 
            });
        }
        
        const resultado = numero1 + numero2;
        
        const response = { 
            num1: numero1, 
            num2: numero2, 
            resultado,
            mensaje: `${numero1} + ${numero2} = ${resultado}`,
            timestamp: new Date().toISOString()
        };
        
        console.log('Respuesta enviada:', response);
        res.json(response);
        
    } catch (error) {
        console.error('Error en /api/sum:', error);
        res.status(500).json({ 
            error: 'Error interno del servidor',
            message: error.message 
        });
    }
});

// Manejar todas las demás rutas - servir el frontend React
app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, '../frontend/build/index.html'));
});

// Manejo de errores global
app.use((error, req, res, next) => {
    console.error('Error no manejado:', error);
    res.status(500).json({
        error: 'Error interno del servidor',
        message: process.env.NODE_ENV === 'development' ? error.message : 'Error interno'
    });
});

// Iniciar servidor
const server = app.listen(PORT, () => {
    console.log(`🚀 Servidor ejecutándose en puerto ${PORT}`);
    console.log(`📅 Iniciado: ${new Date().toISOString()}`);
    console.log(`🌍 Entorno: ${NODE_ENV}`);
    console.log(`📁 Directorio: ${__dirname}`);
});

// Manejo de cierre graceful
process.on('SIGTERM', () => {
    console.log('SIGTERM recibido, cerrando servidor...');
    server.close(() => {
        console.log('Servidor cerrado');
        process.exit(0);
    });
});

process.on('SIGINT', () => {
    console.log('SIGINT recibido, cerrando servidor...');
    server.close(() => {
        console.log('Servidor cerrado');
        process.exit(0);
    });
});

module.exports = app;