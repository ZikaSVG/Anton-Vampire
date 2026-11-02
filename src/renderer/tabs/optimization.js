import { state, clearCheckboxes, toast, Sound } from '../app.js';
import { renderCheckboxGrid } from '../components/checkbox.js';
import { papirusUrl } from '../utils/icons.js';
import { loggedRunStream } from '../logger.js';

/* ============================================================
   ИСТОЧНИКИ ОПТИМИЗАЦИИ
   ============================================================ */
const SOURCES = [
  { id: 'standard', label: '📦 Стандартные', desc: 'Встроенные твики оптимизации', kind: 'standard' },
  { id: 'xos',      label: '🟢 XOS-Tweaks',      kind: 'extra', json: 'tweaks/x_os_tabs.json',      baseDir: 'tweaks/Оптимизация/XOS-Tweaks' },
  { id: 'immortal', label: '💀 ImmortalOS-Tweaks', kind: 'extra', json: 'tweaks/immortal_os_tabs.json', baseDir: 'tweaks/Оптимизация/ImmortalOS-Tweaks' },
  { id: 'marty',    label: '🎯 MartyFiles-Tweaks', kind: 'extra', json: 'tweaks/marty_files_tabs.json', baseDir: 'tweaks/Оптимизация/MartyFiles' },
  { id: 'synergy',  label: '🔷 SynergyOS-Tweaks',  kind: 'extra', json: 'tweaks/synergy_os_tabs.json',  baseDir: 'tweaks/Оптимизация/SynergyOS-Tweaks' },
  { id: 'systemx',  label: '🟣 SystemX-Tweaks',    kind: 'extra', json: 'tweaks/system_x_tabs.json',    baseDir: 'tweaks/Оптимизация/SystemX' },
  { id: 'atlas',    label: '🔴 AtlasOS-Tweaks',    kind: 'extra', json: 'tweaks/atlas_os_tabs.json',    baseDir: 'tweaks/Оптимизация/AtlasOS' },
  { id: 'rapid',    label: '🔴 RapidOS-Tweaks',    kind: 'extra', json: 'tweaks/rapid_os_tabs.json',    baseDir: 'tweaks/Оптимизация/RapidOS' },
  { id: 'revi',     label: '🔴 ReviOS-Tweaks',     kind: 'extra', json: 'tweaks/revi_os_tabs.json',     baseDir: 'tweaks/Оптимизация/ReviOS' },
  { id: 'vain',     label: '👑 VainOS-Tweaks',     kind: 'extra', json: 'tweaks/vain_os_tabs.json',     baseDir: 'tweaks/Оптимизация/VainOS-Tweaks' }
];

/* ─── Vendor-секции: NVIDIA / AMD / Intel / DirectX / OpenGL ─── */
const VENDOR_SECTIONS = [
  { id: 'nvidia',  label: 'NVIDIA',  color: '#76b900', icon: 'nvidia'  },
  { id: 'amd',     label: 'AMD',     color: '#ed1c24', icon: 'amd'     },
  { id: 'intel',   label: 'Intel',   color: '#0071c5', icon: 'intel'   },
  { id: 'directx', label: 'DirectX', color: '#4a9eff', icon: 'directx' },
  { id: 'opengl',  label: 'OpenGL',  color: '#ffbd05', icon: 'opengl'  }
];

/* ─── Категории твиков оптимизации (под-вкладки в разделе «Твики оптимизации») ─── */
const TWEAK_CATEGORIES = [
  'memory', 'sound', 'keyboard', 'mouse', 'hyperv', 'tweaks', 'network'
];

/* ─── Дропдауны ─── */
const DROPDOWN_META = [
  { id: 'svchost',  label: 'Порог разделения svchost',
    desc: 'Количество ядер, после которого Windows разделяет svchost.exe' },
  { id: 'win32',    label: 'Разделение приоритетов Win32',
    desc: 'Баланс между foreground и background процессами' },
  { id: 'services', label: 'Службы',
    desc: 'Готовые наборы отключения служб' }
];

const TWEAK_RE = /\.(bat|cmd|exe|ps1|reg|pow)$/i;
const CANCEL_KEYS = ['отмена', 'Отмена', 'ОТМЕНА', 'cancel', 'Cancel',
                     'Возврат', 'возврат', 'ВОЗВРАТ'];

