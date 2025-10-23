require('dotenv').config();
const express = require('express');
const cors = require('cors');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 5000;
const NODE_ENV = process.env.NODE_ENV || 'development';

// Middleware
const corsOptions = {
    origin: NODE_ENV === 'production' 
        ? process.env.FRONTEND_URL || 'https://tu-dominio.com'
        : 'http://localhost:3000',
    credentials: true
};

app.use(cors(corsOptions));
app.use(express.json());

// Servir archivos estáticos en producción
if (NODE_ENV === 'production') {
    app.use(express.static(path.join(__dirname, '../frontend/build')));
}

// Ruta de prueba
app.get('/', (req, res) => {
    res.json({ message: 'Servidor de suma funcionando correctamente' });
});

// Ruta para sumar dos números
app.post('/api/sum', (req, res) => {
    try {
        const { num1, num2 } = req.body;
        
        // Validar que los valores sean números
        if (typeof num1 !== 'number' || typeof num2 !== 'number') {
            return res.status(400).json({ 
                error: 'Los valores deben ser números válidos' 
            });
        }
        
        const resultado = num1 + num2;
        
        res.json({ 
            num1, 
            num2, 
            resultado,
            mensaje: `${num1} + ${num2} = ${resultado}`
        });
    } catch (error) {
        res.status(500).json({ 
            error: 'Error interno del servidor' 
        });
    }
});

// Servir frontend en producción
if (NODE_ENV === 'production') {
    app.get('*', (req, res) => {
        res.sendFile(path.join(__dirname, '../frontend/build/index.html'));
    });
}

app.listen(PORT, () => {
    console.log(`Servidor ejecutándose en http://localhost:${PORT}`);
});