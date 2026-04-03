-- =====================================================
-- MediCore Database Schema - MySQL
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

-- Tabla de Usuarios (Doctores, Admin, Staff)
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    role ENUM('admin', 'doctor', 'staff') NOT NULL DEFAULT 'doctor',
    status ENUM('Activo', 'Inactivo', 'En Descanso') DEFAULT 'Activo',
    specialty_id INT NULL,
    availability VARCHAR(100) DEFAULT 'Lun-Vie 9:00-17:00',
    avatar_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_users_email (email),
    INDEX idx_users_role (role),
    INDEX idx_users_status (status),
    INDEX idx_users_specialty (specialty_id)
);

-- Tabla de Especialidades Médicas
CREATE TABLE specialties (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    color VARCHAR(7) DEFAULT '#0ea5e9',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabla de Pacientes
CREATE TABLE patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id VARCHAR(20) UNIQUE NOT NULL, -- Formato: PAT001, PAT002...
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL,
    date_of_birth DATE,
    gender ENUM('Masculino', 'Femenino', 'Otro'),
    address TEXT,
    emergency_contact VARCHAR(100),
    emergency_phone VARCHAR(20),
    blood_type VARCHAR(5),
    allergies TEXT,
    assigned_doctor_id INT,
    status ENUM('Activo', 'En Tratamiento', 'Dado de Alta', 'Inactivo') DEFAULT 'Activo',
    last_visit DATE,
    avatar_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_patients_email (email),
    INDEX idx_patients_status (status),
    INDEX idx_patients_doctor (assigned_doctor_id),
    INDEX idx_patients_id (patient_id)
);

-- Tabla de Citas Médicas
CREATE TABLE appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id VARCHAR(20) UNIQUE NOT NULL, -- Formato: APT001, APT002...
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    service VARCHAR(100) NOT NULL,
    status ENUM('Agendada', 'Completada', 'Cancelada', 'En Progreso') DEFAULT 'Agendada',
    notes TEXT,
    price DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_appointments_patient (patient_id),
    INDEX idx_appointments_doctor (doctor_id),
    INDEX idx_appointments_date (date),
    INDEX idx_appointments_status (status),
    INDEX idx_appointments_id (appointment_id)
);

-- Tabla de Historial Médico
CREATE TABLE medical_records (
    id INT AUTO_INCREMENT PRIMARY KEY,
    record_id VARCHAR(20) UNIQUE NOT NULL, -- Formato: REC001, REC002...
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_id INT NULL,
    diagnosis TEXT NOT NULL,
    treatment TEXT,
    prescription TEXT,
    notes TEXT,
    record_type ENUM('Consulta', 'Examen', 'Tratamiento', 'Urgencia', 'Laboratorio') DEFAULT 'Consulta',
    status ENUM('Completado', 'Pendiente', 'En Revisión') DEFAULT 'Completado',
    attachments JSON, -- Array de URLs de archivos adjuntos
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES appointments(id) ON DELETE SET NULL,
    INDEX idx_records_patient (patient_id),
    INDEX idx_records_doctor (doctor_id),
    INDEX idx_records_type (record_type),
    INDEX idx_records_status (status),
    INDEX idx_records_id (record_id)
);

-- Tabla de Facturación
CREATE TABLE invoices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_id VARCHAR(20) UNIQUE NOT NULL, -- Formato: INV001, INV002...
    patient_id INT NOT NULL,
    appointment_id INT NULL,
    service VARCHAR(100) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    tax DECIMAL(10,2) DEFAULT 0,
    total DECIMAL(10,2) NOT NULL,
    status ENUM('Pagada', 'Pendiente', 'Vencida', 'Cancelada') DEFAULT 'Pendiente',
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    payment_date DATE NULL,
    payment_method VARCHAR(50),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES appointments(id) ON DELETE SET NULL,
    INDEX idx_invoices_patient (patient_id),
    INDEX idx_invoices_status (status),
    INDEX idx_invoices_date (issue_date),
    INDEX idx_invoices_id (invoice_id)
);

-- Tabla de Notificaciones
CREATE TABLE notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    message TEXT NOT NULL,
    type ENUM('info', 'warning', 'error', 'success') DEFAULT 'info',
    read BOOLEAN DEFAULT FALSE,
    related_id INT NULL, -- ID del registro relacionado (cita, paciente, etc.)
    related_type VARCHAR(50) NULL, -- Tipo de registro relacionado
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_notifications_user (user_id),
    INDEX idx_notifications_read (read),
    INDEX idx_notifications_type (type)
);