const optimState = {
  sourceId: 'standard',
  vendor: {},
  dropdowns: {},
  extraTree: {},
  driversData: null
};

function basename(p) { return String(p).split(/[\\/]/).pop(); }
function stripExt(p)  { return basename(p).replace(/\.[^.]+$/, ''); }

/* ============================================================
   Пары «твик ↔ отмена»
   ============================================================ */
const ACTION_VERBS = [
  'включить', 'включать', 'включи',
  'отключить', 'отключать', 'отключи', 'выключить', 'выключать', 'выключи',
  'вернуть', 'возвращать', 'верни',
  'восстановить', 'восстанавливать', 'восстанови',
  'включить обратно', 'вернуть обратно', 'восстановить обратно',
  'отменить', 'отмена',
  'показать', 'показывать', 'покажи',
  'скрыть', 'скрывать', 'скрой',
  'убрать', 'убирать', 'убери',
  'добавить', 'добавлять', 'добавь',
  'разблокировать', 'разблокируй',
  'заблокировать', 'блокировать', 'блокируй',
  'удалить', 'удалять', 'удали', 'отменить удаление',
  'настроить', 'настраивать', 'настрой',
  'применить', 'применять', 'примени',
  'сбросить', 'сбрасывать', 'сбрось',
  'откатить', 'откатывать', 'откати',
  'изменить', 'изменять', 'измени',
  'запустить', 'запускать', 'запусти',
  'остановить', 'останавливать', 'останови',
  'включить службу', 'запустить службу',
  'отключить службу', 'остановить службу',
  'разрешить', 'разрешать', 'разреши',
  'запретить', 'запрещать', 'запрети',
  'ограничить', 'ограничивать', 'ограничь',
  'снять ограничение', 'снять ограничения',
  'усилить', 'усиливать', 'усиль',
  'ослабить', 'ослаблять', 'ослабь',
  'включи заново', 'переключить', 'переключи',
  'выбрать', 'выбирать', 'выбери',
  'установить', 'устанавливать', 'установи',
  'переустановить', 'переустанавливать',
  'заменить', 'заменять', 'замени',
];
const ACTION_VERBS_SORTED = [...ACTION_VERBS].sort((a, b) => b.length - a.length);

function normalizeWhitespace(s) {
  return String(s)
    .replace(/[\u00A0\u2007\u202F\u2009\u200A\uFEFF]/g, ' ')
    .replace(/[\t\r\n]+/g, ' ')
    .replace(/\s+/g, ' ')
    .trim();
}

function coreName(fileName) {
  let s = String(fileName);
  s = s.replace(/^[\uFEFF\u00A0]+/, '');
  s = s.replace(/\.(bat|cmd|ps1|reg|exe|pow)$/i, '');
  s = s.replace(/^\s*отмена\s*[\\\/]\s*/i, '');
  s = normalizeWhitespace(s);

  let changed = true;
  while (changed) {
    changed = false;
    for (const verb of ACTION_VERBS_SORTED) {
      const v = normalizeWhitespace(verb).toLowerCase();
      if (s.toLowerCase().startsWith(v + ' ')) {
        s = s.slice(v.length).trim();
        changed = true;
        break;
      }
    }
  }
  return normalizeWhitespace(s).toLowerCase().replace(/\.\s*$/, '');
}

function buildPairMap(rootFiles, cancelFiles) {
  const cancels = new Map();
  for (const f of cancelFiles || []) {
    const base = String(f).replace(/\\/g, '/').split('/').pop();
    const core = coreName(base);
    if (!core) continue;
    if (!cancels.has(core)) cancels.set(core, base);
  }
  const valid = new Set();
  for (const f of rootFiles || []) {
    const base = String(f).replace(/\\/g, '/').split('/').pop();
    const core = coreName(base);
    if (core) valid.add(core);
  }
  const filtered = new Map();
  for (const [core, file] of cancels) {
    if (valid.has(core)) filtered.set(core, file);
  }
  return filtered;
}

/* ============================================================
   Загрузка drivers_tabs.json
   ============================================================ */
