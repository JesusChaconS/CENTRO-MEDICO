// Importa el módulo dotenv para cargar las variables de entorno desde un archivo .env
const API_URL = 'http://localhost:3000/api/auth/login';

// Función de login que envía una solicitud POST al backend para autenticar al usuario
export const login = async (email, password) => {
    // console.log('Enviando:', { email, password }); // ← Para depuración, muestra lo que se va a enviar al backend
    const response = await fetch(API_URL, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ email, password }),
    });
    
    const data = await response.json();

    if (!response.ok) {
        throw new Error(data.message || 'Error al iniciar sesión');
    }

    //Alamacena el token en localStorage para usarlo en futuras solicitudes
    localStorage.setItem('token', data.token);
    localStorage.setItem('usuario', JSON.stringify(data.usuario)); // Almacena la información del usuario

    return data;
};

// Función de logout que elimina el token y la información del usuario del localStorage
export const logout = () => {
    localStorage.removeItem('token');
    localStorage.removeItem('usuario');
    window.location.href = '../views/index.html'; // Redirige al usuario a la página de login después de cerrar sesión
};

// Función para obtener el token del localStorage
export const getToken = () => localStorage.getItem('token'); 

// Función para obtener la información del usuario del localStorage
export const getUsuario = () => {
    const usuario = localStorage.getItem('usuario');
    return usuario ? JSON.parse(usuario) : null; 
}

// Función para verificar si el usuario está loggeado
export const estaLoggeado = () => !!getToken(); 

