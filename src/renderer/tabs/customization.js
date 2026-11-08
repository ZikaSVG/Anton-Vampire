import { toast, Sound, state } from '../app.js';
import { renderCheckboxGrid } from '../components/checkbox.js';
import { loadSourceData, buildPairMap, coreName } from './sources.js';

/* ============================================================
   Вкладка «Кастомизация» — курсоры + твики от сборок
   ============================================================ */

/* ---------- Роли курсоров ---------- */
const ROLE_HINTS = {
  Arrow:       ['normal', 'default', 'arrow', 'pointer', 'select'],
  Help:        ['help', 'helpsel'],
  AppStarting: ['work', 'loading', 'appstarting', 'background', 'busy'],
  Wait:        ['busy', 'wait', 'load'],
  Crosshair:   ['precision', 'cross', 'crosshair', 'precise'],
  IBeam:       ['text', 'ibeam', 'beam'],
  NWPen:       ['hand', 'pen', 'handwriting', 'nwpen'],
  No:          ['unavailable', 'no', 'unavail'],
  SizeNS:      ['vert', 'ns', 'sizens', 'vertical'],
  SizeWE:      ['horz', 'we', 'sizewe', 'horizontal'],
  SizeNWSE:    ['dgn1', 'diag1', 'nwse', 'diagonal1'],
  SizeNESW:    ['dgn2', 'diag2', 'nesw', 'diagonal2'],
  SizeAll:     ['move', 'sizeall', 'all'],
  UpArrow:     ['up', 'alt', 'alternate', 'uparrow'],
  Hand:        ['link', 'pointer', 'hand', 'location'],
  Person:      ['person', 'pin']
};

/* ---------- Стандартные курсоры Windows ---------- */
const DEFAULT_CURSORS = {
  Arrow:       '%SystemRoot%\\cursors\\aero_arrow.cur',
  Help:        '%SystemRoot%\\cursors\\aero_helpsel.cur',
  AppStarting: '%SystemRoot%\\cursors\\aero_working.ani',
  Wait:        '%SystemRoot%\\cursors\\aero_busy.ani',
  Crosshair:   '%SystemRoot%\\cursors\\aero_cross.cur',
  IBeam:       '%SystemRoot%\\cursors\\aero_beam.cur',
  NWPen:       '%SystemRoot%\\cursors\\aero_pen.cur',
  No:          '%SystemRoot%\\cursors\\aero_unavail.cur',
  SizeNS:      '%SystemRoot%\\cursors\\aero_ns.cur',
  SizeWE:      '%SystemRoot%\\cursors\\aero_ew.cur',
  SizeNWSE:    '%SystemRoot%\\cursors\\aero_nwse.cur',
  SizeNESW:    '%SystemRoot%\\cursors\\aero_nesw.cur',
  SizeAll:     '%SystemRoot%\\cursors\\aero_move.cur',
  UpArrow:     '%SystemRoot%\\cursors\\aero_up.cur',
  Hand:        '%SystemRoot%\\cursors\\aero_link.cur',
  Person:      '%SystemRoot%\\cursors\\aero_person.cur'
};

/* ============================================================
   Источники твиков кастомизации.
   Реально есть: MartyFiles, SynergyOS-Tweaks, VainOS-Tweaks, XOS-Tweaks.
   ============================================================ */
