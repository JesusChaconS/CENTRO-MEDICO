// Importa el módulo bcryptjs para manejar el hashing de contraseñas y jsonwebtoken para manejar tokens JWT
const bcrypt = require('bcryptjs'); 
const jwt = require('jsonwebtoken');

// Importa el pool de conexiones a la base de datos
const pool = require('../config/db'); 


// Función de login que maneja la autenticación de usuarios
const login = async (req, res) => {
    // Obtiene el email y la contraseña del cuerpo de la solicitud
    const { email, password } = req.body; 

    //Validar que vengan ambos campos
    if(!email || !password){
        return res.status(400).json({ message: 'Email y contraseña son requeridos' });
    }

    try{
        // Busca el usuario en la base de datos por su email
        const [rows] = await pool.query('SELECT * FROM usuarios WHERE email = ?', [email]);

        if(rows.length === 0){
            return res.status(401).json({ message: 'Credenciales inválidas' });
        }

        const usuario = rows[0];

        // Compara la contraseña proporcionada con la contraseña almacenada en la base de datos
        const claveValida = await bcrypt.compare(password, usuario.password);
        
        if(!claveValida){
            return res.status(401).json({ message: 'Credenciales inválidas' });
        }

        // Genera un token JWT con el ID del usuario como payload
        const token = jwt.sign(
            { 
                id: usuario.id, 
                email: usuario.email,
                nombre: usuario.nombre,
                rol: usuario.rol
            }   ,
            process.env.JWT_SECRET, // Clave secreta para firmar el token
            { expiresIn: process.env.JWT_EXPIRES_IN } // Tiempo de expiración del token
        )

        res.json({ token,
            usuario: {
                id: usuario.id,
                nombre: usuario.nombre,
                email: usuario.email,
                rol: usuario.rol
            }
         }); // Devuelve el token al cliente y la información del usuario

    //Control de errores
    } catch (error) {
        console.error('Mensaje:', error.message);
        console.error('Stack:', error.stack);
        res.status(500).json({ message: 'Error interno del servidor' });
    }
};

// Exporta la función de login para que pueda ser utilizada en las rutas de autenticación
module.exports = {login}; 