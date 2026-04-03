-- =====================================================
-- MediCore Database Schema - MySQL (Simplificado)
-- Sistema de Gestión Médica
-- =====================================================

-- Crear base de datos
CREATE DATABASE IF NOT EXISTS medicore_db 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE medicore_db;

-- =====================================================
-- Tablas Principales
-- =====================================================

-- Usuarios (Doctores y Admin)
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    rol ENUM('admin', 'doctor') NOT NULL DEFAULT 'doctor',
    especialidad VARCHAR(50),
    estado ENUM('activo', 'inactivo') DEFAULT 'activo',
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Especialidades Médicas
CREATE TABLE especialidades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    color VARCHAR(7) DEFAULT '#0ea5e9',
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Pacientes
CREATE TABLE pacientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE,
    genero ENUM('masculino', 'femenino'),
    direccion TEXT,
    contacto_emergencia VARCHAR(100),
    telefono_emergencia VARCHAR(20),
    doctor_asignado INT,
    estado ENUM('activo', 'en_tratamiento', 'dado_de_alta') DEFAULT 'activo',
    ultima_visita DATE,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX idx_pacientes_email (email),
    INDEX idx_pacientes_estado (estado),
    INDEX idx_pacientes_doctor (doctor_asignado)
);

-- Citas Médicas
CREATE TABLE citas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) UNIQUE NOT NULL,
    paciente_id INT NOT NULL,
    doctor_id INT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    servicio VARCHAR(100) NOT NULL,
    estado ENUM('agendada', 'completada', 'cancelada') DEFAULT 'agendada',
    notas TEXT,
    precio DECIMAL(10,2),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    INDEX idx_citas_paciente (paciente_id),
    INDEX idx_citas_doctor (doctor_id),
    INDEX idx_citas_fecha (fecha),
    INDEX idx_citas_estado (estado)
);

-- Historial Médico
CREATE TABLE historial_medico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) UNIQUE NOT NULL,
    paciente_id INT NOT NULL,
    doctor_id INT NOT NULL,
    cita_id INT NULL,
    diagnostico TEXT NOT NULL,
    tratamiento TEXT,
    receta TEXT,
    notas TEXT,
    tipo ENUM('consulta', 'examen', 'tratamiento', 'urgencia') DEFAULT 'consulta',
    estado ENUM('completado', 'pendiente') DEFAULT 'completado',
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (cita_id) REFERENCES citas(id) ON DELETE SET NULL,
    INDEX idx_historial_paciente (paciente_id),
    INDEX idx_historial_doctor (doctor_id),
    INDEX idx_historial_tipo (tipo)
);

-- Facturación
CREATE TABLE facturas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) UNIQUE NOT NULL,
    paciente_id INT NOT NULL,
    cita_id INT NULL,
    servicio VARCHAR(100) NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    impuesto DECIMAL(10,2) DEFAULT 0,
    total DECIMAL(10,2) NOT NULL,
    estado ENUM('pagada', 'pendiente', 'vencida') DEFAULT 'pendiente',
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    fecha_pago DATE NULL,
    descripcion TEXT,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE,
    FOREIGN KEY (cita_id) REFERENCES citas(id) ON DELETE SET NULL,
    INDEX idx_facturas_paciente (paciente_id),
    INDEX idx_facturas_estado (estado),
    INDEX idx_facturas_fecha (fecha_emision)
);

-- =====================================================
-- Datos Iniciales
-- =====================================================

-- Especialidades
INSERT INTO especialidades (nombre, color) VALUES
('Cardiología', '#ef4444'),
('Pediatría', '#10b981'),
('Dermatología', '#f59e0b'),
('Neurología', '#8b5cf6'),
('Medicina General', '#0ea5e9');

-- Usuarios (Doctores y Admin)
INSERT INTO usuarios (nombre, email, password, telefono, rol, especialidad, estado) VALUES
('Dr. Ana García', 'admin@medicore.com', '$2a$10$YourHashedPasswordHere', '+1 234-567-8900', 'admin', NULL, 'activo'),

('Dr. John Smith', 'dr.smith@medicore.com', '$2a$10$YourHashedPasswordHere', '+1 234-567-8901', 'doctor', 'Cardiología', 'activo'),
('Dra. Sarah Johnson', 'dra.johnson@medicore.com', '$2a$10$YourHashedPasswordHere', '+1 234-567-8902', 'doctor', 'Pediatría', 'activo'),
('Dr. Michael Williams', 'dr.williams@medicore.com', '$2a$10$YourHashedPasswordHere', '+1 234-567-8903', 'doctor', 'Dermatología', 'activo');

-- Pacientes
INSERT INTO pacientes (codigo, nombre, email, telefono, fecha_nacimiento, genero, doctor_asignado, estado, ultima_visita) VALUES
('PAC001', 'Juan Pérez', 'juan.perez@email.com', '+1 234-567-8901', '1985-03-15', 'masculino', 2, 'activo', '2026-03-15'),
('PAC002', 'María García', 'maria.garcia@email.com', '+1 234-567-8902', '1992-07-22', 'femenino', 3, 'en_tratamiento', '2026-03-18'),
('PAC003', 'Carlos López', 'carlos.lopez@email.com', '+1 234-567-8903', '1978-11-08', 'masculino', 4, 'activo', '2026-03-20');

