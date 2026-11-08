import { state, registerCheckbox, updateCounter, toast, Sound } from '../app.js';
import { papirusUrl } from '../utils/icons.js';
import { loggedRunStream } from '../logger.js';

/**
 * Режимы отображения:
 *  - regular    → Hone
 *  - rectangle  → All Tweaker
 *  - wide       → BoosterX
 *  - expandable → BoosterX
 */
const MODE_MAP = {
  regular:      'hone',
  rectangle:    'all-tweaker',
  wide:         'boosterx',
  expandable:   'boosterx',
  hone:         'hone',
  'all-tweaker':'all-tweaker',
  boosterx:     'boosterx'
};

/* Флаг «показывать кнопки отмены» */
let _showCancel = true;
export function setShowCancelButton(v) { _showCancel = !!v; }

/* ============================================================
   ВЫДЕЛЕНИЕ ЧЕКБОКСОВ
   ============================================================ */
const SELECTION_KEY = 'General.checkbox_selection_enabled';
const MASS_ACTION_BTN_IDS = ['btn-select-all', 'btn-execute'];

/** Источник истины — state.config.General.checkbox_selection_enabled */
export function isSelectionEnabled() {
  return !!state?.config?.General?.checkbox_selection_enabled;
}

/** Программное включение/выключение. Применяется сразу к телу документа
 *  и к кнопкам массовых действий; для карточек — нужно пере-рендерить. */
export function setEnableSelection(v) {
  if (!state.config) state.config = {};
  if (!state.config.General) state.config.General = {};
  state.config.General.checkbox_selection_enabled = !!v;
  syncSelectionUIVisibility();
}

/** Синхронизирует:
 *  — класс body.cbx-selection-off (CSS прячет кнопки массовых действий);
 *  — display кнопок #btn-select-all / #btn-execute напрямую.
 */
function syncSelectionUIVisibility() {
  const enabled = isSelectionEnabled();

  document.body.classList.toggle('cbx-selection-off', !enabled);

  const apply = () => {
    for (const id of MASS_ACTION_BTN_IDS) {
      const el = document.getElementById(id);
      if (el) el.style.display = enabled ? '' : 'none';
    }
  };
  apply();
  // на случай, если кнопки рендерятся после грида
  requestAnimationFrame(apply);
  setTimeout(apply, 100);
}

/* Защита от зависших кнопок */
const BUTTON_GUARD_MS = 30 * 1000;

export function renderCheckboxGrid(container, options) {
  const { items, tabId, sectionId, mode = 'hone', columns = 3, showCancelButton } = options;

  if (typeof showCancelButton === 'boolean') setShowCancelButton(showCancelButton);

  // Синхронизируем видимость кнопок массовых действий
  syncSelectionUIVisibility();

  if (!items || !items.length) {
    container.innerHTML = '<p class="muted">Нет элементов</p>';
    return;
  }

  const resolved = MODE_MAP[mode] || 'hone';

  switch (resolved) {
    case 'all-tweaker': return renderAllTweaker(container, items, tabId, sectionId, columns);
    case 'boosterx':    return renderBoosterX(container, items, tabId, sectionId);
    case 'hone':
    default:            return renderHone(container, items, tabId, sectionId, columns);
  }
}

/* ===================== Кэш описаний ===================== */
const descriptionCache = new Map();
const DESCRIPTION_TTL_MS = 5 * 60 * 1000;
const DESCRIPTION_CLEANUP_INTERVAL_MS = 60 * 1000;

setInterval(() => {
  const now = Date.now();
  for (const [key, val] of descriptionCache) {
    if (now - val.ts >= DESCRIPTION_TTL_MS) descriptionCache.delete(key);
  }
}, DESCRIPTION_CLEANUP_INTERVAL_MS).unref?.();

export function clearDescriptionCache() {
  descriptionCache.clear();
}