async function loadDriversData() {
  if (optimState.driversData) return optimState.driversData;
  try {
    const res = await window.api.tabs.readJson('tweaks/drivers_tabs.json');
    if (res && res.ok && res.data) {
      optimState.driversData = res.data;
      return res.data;
    }
    console.warn('[optimization] drivers_tabs.json:', res?.error);
  } catch (e) {
    console.warn('[optimization] loadDriversData:', e);
  }
  return {};
}

/* ============================================================
   ГЛАВНЫЙ РЕНДЕР
   ============================================================ */
export async function renderOptimization() {
  const tabsNav = document.getElementById('tabs-nav');
  const content = document.getElementById('tab-content');
  tabsNav.innerHTML = ''; content.innerHTML = '';
  clearCheckboxes();

  optimState.vendor = {};
  optimState.dropdowns = {};
  if (!optimState.sourceId) optimState.sourceId = 'standard';

  const data = state.tabsData || {};
  const tabs = data.tabs || {};

  const wrap = document.createElement('div');
  wrap.className = 'opt-root';
  content.appendChild(wrap);

  const srcNav = document.createElement('div');
  srcNav.className = 'opt-src-nav';
  wrap.appendChild(srcNav);

  const srcBody = document.createElement('div');
  srcBody.className = 'opt-src-body';
  wrap.appendChild(srcBody);

  for (const s of SOURCES) {
    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'opt-src-btn' + (s.id === optimState.sourceId ? ' active' : '');
    btn.dataset.src = s.id;
    btn.innerHTML = `<span class="opt-src-lbl">${s.label}</span>`;
    btn.title = s.desc || '';
    btn.addEventListener('click', async () => {
      if (optimState.sourceId === s.id) return;
      Sound.click();
      optimState.sourceId = s.id;
      srcNav.querySelectorAll('.opt-src-btn').forEach(
        b => b.classList.toggle('active', b.dataset.src === s.id)
      );
      srcBody.innerHTML = '';
      clearCheckboxes();
      await renderSource(s.id, srcBody, { tabs });
    });
    srcNav.appendChild(btn);
  }

  await renderSource(optimState.sourceId, srcBody, { tabs });
}

async function renderSource(sourceId, host, ctx) {
  host.innerHTML = '';

  if (sourceId === 'standard') {
    const driversData = await loadDriversData();
    renderStandardSource(host, { ...ctx, driversData });
    return;
  }

  const src = SOURCES.find(s => s.id === sourceId);
  if (!src) {
    host.innerHTML = `<p class="muted" style="padding:20px">Неизвестный источник: ${escapeHtml(sourceId)}</p>`;
    return;
  }

  let tree = optimState.extraTree[sourceId];
  if (!tree) {
    host.innerHTML = `<p class="muted" style="padding:20px">Загрузка ${escapeHtml(src.label)}…</p>`;
    try { tree = await loadExtraTree(src); }
    catch (e) {
      host.innerHTML = `<div class="apps-empty" style="padding:20px">Ошибка загрузки: ${escapeHtml(e.message)}</div>`;
      return;
    }
    if (!tree) {
      host.innerHTML = `<div class="apps-empty" style="padding:20px">Не удалось построить список твиков для ${escapeHtml(src.label)}</div>`;
      return;
    }
    optimState.extraTree[sourceId] = tree;
  }

  host.innerHTML = '';
  renderExtraSource(host, src, tree);
}

async function loadExtraTree(src) {
  if (src.json) {
    try {
      const res = await window.api.tabs.readJson(src.json);
      if (res && res.ok && res.data && res.data.tabs) {
        const categories = {};
        const cancels = {};

        for (const [cat, payload] of Object.entries(res.data.tabs)) {
          if (!payload || typeof payload !== 'object') continue;

          if (Array.isArray(payload.Root)) {
            const filtered = payload.Root.filter(f => TWEAK_RE.test(f));
            if (filtered.length) categories[cat] = filtered;

            for (const ck of CANCEL_KEYS) {
              if (Array.isArray(payload[ck]) && payload[ck].length) {
                cancels[cat] = { key: ck, files: payload[ck].filter(f => TWEAK_RE.test(f)) };
                break;
              }
            }
          } else if (Array.isArray(payload)) {
            const filtered = payload.filter(f => TWEAK_RE.test(f));
            if (filtered.length) categories[cat] = filtered;
          }
        }
        if (Object.keys(categories).length) return { categories, cancels };
      }
    } catch { /* ignore */ }
  }

  try {
    const res = await window.api.tabs.scanDir(src.baseDir);
    if (res && res.ok && res.data) {
      return { categories: res.data, cancels: {} };
    }
  } catch { /* ignore */ }

  return null;
}