-- =====================================================
-- Insertar Datos Iniciales
-- =====================================================

-- Especialidades Médicas
INSERT INTO specialties (name, description, color) VALUES
('Cardiología', 'Enfermedades del corazón y sistema circulatorio', '#ef4444'),
('Pediatría', 'Atención médica infantil y adolescentes', '#10b981'),
('Dermatología', 'Enfermedades de la piel, cabello y uñas', '#f59e0b'),
('Neurología', 'Enfermedades del sistema nervioso', '#8b5cf6'),
('Medicina General', 'Atención primaria y medicina familiar', '#0ea5e9'),
('Ginecología', 'Salud reproductiva femenina', '#ec4899'),
('Oftalmología', 'Enfermedades de los ojos y visión', '#06b6d4'),
('Ortopedia', 'Sistema musculoesquelético', '#84cc16');

-- Usuarios (Doctores y Admin)
INSERT INTO users (name, email, password, phone, role, specialty_id, availability, status) VALUES
-- Admin
('Dr. Ana García', 'admin@medicore.com', '$2a$10$YourHashedPasswordHere', '+1 234-567-8900', 'admin', NULL, 'Lun-Vie 8:00-18:00', 'Activo'),

-- Doctores
('Dr. John Smith', 'dr.smith@medicore.com', '$2a$10$YourHashedPasswordHere', '+1 234-567-8901', 'doctor', 1, 'Lun-Vie 9:00-17:00', 'Activo'),
('Dra. Sarah Johnson', 'dra.johnson@medicore.com', '$2a$10$YourHashedPasswordHere', '+1 234-567-8902', 'doctor', 2, 'Lun-Vie 8:00-16:00', 'Activo'),
('Dr. Michael Williams', 'dr.williams@medicore.com', '$2a$10$YourHashedPasswordHere', '+1 234-567-8903', 'doctor', 3, 'Lun-Vie 10:00-18:00', 'En Descanso'),
('Dra. Emily Brown', 'dra.brown@medicore.com', '$2a$10$YourHashedPasswordHere', '+1 234-567-8904', 'doctor', 4, 'Lun-Vie 9:00-17:00', 'Activo'),
('Dr. David Martinez', 'dr.martinez@medicore.com', '$2a$10$YourHashedPasswordHere', '+1 234-567-8905', 'doctor', 5, 'Lun-Sáb 8:00-20:00', 'Activo');

-- Pacientes de Ejemplo
INSERT INTO patients (patient_id, name, email, phone, date_of_birth, gender, assigned_doctor_id, status, last_visit) VALUES
('PAT001', 'Juan Pérez', 'juan.perez@email.com', '+1 234-567-8901', '1985-03-15', 'Masculino', 1, 'Activo', '2026-03-15'),
('PAT002', 'María García', 'maria.garcia@email.com', '+1 234-567-8902', '1992-07-22', 'Femenino', 2, 'En Tratamiento', '2026-03-18'),
('PAT003', 'Carlos López', 'carlos.lopez@email.com', '+1 234-567-8903', '1978-11-08', 'Masculino', 3, 'Activo', '2026-03-20'),
('PAT004', 'Ana Martínez', 'ana.martinez@email.com', '+1 234-567-8904', '1995-05-30', 'Femenino', 1, 'Activo', '2026-03-28'),
('PAT005', 'Roberto Silva', 'roberto.silva@email.com', '+1 234-567-8905', '1980-09-12', 'Masculino', 4, 'Dado de Alta', '2026-03-10');

-- Citas de Ejemplo
INSERT INTO appointments (appointment_id, patient_id, doctor_id, date, time, service, status, price) VALUES
('APT001', 1, 1, '2026-04-02', '10:30:00', 'Consulta General', 'Agendada', 150.00),
('APT002', 2, 2, '2026-04-02', '14:00:00', 'Control Pediatría', 'Completada', 120.00),
('APT003', 3, 3, '2026-04-02', '16:30:00', 'Consulta Dermatología', 'Cancelada', 180.00),
('APT004', 4, 1, '2026-04-02', '09:00:00', 'Revisión Cardiología', 'Agendada', 200.00),
('APT005', 5, 4, '2026-04-03', '11:00:00', 'Consulta Neurología', 'Agendada', 220.00);

