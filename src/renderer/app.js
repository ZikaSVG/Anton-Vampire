import { renderSidebar } from './sidebar.js';
import { SECTIONS } from './sections.js';
import {
  applyTheme, applySidebarOpacity, THEME_NAMES,
  applyFonts, applyDensity, applyCornerRadius, applyVisualEffect
} from './themes.js';
import { applyStyle } from './styles/style-loader.js';
import { renderHome, stopHardwarePolling } from './tabs/home.js';
import { renderOptimization } from './tabs/optimization.js';
import { renderPower } from './tabs/power.js';
import { renderFixes } from './tabs/fixes.js';
import { renderCleaner } from './tabs/cleaner.js';
import { renderGameMode } from './tabs/game-mode.js';
import { renderStartup } from './tabs/startup.js';
import { renderSecurity } from './tabs/security/index.js';
import { renderCustomization } from './tabs/customization.js';
import { renderAppUninstaller } from './tabs/app-uninstaller.js';
import { renderSettings } from './tabs/settings.js';
import { loggedRunMany, logLine, logSeparator, logWrite } from './logger.js';
import { clearDescriptionCache } from './components/checkbox.js';

const WEBSITE_URL = 'https://anton18-png.github.io/Anton-Vampire/web/index.html';

/* Вкладки, которые НЕ кэшируются между заходами. */
const ALWAYS_RERENDER = new Set([
  'startup',
  'uninstaller',
  'customization',
  'security'
]);

export const state = {
  config: {},
  tabsData: {},
  activeSection: 'main',
  activeTab: null,
  search: '',
  checkboxes: new Map(),
  lazyTabs: true,
  preloadHeavy: true,
  preloadAudits: true,
  loadedTabs: new Set(),
  dataCache: {}
};

/* ================= Sound ================= */
export const Sound = {
  enabled: JSON.parse(localStorage.getItem('sound.enabled') ?? 'true'),
  volume: Number(localStorage.getItem('sound.volume') ?? 0.15),
  ctx: null,
  _lastHover: 0,
  getCtx() {
    if (!this.ctx) {
      const C = window.AudioContext || window.webkitAudioContext;
      if (!C) return null;
      try { this.ctx = new C(); } catch { return null; }
    }
    return this.ctx;
  },
  save() {
    localStorage.setItem('sound.enabled', JSON.stringify(this.enabled));
    localStorage.setItem('sound.volume', String(this.volume));
  },
  tone(freq, ms, vol = this.volume) {
    if (!this.enabled) return;
    const ctx = this.getCtx();
    if (!ctx) return;
    try {
      const osc = ctx.createOscillator();
      const gain = ctx.createGain();
      osc.frequency.value = freq;
      osc.type = 'sine';
      gain.gain.value = vol;
      osc.connect(gain).connect(ctx.destination);
      const now = ctx.currentTime;
      gain.gain.setValueAtTime(vol, now);
      gain.gain.exponentialRampToValueAtTime(0.0001, now + ms / 1000);
      osc.start(now);
      osc.stop(now + ms / 1000);
    } catch { /* ignore */ }
  },
  click()     { this.tone(600, 30, 0.15); setTimeout(() => this.tone(900, 40, 0.12), 50); },
  toggleOn()  { this.tone(700, 40, 0.14); setTimeout(() => this.tone(1100, 60, 0.12), 40); },
  toggleOff() { this.tone(700, 40, 0.12); setTimeout(() => this.tone(400, 60, 0.14), 40); },
  hover() {
    const now = Date.now();
    if (now - this._lastHover < 80) return;
    this._lastHover = now;
    this.tone(800, 40, 0.06);
  },
  success() { this.tone(523, 100); setTimeout(() => this.tone(659, 100), 100); setTimeout(() => this.tone(784, 150), 200); },
  error()   { this.tone(400, 100, 0.2); setTimeout(() => this.tone(300, 150, 0.25), 100); }
};