/* ============================================================
   СТАНДАРТНЫЕ
   ============================================================ */
function renderStandardSource(host, { tabs, driversData }) {
  const hasDrivers = driversData && Object.keys(driversData).length > 0;
  const hasTabs    = tabs && Object.keys(tabs).length > 0;

  if (!hasDrivers && !hasTabs) {
    const msg = document.createElement('p');
    msg.className = 'muted';
    msg.style.padding = '20px';
    msg.textContent = 'Нет данных. Запустите build_drivers_json.py, чтобы создать tweaks/drivers_tabs.json.';
    host.appendChild(msg);
    return;
  }

  /* ─── Toolbar ─── */
  const toolbar = document.createElement('div');
  toolbar.className = 'vendor-toolbar';
  toolbar.innerHTML = `
    <button class="btn" id="btn-vendor-select-all">Выбрать все твики</button>
    <button class="btn warning" id="btn-vendor-deselect-all">Снять все</button>
    <span class="muted" id="vendor-counter"></span>
  `;
  host.appendChild(toolbar);

  if (hasDrivers) {
    /* ─── 1. Vendor-панель: NVIDIA / AMD / Intel / DirectX / OpenGL ─── */
    const vendorPanel = document.createElement('div');
    vendorPanel.className = 'vendor-panel';
    host.appendChild(vendorPanel);

    for (const sec of VENDOR_SECTIONS) {
      const sectionData = driversData?.[sec.id];
      if (!sectionData) continue;
      renderDriverSection(vendorPanel, sec.id, sec.label, sec.color, sec.icon, sectionData);
    }

    /* ─── 2. Дропдауны: svchost / win32 / services ─── */
    const dropdownsWrap = document.createElement('div');
    dropdownsWrap.className = 'vendor-dropdowns';
    host.appendChild(dropdownsWrap);

    for (const d of DROPDOWN_META) {
      const sectionData = driversData?.[d.id];
      if (!sectionData) continue;
      renderDropdown(dropdownsWrap, d, sectionData);
    }

    /* ─── 3. Категории твиков оптимизации (вместо tabs.json) ─── */
    renderTweaksCategories(host, driversData);
  } else {
    /* ─── Fallback: old tabs.json ─── */
    renderOptimTabs(host, tabs);
  }

  /* ─── Кнопки select/deselect all ─── */
  host.querySelector('#btn-vendor-select-all')?.addEventListener('click', () => {
    Sound.click();
    for (const s of Object.values(optimState.vendor)) {
      s.vars.forEach(v => { v.checked = true; });
    }
    host.querySelectorAll('.vendor-row').forEach(r => r.classList.add('checked'));
    host.querySelectorAll('.vendor-section input[data-role="sa"]').forEach(sa => { sa.checked = true; });

    for (const info of state.checkboxes.values()) {
      if (info.section !== 'optimization') continue;
      info.var.checked = true;
      info.el?.classList.add('checked');
      const inp = info.el?.querySelector('input');
      if (inp) inp.checked = true;
    }
    updateCounter(host);
  });

  host.querySelector('#btn-vendor-deselect-all')?.addEventListener('click', () => {
    Sound.click();
    for (const s of Object.values(optimState.vendor)) {
      s.vars.forEach(v => { v.checked = false; });
    }
    host.querySelectorAll('.vendor-row').forEach(r => r.classList.remove('checked'));
    host.querySelectorAll('.vendor-section input[data-role="sa"]').forEach(sa => { sa.checked = false; });

    for (const info of state.checkboxes.values()) {
      if (info.section !== 'optimization') continue;
      info.var.checked = false;
      info.el?.classList.remove('checked');
      const inp = info.el?.querySelector('input');
      if (inp) inp.checked = false;
    }
    updateCounter(host);
  });

  updateCounter(host);

  function updateCounter(root) {
    let vTotal = 0, vSel = 0;
    for (const s of Object.values(optimState.vendor)) {
      vTotal += s.vars.length;
      vSel   += s.vars.filter(v => v.checked).length;
    }
    let sTotal = 0, sSel = 0;
    for (const info of state.checkboxes.values()) {
      if (info.section !== 'optimization') continue;
      sTotal++;
      if (info.var.checked) sSel++;
    }
    const total = vTotal + sTotal;
    const sel = vSel + sSel;
    const el = root.querySelector('#vendor-counter');
    if (el) {
      el.textContent = `Выбрано: ${sel} / ${total}` +
        (vTotal ? `  (драйверы: ${vSel}/${vTotal}, твики: ${sSel}/${sTotal})` : '');
    }
  }
}

