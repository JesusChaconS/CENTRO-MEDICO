// Lógica del Componente Modal
class Modal {
    constructor(element) {
        this.element = element;
        this.trigger = element.getAttribute('data-trigger');
        this.closeBtn = element.querySelector('.close-modal');
        
        if(this.closeBtn) {
            this.closeBtn.addEventListener('click', () => this.close());
        }
        
        // Cerrar al hacer clic fuera
        this.element.addEventListener('click', (e) => {
            if (e.target === this.element) this.close();
        });
    }

    open() {
        this.element.classList.remove('hidden');
    }

    close() {
        this.element.classList.add('hidden');
    }
}

// Auto-inicializar modales en el DOM
document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.modal').forEach(modal => {
        new Modal(modal);
    });
});