/* ================= Toast ================= */
export function toast(msg, type = 'info', timeout = 3000) {
  const c = document.getElementById('toast-container');
  if (!c) return;
  const el = document.createElement('div');
  el.className = `toast ${type}`;
  el.textContent = msg;
  c.appendChild(el);
  setTimeout(() => el.remove(), timeout);
}

export function setStatus(text) {
  const el = document.getElementById('status-text');
  if (el) el.textContent = text;
}

export function updateCounter() {
  const total = state.checkboxes.size;
  let sel = 0;
  for (const c of state.checkboxes.values()) {
    if (c.var.checked) sel++;
  }
  const counter = document.getElementById('selection-counter');
  if (counter) counter.textContent = `Выбрано: ${sel} / ${total}`;
}

/* ============================================================
   SPLASH SCREEN
   ============================================================ */
let splashDisabled = false;

function splashSetProgress(percent, text) {
  if (splashDisabled) return;
  const fill = document.getElementById('splash-progress-fill');
  const txt  = document.getElementById('splash-progress-text');
  if (fill) fill.style.width = Math.max(0, Math.min(100, percent)) + '%';
  if (txt)  txt.textContent = text || '';
}

function splashHideImmediate() {
  splashDisabled = true;
  const splash = document.getElementById('splash-screen');
  document.body.classList.remove('app-loading');
  document.body.classList.add('app-ready');
  if (!splash) return;
  if (splash.parentElement) splash.parentElement.removeChild(splash);
}

function waitImage(imgEl, url, timeoutMs = 20000) {
  return new Promise((resolve) => {
    if (!imgEl || !url) return resolve(false);

    let done = false;
    const finish = (ok) => {
      if (done) return;
      done = true;
      clearTimeout(timer);
      imgEl.removeEventListener('load', onLoad);
      imgEl.removeEventListener('error', onError);
      resolve(ok);
    };

    const onLoad = () => finish(true);
    const onError = () => finish(false);
    const timer = setTimeout(() => finish(false), timeoutMs);

    imgEl.addEventListener('load', onLoad);
    imgEl.addEventListener('error', onError);

    requestAnimationFrame(() => {
      imgEl.src = url;
    });
  });
}

async function splashLoadLogo() {
  if (splashDisabled) return false;
  const logo = document.getElementById('splash-logo');
  if (!logo) return false;

  let ok = false;

  try {
    const iconPath = await window.api.app.icon();
    if (iconPath) {
      const url = `file://${String(iconPath).replace(/\\/g, '/')}?t=${Date.now()}`;
      ok = await waitImage(logo, url);
    }
  } catch { /* ignore */ }

  if (!ok) {
    ok = await waitImage(logo, `assets/logo.png?t=${Date.now()}`);
  }

  if (ok) {
    logo.classList.add('visible');
    const fb = document.querySelector('.splash-logo-fallback');
    if (fb) fb.style.display = 'none';
  }

  return ok;
}

async function splashLoadBackground() {
  if (splashDisabled) return false;
  const bg = document.getElementById('splash-bg');
  if (!bg) return false;

  let ok = false;

  try {
    const userPath = await window.api.background.get();
    if (userPath) {
      const url = `file://${String(userPath).replace(/\\/g, '/')}?t=${Date.now()}`;
      ok = await waitImage(bg, url);
    }
  } catch { /* ignore */ }

  if (!ok) {
    try {
      if (typeof window.api.background.default === 'function') {
        const defPath = await window.api.background.default();
        if (defPath) {
          const url = `file://${String(defPath).replace(/\\/g, '/')}?t=${Date.now()}`;
          ok = await waitImage(bg, url);
        }
      }
    } catch { /* ignore */ }
  }

  if (ok) {
    bg.classList.add('visible');
  } else {
    bg.classList.remove('visible');
  }

  return ok;
}

function splashHide() {
  if (splashDisabled) return;
  const splash = document.getElementById('splash-screen');
  document.body.classList.remove('app-loading');
  document.body.classList.add('app-ready');
  if (!splash) return;
  splash.classList.add('hidden');
  setTimeout(() => {
    if (splash && splash.parentElement) splash.parentElement.removeChild(splash);
  }, 500);
}