/* ============================================================
   Vendor-секция (NVIDIA / AMD / …) — рекурсивно
   ============================================================ */
function renderDriverSection(parent, secId, label, color, icon, sectionData) {
  const section = document.createElement('div');
  section.className = 'vendor-section';
  section.style.setProperty('--vendor-color', color);

  const head = document.createElement('div');
  head.className = 'vendor-head';

  const iconHtml = icon
    ? `<img class="vendor-head-icon" src="${papirusUrl('vendors', icon)}" alt=""
            onerror="this.style.display='none'">`
    : '';

  const total = countAllFiles(sectionData);

  head.innerHTML = `
    <label class="vendor-select-all">
      <input type="checkbox" data-role="sa">
      ${iconHtml}
      <span>${escapeHtml(label)}</span>
    </label>
    <span class="vendor-count">${total}</span>
  `;
  section.appendChild(head);

  const list = document.createElement('div');
  list.className = 'vendor-list';

  const vars = [];
  renderDriverLevel(list, sectionData, vars);

  if (!total) {
    const empty = document.createElement('div');
    empty.className = 'vendor-empty';
    empty.textContent = 'Нет файлов';
    list.appendChild(empty);
  }

  const selectAll = head.querySelector('input[data-role="sa"]');
  selectAll.addEventListener('change', () => {
    const on = selectAll.checked;
    for (const v of vars) v.checked = on;
    list.querySelectorAll('.vendor-row').forEach(r => r.classList.toggle('checked', on));
    const cnt = document.querySelector('#vendor-counter');
    // updateCounter живёт в renderStandardSource, дергаем через событие
    document.dispatchEvent(new CustomEvent('optim:update'));
  });

  section.appendChild(list);
  parent.appendChild(section);
  optimState.vendor[secId] = { vars };
}

function countAllFiles(node) {
  let n = (node.files || []).length;
  for (const sub of Object.values(node.subfolders || {})) n += countAllFiles(sub);
  return n;
}

function renderDriverLevel(container, node, vars) {
  const files     = node.files || [];
  const cancels   = node.cancels || [];
  const cancelDir = node.cancelDir;
  const baseDir   = node.baseDir;
  const pairMap   = buildPairMap(files, cancels);

  for (const file of files) {
    const core       = coreName(file);
    const cancelFile = pairMap.get(core) || null;
    const cancelPath = cancelFile && cancelDir
      ? `${baseDir}/${cancelDir}/${cancelFile}`
      : null;

    container.appendChild(makeDriverRow(
      file,
      `${baseDir}/${file}`,
      { path: cancelPath, name: cancelFile ? stripExt(cancelFile) : null },
      vars
    ));
  }

  for (const [subName, sub] of Object.entries(node.subfolders || {})) {
    const subHead = document.createElement('div');
    subHead.className = 'vendor-subfolder-head';
    subHead.textContent = `${subName} · ${countAllFiles(sub)}`;
    container.appendChild(subHead);
    renderDriverLevel(container, sub, vars);
  }
}

