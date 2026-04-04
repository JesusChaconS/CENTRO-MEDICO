const express = require('express');
const cors = require('cors');
require('dotenv').config();

// Importa las rutas de autenticación
const authRoutes = require('./routes/authRoutes'); // Importa las rutas de autenticación

// Crea una instancia de Express
const app = express();

// Middleware para analizar el cuerpo de las solicitudes como JSON
app.use(cors({
    origin: 'http://127.0.0.1:5500'
}));
app.use(express.json());

// Usa las rutas de autenticación bajo el prefijo /api/auth
app.use('/api/auth', authRoutes); 

// Inicia el servidor
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Servidor iniciado en el puerto ${PORT}`);
});