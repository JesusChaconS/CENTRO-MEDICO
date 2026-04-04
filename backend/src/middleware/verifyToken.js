// Middleware para verificar el token JWT

const jwt = require('jsonwebtoken'); // Importa el módulo jsonwebtoken para manejar tokens JWT

const verifyToken = (req, res, next) => {
    const authHeader = req.headers['authorization']; // Obtiene el encabezado de autorización
    const token = authHeader && authHeader.split(' ')[1]; // Extrae el token del encabezado

    if (!token) {
        // Si no hay token, devuelve un error 401
        return res.status(401).json({ message: 'Token no proporcionado' }); 
    }

    try{
        // Verifica el token utilizando la clave secreta
        const decode = jwt.verify(token, process.env.JWT_SECRET);
        req.usuario = decode; // Agrega la información del usuario decodificada al objeto de solicitud
        next(); // Continúa con el siguiente middleware o ruta
    }
    catch (error){
         // Si el token es inválido, devuelve un error 403
        return res.status(403).json({ message: 'Token inválido o expirado' });
    }
};

// Exporta el middleware para que pueda ser utilizado en las rutas protegidas
module.exports = verifyToken; 