-- Registros Médicos de Ejemplo
INSERT INTO medical_records (record_id, patient_id, doctor_id, appointment_id, diagnosis, treatment, prescription, record_type, status) VALUES
('REC001', 1, 1, 1, 'Hipertensión arterial estadio 2', 'Ejercicio regular, dieta baja en sodio, medicación', 'Lisinopril 10mg una vez al día', 'Consulta', 'Completado'),
('REC002', 2, 2, 2, 'Dermatitis atópica leve', 'Crema hidratante, evitar irritantes', 'Hidrocortisona 1% aplicar 2 veces al día', 'Consulta', 'Completado'),
('REC003', 3, 3, NULL, 'Fractura de fémur', 'Inmovilización, cirugía reparadora', 'Analgésicos, antibióticos profilácticos', 'Urgencia', 'Completado');

-- Facturas de Ejemplo
INSERT INTO invoices (invoice_id, patient_id, appointment_id, service, amount, tax, total, status, issue_date, due_date, payment_date) VALUES
('INV001', 1, 1, 'Consulta General', 150.00, 12.00, 162.00, 'Pagada', '2026-04-01', '2026-04-15', '2026-04-01'),
('INV002', 2, 2, 'Control Pediatría', 120.00, 9.60, 129.60, 'Pagada', '2026-03-28', '2026-04-11', '2026-03-28'),
('INV003', 3, 3, 'Consulta Dermatología', 180.00, 14.40, 194.40, 'Pendiente', '2026-03-20', '2026-04-03', NULL),
('INV004', 4, 4, 'Revisión Cardiología', 200.00, 16.00, 216.00, 'Pendiente', '2026-03-30', '2026-04-14', NULL);

-- =====================================================
-- Vistas Útiles para Consultas Comunes
-- =====================================================

-- Vista de Pacientes con su Doctor Asignado
CREATE VIEW patient_details AS
SELECT 
    p.id,
    p.patient_id,
    p.name,
    p.email,
    p.phone,
    p.status,
    p.last_visit,
    u.name AS doctor_name,
    s.name AS specialty_name
FROM patients p
LEFT JOIN users u ON p.assigned_doctor_id = u.id
LEFT JOIN specialties s ON u.specialty_id = s.id;

-- Vista de Citas Detalladas
CREATE VIEW appointment_details AS
SELECT 
    a.id,
    a.appointment_id,
    a.date,
    a.time,
    a.service,
    a.status,
    a.price,
    p.name AS patient_name,
    p.patient_id,
    u.name AS doctor_name,
    s.name AS specialty_name
FROM appointments a
JOIN patients p ON a.patient_id = p.id
JOIN users u ON a.doctor_id = u.id
LEFT JOIN specialties s ON u.specialty_id = s.id;

-- Vista de Estadísticas del Dashboard
CREATE VIEW dashboard_stats AS
SELECT 
    (SELECT COUNT(*) FROM patients) AS total_patients,
    (SELECT COUNT(*) FROM appointments WHERE DATE(date) = CURDATE()) AS appointments_today,
    (SELECT COUNT(*) FROM users WHERE role = 'doctor' AND status = 'Activo') AS doctors_available,
    (SELECT COUNT(*) FROM patients WHERE status = 'Activo') AS active_patients,
    (SELECT COUNT(*) FROM patients WHERE status = 'En Tratamiento') AS patients_in_treatment,
    (SELECT COALESCE(SUM(total), 0) FROM invoices 
     WHERE status = 'Pagada' AND MONTH(issue_date) = MONTH(CURDATE()) 
     AND YEAR(issue_date) = YEAR(CURDATE())) AS monthly_revenue;

-- =====================================================
-- Triggers para Actualización Automática
-- =====================================================

-- Trigger para actualizar last_visit del paciente cuando se completa una cita
DELIMITER //
CREATE TRIGGER update_patient_last_visit
AFTER UPDATE ON appointments
FOR EACH ROW
BEGIN
    IF NEW.status = 'Completada' AND OLD.status != 'Completada' THEN
        UPDATE patients 
        SET last_visit = NEW.date 
        WHERE id = NEW.patient_id;
    END IF;