/* ===================== Утилиты ===================== */
function iconForItem(item) {
  const t = (String(item.name || '') + ' ' + String(item.path || '')).toLowerCase();
  if (/nvidia|geforce/i.test(t))   return { type: 'vendor', name: 'nvidia' };
  if (/amd|radeon|ryzen/i.test(t)) return { type: 'vendor', name: 'amd' };
  if (/\bintel/i.test(t))          return { type: 'vendor', name: 'intel' };
  if (/directx/i.test(t))          return { type: 'vendor', name: 'directx' };
  if (/opengl/i.test(t))           return { type: 'vendor', name: 'opengl' };

  const ext = String(item.ext || '').toLowerCase();
  if (ext === 'bat' || ext === 'cmd') return { type: 'emoji', value: '⚙️' };
  if (ext === 'ps1')                  return { type: 'emoji', value: '🔷' };
  if (ext === 'reg')                  return { type: 'emoji', value: '📋' };
  if (ext === 'pow')                  return { type: 'emoji', value: '🔋' };
  if (ext === 'exe')                  return { type: 'emoji', value: '📦' };
  return { type: 'emoji', value: '📄' };
}

function iconHtml(item) {
  const info = iconForItem(item);
  if (info.type === 'vendor') {
    const url = papirusUrl('vendors', info.name);
    return `<img src="${url}" alt=""
      onerror="this.style.display='none';this.parentElement.textContent='📄'">`;
  }
  return info.value;
}

async function loadDescription(item) {
  const cached = descriptionCache.get(item.path);
  if (cached && Date.now() - cached.ts < DESCRIPTION_TTL_MS) {
    return cached.value;
  }
  try {
    if (!window.api?.tweaks?.describe) {
      descriptionCache.set(item.path, { value: null, ts: Date.now() });
      return null;
    }
    const desc = await window.api.tweaks.describe(item.path);
    descriptionCache.set(item.path, { value: desc || null, ts: Date.now() });
    return desc || null;
  } catch {
    descriptionCache.set(item.path, { value: null, ts: Date.now() });
    return null;
  }
}

/* ============================================================
   ЗАПУСК ОДНОГО ТВИКА
   ============================================================ */
async function runTweak(item, btn) {
  if (btn.disabled) return;
  btn.disabled = true;
  Sound.click();

  let done = false;
  const release = () => {
    if (done) return;
    done = true;
    btn.disabled = false;
  };

  const guard = setTimeout(release, 30000);

  try {
    await loggedRunStream(item.path, {
      onEnd: (r) => {
        clearTimeout(guard);
        release();
        if (r && r.code === 0) Sound.success();
        else {
          Sound.error();
          toast(`Ошибка запуска: ${item.name} (exit ${r?.code ?? '?'})`, 'error', 5000);
        }
      }
    });
  } catch (err) {
    clearTimeout(guard);
    release();
    Sound.error();
    toast('❌ ' + (err?.message || err), 'error', 6000);
  }
}

/* ============================================================
   ЗАПУСК ПАРНОГО ФАЙЛА ОТМЕНЫ
   ============================================================ */
async function runCancelTweak(item, btn) {
  if (!item.cancelPath) return;
  if (btn.disabled) return;
  btn.disabled = true;
  Sound.click();

  let done = false;
  const release = () => {
    if (done) return;
    done = true;
    btn.disabled = false;
  };

  const guard = setTimeout(() => {
    release();
    toast('↩ Отмена не ответила за 30 секунд — кнопка разблокирована', 'warning', 4000);
  }, 30000);

  try {
    await loggedRunStream(item.cancelPath, {
      onEnd: (r) => {
        clearTimeout(guard);
        release();
        if (r && r.code === 0) {
          Sound.success();
          toast(`↩ Отменено: ${item.cancelName || item.name}`, 'success', 2500);
        } else {
          Sound.error();
          toast(`Ошибка отмены: ${item.cancelName || item.name} (exit ${r?.code ?? '?'})`, 'error', 5000);
        }
      }
    });
  } catch (err) {
    clearTimeout(guard);
    release();
    Sound.error();
    toast('❌ ' + (err?.message || err), 'error', 6000);
  }
}

/* ============================================================
   КНОПКА «↩»
   ============================================================ */
function attachCancelButton(item, container, enabled = true) {
  if (!item.cancelPath || !enabled) return;
  const btn = document.createElement('button');
  btn.type = 'button';
  btn.className = 'cbx-cancel';
  btn.textContent = '↩';
  btn.title = 'Отмена: ' + (item.cancelName || '');
  btn.addEventListener('click', (e) => {
    e.stopPropagation();
    runCancelTweak(item, btn);
  });
  container.appendChild(btn);
}

