# 🏥 MediCore - Sistema de Gestión Médica Integral

## 📋 Descripción del Proyecto

**MediCore** es un sistema de gestión médica completo diseñado para centros de salud, clínicas y hospitales. Proporciona una interfaz moderna y responsiva para administrar pacientes, médicos, citas, historial médico, facturación y especialidades, todo en una plataforma unificada.

### 🎯 Objetivo Principal

Crear una solución integral que optimice la gestión clínica, mejore la experiencia del paciente y facilite el trabajo del personal médico a través de tecnología moderna y procesos automatizados.

---

## 🛠️ Stack Tecnológico

### **Frontend (HTML5 + JavaScript Vanilla)**
- **🎨 Tailwind CSS** - Framework CSS para diseño moderno y responsivo
- **📱 Responsive Design** - Adaptable a todos los dispositivos
- **🎯 Lucide Icons** - Sistema de iconos moderno y consistente
- **📊 Chart.js** - Visualización de datos y estadísticas
- **🌙 Dark Mode** - Tema claro/oscuro con persistencia
- **🔥 Vanilla JavaScript** - Sin dependencias pesadas, rendimiento óptimo

### **Backend (Node.js + Express)**
- **⚡ Express.js** - Framework web rápido y minimalista
- **🗄️ MySQL** - Base de datos relacional robusta
- **🔗 mysql2** - Driver MySQL para Node.js
- **🛡️ Helmet.js** - Seguridad HTTP headers
- **🌐 CORS** - Compartir recursos entre orígenes
- **📝 Morgan** - Logging de peticiones HTTP
- **⚙️ dotenv** - Gestión de variables de entorno

### **Arquitectura y Herramientas**
- **📁 Estructura Modular** - Código organizado y mantenible
- **🔧 ES6+** - JavaScript moderno con clases y módulos
- **🎨 Componentes Reutilizables** - Modales, tablas, gráficos
- **📊 API RESTful** - Endpoints estructurados y documentados
- **🔄 Fallback Data** - Funcionamiento sin conexión a BD

---

## 🏗️ Arquitectura del Sistema

```
Centro-Medico/
├── 📁 src/
│   ├── 📁 views/           # Páginas HTML
│   ├── 📁 components/       # Componentes JS reutilizables
│   ├── 📁 utils/          # Utilidades y configuración
│   ├── 📁 styles/         # CSS personalizado
│   └── 📁 services/       # Lógica de negocio
├── 📁 public/             # Archivos estáticos
├── 📁 assets/             # Imágenes y recursos
├── 📁 docs/              # Documentación técnica
├── 🗄️ database_simple.sql # Base de datos en español
├── 🚀 server_simple.js   # Servidor Express
├── 📦 package.json       # Dependencias y scripts
└── ⚙️ .env.example      # Variables de entorno
```

---

## 📊 Funcionalidades Implementadas

### ✅ **Completadas**

#### **🎨 Interfaz de Usuario**
- [x] **Login Moderno** - Diseño profesional con validación
- [x] **Dashboard Principal** - Vista general con estadísticas
- [x] **Dark Mode** - Tema claro/oscuro persistente
- [x] **Sidebar Navegación** - Menú lateral responsive
- [x] **Header Dinámico** - Búsqueda, notificaciones, perfil

#### **📋 Gestión de Pacientes**
- [x] **Listado Completo** - Tabla con filtros y búsqueda
- [x] **Estadísticas Visuales** - Cards con métricas clave
- [x] **Modal Agregar** - Formulario para nuevos pacientes
- [x] **Estados Visuales** - Badges coloridos y animados

#### **👨‍⚕️ Gestión de Médicos**
- [x] **Directorio Médico** - Listado por especialidades
- [x] **Información Detallada** - Perfiles completos de doctores
- [x] **Disponibilidad** - Estados activo/inactivo
- [x] **Especialidades** - Clasificación por áreas médicas

#### **📅 Gestión de Citas**
- [ ] **Calendario de Citas** - Vista semanal/diaria
- [ ] **Estados Dinámicos** - Agendada, completada, cancelada
- [ ] **Filtros Avanzados** - Por médico, paciente, fecha
- [ ] **Quick Actions** - Acciones rápidas desde la tabla

#### **📋 Historial Médico**
- [x] **Registros Clínicos** - Historial completo de pacientes
- [ ] **Diagnósticos** - Registro de condiciones médicas
- [ ] **Tratamientos** - Seguimiento de terapias
- [ ] **Tipos de Consulta** - Clasificación por servicio

