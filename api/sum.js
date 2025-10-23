// Función serverless para Vercel
export default function handler(req, res) {
    // Configurar CORS
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

    // Manejar preflight requests
    if (req.method === 'OPTIONS') {
        res.status(200).end();
        return;
    }

    // Solo permitir POST
    if (req.method !== 'POST') {
        return res.status(405).json({ error: 'Método no permitido. Solo POST.' });
    }

    try {
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
        
        res.json({ 
            num1: numero1, 
            num2: numero2, 
            resultado,
            mensaje: `${numero1} + ${numero2} = ${resultado}`,
            timestamp: new Date().toISOString()
        });
        
    } catch (error) {
        console.error('Error en /api/sum:', error);
        res.status(500).json({ 
            error: 'Error interno del servidor',
            message: error.message 
        });
    }
}