function makeDriverRow(file, relPath, cancel, vars) {
  const row = document.createElement('div');
  row.className = 'vendor-row';

  const cb = document.createElement('input');
  cb.type = 'checkbox';

  const name = document.createElement('span');
  name.className = 'vendor-name';
  name.textContent = stripExt(file);
  name.title = relPath;

  const run = document.createElement('button');
  run.type = 'button';
  run.className = 'vendor-run';
  run.textContent = '▶';
  run.title = 'Запустить только этот файл';
  run.addEventListener('click', async (e) => {
    e.preventDefault(); e.stopPropagation();
    if (run.disabled) return;
    run.disabled = true;
    Sound.click();
    try {
      await loggedRunStream(relPath, {
        onEnd: (r) => {
          run.disabled = false;
          if (r && r.code === 0) Sound.success();
          else {
            Sound.error();
            toast(`Ошибка запуска: ${file} (exit ${r?.code ?? '?'})`, 'error', 5000);
          }
        }
      });
    } catch (err) {
      run.disabled = false;
      Sound.error();
      toast('❌ ' + (err?.message || err), 'error', 6000);
    }
  });

  cb.addEventListener('change', () => {
    row.classList.toggle('checked', cb.checked);
    document.dispatchEvent(new CustomEvent('optim:update'));
  });

  row.addEventListener('click', (e) => {
    if (e.target === cb || e.target.closest('button')) return;
    cb.checked = !cb.checked;
    row.classList.toggle('checked', cb.checked);
    document.dispatchEvent(new CustomEvent('optim:update'));
  });

  row.append(cb, name);

  if (cancel && cancel.path && state.config.General?.show_cancel_buttons !== false) {
    const cancelBtn = document.createElement('button');
    cancelBtn.type = 'button';
    cancelBtn.className = 'vendor-cancel';
    cancelBtn.textContent = '↩';
    cancelBtn.title = 'Отмена: ' + (cancel.name || '');
    cancelBtn.addEventListener('click', async (e) => {
      e.preventDefault(); e.stopPropagation();
      if (cancelBtn.disabled) return;
      cancelBtn.disabled = true;
      Sound.click();
      try {
        await loggedRunStream(cancel.path, {
          onEnd: (r) => {
            cancelBtn.disabled = false;
            if (r && r.code === 0) {
              Sound.success();
              toast(`↩ Отменено: ${cancel.name}`, 'success', 2500);
            } else {
              Sound.error();
              toast(`Ошибка отмены: ${cancel.name} (exit ${r?.code ?? '?'})`, 'error', 5000);
            }
          }
        });
      } catch (err) {
        cancelBtn.disabled = false;
        Sound.error();
        toast('❌ ' + (err?.message || err), 'error', 6000);
      }
    });
    row.appendChild(cancelBtn);
  }

  row.appendChild(run);
  vars.push(cb);
  return row;
}

/* ============================================================
   Дропдаун
   ============================================================ */
function renderDropdown(container, meta, sectionData) {
  const files = (sectionData.files || [])
    .filter(f => TWEAK_RE.test(f))
    .sort((a, b) => a.localeCompare(b, 'ru'));

  const wrap = document.createElement('div');
  wrap.className = 'vendor-dropdown';

  const title = document.createElement('div');
  title.className = 'vendor-dropdown-title';
  title.textContent = meta.label;

  const desc = document.createElement('div');
  desc.className = 'vendor-dropdown-desc';
  desc.textContent = meta.desc;

  const sel = document.createElement('select');
  sel.innerHTML = `<option value="">— выберите файл —</option>` +
    files.map(f => `<option value="${f}">${f}</option>`).join('');
  sel.addEventListener('change', () => {
    optimState.dropdowns[meta.id] = sel.value || null;
  });

  wrap.append(title, desc, sel);
  container.appendChild(wrap);
  optimState.dropdowns[meta.id] = null;
  optimState.dropdowns[meta.id + '_baseDir'] = sectionData.baseDir || '';
}

/* ============================================================
   Твики оптимизации — под-вкладки из папок Драйверов
   ============================================================ */