#### **💰 Sistema de Facturación**
- [ ] **Gestión de Facturas** - Creación y seguimiento
- [ ] **Estados de Pago** - Pagada, pendiente, vencida
- [ ] **Cálculos Automáticos** - Subtotales, impuestos, totales
- [ ] **Reportes Financieros** - Estadísticas de ingresos

#### **📊 Visualización de Datos**
- [x] **Gráficos Interactivos** - Chart.js integrado
- [x] **Estadísticas en Tiempo Real** - Métricas del dashboard
- [x] **Tendencias** - Análisis de crecimiento
- [x] **Distribución por Departamento** - Gráficos de pastel

#### **🔧 Backend y API**
- [x] **Servidor Express** - Configurado y funcional
- [x] **API RESTful** - Endpoints completos para todas las entidades
- [x] **MySQL Integration** - Conexión y consultas
- [x] **Fallback Data** - Datos demo si falla BD
- [x] **Middleware Seguridad** - Helmet, CORS, logging
- [x] **Variables Entorno** - Configuración segura

---

## 🚧 Funcionalidades en Desarrollo

### 🔄 **En Progreso**

#### **🔐 Sistema de Autenticación**
- [x] **JWT Tokens** - Autenticación segura
- [x] **Roles y Permisos** - Admin, doctor, recepcionista
- [x] **Session Management** - Control de sesiones activas
- [ ] **Password Recovery** - Recuperación de contraseñas

#### **📱 Notificaciones Push**
- [x] **Browser Notifications** - Alertas del sistema
- [ ] **Email Notifications** - Confirmaciones automáticas
- [ ] **Whatsapp Integration** - Recordatorios de citas
- [ ] **Dashboard Alerts** - Notificaciones en tiempo real

#### **📈 Reportes Avanzados**
- [ ] **PDF Generation** - Reportes exportables
- [ ] **Excel Export** - Datos en hojas de cálculo
- [ ] **Custom Reports** - Reportes personalizados
- [ ] **Scheduled Reports** - Envío automático periódico

---

## 📋 Funcionalidades Pendientes

### 🎯 **Plan Futuro**

#### **🏥 Módulos Médicos Avanzados**
- [ ] **Historial Clínico Completo** - Alergias, antecedentes
- [ ] **Recetas Electrónicas** - Prescripciones digitales
- [ ] **Imágenes Médicas** - DICOM y radiología
- [ ] **Inventario Médico** - Gestión de suministros

#### **💳 Pagos y Finanzas**
- [ ] **Payment Gateway** - Integración con pasarelas
- [ ] **Seguro Médico** - Gestión de pólizas
- [ ] **Facturación Electrónica** - Comprobantes fiscales

#### **📲 Aplicación Móvil**
- [ ] **React Native App** - Versión móvil nativa
- [ ] **Offline Mode** - Sincronización cuando hay conexión

#### **🏢 Gestión Institucional**
- [ ] **Configuración por Centro** - Personalización por sede
- [ ] **Auditoría Completa** - Log de todas las acciones
- [ ] **Backup Automático** - Respaldos programados

---

## 🚀 Quick Start

### **Requisitos Previos**
- Node.js 14+ 
- MySQL 5.7+
- npm o yarn

### **Instalación Rápida**
```bash
# 1. Clonar el proyecto
git clone <repository-url>
cd Centro-Medico

# 2. Instalar dependencias
npm install

# 3. Configurar base de datos
mysql -u root -p medicore_db < database_simple.sql

# 4. Configurar variables
cp .env.example .env
# Editar .env con tus credenciales

# 5. Iniciar servidor
npm start

# 6. Acceder al sistema
# http://localhost:8000/
```

---

## 🤝 Contribución

### **Cómo Contribuir**
1. **Fork** el proyecto
2. **Crear Rama** (`git checkout -b feature/nueva-funcionalidad`)
3. **Commits** descriptivos (`git commit -m 'Agregar nueva funcionalidad'`)
4. **Push** a la rama (`git push origin feature/nueva-funcionalidad`)
5. **Pull Request** para revisión

### **Guía de Estilo**
- **Comentarios en español** - Todo el código documentado en español
- **Nombres descriptivos** - Variables y funciones claras
- **Componentes reutilizables** - Modularidad y mantenibilidad
- **Testing obligatorio** - Pruebas unitarias para nuevas features

---

*Última actualización: 4 de Abril 2026*