END//
DELIMITER ;

-- Trigger para crear notificaciones automáticas
DELIMITER //
CREATE TRIGGER notify_appointment_created
AFTER INSERT ON appointments
FOR EACH ROW
BEGIN
    INSERT INTO notifications (user_id, title, message, type, related_id, related_type)
    VALUES 
    (NEW.doctor_id, 'Nueva Cita Agendada', 
     CONCAT('Nueva cita agendada con ', (SELECT name FROM patients WHERE id = NEW.patient_id), 
            ' para el ', NEW.date, ' a las ', NEW.time), 
     'info', NEW.id, 'appointment'),
     
    (NEW.patient_id, 'Confirmación de Cita', 
     CONCAT('Su cita ha sido agendada para el ', NEW.date, ' a las ', NEW.time), 
     'success', NEW.id, 'appointment');
END//
DELIMITER ;

-- =====================================================
-- Procedimientos Almacenados Útiles
-- =====================================================

-- Procedimiento para obtener estadísticas de citas por semana
DELIMITER //
CREATE PROCEDURE GetWeeklyAppointments(IN start_date DATE, IN end_date DATE)
BEGIN
    SELECT 
        DAYNAME(date) AS day_name,
        COUNT(*) AS appointments_count
    FROM appointments
    WHERE date BETWEEN start_date AND end_date
    GROUP BY DAYNAME(date), date
    ORDER BY date;
END//
DELIMITER ;

-- Procedimiento para obtener distribución por especialidad
DELIMITER //
CREATE PROCEDURE GetDepartmentDistribution()
BEGIN
    SELECT 
        s.name AS department,
        COUNT(u.id) AS doctor_count,
        ROUND((COUNT(u.id) * 100.0 / (SELECT COUNT(*) FROM users WHERE role = 'doctor')), 2) AS percentage
    FROM specialties s
    LEFT JOIN users u ON s.id = u.specialty_id AND u.role = 'doctor'
    GROUP BY s.id, s.name
    ORDER BY doctor_count DESC;
END//
DELIMITER ;

-- =====================================================
-- Índices Adicionales para Performance
-- =====================================================

-- Índices compuestos para consultas frecuentes
CREATE INDEX idx_appointments_doctor_date ON appointments(doctor_id, date);
CREATE INDEX idx_appointments_patient_date ON appointments(patient_id, date);
CREATE INDEX idx_records_patient_doctor ON medical_records(patient_id, doctor_id);
CREATE INDEX idx_invoices_patient_status ON invoices(patient_id, status);

-- =====================================================
-- Configuración Final
-- =====================================================

-- Mostrar resumen de la base de datos
SELECT 
    'Database Setup Complete' AS status,
    DATABASE() AS database_name,
    NOW() AS setup_time;

-- Contar registros iniciales
SELECT 
    'users' AS table_name, COUNT(*) AS record_count FROM users
UNION ALL
SELECT 'patients', COUNT(*) FROM patients
UNION ALL
SELECT 'appointments', COUNT(*) FROM appointments
UNION ALL
SELECT 'medical_records', COUNT(*) FROM medical_records
UNION ALL
SELECT 'invoices', COUNT(*) FROM invoices
UNION ALL
SELECT 'specialties', COUNT(*) FROM specialties;

-- =====================================================
-- Notas Importantes
-- =====================================================

/*
1. CONTRASEÑAS:
   - Las contraseñas en los usuarios iniciales están hasheadas con bcrypt
   - Reemplazar '$2a$10$YourHashedPasswordHere' con hashes reales
   - Ejemplo de hash: bcrypt.hashSync('password123', 10)

2. AJUSTES RECOMENDADOS:
   - Configurar timezone del servidor: SET time_zone = '-03:00';
   - Ajustar max_connections según necesidades
   - Configurar backup automático regular

3. SEGURIDAD:
   - Crear usuario específico para la aplicación con permisos limitados
   - No usar root en producción
   - Configurar SSL/TLS para conexiones

4. ESCALABILIDAD:
   - Considerar particionamiento para tablas grandes
   - Configurar réplica para lectura intensiva
   - Monitorear performance regularmente

5. BACKUP:
   - Programar backups diarios completos
   - Mantener logs binarios para recuperación point-in-time
   - Testear restauración regularmente
*/
