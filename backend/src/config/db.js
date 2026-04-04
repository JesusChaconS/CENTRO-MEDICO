const mysql = require('mysql2/promise'); // Importa el módulo mysql2 con soporte para promesas
require('dotenv').config(); // Carga las variables de entorno desde el archivo .env

const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    waitForConnections: true, // Espera a que haya una conexión disponible si el pool está lleno
    connectionLimit: 5, // Limita el número de conexiones simultáneas
}); // Crea un pool de conexiones a la base de datos

// Exporta el pool para que pueda ser utilizado en otros archivos
module.exports = pool; 