import { state, clearCheckboxes, navigate, Sound } from '../app.js';
import { papirusUrl } from '../utils/icons.js';

/* Papirus-иконки для статов и кнопки */
const PAPIRUS = {
  cpu:  { cat: 'devices', name: 'cpu' },
  gpu:  { cat: 'apps', name: 'preferences-system' },
  ram:  { cat: 'devices', name: 'memory' },
  disk: { cat: 'devices', name: 'hdd' },
  run:  { cat: 'apps',    name: 'preferences-system' }
};

/* Разделы, на которые ведут плитки.
   id — совпадает с SECTION в sections.js (navigate(id)).
   icon — эмодзи-фолбэк, если Papirus не найдётся. */
const SECTIONS_TILES = [
  { id: 'security',      icon: '🛡️', title: 'Безопасность',  desc: 'Аудит и защита Windows' },
  { id: 'startup',       icon: '🚀', title: 'Автозагрузка',   desc: 'Службы, задачи, программы' },
  { id: 'optimization',  icon: '⚡', title: 'Оптимизация',    desc: 'Твики, драйверы, службы' },
  { id: 'cleaner',       icon: '🧹', title: 'Очистка',        desc: 'Кэш, временные, мусор' },
  { id: 'fixes',         icon: '⚜️', title: 'Исправления',    desc: 'Восстановление системы' },
  { id: 'game',          icon: '🎮', title: 'Игровой режим',  desc: 'Максимум FPS' },
  { id: 'power',         icon: '🔋', title: 'Электропитание', desc: 'Планы питания' },
  { id: 'customization', icon: '🎨', title: 'Кастомизация',   desc: 'Темы, курсоры, конфиги' },
  { id: 'uninstaller',   icon: '📦', title: 'Приложения',     desc: 'Удаление Appx и софта' },
  { id: 'settings',      icon: '⚙️', title: 'Настройки',      desc: 'Внешний вид и поведение' }
];

/* Papirus-иконки для разделов (если есть у вас в assets/papirus/apps/) */
const SECTION_PAPIRUS = {
  security:      { cat: 'apps', name: 'security-high' },
  startup:       { cat: 'apps', name: 'system-run' },
  optimization:  { cat: 'apps', name: 'preferences-system' },
  cleaner:       { cat: 'apps', name: 'edit-clear-alt' },
  game:          { cat: 'apps', name: 'applications-games' },
  power:         { cat: 'apps', name: 'preferences-system-power' },
  customization: { cat: 'apps', name: 'preferences-desktop-theme' },
  uninstaller:   { cat: 'apps', name: 'edit-clear' },
  settings:      { cat: 'apps', name: 'preferences-system-alt' }
};

function pUrl(key) {
  const p = PAPIRUS[key];
  if (!p) return '';
  try { return papirusUrl(p.cat, p.name); } catch { return ''; }
}

function pImgHtml(key, emoji, className) {
  const url = pUrl(key);
  if (!url) return `<span class="${className}-fallback">${emoji}</span>`;
  return `
    <img class="${className}" src="${url}" alt="" draggable="false"
         onerror="this.style.display='none';this.nextElementSibling.style.display='inline-flex'">
    <span class="${className}-fallback" style="display:none">${emoji}</span>
  `;
}

/* Иконка раздела: сначала Papirus, потом эмодзи */
function sectionIconHtml(sectionId, emoji) {
  const p = SECTION_PAPIRUS[sectionId];
  if (!p) return `<span class="home-nav-emoji">${emoji}</span>`;
  let url = '';
  try { url = papirusUrl(p.cat, p.name); } catch { url = ''; }
  if (!url) return `<span class="home-nav-emoji">${emoji}</span>`;
  return `
    <img class="home-nav-img" src="${url}" alt="" draggable="false"
         onerror="this.style.display='none';this.nextElementSibling.style.display='inline-flex'">
    <span class="home-nav-emoji" style="display:none">${emoji}</span>
  `;
}

