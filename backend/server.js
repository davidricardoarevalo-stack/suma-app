const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(cors());
app.use(express.json());

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

app.listen(PORT, () => {
    console.log(`Servidor ejecutándose en http://localhost:${PORT}`);
});