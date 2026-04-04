// Este script se utiliza para crear un nuevo usuario administrador en la base de datos. Asegúrate de tener la base de datos configurada correctamente antes de ejecutar este script.

const bcrypt = require('bcryptjs');
const pool = require('../backend/src/config/db');

const crearUsuario = async () => {
    const email = 'admin@correo.com';
    const passwordPlano = 'admin123';

    const hash = await bcrypt.hash(passwordPlano, 10);

    await pool.query(
    `INSERT INTO usuarios (nombre, email, password, telefono, rol, especialidad, estado) 
    VALUES (?, ?, ?, ?, ?, ?, ?)`,
    ['Administrador', email, hash, '1234567890', 'admin', null, 'activo']
    );

    console.log('Email:', email);
    console.log('Password:', passwordPlano);
    console.log('Usuario creado exitosamente');

    process.exit(0);
};

crearUsuario().catch((err) => {
    console.error('Error al crear usuario:', err.message);
    process.exit(1);
});