export async function renderHome() {
  const tabsNav = document.getElementById('tabs-nav');
  const content = document.getElementById('tab-content');
  tabsNav.innerHTML = '';
  content.innerHTML = '';
  clearCheckboxes();

  const user = await safeUsername();
  const iconPath = await safeIconPath();
  const iconUrl = iconPath ? `file://${String(iconPath).replace(/\\/g, '/')}?t=${Date.now()}` : '';

  /* ============================================================
     HERO
     ============================================================ */
  const hero = document.createElement('div');
  hero.className = 'home-hero-v2';
  hero.innerHTML = `
    <div class="hh-left">
      <div class="hh-avatar">
        ${iconUrl ? `<img src="${iconUrl}" alt="" class="hh-avatar-img">` : '<span class="hh-avatar-emoji">👤</span>'}
      </div>
      <div class="hh-greet">
        <div class="hh-hi">Привет, <span class="hh-name">${escapeHtml(user)}</span></div>
        <div class="hh-tag">Anton Vampire — игровой оптимизатор</div>
      </div>
      <button class="hh-run-btn" id="hh-run">
        ${pImgHtml('run', '⚡', 'hh-run-ico')}
        <span>Оптимизация</span>
      </button>
    </div>

    <div class="hh-right">
      <div class="hh-stat" data-kind="cpu">
        <div class="hh-stat-ico">${pImgHtml('cpu', '🧠', 'hh-stat-img')}</div>
        <div class="hh-stat-body">
          <div class="hh-stat-top">
            <span class="hh-stat-label">CPU</span>
            <span class="hh-stat-pct" id="v-cpu-pct">—</span>
          </div>
          <div class="hh-stat-bar"><div class="hh-stat-fill" id="v-cpu-fill" style="width:0%"></div></div>
          <div class="hh-stat-name" id="v-cpu-name">…</div>
        </div>
      </div>

      <div class="hh-stat" data-kind="gpu">
        <div class="hh-stat-ico">${pImgHtml('gpu', '🎮', 'hh-stat-img')}</div>
        <div class="hh-stat-body">
          <div class="hh-stat-top">
            <span class="hh-stat-label">GPU</span>
            <span class="hh-stat-pct" id="v-gpu-pct">—</span>
          </div>
          <div class="hh-stat-bar"><div class="hh-stat-fill" id="v-gpu-fill" style="width:0%"></div></div>
          <div class="hh-stat-name" id="v-gpu-name">…</div>
        </div>
      </div>

      <div class="hh-stat" data-kind="ram">
        <div class="hh-stat-ico">${pImgHtml('ram', '💾', 'hh-stat-img')}</div>
        <div class="hh-stat-body">
          <div class="hh-stat-top">
            <span class="hh-stat-label">RAM</span>
            <span class="hh-stat-pct" id="v-ram-pct">—</span>
          </div>
          <div class="hh-stat-bar"><div class="hh-stat-fill" id="v-ram-fill" style="width:0%"></div></div>
          <div class="hh-stat-name" id="v-ram-name">…</div>
        </div>
      </div>

      <div class="hh-stat" data-kind="disk">
        <div class="hh-stat-ico">${pImgHtml('disk', '🗄️', 'hh-stat-img')}</div>
        <div class="hh-stat-body">
          <div class="hh-stat-top">
            <span class="hh-stat-label">ДИСК</span>
            <span class="hh-stat-pct" id="v-disk-pct">—</span>
          </div>
          <div class="hh-stat-bar"><div class="hh-stat-fill" id="v-disk-fill" style="width:0%"></div></div>
          <div class="hh-stat-name" id="v-disk-name">…</div>
        </div>
      </div>
    </div>
  `;
  content.appendChild(hero);

  hero.querySelector('#hh-run').addEventListener('click', () => {
    Sound.click();
    navigate('optimization');
  });

  startHardwarePolling();

  /* ============================================================
     NAV TILES — переходы по разделам
     ============================================================ */
  const navWrap = document.createElement('div');
  navWrap.className = 'home-nav';
  navWrap.innerHTML = `
    <div class="home-nav-grid">
      ${SECTIONS_TILES.map(s => `
        <button class="home-nav-tile" data-target="${s.id}">
          <div class="home-nav-ico">${sectionIconHtml(s.id, s.icon)}</div>
          <div class="home-nav-name">${escapeHtml(s.title)}</div>
          <div class="home-nav-desc">${escapeHtml(s.desc)}</div>
        </button>
      `).join('')}
    </div>
  `;
  content.appendChild(navWrap);

  navWrap.querySelectorAll('.home-nav-tile').forEach(btn => {
    btn.addEventListener('click', () => {
      Sound.click();
      navigate(btn.dataset.target);
    });
  });
}

async function safeUsername() {
  try {
    if (window.api?.app?.username) {
      const u = await window.api.app.username();
      return u || 'user';
    }
  } catch { /* ignore */ }
  return 'user';
}

async function safeIconPath() {
  try {
    if (window.api?.app?.icon) {
      const p = await window.api.app.icon();
      return p || null;
    }
  } catch { /* ignore */ }
  return null;
}

/* ================= Hardware polling ================= */
let hwTimer = null;

async function startHardwarePolling() {
  if (hwTimer) clearInterval(hwTimer);
  await pollOnce();
  hwTimer = setInterval(pollOnce, 2000);
}

export function stopHardwarePolling() {
  if (hwTimer) {
    clearInterval(hwTimer);
    hwTimer = null;
  }
}

async function pollOnce() {
  try {
    if (!window.api?.hardware?.stats) return;
    const s = await window.api.hardware.stats();
    if (!s) return;

    const setStat = (key, val, nameText) => {
      const pct = document.getElementById(`v-${key}-pct`);
      const fill = document.getElementById(`v-${key}-fill`);
      const name = document.getElementById(`v-${key}-name`);
      const v = Math.max(0, Math.min(100, Number(val) || 0));

      if (pct) pct.textContent = v.toFixed(0) + '%';
      if (fill) fill.style.width = v + '%';
      if (name) {
        name.textContent = nameText;
        name.title = nameText;
      }

      const stat = document.querySelector(`.hh-stat[data-kind="${key}"]`);
      if (stat) {
        stat.classList.remove('warn', 'danger');
        if (v >= 85) stat.classList.add('danger');
        else if (v >= 60) stat.classList.add('warn');
      }
    };

    setStat('cpu', s.cpuLoad, s.cpuName || 'CPU');
    setStat('gpu', s.gpuLoad, s.gpuName || 'GPU');
    setStat('ram', s.ramPercent,
      `${s.ramUsedGb.toFixed(1)} / ${s.ramTotalGb.toFixed(1)} GB`);

    if (s.diskTotalGb) {
      setStat('disk', s.diskPercent,
        `${s.diskUsedGb.toFixed(1)} / ${s.diskTotalGb.toFixed(1)} GB`);
    } else {
      setStat('disk', 0, 'недоступно');
    }
  } catch { /* ignore */ }
}

function escapeHtml(s) {
  return String(s)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}