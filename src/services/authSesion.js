
import { estaLoggeado, getUsuario, logout } from './authService.js';

// Redirige al login si no hay sesión
if (!estaLoggeado()) {
window.location.href = '../views/index.html';
}

// Datos del usuario disponibles en toda la página
const usuario = getUsuario();

// Mostrar nombre y rol en el header si tenés un elemento para eso
const nombreEl = document.getElementById('usuario-nombre');
if (nombreEl) nombreEl.textContent = usuario.nombre;
const rolEl = document.getElementById('usuario-rol');
if (rolEl) rolEl.textContent = usuario.rol;


// Botón de cerrar sesión
const btnLogout = document.getElementById('btn-logout');
if (btnLogout) btnLogout.addEventListener('click', logout);


//Agrega la funcion de logo de usuario con sus inciales usando a API ui-avatars.com - OK
const getAvatarUrl = (nombre) => {
    const nombreEl = encodeURIComponent(nombre);
    return `https://ui-avatars.com/api/?name=${nombreEl}&background=0ea5e9&color=fff'`; // Personaliza el fondo y el color del texto según tus preferencias
}

const avatarEl = document.getElementById('usuario-avatar');
if (avatarEl) {
    avatarEl.src = getAvatarUrl(usuario.nombre);
}