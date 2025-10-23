// Health check endpoint para Vercel
module.exports = (req, res) => {
    // Configurar CORS
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

    // Manejar preflight requests
    if (req.method === 'OPTIONS') {
        res.status(200).end();
        return;
    }

    res.json({
        status: 'OK',
        message: 'Servidor de suma funcionando correctamente en Vercel',
        timestamp: new Date().toISOString(),
        environment: 'production',
        platform: 'Vercel Serverless'
    });
};