function escapeHtml(s) {
  return String(s)
    .replace(/&/g, '&amp;').replace(/</g, '&lt;')
    .replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/'/g, '&#39;');
}

function attachCheckbox(card, input, varRef) {
  input.addEventListener('change', (e) => {
    varRef.checked = e.target.checked;
    card.classList.toggle('checked', varRef.checked);
    updateCounter();
  });
  card.addEventListener('click', (e) => {
    if (e.target === input) return;
    if (e.target.closest('button')) return;
    varRef.checked = !varRef.checked;
    input.checked = varRef.checked;
    card.classList.toggle('checked', varRef.checked);
    updateCounter();
  });
}

function registerCard(key, card, item, sectionId, tabId, varRef) {
  registerCheckbox(key, {
    var: varRef,
    path: item.path,
    name: item.name,
    el: card,
    section: sectionId,
    tab: tabId
  });
}

/** Выделение выключено:
 *  — квадратик-чекбокс скрыт ПОЛНОСТЬЮ (display: none);
 *  — карточка получает класс cbx-no-select для стилизации. */
function lockSelection(card, input) {
  input.disabled = true;
  input.style.display = 'none';
  card.classList.add('cbx-no-select');
}

/* ============================================================
   HONE
   ============================================================ */
function renderHone(container, items, tabId, sectionId, columns) {
  const grid = document.createElement('div');
  grid.className = 'cbx-hone-grid';
  grid.style.setProperty('--cols', columns);
  for (const item of items) grid.appendChild(makeHoneCard(item, tabId, sectionId));
  container.appendChild(grid);
  updateCounter();
}

function makeHoneCard(item, tabId, sectionId) {
  const key = `${sectionId}::${tabId}::${item.path}`;
  if (state.checkboxes.has(key)) return state.checkboxes.get(key).el;

  const card = document.createElement('div');
  card.className = 'cbx-hone';

  const varRef = { checked: false };
  const input = document.createElement('input');
  input.type = 'checkbox';
  input.className = 'cbx-hone-input';

  const icon = document.createElement('span');
  icon.className = 'cbx-hone-icon';
  icon.innerHTML = iconHtml(item);

  const title = document.createElement('span');
  title.className = 'cbx-hone-title';
  title.textContent = item.name;

  const head = document.createElement('div');
  head.className = 'cbx-hone-head';
  head.appendChild(input);
  head.appendChild(icon);
  head.appendChild(title);

  const desc = document.createElement('div');
  desc.className = 'cbx-hone-desc';
  desc.textContent = '…';

  const runBtn = document.createElement('button');
  runBtn.type = 'button';
  runBtn.className = 'cbx-hone-run';
  runBtn.textContent = '▶';
  runBtn.addEventListener('click', (e) => { e.stopPropagation(); runTweak(item, runBtn); });

  const actions = document.createElement('div');
  actions.className = 'cbx-hone-actions';
  actions.appendChild(runBtn);
  attachCancelButton(item, actions, _showCancel);

  card.appendChild(head);
  card.appendChild(desc);
  card.appendChild(actions);

  loadDescription(item).then(text => {
    desc.textContent = text || 'Без описания';
    if (!text) desc.classList.add('muted');
  });

  if (isSelectionEnabled()) {
    attachCheckbox(card, input, varRef);
  } else {
    lockSelection(card, input);
  }

  registerCard(key, card, item, sectionId, tabId, varRef);
  return card;
}

/* ============================================================
   ALL TWEAKER
   ============================================================ */
function renderAllTweaker(container, items, tabId, sectionId, columns) {
  const grid = document.createElement('div');
  grid.className = 'cbx-at-grid';
  grid.style.setProperty('--cols', columns);
  for (const item of items) grid.appendChild(makeAllTweakerCard(item, tabId, sectionId));
  container.appendChild(grid);
  updateCounter();
}