/* ================= Navigation ================= */
const RENDERERS = {
  main: renderHome,
  optimization: renderOptimization,
  power: renderPower,
  cleaner: renderCleaner,
  fixes: renderFixes,
  game: renderGameMode,
  startup: renderStartup,
  security: renderSecurity,
  customization: renderCustomization,
  uninstaller: renderAppUninstaller,
  settings: renderSettings
};

export function navigate(sectionId) {
  if (sectionId !== 'main') {
    try { stopHardwarePolling(); } catch { /* ignore */ }
  }

  try { clearDescriptionCache(); } catch { /* ignore */ }

  state.activeSection = sectionId;

  try { renderSidebar(sectionId, navigate); }
  catch (e) { console.error('[navigate] renderSidebar failed:', e); }

  try { bindSidebarButtons(); }
  catch (e) { console.error('[navigate] bindSidebarButtons failed:', e); }

  const renderer = RENDERERS[sectionId] || renderOptimization;

  const needsRerender = !state.loadedTabs.has(sectionId) || ALWAYS_RERENDER.has(sectionId);

  if (state.lazyTabs && needsRerender) {
    const content = document.getElementById('tab-content');
    if (content && !content.querySelector('.tab-loading-placeholder')) {
      content.innerHTML = `
        <div class="tab-loading-placeholder">
          <div class="tab-loading-spinner"></div>
          <div class="tab-loading-text">Загрузка вкладки…</div>
        </div>
      `;
    }
  }

  Promise.resolve().then(async () => {
    try {
      if (state.preloadHeavy) {
        const needPreload = PRELOAD_JOBS.some(
          j => j.tabs.includes(sectionId) && state.dataCache[j.key] === undefined
        );
        if (needPreload) {
          try { await preloadTab(sectionId); } catch { /* ignore */ }
        }
      }
      await renderer();
      state.loadedTabs.add(sectionId);
    } catch (err) {
      console.error('[navigate] renderer failed:', err);
      toast('Ошибка загрузки вкладки: ' + err.message, 'error');
    }
  });
}

/* ================= Checkbox registry ================= */
export function registerCheckbox(key, info) {
  state.checkboxes.set(key, info);
  updateCounter();
}

export function clearCheckboxes() {
  state.checkboxes.clear();
  updateCounter();
}

/* ================= Execute selected ================= */
async function executeSelected() {
  const paths = [...state.checkboxes.values()]
    .filter(info => info.var.checked)
    .map(info => info.path);

  if (!paths.length) { toast('Не выбрано ни одного твика', 'warning'); return; }
  if (!confirm(`Применить ${paths.length} твиков?`)) return;

  setStatus(`Выполняется ${paths.length} твиков...`);
  Sound.click();

  try {
    const results = await loggedRunMany(paths, { visible: false });
    const success = results.filter(r => r.ok).length;
    const failed  = results.filter(r => !r.ok);
    
    setStatus(`Готово: ${success} / ${paths.length}`);
    toast(
      `Выполнено: ${success} / ${paths.length}`,
      failed.length === 0 ? 'success' : 'warning',
      failed.length === 0 ? 3000 : 5000
    );
    if (success > 0) Sound.success();
    if (failed.length) {
      Sound.error();
      for (const f of failed.slice(0, 5)) {
        const name = f.path.split('/').pop();
        toast(`❌ ${name}: ${f.error || 'ошибка'}`, 'error', 6000);
      }
    }
  } catch (e) {
    setStatus('Ошибка');
    Sound.error();
    toast('Ошибка IPC: ' + e.message, 'error', 5000);
    logLine('❌ executeSelected: ' + e.message);
  }
}

/* ================= Background ================= */
export function setBackground(filePath) {
  const bgEl = document.getElementById('bg-image');
  const appEl = document.getElementById('app');
  if (!bgEl) return;
  if (!filePath) {
    bgEl.removeAttribute('src');
    bgEl.classList.remove('visible');
    appEl?.classList.remove('has-bg');
    return;
  }
  bgEl.src = `file://${String(filePath).replace(/\\/g, '/')}?t=${Date.now()}`;
  bgEl.classList.add('visible');
  appEl?.classList.add('has-bg');
}

