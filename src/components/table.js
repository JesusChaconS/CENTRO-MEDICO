// Lógica del Componente Tabla
function renderTable(containerId, data, columns) {
    const container = document.getElementById(containerId);
    if (!container) return;

    let html = `
        <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-slate-200 dark:divide-slate-700">
                <thead class="bg-slate-50 dark:bg-slate-800">
                    <tr>
                        ${columns.map(col => `
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-slate-500 dark:text-slate-400 uppercase tracking-wider">
                                ${col.label}
                            </th>
                        `).join('')}
                    </tr>
                </thead>
                <tbody class="bg-white dark:bg-dark-card divide-y divide-slate-200 dark:divide-slate-700">
    `;

    data.forEach(row => {
        html += `
            <tr class="hover:bg-slate-50 dark:hover:bg-slate-800/50 transition-colors">
                ${columns.map(col => {
                    let content = row[col.key];
                    if (col.type === 'status') {
                        content = `<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${col.class}">${row[col.key]}</span>`;
                    } else if (col.type === 'avatar') {
                        content = `<div class="flex items-center gap-3"><img class="w-8 h-8 rounded-full object-cover" src="${row[col.key]}" alt=""> <span class="text-sm font-medium text-slate-900 dark:text-white">${row[col.name]}</span></div>`;
                    } else if (col.type === 'icon') {
                        content = `<div class="flex items-center gap-3"><i data-lucide="${row[col.key]}" class="w-4 h-4 text-slate-400"></i> <span class="text-sm font-medium text-slate-900 dark:text-white">${row[col.name]}</span></div>`;
                    }
                    return `<td class="px-6 py-4 whitespace-nowrap text-sm text-slate-600 dark:text-slate-300">${content}</td>`;
                }).join('')}
            </tr>
        `;
    });

    html += `
                </tbody>
            </table>
        </div>
    `;

    container.innerHTML = html;
    lucide.createIcons();
}
