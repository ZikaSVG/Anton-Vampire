import { SECTIONS } from './sections.js';
import { Sound } from './app.js';

export function renderSidebar(active, onNavigate) {
  const nav = document.getElementById('sidebar-nav');
  if (!nav) return;
  nav.innerHTML = '';

  for (const s of SECTIONS) {
    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'sb-btn' + (s.id === active ? ' active' : '');
    btn.innerHTML = `
      <span class="sb-ico">${s.icon}</span>
      <span class="sb-txt">${s.label}</span>
    `;
    btn.addEventListener('click', () => { Sound.click(); onNavigate(s.id); });
    nav.appendChild(btn);
  }
}