async function loadSavedBackground() {
  try {
    const userPath = await window.api.background.get();
    if (userPath && userPath.length) { setBackground(userPath); return; }
  } catch { /* ignore */ }

  try {
    if (typeof window.api.background.default === 'function') {
      const defPath = await window.api.background.default();
      if (defPath) setBackground(defPath);
    }
  } catch { /* ignore */ }
}

export async function applyWallpaperAsBackground(fullPath) {
  const saved = await window.api.background.save(fullPath);
  if (saved) {
    setBackground(saved);
    return true;
  }
  return false;
}

export async function pickBackground() {
  const file = await window.api.dialog.pickFile({
    title: 'Выберите фон',
    filters: [{ name: 'Изображения', extensions: ['png', 'jpg', 'jpeg', 'bmp', 'webp'] }],
    properties: ['openFile']
  });
  if (!file) return false;
  const saved = await window.api.background.save(file);
  if (!saved) return false;
  setBackground(saved);
  return true;
}

export async function clearBackground() {
  await window.api.background.clear();
  try {
    if (typeof window.api.background.default === 'function') {
      const defPath = await window.api.background.default();
      if (defPath) { setBackground(defPath); return; }
    }
  } catch { /* ignore */ }
  setBackground(null);
}

/* ================= Sound button ================= */
function updateSoundButton() {
  const btn = document.getElementById('btn-sound');
  if (!btn) return;
  btn.textContent = Sound.enabled ? '🔊' : '🔇';
  btn.title = Sound.enabled ? 'Звук включён' : 'Звук выключен';
}

/* ================= Reapply ================= */
function readUnified() {
  return !!state.config.General?.unified_button_color;
}

function readSidebarOpacity() {
  const v = state.config.General?.sidebar_opacity;
  return v === undefined ? 75 : Number(v);
}

export function reapplyTheme() {
  const g = state.config.General || {};
  applyTheme(g.theme || 'material3', readUnified(), readSidebarOpacity());
  applyVisualEffect(g.visual_effect || 'none');
}

export function reapplySidebarOpacity() {
  applySidebarOpacity(readSidebarOpacity());
}

export function reapplyFontsAndShape() {
  const g = state.config.General || {};
  applyFonts(g);
  applyDensity(g.ui_density || 'comfortable');
  applyCornerRadius(g.corner_radius ?? 12);
}

/* ============================================================
   ПРИМЕНЕНИЕ CSS-СТИЛЯ
   ============================================================ */
export async function setUiStyle(styleId) {
  state.config.General = state.config.General || {};
  state.config.General.ui_style = styleId;

  try { await window.api.config.set('General.ui_style', styleId); }
  catch (e) { console.warn('[setUiStyle] config.set failed:', e); }

  await applyStyle(styleId);
  reapplyTheme();
  reapplyFontsAndShape();

  return true;
}

/* ================= Sidebar buttons ================= */
function bindSidebarButtons() {
  const bind = (id, fn) => {
    const el = document.getElementById(id);
    if (!el || el.dataset.bound) return;
    el.dataset.bound = '1';
    el.addEventListener('click', fn);
  };

  bind('btn-theme', async () => {
    Sound.click();
    const cur = state.config.General?.theme || 'material3';
    const idx = THEME_NAMES.indexOf(cur);
    const next = THEME_NAMES[(idx + 1) % THEME_NAMES.length];
    state.config.General = state.config.General || {};
    state.config.General.theme = next;
    applyTheme(next, readUnified(), readSidebarOpacity());
    await window.api.config.set('General.theme', next);
    toast('Тема: ' + next, 'success', 1200);
  });

  bind('btn-sound', () => {
    Sound.enabled = !Sound.enabled;
    Sound.save();
    updateSoundButton();
    if (Sound.enabled) Sound.success();
  });

  bind('btn-bg', async () => {
    Sound.click();
    const ok = await pickBackground();
    if (ok) { Sound.success(); toast('Фон применён', 'success'); }
  });

  bind('btn-website', () => {
    Sound.click();
    window.api.shell.openExternal(WEBSITE_URL);
  });

  bind('btn-telegram', () => {
    Sound.click();
    window.api.shell.openExternal('https://t.me/all_tweaker');
  });

  bind('btn-donate', () => {
    Sound.click();
    window.api.shell.openExternal('https://www.tinkoff.ru/cf/2VBH9zSztcW');
  });

  updateSoundButton();
}

