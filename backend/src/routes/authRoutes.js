// Rutas de autenticación

const express = require('express'); // Importa el módulo express para crear rutas
const router = express.Router(); // Crea un enrutador de Express

// Importa la función de login del controlador de autenticación
const { login } = require('../controllers/authController'); 

// Define la ruta POST para el login, que llama a la función de login del controlador
router.post('/login', login);

// Exporta el enrutador para que pueda ser utilizado en el archivo principal de la aplicación
module.exports = router;