function renderTweaksCategories(host, driversData) {
  const optimSection = document.createElement('div');
  optimSection.className = 'section';
  host.appendChild(optimSection);

  const optimTitle = document.createElement('div');
  optimTitle.className = 'section-title';
  optimTitle.textContent = 'Твики оптимизации';
  optimSection.appendChild(optimTitle);

  const subNav = document.createElement('div');
  subNav.className = 'sub-tabs-nav';
  optimSection.appendChild(subNav);

  const catsHost = document.createElement('div');
  optimSection.appendChild(catsHost);

  const catContainers = {};
  let firstRendered = false;

  for (const secId of TWEAK_CATEGORIES) {
    const sectionData = driversData?.[secId];
    if (!sectionData) continue;

    const label = sectionData.label || secId;

    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'sub-tab-btn' + (!firstRendered ? ' active' : '');
    btn.textContent = label;
    btn.addEventListener('click', () => {
      Sound.click();
      subNav.querySelectorAll('.sub-tab-btn').forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      for (const c of Object.values(catContainers)) c.style.display = 'none';
      if (catContainers[secId]) catContainers[secId].style.display = '';
    });
    subNav.appendChild(btn);

    const catContainer = document.createElement('div');
    catContainer.className = 'sub-tab-content';
    catContainer.style.display = (!firstRendered ? '' : 'none');
    catsHost.appendChild(catContainer);
    catContainers[secId] = catContainer;
    firstRendered = true;

    renderCategoryContent(catContainer, sectionData, secId, '');
  }

  if (!firstRendered) {
    const empty = document.createElement('p');
    empty.className = 'muted';
    empty.textContent = 'Категорий не найдено.';
    optimSection.appendChild(empty);
  }
}

/* Рекурсивный рендер содержимого категории (файлы + подпапки) */
function renderCategoryContent(container, node, secId, pathSuffix) {
  const files     = node.files || [];
  const cancels   = node.cancels || [];
  const baseDir   = node.baseDir;
  const cancelDir = node.cancelDir;
  const pairMap   = buildPairMap(files, cancels);

  if (files.length > 0) {
    const items = files.map(f => {
      const core       = coreName(f);
      const cancelFile = pairMap.get(core) || null;
      return {
        name: stripExt(f),
        path: `${baseDir}/${f}`,
        ext: f.includes('.') ? f.split('.').pop() : '',
        cancelPath: cancelFile && cancelDir
          ? `${baseDir}/${cancelDir}/${cancelFile}`
          : null,
        cancelName: cancelFile ? stripExt(cancelFile) : null
      };
    });

    const gridWrap = document.createElement('div');
    container.appendChild(gridWrap);

    renderCheckboxGrid(gridWrap, {
      items,
      tabId: `tweaks:${secId}:${pathSuffix || 'root'}`,
      sectionId: 'optimization',
      mode: state.config.General?.checkbox_display_mode || 'rectangle',
      columns: parseInt(state.config.Columns?.default || '3', 10) || 3,
      showCancelButton: state.config.General?.show_cancel_buttons !== false
    });
  }

  for (const [subName, sub] of Object.entries(node.subfolders || {})) {
    const subHead = document.createElement('div');
    subHead.className = 'section-title';
    subHead.style.marginTop = '16px';
    subHead.style.fontSize = '12px';
    subHead.textContent = `${subName} · ${countAllFiles(sub)}`;
    container.appendChild(subHead);

    renderCategoryContent(container, sub, secId, `${pathSuffix || 'root'}:${subName}`);
  }
}

/* ============================================================
   FALLBACK: рендер из tabs.json (если drivers_tabs.json нет)
   ============================================================ */
function renderOptimTabs(host, tabs) {
  const optimSection = document.createElement('div');
  optimSection.className = 'section';
  host.appendChild(optimSection);

  const t = document.createElement('div');
  t.className = 'section-title';
  t.textContent = 'Твики оптимизации (tabs.json)';
  optimSection.appendChild(t);

  const knownCats = Object.keys(tabs);
  if (!knownCats.length) {
    const empty = document.createElement('p');
    empty.className = 'muted';
    empty.textContent = 'tabs.json не содержит секции "tabs".';
    optimSection.appendChild(empty);
    return;
  }

  const subNav = document.createElement('div');
  subNav.className = 'sub-tabs-nav';
  optimSection.appendChild(subNav);

  const catsHost = document.createElement('div');
  optimSection.appendChild(catsHost);

  const catContainers = {};

  for (let i = 0; i < knownCats.length; i++) {
    const cat = knownCats[i];

    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'sub-tab-btn' + (i === 0 ? ' active' : '');
    btn.textContent = cat;
    btn.addEventListener('click', () => {
      Sound.click();
      subNav.querySelectorAll('.sub-tab-btn').forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      for (const c of Object.values(catContainers)) c.style.display = 'none';
      if (catContainers[cat]) catContainers[cat].style.display = '';
    });
    subNav.appendChild(btn);

    const catContainer = document.createElement('div');
    catContainer.className = 'sub-tab-content';
    catContainer.style.display = (i === 0 ? '' : 'none');
    catsHost.appendChild(catContainer);
    catContainers[cat] = catContainer;

    const files = (tabs[cat] || []).filter(f => TWEAK_RE.test(f));
    const items = files.map(rel => {
      const relStr = String(rel).replace(/\\/g, '/');
      const seg = relStr.split('/');
      const base = seg[seg.length - 1];
      return {
        name: base.replace(/\.[^.]+$/, ''),
        path: `tweaks/Оптимизация/${cat}/${relStr}`,
        ext: base.includes('.') ? base.split('.').pop() : '',
        category: seg.length > 1 ? seg.slice(0, -1).join('/') : null
      };
    });

    renderCheckboxGrid(catContainer, {
      items,
      tabId: cat,
      sectionId: 'optimization',
      mode: state.config.General?.checkbox_display_mode || 'rectangle',
      columns: parseInt(state.config.Columns?.default || '3', 10) || 3,
      showCancelButton: state.config.General?.show_cancel_buttons !== false
    });
  }
}

