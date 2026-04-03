// Lógica del Modo Oscuro
const toggleTheme = () => {
    const html = document.documentElement;
    if (html.classList.contains('dark')) {
        html.classList.remove('dark');
        localStorage.setItem('theme', 'light');
    } else {
        html.classList.add('dark');
        localStorage.setItem('theme', 'dark');
    }
};

// Verificar Almacenamiento Local para el Tema
if (localStorage.getItem('theme') === 'dark' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
    document.documentElement.classList.add('dark');
} else {
    document.documentElement.classList.remove('dark');
}

// Escuchador de Eventos para el Alternador
document.addEventListener('DOMContentLoaded', () => {
    const toggleBtn = document.getElementById('theme-toggle');
    if (toggleBtn) {
        toggleBtn.addEventListener('click', toggleTheme);
    }

    // Inicializar Alternador de Barra Lateral si existe
    const sidebarToggle = document.getElementById('sidebar-toggle');
    const sidebar = document.getElementById('sidebar');
    
    if (sidebarToggle && sidebar) {
        sidebarToggle.addEventListener('click', () => {
            sidebar.classList.toggle('hidden');
        });
    }

    // Inicializar Modales
    const modals = document.querySelectorAll('.modal');
    modals.forEach(modal => {
        const trigger = modal.getAttribute('data-trigger');
        if(trigger) {
            document.getElementById(trigger).addEventListener('click', () => {
                modal.classList.remove('hidden');
            });
        }
    });
});

// Función auxiliar para cerrar modales
window.closeModal = (modalId) => {
    const modal = document.getElementById(modalId);
    if(modal) modal.classList.add('hidden');
};