-- Citas
INSERT INTO citas (codigo, paciente_id, doctor_id, fecha, hora, servicio, estado, precio) VALUES
('CITA001', 1, 2, '2026-04-02', '10:30:00', 'Consulta General', 'agendada', 150.00),
('CITA002', 2, 3, '2026-04-02', '14:00:00', 'Control Pediatría', 'completada', 120.00),
('CITA003', 3, 4, '2026-04-02', '16:30:00', 'Consulta Dermatología', 'cancelada', 180.00);

-- Historial Médico
INSERT INTO historial_medico (codigo, paciente_id, doctor_id, diagnostico, tratamiento, tipo, estado) VALUES
('HM001', 1, 2, 'Hipertensión arterial', 'Ejercicio regular, dieta baja en sodio', 'consulta', 'completado'),
('HM002', 2, 3, 'Dermatitis atópica', 'Crema hidratante, evitar irritantes', 'consulta', 'completado');

-- Facturas
INSERT INTO facturas (codigo, paciente_id, servicio, monto, impuesto, total, estado, fecha_emision, fecha_vencimiento) VALUES
('FAC001', 1, 'Consulta General', 150.00, 12.00, 162.00, 'pagada', '2026-04-01', '2026-04-15'),
('FAC002', 2, 'Control Pediatría', 120.00, 9.60, 129.60, 'pagada', '2026-03-28', '2026-04-11'),
('FAC003', 3, 'Consulta Dermatología', 180.00, 14.40, 194.40, 'pendiente', '2026-03-20', '2026-04-03');

-- =====================================================
-- Vista para Estadísticas del Dashboard
-- =====================================================

CREATE VIEW dashboard_estadisticas AS
SELECT 
    (SELECT COUNT(*) FROM pacientes) AS total_pacientes,
    (SELECT COUNT(*) FROM citas WHERE DATE(fecha) = CURDATE()) AS citas_hoy,
    (SELECT COUNT(*) FROM usuarios WHERE rol = 'doctor' AND estado = 'activo') AS doctores_disponibles,
    (SELECT COALESCE(SUM(total), 0) FROM facturas 
     WHERE estado = 'pagada' AND MONTH(fecha_emision) = MONTH(CURDATE()) 
     AND YEAR(fecha_emision) = YEAR(CURDATE())) AS ingresos_mensuales;

-- =====================================================
-- Procedimientos Útiles
-- =====================================================

DELIMITER //
CREATE PROCEDURE ObtenerCitasSemana()
BEGIN
    SELECT 
        DAYNAME(fecha) AS dia,
        COUNT(*) AS cantidad
    FROM citas
    WHERE fecha >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
    GROUP BY DAYNAME(fecha), fecha
    ORDER BY fecha;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerDistribucionEspecialidades()
BEGIN
    SELECT 
        e.nombre AS especialidad,
        COUNT(u.id) AS cantidad,
        ROUND((COUNT(u.id) * 100.0 / (SELECT COUNT(*) FROM usuarios WHERE rol = 'doctor')), 2) AS porcentaje
    FROM especialidades e
    LEFT JOIN usuarios u ON e.nombre = u.especialidad AND u.rol = 'doctor'
    GROUP BY e.id, e.nombre
    ORDER BY cantidad DESC;
END//
DELIMITER ;

-- =====================================================
-- Resumen Final
-- =====================================================

SELECT 
    'Base de datos simplificada creada' AS estado,
    DATABASE() AS nombre_bd,
    NOW() AS fecha_creacion;

-- Contar registros iniciales
SELECT 
    'usuarios' AS tabla, COUNT(*) AS registros FROM usuarios
UNION ALL
SELECT 
    'pacientes', COUNT(*) FROM pacientes
UNION ALL
SELECT 
    'citas', COUNT(*) FROM citas
UNION ALL
SELECT 
    'historial_medico', COUNT(*) FROM historial_medico
UNION ALL
SELECT 
    'facturas', COUNT(*) FROM facturas
UNION ALL
SELECT 
    'especialidades', COUNT(*) FROM especialidades;

-- =====================================================
-- Notas Importantes
-- =====================================================

/*
1. CONTRASEÑAS:
   - Reemplazar '$2a$10$YourHashedPasswordHere' con hashes reales
   - Ejemplo: bcrypt.hashSync('password123', 10)

2. CAMBIOS REALIZADOS:
   - Nombres en español: usuarios, pacientes, citas, etc.
   - Columnas simplificadas: nombre, email, telefono, etc.
   - Sin campos innecesarios: avatares, timestamps complejos, etc.
   - Relaciones directas y claras

3. AJUSTES:
   - Configurar timezone: SET time_zone = '-03:00';
   - Crear usuario específico para la aplicación
   - Configurar conexión remota si es necesario

4. ESCALABILIDAD:
   - Estructura simple para fácil mantenimiento
   - Índices en columnas importantes
   - Vistas para consultas complejas
   - Procedimientos para operaciones frecuentes
*/