/* ============================================================
   EXTRA (XOS / ImmortalOS / MartyFiles / SynergyOS / SystemX / VainOS)
   ============================================================ */
function renderExtraSource(host, src, tree) {
  const categoriesObj = tree.categories || {};
  const cancelsObj    = tree.cancels    || {};
  const categories    = Object.keys(categoriesObj);

  const header = document.createElement('div');
  header.className = 'opt-extra-header';
  header.innerHTML = `
    <div class="opt-extra-title">${escapeHtml(src.label)}</div>
    <div class="opt-extra-desc">${escapeHtml(src.desc || '')}</div>
  `;
  host.appendChild(header);

  if (!categories.length) {
    host.innerHTML += `<div class="apps-empty">Категорий не найдено</div>`;
    return;
  }

  const subNav = document.createElement('div');
  subNav.className = 'sub-tabs-nav';
  host.appendChild(subNav);

  const catsHost = document.createElement('div');
  host.appendChild(catsHost);

  const catContainers = {};

  for (let i = 0; i < categories.length; i++) {
    const cat = categories[i];

    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'sub-tab-btn' + (i === 0 ? ' active' : '');
    btn.textContent = cat;
    btn.addEventListener('click', () => {
      Sound.click();
      subNav.querySelectorAll('.sub-tab-btn').forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      for (const c of Object.values(catContainers)) c.style.display = 'none';
      if (catContainers[cat]) catContainers[cat].style.display = '';
    });
    subNav.appendChild(btn);

    const catContainer = document.createElement('div');
    catContainer.className = 'sub-tab-content';
    catContainer.style.display = (i === 0 ? '' : 'none');
    catsHost.appendChild(catContainer);
    catContainers[cat] = catContainer;

    const files = categoriesObj[cat] || [];
    const cancelEntry = cancelsObj[cat];
    const cancelFiles = cancelEntry ? cancelEntry.files : [];
    const cancelDirName = cancelEntry ? cancelEntry.key : 'отмена';

    const pairMap = buildPairMap(files, cancelFiles);

    const items = files.map(f => {
      const baseName = String(f).replace(/\\/g, '/').split('/').pop();
      const ext = baseName.includes('.') ? baseName.split('.').pop() : '';
      const core = coreName(baseName);
      const cancelFile = pairMap.get(core) || null;

      return {
        name: baseName.replace(/\.[^.]+$/, ''),
        path: `${src.baseDir}/${cat}/${f}`,
        ext,
        category: cat,
        cancelPath: cancelFile
          ? `${src.baseDir}/${cat}/${cancelDirName}/${cancelFile}`
          : null,
        cancelName: cancelFile ? cancelFile.replace(/\.[^.]+$/, '') : null
      };
    });

    renderCheckboxGrid(catContainer, {
      items,
      tabId: `${src.id}:${cat}`,
      sectionId: 'optimization',
      mode: state.config.General?.checkbox_display_mode || 'rectangle',
      columns: parseInt(state.config.Columns?.default || '3', 10) || 3,
      showCancelButton: state.config.General?.show_cancel_buttons !== false
    });
  }
}

function escapeHtml(s) {
  return String(s)
    .replace(/&/g, '&amp;').replace(/</g, '&lt;')
    .replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/'/g, '&#39;');
}