const CUSTOMIZATION_SOURCES = [
  {
    id: 'xos',
    label: '🟢 XOS-Tweaks',
    desc: 'Твики кастомизации XOS',
    json: 'tweaks/x_os_customization_tabs.json',
    baseDir: 'tweaks/Кастомизация/XOS-Tweaks'
  },
  {
    id: 'marty',
    label: '🎯 MartyFiles-Tweaks',
    desc: 'Твики кастомизации MartyFiles',
    json: 'tweaks/marty_files_customization_tabs.json',
    baseDir: 'tweaks/Кастомизация/MartyFiles'
  },
  {
    id: 'synergy',
    label: '🔷 SynergyOS-Tweaks',
    desc: 'Твики кастомизации SynergyOS',
    json: 'tweaks/synergy_os_customization_tabs.json',
    baseDir: 'tweaks/Кастомизация/SynergyOS-Tweaks'
  },
  {
    id: 'vain',
    label: '👑 VainOS-Tweaks',
    desc: 'Твики кастомизации VainOS',
    json: 'tweaks/vain_os_customization_tabs.json',
    baseDir: 'tweaks/Кастомизация/VainOS-Tweaks'
  },
  {
    id: 'atlas',
    label: '🔴 AtlasOS-Tweaks',
    desc: 'Твики кастомизации AtlasOS',
    json: 'tweaks/atlas_os_customization_tabs.json',
    baseDir: 'tweaks/Кастомизация/AtlasOS-Tweaks'
  },
  {
    id: 'rapid',
    label: '🔴 RapidOS-Tweaks',
    desc: 'Твики кастомизации RapidOS',
    json: 'tweaks/rapid_os_customization_tabs.json',
    baseDir: 'tweaks/Кастомизация/RapidOS-Tweaks'
  },
  {
    id: 'revi',
    label: '🔴 ReviOS-Tweaks',
    desc: 'Твики кастомизации ReviOS',
    json: 'tweaks/revi_os_customization_tabs.json',
    baseDir: 'tweaks/Кастомизация/ReviOS-Tweaks'
  }
];

/* ---------- Состояние вкладки ---------- */
const state2 = {
  subTab: 'cursors',     // 'cursors' | 'tweaks'
  cursors: [],
  busy: new Set(),
  loading: false,
  srcState: {
    sourceId: null,
    dataCache: {}
  }
};

/* ============================================================
   ГЛАВНЫЙ РЕНДЕР
   ============================================================ */