function makeAllTweakerCard(item, tabId, sectionId) {
  const key = `${sectionId}::${tabId}::${item.path}`;
  if (state.checkboxes.has(key)) return state.checkboxes.get(key).el;

  const card = document.createElement('div');
  card.className = 'cbx-at';

  const varRef = { checked: false };
  const input = document.createElement('input');
  input.type = 'checkbox';
  input.className = 'cbx-at-input';

  const label = document.createElement('span');
  label.className = 'cbx-at-label';
  label.textContent = item.name;

  const actions = document.createElement('div');
  actions.className = 'cbx-at-actions';
  attachCancelButton(item, actions, _showCancel);

  card.appendChild(input);
  card.appendChild(label);
  if (actions.children.length) card.appendChild(actions);

  let tooltip = null;
  card.addEventListener('mouseenter', async () => {
    if (!state.config.General?.tooltips_enabled) return;
    const desc = await loadDescription(item);
    if (!desc) return;
    tooltip = document.createElement('div');
    tooltip.className = 'hover-tooltip';
    tooltip.textContent = desc;
    document.body.appendChild(tooltip);
    const r = card.getBoundingClientRect();
    const tr = tooltip.getBoundingClientRect();
    let left = r.left;
    let top = r.top - tr.height - 8;
    if (top < 8) top = r.bottom + 8;
    if (left + tr.width > window.innerWidth - 8) left = window.innerWidth - tr.width - 8;
    tooltip.style.left = left + 'px';
    tooltip.style.top = top + 'px';
  });
  card.addEventListener('mouseleave', () => {
    if (tooltip) { tooltip.remove(); tooltip = null; }
  });

  if (isSelectionEnabled()) {
    attachCheckbox(card, input, varRef);
  } else {
    lockSelection(card, input);
  }

  registerCard(key, card, item, sectionId, tabId, varRef);
  return card;
}

/* ============================================================
   BOOSTERX
   ============================================================ */
function renderBoosterX(container, items, tabId, sectionId) {
  const list = document.createElement('div');
  list.className = 'checkbox-list-wide';
  for (const item of items) list.appendChild(makeBoosterXCard(item, tabId, sectionId));
  container.appendChild(list);
  updateCounter();
}

function makeBoosterXCard(item, tabId, sectionId) {
  const key = `${sectionId}::${tabId}::${item.path}`;
  if (state.checkboxes.has(key)) return state.checkboxes.get(key).el;

  const card = document.createElement('div');
  card.className = 'cbx wide';

  const varRef = { checked: false };

  const input = document.createElement('input');
  input.type = 'checkbox';

  const label = document.createElement('div');
  label.className = 'label';
  label.innerHTML = `${escapeHtml(item.name)} <span class="ext">.${item.ext}</span>`;

  const launchBtn = document.createElement('button');
  launchBtn.type = 'button';
  launchBtn.className = 'launch';
  launchBtn.textContent = '▶';
  launchBtn.title = 'Запустить только этот твик';
  launchBtn.addEventListener('click', (e) => {
    e.preventDefault();
    e.stopPropagation();
    runTweak(item, launchBtn);
  });

  const row = document.createElement('div');
  row.className = 'row';

  row.appendChild(input);
  row.appendChild(label);
  row.appendChild(launchBtn);
  attachCancelButton(item, row, _showCancel);

  const expBtn = document.createElement('button');
  expBtn.type = 'button';
  expBtn.className = 'expand';
  expBtn.textContent = '➕';
  expBtn.title = 'Показать описание';
  expBtn.addEventListener('click', async (e) => {
    e.preventDefault();
    e.stopPropagation();
    const expanded = card.classList.toggle('expanded');
    expBtn.textContent = expanded ? '➖' : '➕';
    expBtn.title = expanded ? 'Скрыть описание' : 'Показать описание';
    if (expanded) {
      const descEl = card.querySelector('.desc');
      if (descEl && descEl.dataset.loaded !== '1') {
        descEl.textContent = '…';
        descEl.dataset.loaded = '1';
        const desc = await loadDescription(item);
        if (desc) {
          descEl.textContent = desc;
        } else {
          descEl.textContent = item.name;
          descEl.classList.add('muted-desc');
        }
      }
    }
  });
  row.appendChild(expBtn);

  card.appendChild(row);

  const desc = document.createElement('div');
  desc.className = 'desc';
  card.appendChild(desc);

  if (isSelectionEnabled()) {
    attachCheckbox(card, input, varRef);
  } else {
    lockSelection(card, input);
  }

  registerCard(key, card, item, sectionId, tabId, varRef);
  return card;
}