function bindMainUI() {
  document.getElementById('global-search')?.addEventListener('input', e => {
    state.search = e.target.value.toLowerCase();
    applySearch();
  });

  document.getElementById('btn-execute')?.addEventListener('click', () => {
    Sound.click();
    executeSelected();
  });

  document.getElementById('btn-select-all')?.addEventListener('click', () => {
    Sound.click();
    for (const info of state.checkboxes.values()) {
      info.var.checked = true;
      info.el?.classList.add('checked');
      const inp = info.el?.querySelector('input');
      if (inp) inp.checked = true;
    }
    updateCounter();
  });

  document.getElementById('btn-minimize')?.addEventListener('click', () => window.api.window.minimize());
  document.getElementById('btn-close')?.addEventListener('click',    () => window.api.window.close());

  document.getElementById('btn-refresh-all')?.addEventListener('click', async () => {
    Sound.click();
    if (!confirm('Сбросить кэш всех вкладок и перезагрузить данные?')) return;
    state.dataCache = {};
    state.loadedTabs.clear();
    toast('Кэш сброшен — данные будут загружены заново', 'success', 2000);
    navigate(state.activeSection);
  });

  const maxBtn = document.getElementById('btn-maximize');
  if (maxBtn) {
    const syncMaxIcon = async () => {
      const isMax = await window.api.window.isMaximized();
      maxBtn.textContent = isMax ? '❐' : '⛶';
      maxBtn.title = isMax ? 'Восстановить' : 'Развернуть';
    };
    maxBtn.addEventListener('click', async () => {
      Sound.click();
      await window.api.window.maximize();
      syncMaxIcon();
    });
    if (typeof window.api.window.onMaximizedChange === 'function') {
      window.api.window.onMaximizedChange(isMax => {
        maxBtn.textContent = isMax ? '❐' : '⛶';
        maxBtn.title = isMax ? 'Восстановить' : 'Развернуть';
      });
    }
    syncMaxIcon();
  }

  document.getElementById('btn-fullscreen')?.addEventListener('click', () => {
    Sound.click();
    window.api.window.toggleFullscreen();
  });

  document.body.addEventListener('mouseover', (e) => {
    const btn = e.target.closest('button, .cbx, .sb-btn, .tab-btn, .vendor-row');
    if (!btn) return;
    if (e.relatedTarget && btn.contains(e.relatedTarget)) return;
    Sound.hover();
  });

  document.addEventListener('keydown', e => {
    if (e.key === 'F11') { e.preventDefault(); window.api.window.toggleFullscreen(); }
    if (e.key === 'F5')  { e.preventDefault(); location.reload(); }
    if (e.key === 'F1')  { e.preventDefault(); window.api.shell.openExternal(WEBSITE_URL); }
  });
}

/* ============================================================
   ФОНОВАЯ ДОГРУЗКА ТЯЖЁЛЫХ ДАННЫХ
   ============================================================ */

const PRELOAD_JOBS = [
  { key: 'startup',        tabs: ['startup'],       critical: true,  load: () => window.api.startup.list(true) },
  { key: 'apps',           tabs: ['uninstaller'],   critical: true,  load: async () => {
      const [list, detect] = await Promise.all([
        window.api.apps.list(),
        window.api.apps.detect()
      ]);
      return { raw: list?.raw || '', detectRaw: detect?.raw || '' };
  }},
  { key: 'audit_security', tabs: ['security'],      critical: true,  load: () => window.api.security.audit('security') },
  { key: 'audit_privacy',  tabs: ['security'],      critical: true,  load: () => window.api.security.audit('privacy') },
  { key: 'audit_comfort',  tabs: ['security'],      critical: true,  load: () => window.api.security.audit('comfort') },
  { key: 'firewall',       tabs: ['security'],      critical: false, load: () => window.api.firewall.list() },
  { key: 'netmon',         tabs: ['security'],      critical: false, load: () => window.api.netmon.snapshot() },
  { key: 'cursors',        tabs: ['customization'], critical: false, load: () => window.api.cursors.list(false) }
];

