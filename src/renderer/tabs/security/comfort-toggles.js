import { state, toast, Sound } from '../../app.js';

const cache = { loaded: false, state: null, promise: null };
let refs = { host: null };

const COMFORT_ITEMS = [
  { id: 'defender', icon: '', title: 'Defender', desc: 'Защита в реальном времени' },
  { id: 'uac', icon: '🔐', title: 'UAC', desc: 'Контроль учётных записей' },
  { id: 'smartscreen', icon: '', title: 'SmartScreen', desc: 'Фильтр опасных программ' },
  { id: 'updates', icon: '🔄', title: 'Обновления', desc: 'Служба Windows Update' },
  { id: 'firewall', icon: '🔥', title: 'Брандмауэр', desc: 'Сетевой фильтр Windows' }
];

export function buildComfortToggles(panel) {
  const section = document.createElement('section');
  section.className = 'm3-section';
  section.innerHTML = `
    <div class="m3-section-title">🎛 Управление защитой</div>
    <p class="m3-note">Включено — защита работает. Выключено — отключена ради удобства.</p>
    <div class="m3-toggles-grid" id="comfort-tiles"></div>
  `;
  panel.appendChild(section);
  refs.host = section.querySelector('#comfort-tiles');
  loadComfort();
}

async function loadComfort() {
  if (cache.loaded && cache.state) { renderTiles(); return; }
  if (cache.promise) return cache.promise;

  if (refs.host) refs.host.innerHTML = `<div class="muted">Загрузка…</div>`;
  cache.promise = (async () => {
    try {
      const st = await window.api.comfort.getState();
      cache.state = st;
      cache.loaded = true;
    } catch (e) {
      cache.state = null;
      cache.loaded = true;
      toast('Ошибка загрузки: ' + e.message, 'error', 4000);
    } finally { cache.promise = null; }
    renderTiles();
  })();
  return cache.promise;
}

function renderTiles() {
  const host = refs.host;
  if (!host) return;
  host.innerHTML = '';

  const st = cache.state || {};
  for (const it of COMFORT_ITEMS) {
    const on = !!st[it.id];
    const card = document.createElement('div');
    card.className = 'm3-toggle-card ' + (on ? 'on' : 'off');
    card.innerHTML = `
      <div class="m3-toggle-icon">${it.icon}</div>
      <div class="m3-toggle-info">
        <div class="m3-toggle-title">${it.title}</div>
        <div class="m3-toggle-desc">${it.desc}</div>
      </div>
      <div class="m3-toggle-switch ${on ? 'on' : 'off'}">
        <div class="m3-toggle-thumb"></div>
      </div>
    `;
    card.addEventListener('click', async () => {
      Sound.click();
      const next = !on;
      if (!confirm(`${next ? 'Включить' : 'Отключить'} «${it.title}»?`)) return;
      const r = await window.api.comfort.setItem(it.id, next);
      if (r && r.ok) {
        toast(next ? 'Включено' : 'Отключено', 'success', 1200);
        cache.loaded = false;
        cache.promise = null;
        loadComfort();
      } else {
        toast('Ошибка: ' + (r?.error || 'неизвестно'), 'error', 4000);
      }
    });
    host.appendChild(card);
  }
}