export async function renderCustomization() {
  const tabsNav = document.getElementById('tabs-nav');
  const content = document.getElementById('tab-content');
  tabsNav.innerHTML = '';
  content.innerHTML = '';

  /* ---------- HEADER ---------- */
  const header = document.createElement('div');
  header.className = 'apps-header';
  header.innerHTML = `
    <div class="apps-title">
      <span class="apps-title-icon">🎨</span>
      <span>Кастомизация</span>
      <span class="apps-count" id="cust-count">…</span>
    </div>
  `;
  content.appendChild(header);

  /* ---------- SUB-TABS ---------- */
  const subNav = document.createElement('div');
  subNav.className = 'sub-tabs-nav';
  content.appendChild(subNav);

  const SUBTABS = [
    { id: 'cursors', label: '🖱️ Курсоры' },
    { id: 'tweaks',  label: '⚙️ Твики' }
  ];

  const host = document.createElement('div');
  content.appendChild(host);

  for (const st of SUBTABS) {
    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'sub-tab-btn' + (st.id === state2.subTab ? ' active' : '');
    btn.dataset.tab = st.id;
    btn.textContent = st.label;
    btn.addEventListener('click', () => {
      Sound.click();
      subNav.querySelectorAll('.sub-tab-btn').forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      state2.subTab = st.id;
      renderSub();
    });
    subNav.appendChild(btn);
  }

  function renderSub() {
    host.innerHTML = '';
    updateCount();
    if (state2.subTab === 'cursors') {
      renderCursorsSection(host);
    } else if (state2.subTab === 'tweaks') {
      renderTweaksSection(host);
    }
  }

  function updateCount() {
    const el = header.querySelector('#cust-count');
    if (!el) return;
    if (state2.subTab === 'cursors') {
      const total = state2.cursors.length;
      const installed = state2.cursors.filter(c => c.installed).length;
      el.textContent = `${installed} / ${total} курсоров`;
    } else {
      el.textContent = `${CUSTOMIZATION_SOURCES.length} сборок`;
    }
  }

  /* ============================================================
     СЕКЦИЯ «КУРСОРЫ»
     ============================================================ */
  function renderCursorsSection(host) {
    /* --- HEADER --- */
    const ch = document.createElement('div');
    ch.className = 'apps-header';
    ch.style.marginTop = '0';
    ch.innerHTML = `
      <div class="apps-title">
        <span class="apps-title-icon">🖱️</span>
        <span>Курсоры</span>
      </div>
      <div class="apps-toolbar">
        <button class="btn" id="cur-refresh">🔄 Обновить</button>
        <button class="btn" id="cur-open-folder">📂 Папка курсоров</button>
        <button class="btn danger" id="cur-delete-all">🗑️ Удалить все</button>
      </div>
    `;
    host.appendChild(ch);

    /* --- INFO --- */
    const info = document.createElement('div');
    info.className = 'apps-detected-section';
    info.style.background = 'color-mix(in srgb, var(--accent) 8%, var(--card))';
    info.style.borderColor = 'color-mix(in srgb, var(--accent) 30%, transparent)';
    info.innerHTML = `
      <div class="section-title" style="margin-top:0">🖱️ Как это работает</div>
      <p class="muted" style="margin:0;font-size:12px;line-height:1.6">
        <b>📥 Скачать</b> — архив <code>.7z</code> качается с GitHub в
        <code>extreme_data/cursors_cache/</code>.<br>
        <b>✅ Установить</b> — архив распаковывается в
        <code>C:\\Windows\\Cursors\\&lt;имя&gt;\\</code>.<br>
        <b>▶️ Применить</b> — курсор переключается без перезагрузки.<br>
        <b>🗑️ Удалить</b> — папка курсора и архив удаляются.
      </p>
    `;
    host.appendChild(info);

    /* --- STATUS --- */
    const status = document.createElement('div');
    status.className = 'apps-status';
    status.textContent = 'Загрузка…';
    host.appendChild(status);

    /* --- GRID --- */
    const grid = document.createElement('div');
    grid.className = 'cursor-grid';
    host.appendChild(grid);

    /* --- LOAD --- */
    async function load(force = false) {
      if (state2.loading) return;
      state2.loading = true;

      /* Кэш сессии из preload */
      if (!force && state.dataCache?.cursors && Array.isArray(state.dataCache.cursors)) {
        console.log('[cursors] данные из кэша');
        state2.cursors = state.dataCache.cursors;
        renderCursors();
        status.textContent = `Всего: ${state2.cursors.length} (из кэша)`;
        updateCount();
        state2.loading = false;
        return;
      }

      status.textContent = 'Загрузка списка с GitHub…';
      grid.innerHTML = '<div class="tab-loading-placeholder"><div class="tab-loading-spinner"></div><div class="tab-loading-text">Загрузка списка курсоров…</div></div>';

      try {
        state2.cursors = await window.api.cursors.list(force);
        state.dataCache.cursors = state2.cursors;
        renderCursors();
        const total = state2.cursors.length;
        const installedCount = state2.cursors.filter(c => c.installed).length;
        status.textContent = `Всего: ${total}`;
        updateCount();
      } catch (e) {
        status.textContent = 'Ошибка загрузки: ' + e.message;
        toast('Ошибка загрузки курсоров: ' + e.message, 'error', 5000);
      } finally {
        state2.loading = false;
      }
    }

    function renderCursors() {
      grid.innerHTML = '';
      for (const c of state2.cursors) grid.appendChild(makeCursorCard(c));
    }

    function makeCursorCard(cursor) {
      const card = document.createElement('div');
      card.className = 'cursor-card';
      card.dataset.name = cursor.name;
      if (cursor.installed) card.classList.add('installed');
      if (cursor.downloaded) card.classList.add('downloaded');

      const preview = document.createElement('div');
      preview.className = 'cursor-preview';
      if (cursor.icon) {
        const img = document.createElement('img');
        img.className = 'cursor-icon';
        img.src = `file://${String(cursor.icon).replace(/\\/g, '/')}?t=${Date.now()}`;
        img.alt = cursor.name;
        img.draggable = false;
        img.onerror = () => {
          img.remove();
          preview.innerHTML = '<div class="cursor-icon-fallback">🖱️</div>';
        };
        preview.appendChild(img);
      } else {
        preview.innerHTML = '<div class="cursor-icon-fallback">🖱️</div>';
      }
      card.appendChild(preview);

      const info = document.createElement('div');
      info.className = 'cursor-info';
      info.innerHTML = `<span class="cursor-name" title="${escapeHtml(cursor.name)}">${escapeHtml(cursor.name)}</span>`;
      card.appendChild(info);

      const badges = document.createElement('div');
      badges.className = 'cursor-badges';
      if (cursor.installed) badges.innerHTML += '<span class="badge installed">✓ Установлен</span>';
      else if (cursor.downloaded) badges.innerHTML += '<span class="badge downloaded">📦 Скачан</span>';
      card.appendChild(badges);

      const actions = document.createElement('div');
      actions.className = 'cursor-actions';

      const btnDownload = makeBtn('📥', 'Скачать', 'btn-download', async () => {
        await runCursorAction(cursor, btnDownload, 'Скачивание…', async () => {
          const r = await window.api.cursors.download(cursor.name);
          if (!r.ok) throw new Error(r.error || 'Ошибка скачивания');
          cursor.downloaded = true;
          toast(`📥 Скачано: ${cursor.name}`, 'success', 2000);
        });
      });
      if (cursor.downloaded) btnDownload.classList.add('done');

      const btnInstall = makeBtn('✅', 'Установить', 'btn-install', async () => {
        await runCursorAction(cursor, btnInstall, 'Установка…', async () => {
          const r = await window.api.cursors.install(cursor.name, ROLE_HINTS);
          if (!r.ok) throw new Error(r.error || 'Ошибка установки');
          cursor.installed = true;
          cursor.downloaded = true;
          toast(`✅ Установлено: ${cursor.name}`, 'success', 2000);
        });
      });
      if (cursor.installed) btnInstall.classList.add('done');

      const btnApply = makeBtn('▶️', 'Применить', 'btn-apply', async () => {
        if (!cursor.installed) {
          toast('Сначала установите курсор', 'warning', 2500);
          return;
        }
        await runCursorAction(cursor, btnApply, 'Применение…', async () => {
          const r = await window.api.cursors.activate(cursor.name, ROLE_HINTS);
          if (!r.ok) throw new Error(r.error || 'Ошибка применения');
          toast(`▶️ Применён: ${cursor.name}`, 'success', 2000);
        });
      });

      const btnDelete = makeBtn('🗑️', 'Удалить', 'btn-delete', async () => {
        if (!confirm(`Удалить курсор «${cursor.name}» из системы?`)) return;
        await runCursorAction(cursor, btnDelete, 'Удаление…', async () => {
          const r = await window.api.cursors.uninstall(cursor.name);
          if (!r.ok) throw new Error(r.error || 'Ошибка удаления');
          cursor.installed = false;
          cursor.downloaded = false;
          toast(`🗑️ Удалено: ${cursor.name}`, 'success', 2000);
        });
      });
      if (!cursor.installed && !cursor.downloaded) btnDelete.disabled = true;

      actions.append(btnDownload, btnInstall, btnApply, btnDelete);
      card.appendChild(actions);
      return card;
    }

    function makeBtn(emoji, text, className, onClick) {
      const btn = document.createElement('button');
      btn.type = 'button';
      btn.className = `action-btn ${className}`;
      btn.innerHTML = `<span class="action-emoji">${emoji}</span><span class="action-text">${text}</span>`;
      btn.addEventListener('click', onClick);
      return btn;
    }

    async function runCursorAction(cursor, btn, busyText, fn) {
      if (state2.busy.has(cursor.name)) return;
      state2.busy.add(cursor.name);
      Sound.click();
      const original = btn.innerHTML;
      btn.disabled = true;
      btn.classList.add('busy');
      btn.innerHTML = `<span class="spinner"></span><span class="action-text">${busyText}</span>`;
      try {
        await fn();
        Sound.success();
      } catch (e) {
        console.error(e);
        toast(`Ошибка: ${e.message}`, 'error', 5000);
        Sound.error();
      } finally {
        state2.busy.delete(cursor.name);
        btn.disabled = false;
        btn.classList.remove('busy');
        btn.innerHTML = original;
        const oldCard = grid.querySelector(`.cursor-card[data-name="${CSS.escape(cursor.name)}"]`);
        if (oldCard) oldCard.replaceWith(makeCursorCard(cursor));
        updateCount();
      }
    }

    ch.querySelector('#cur-refresh').addEventListener('click', () => {
      Sound.click();
      delete state.dataCache.cursors;   // сброс кэша
      load(true);
    });

    ch.querySelector('#cur-open-folder').addEventListener('click', () => {
      Sound.click();
      window.api.cursors.openFolder();
    });

    ch.querySelector('#cur-delete-all').addEventListener('click', async () => {
      Sound.click();
      if (!confirm('Удалить все установленные курсоры?')) return;
      const btn = ch.querySelector('#cur-delete-all');
      const original = btn.innerHTML;
      btn.disabled = true;
      btn.innerHTML = '<span class="spinner"></span> Удаление…';
      try {
        const names = state2.cursors.map(c => c.name);
        const r = await window.api.cursors.uninstallAll(names, DEFAULT_CURSORS);
        if (!r.ok) throw new Error(r.error || 'Ошибка удаления');
        const removed = r.removed?.length || 0;
        const failed = r.failed?.length || 0;
        if (failed > 0) toast(`Удалено: ${removed}, ошибок: ${failed}`, 'warning', 5000);
        else toast(`🧹 Удалено: ${removed}`, 'success', 3000);
        Sound.success();
        delete state.dataCache.cursors;
        await load(true);
      } catch (e) {
        toast('Ошибка: ' + e.message, 'error', 5000);
        Sound.error();
      } finally {
        btn.disabled = false;
        btn.innerHTML = original;
      }
    });

    /* ---- INITIAL LOAD ---- */
    load();
  }

  /* ============================================================
     СЕКЦИЯ «ТВИКИ ОТ СБОРОК»
     ============================================================ */
  function renderTweaksSection(host) {
    /* --- Источники (панель сверху) --- */
    const srcSection = document.createElement('div');
    srcSection.className = 'opt-root';
    host.appendChild(srcSection);

    const srcNav = document.createElement('div');
    srcNav.className = 'opt-src-nav';
    srcSection.appendChild(srcNav);

    const srcBody = document.createElement('div');
    srcBody.className = 'opt-src-body';
    srcSection.appendChild(srcBody);

    /* --- Контейнер под контент --- */
    const srcContent = document.createElement('div');
    srcContent.id = 'cust-src-content';
    host.appendChild(srcContent);

    /* --- Инициализация источника --- */
    if (!state2.srcState.sourceId) {
      state2.srcState.sourceId = CUSTOMIZATION_SOURCES[0]?.id || null;
    }

    /* --- Кнопки источников --- */
    for (const s of CUSTOMIZATION_SOURCES) {
      const btn = document.createElement('button');
      btn.type = 'button';
      btn.className = 'opt-src-btn' + (s.id === state2.srcState.sourceId ? ' active' : '');
      btn.dataset.src = s.id;
      btn.innerHTML = `<span class="opt-src-lbl">${escapeHtml(s.label)}</span>`;
      btn.title = s.desc || '';
      btn.addEventListener('click', async () => {
        if (state2.srcState.sourceId === s.id) return;
        Sound.click();
        state2.srcState.sourceId = s.id;
        srcNav.querySelectorAll('.opt-src-btn').forEach(b => {
          b.classList.toggle('active', b.dataset.src === s.id);
        });
        await switchSource(s, srcBody, srcContent);
      });
      srcNav.appendChild(btn);
    }

    /* --- Рендер первого источника --- */
    (async () => {
      const s = CUSTOMIZATION_SOURCES.find(x => x.id === state2.srcState.sourceId);
      if (s) await switchSource(s, srcBody, srcContent);
    })();
  }

  async function switchSource(src, srcBody, srcContent) {
    let data = state2.srcState.dataCache[src.id];
    if (data === undefined) {
      srcBody.innerHTML = `<p class="muted" style="padding:20px">Загрузка ${escapeHtml(src.label)}…</p>`;
      try {
        data = await loadSourceData(src);
      } catch (e) {
        srcBody.innerHTML = `<div class="apps-empty">Ошибка: ${escapeHtml(e.message)}</div>`;
        return;
      }
      state2.srcState.dataCache[src.id] = data;
      srcBody.innerHTML = '';
    }

    srcContent.innerHTML = '';
    renderSourceContent(srcContent, src, data);
  }

  function renderSourceContent(host, src, data) {
    if (!data) {
      host.innerHTML = `<div class="apps-empty" style="padding:20px">Не удалось получить твики ${escapeHtml(src.label)}</div>`;
      return;
    }

    /* --- Плоский вариант --- */
    if (data.kind === 'flat') {
      const pairMap = buildPairMap(data.rootFiles, data.cancelFiles);
      const items = data.rootFiles.map(f => {
        const baseName = String(f).replace(/\\/g, '/').split('/').pop();
        const ext = baseName.includes('.') ? baseName.split('.').pop() : '';
        const core = coreName(baseName);
        const cancelFile = pairMap.get(core) || null;
        return {
          name: baseName.replace(/\.[^.]+$/, ''),
          path: `${src.baseDir}/${f}`,
          ext,
          category: src.label,
          cancelPath: cancelFile ? `${src.baseDir}/отмена/${cancelFile}` : null,
          cancelName: cancelFile ? cancelFile.replace(/\.[^.]+$/, '') : null
        };
      });

      const wrap = document.createElement('div');
      wrap.className = 'section';
      host.appendChild(wrap);

      const title = document.createElement('div');
      title.className = 'section-title';
      title.textContent = `Твики: ${src.label}`;
      wrap.appendChild(title);

      const grid = document.createElement('div');
      wrap.appendChild(grid);

      const mode = state.config.General?.checkbox_display_mode || 'rectangle';
      const cols = parseInt(state.config.Columns?.default || '3', 10) || 3;

      renderCheckboxGrid(grid, {
        items,
        tabId: `customization:${src.id}:root`,
        sectionId: 'customization',
        mode,
        columns: cols,
        showCancelButton: state.config.General?.show_cancel_buttons !== false
      });
      return;
    }

    /* --- Группированный вариант --- */
    const categories = Object.keys(data.categories || {});
    if (!categories.length) {
      host.innerHTML = '<div class="apps-empty">Категорий не найдено</div>';
      return;
    }

    const wrap = document.createElement('div');
    wrap.className = 'section';
    host.appendChild(wrap);

    const title = document.createElement('div');
    title.className = 'section-title';
    title.textContent = `Твики: ${src.label}`;
    wrap.appendChild(title);

    const subNav = document.createElement('div');
    subNav.className = 'sub-tabs-nav';
    wrap.appendChild(subNav);

    const catsHost = document.createElement('div');
    wrap.appendChild(catsHost);

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

      const files = data.categories[cat] || [];
      const cancelEntry = data.cancels[cat];
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

      const mode = state.config.General?.checkbox_display_mode || 'rectangle';
      const cols = parseInt(state.config.Columns?.default || '3', 10) || 3;

      renderCheckboxGrid(catContainer, {
        items,
        tabId: `customization:${src.id}:${cat}`,
        sectionId: 'customization',
        mode,
        columns: cols,
        showCancelButton: state.config.General?.show_cancel_buttons !== false
      });
    }
  }

  /* ---- INITIAL RENDER ---- */
  renderSub();
}

function escapeHtml(s) {
  return String(s)
    .replace(/&/g, '&amp;').replace(/</g, '&lt;')
    .replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/'/g, '&#39;');
}