let _preloadPromise = null;

export function getPreloadPromise() {
  return _preloadPromise;
}

async function runPreloadJob(job) {
  if (state.dataCache[job.key] !== undefined) return;
  try {
    const data = await job.load();
    state.dataCache[job.key] = data;
    console.log(`[preload] ✅ ${job.key}`);
  } catch (e) {
    console.warn(`[preload] ❌ ${job.key}:`, e);
    state.dataCache[job.key] = null;
  }
}

export async function preloadHeavyTabsData(opts = {}) {
  const { onProgress = null, criticalOnly = false } = opts;
  console.log('[preload] старт прогрева', criticalOnly ? '(critical only)' : '(все)');

  if (!criticalOnly && _preloadPromise) {
    return _preloadPromise;
  }

  const jobs = criticalOnly
    ? PRELOAD_JOBS.filter(j => j.critical)
    : PRELOAD_JOBS;

  const total = jobs.length;
  let done = 0;

  const runOne = async (job) => {
    await runPreloadJob(job);
    done++;
    if (typeof onProgress === 'function') {
      try { onProgress(done, total, job.key); } catch {}
    }
  };

  const p = Promise.allSettled(jobs.map(runOne)).then(() => {
    if (_preloadPromise === p) _preloadPromise = null;
  });

  _preloadPromise = p;

  return p;
}

export async function preloadTab(sectionId) {
  const jobs = PRELOAD_JOBS.filter(j => j.tabs.includes(sectionId));
  if (!jobs.length) return false;
  await Promise.allSettled(jobs.map(runPreloadJob));
  return true;
}

export function invalidateCache(sectionIdOrKey) {
  let cleared = false;
  for (const job of PRELOAD_JOBS) {
    if (job.tabs.includes(sectionIdOrKey)) {
      delete state.dataCache[job.key];
      cleared = true;
    }
  }
  if (!cleared) {
    for (const job of PRELOAD_JOBS) {
      if (job.key === sectionIdOrKey) {
        delete state.dataCache[job.key];
        cleared = true;
      }
    }
  }
  if (!cleared) delete state.dataCache[sectionIdOrKey];
  return cleared;
}

function allJobsDone() {
  return PRELOAD_JOBS.every(j => state.dataCache[j.key] !== undefined);
}

/* ============================================================
   INIT
   ============================================================ */
async function init() {
  console.log('[init] start');

  document.body.classList.add('app-loading');

  let config = { General: {} };
  try {
    config = await window.api.config.getAll() || { General: {} };
  } catch (e) {
    console.error('[init] config failed:', e);
  }
  state.config = config;

  try {
    await applyStyle(state.config.General?.ui_style || 'default');
  } catch (e) {
    console.warn('[init] style apply failed:', e);
  }

  reapplyTheme();
  reapplyFontsAndShape();

  document.body.classList.remove('app-loading');

  const showSplash = state.config.General?.show_splash !== false;

  if (!showSplash) {
    console.log('[init] splash disabled → hide immediately');
    splashHideImmediate();
  }

  splashSetProgress(5, '🩸 Загрузка логотипа и фона…');

  const logoPromise = showSplash ? splashLoadLogo() : Promise.resolve(false);
  const bgPromise   = showSplash ? splashLoadBackground() : Promise.resolve(false);

  const versionPromise = window.api.app.version().catch(() => null);
  const tabsPromise    = window.api.tabs.data().catch(() => ({}));

  if (showSplash) {
    const [logoOk, bgOk] = await Promise.all([logoPromise, bgPromise]);
    console.log('[init] preloader ready. logo =', logoOk, ', bg =', bgOk);
    splashSetProgress(30, '✅ Логотип и фон загружены');
  }

  state.lazyTabs      = state.config.General?.lazy_tabs !== false;
  state.preloadHeavy  = state.config.General?.preload_heavy_tabs !== false;
  state.preloadAudits = state.config.General?.preload_audits !== false;

  reapplyTheme();
  reapplyFontsAndShape();
  splashSetProgress(50, '🎨 Тема и шрифты применены');

  try { await loadSavedBackground(); }
  catch (e) { console.warn('[init] background failed:', e); }
  splashSetProgress(60, '🖼 Обои применены');

  try {
    const version = await versionPromise;
    const versionEl = document.getElementById('app-version');
    if (versionEl && version) versionEl.textContent = `v${version}`;
  } catch (e) {
    console.warn('[init] version failed:', e);
  }

  const titleEl = document.getElementById('app-title');
  if (titleEl) titleEl.textContent = 'Anton Vampire';

  try {
    state.tabsData = await tabsPromise;
    console.log('[init] tabsData loaded');
    if (state.tabsData && state.tabsData.ok === false) {
      toast('tabs.json не загружен: ' + (state.tabsData.error || 'неизвестная ошибка'), 'warning', 6000);
    }
  } catch (e) {
    console.warn('[init] tabsData failed:', e);
    state.tabsData = {};
  }

  bindMainUI();
  splashSetProgress(75, '⚙ Интерфейс подготовлен');

  const startSection = state.config.General?.initial_tab || 'main';
  const validStart = SECTIONS.some(s => s.id === startSection) ? startSection : 'main';

  if (state.preloadHeavy) {
    splashSetProgress(80, '⚡ Прогрев данных…');

    await preloadHeavyTabsData({
      criticalOnly: true,
      onProgress: (done, total, key) => {
        const pct = 80 + Math.round((done / Math.max(1, total)) * 15);
        splashSetProgress(pct, `⚡ ${done} / ${total} — ${key}`);
      }
    });

    splashSetProgress(95, '⚡ Данные прогреты');
  }

  splashSetProgress(100, '✨ Открытие…');

  if (showSplash) {
    splashHide();
  } else {
    document.body.classList.remove('app-loading');
    document.body.classList.add('app-ready');
  }

  try {
    state.activeSection = validStart;
    const renderer = RENDERERS[validStart] || renderOptimization;
    renderSidebar(validStart, navigate);
    bindSidebarButtons();
    await renderer();
    state.loadedTabs.add(validStart);
  } catch (e) {
    console.error('[init] start tab failed:', e);
  }

  if (state.preloadHeavy) {
    const nonCriticalPending = PRELOAD_JOBS.some(
      j => !j.critical && state.dataCache[j.key] === undefined
    );
    if (nonCriticalPending) {
      console.log('[preload] догружаем non-critical в фоне');
      preloadHeavyTabsData().catch(() => {});
    }
  }

  console.log('[init] complete. lazyTabs =', state.lazyTabs, ', showSplash =', showSplash);
}

function applySearch() {
  const q = state.search;

  const sectionTitles = document.querySelectorAll('.section-title');
  const sectionVisibility = new Map();

  for (const info of state.checkboxes.values()) {
    const name = (info.name || '').toLowerCase();
    const match = !q || name.includes(q);
    if (info.el) info.el.style.display = match ? '' : 'none';

    if (info.el) {
      const title = info.el.closest('.section')?.querySelector('.section-title');
      if (title) {
        const prev = sectionVisibility.get(title) || false;
        sectionVisibility.set(title, prev || match);
      }
    }
  }

  for (const title of sectionTitles) {
    const anyVisible = sectionVisibility.get(title) ?? true;
    title.style.display = (q && !anyVisible) ? 'none' : '';
  }
}

init().catch(err => {
  console.error('[init] FAILED', err);
  const c = document.getElementById('toast-container');
  if (c) {
    const el = document.createElement('div');
    el.className = 'toast error';
    el.textContent = 'Ошибка запуска: ' + err.message;
    c.appendChild(el);
  }
  splashHideImmediate();
});