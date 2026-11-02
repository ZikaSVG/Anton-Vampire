import { state, clearCheckboxes, toast, Sound } from '../app.js';
import { renderCheckboxGrid } from '../components/checkbox.js';
import { renderSources, loadSourceData, buildPairMap, coreName } from './sources.js';

/* ============================================================
   ТАБЛИЦА ПЛАНОВ ПИТАНИЯ
   Данные лежат в src/renderer/tabs/power-table.json
   ============================================================ */
let POWER_TABLE = [];
let POWER_TABLE_SOURCE = '';

async function loadPowerTable() {
  try {
    const res = await window.api.tabs.readJson('src/renderer/tabs/power-table.json');
    if (res && res.ok && res.data) {
      POWER_TABLE = Array.isArray(res.data.rows) ? res.data.rows : [];
      POWER_TABLE_SOURCE = res.data.source || '';
      console.log(`[power] таблица загружена: ${POWER_TABLE.length} строк`);
      return true;
    }
    console.warn('[power] power-table.json не прочитан:', res?.error);
  } catch (e) {
    console.warn('[power] loadPowerTable failed:', e);
  }
  return false;
}

/* ============================================================
   ИСТОЧНИКИ ЭЛЕКТРОПИТАНИЯ

   __standard__        — таблица планов + tabs_2 из tabs.json
   XOS-Tweaks         — 15 батников (плоская папка)
   xOS (расширенная)  — 6 подпапок (xOS Power Plan / Возврат /
                        Enum / Твики для ПК / USB PCI Express)
                        это ДРУГАЯ папка, не XOS-Tweaks!
   SystemX            — плоская
   Igromanoff         — плоская
   VainOS-Tweaks      — плоская + отмена
   SynergyOS-Tweaks   — плоская + отмена
   Другое             — батники питания вне tabs_2
   ============================================================ */
const POWER_SOURCES = [
  {
    id: '__standard__',
    label: '📦 Стандартные',
    desc: 'Таблица планов + встроенные твики электропитания',
    json: null,
    baseDir: null,
    _isStandard: true
  },
  {
    id: 'xos',
    label: '🟢 XOS-Tweaks',
    desc: 'Набор твиков XOS',
    json: 'tweaks/x_os_power_tabs.json',
    baseDir: 'tweaks/Электропитание/XOS-Tweaks'
  },
  {
    id: 'xos_legacy',
    label: '🟢 xOS (расширенный)',
    desc: 'Расширенная папка xOS: планы, USB/PCIe, Enum-твики',
    json: 'tweaks/x_os_legacy_power_tabs.json',
    baseDir: 'tweaks/Электропитание/xOS'
  },
  { 
    id: 'immortal',
    label: '💀 ImmortalOS-Tweaks',
    desc: 'Набор твиков ImmortalOS',
    json: 'tweaks/immortal_os_power_tabs.json',
    baseDir: 'tweaks/Электропитание/ImmortalOS-Tweaks',
  },
  {
    id: 'systemx',
    label: '🟣 SystemX-Tweaks',
    desc: 'Набор твиков SystemX',
    json: 'tweaks/system_x_power_tabs.json',
    baseDir: 'tweaks/Электропитание/SystemX'
  },
  {
    id: 'igromanoff',
    label: '🎩 Igromanoff-Tweaks',
    desc: 'Набор твиков Igromanoff',
    json: 'tweaks/igromanoff_power_tabs.json',
    baseDir: 'tweaks/Электропитание/Igromanoff'
  },
  {
    id: 'vain',
    label: '👑 VainOS-Tweaks',
    desc: 'Набор твиков VainOS',
    json: 'tweaks/vain_os_power_tabs.json',
    baseDir: 'tweaks/Электропитание/VainOS-Tweaks'
  },
  {
    id: 'synergy',
    label: '🔷 SynergyOS-Tweaks',
    desc: 'Набор твиков SynergyOS',
    json: 'tweaks/synergy_os_power_tabs.json',
    baseDir: 'tweaks/Электропитание/SynergyOS-Tweaks'
  },
  {
    id: 'other',
    label: '📁 Другое',
    desc: 'Прочие батники питания (не вошли в tabs_2)',
    json: 'tweaks/drugoe_power_tabs.json',
    baseDir: 'tweaks/Электропитание/Другое'
  }
];

/* ============================================================
   РЕНДЕР ВКЛАДКИ
   ============================================================ */
export async function renderPower() {
  const tabsNav = document.getElementById('tabs-nav');
  const content = document.getElementById('tab-content');
  tabsNav.innerHTML = ''; content.innerHTML = '';
  clearCheckboxes();

  /* Загружаем таблицу из JSON (один раз) */
  if (!POWER_TABLE.length) {
    await loadPowerTable();
  }

  /* Верхний контейнер под панель источников */
  const srcSection = document.createElement('div');
  srcSection.className = 'opt-root';
  content.appendChild(srcSection);

  const srcNav = document.createElement('div');
  srcNav.className = 'opt-src-nav';
  srcSection.appendChild(srcNav);

  const srcBody = document.createElement('div');
  srcBody.className = 'opt-src-body';
  srcSection.appendChild(srcBody);

  /* Контейнер «Стандартные» — сюда рендерится таблица + tabs_2 */
  const stdContent = document.createElement('div');
  stdContent.id = 'power-std-content';
  content.appendChild(stdContent);

  /* Контейнер под контент источника — сюда рендерятся твики OS */
  const srcContent = document.createElement('div');
  srcContent.id = 'power-src-content';
  srcContent.style.display = 'none';
  content.appendChild(srcContent);

  /* Стейт панели источников */
  const srcState = { sourceId: '__standard__', dataCache: {} };

  /* Кнопки источников */
  for (const s of POWER_SOURCES) {
    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'opt-src-btn' + (s.id === srcState.sourceId ? ' active' : '');
    btn.dataset.src = s.id;
    btn.innerHTML = `<span class="opt-src-lbl">${escapeHtml(s.label)}</span>`;
    btn.title = s.desc || '';
    btn.addEventListener('click', async () => {
      if (srcState.sourceId === s.id) return;
      Sound.click();
      srcState.sourceId = s.id;
      srcNav.querySelectorAll('.opt-src-btn').forEach(b => {
        b.classList.toggle('active', b.dataset.src === s.id);
      });
      await switchSource(s);
    });
    srcNav.appendChild(btn);
  }

  /* ============================================================
     Переключение источника.
     ============================================================ */
  async function switchSource(src) {
    if (src._isStandard) {
      srcBody.innerHTML = '';
      srcContent.style.display = 'none';
      srcContent.innerHTML = '';
      stdContent.style.display = '';
      clearCheckboxes();
      return;
    }

    stdContent.style.display = 'none';
    srcContent.style.display = '';

    let data = srcState.dataCache[src.id];
    if (data === undefined) {
      srcBody.innerHTML = `<p class="muted" style="padding:20px">Загрузка ${escapeHtml(src.label)}…</p>`;
      try {
        data = await loadSourceData(src);
      } catch (e) {
        srcBody.innerHTML = `<div class="apps-empty">Ошибка: ${escapeHtml(e.message)}</div>`;
        return;
      }
      srcState.dataCache[src.id] = data;
      srcBody.innerHTML = '';
    }

    srcContent.innerHTML = '';
    renderSourceContent(srcContent, src, data);
    clearCheckboxes();
  }

  /* ============================================================
     Рендер контента одного источника.
     ============================================================ */
  function renderSourceContent(host, src, data) {
    if (!data) {
      host.innerHTML = `<div class="apps-empty" style="padding:20px">Не удалось получить твики ${escapeHtml(src.label)}</div>`;
      return;
    }

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

      const mode = state.config.General?.checkbox_display_mode || 'rectangle';
      const cols = parseInt(state.config.Columns?.default || '3', 10) || 3;

      const wrap = document.createElement('div');
      wrap.className = 'section';
      host.appendChild(wrap);

      const title = document.createElement('div');
      title.className = 'section-title';
      title.textContent = `Твики: ${src.label}`;
      wrap.appendChild(title);

      const grid = document.createElement('div');
      wrap.appendChild(grid);

      renderCheckboxGrid(grid, {
        items,
        tabId: `power:${src.id}:root`,
        sectionId: 'power',
        mode,
        columns: cols,
        showCancelButton: state.config.General?.show_cancel_buttons !== false
      });
      return;
    }

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
        tabId: `power:${src.id}:${cat}`,
        sectionId: 'power',
        mode,
        columns: cols,
        showCancelButton: state.config.General?.show_cancel_buttons !== false
      });
    }
  }

  /* ============================================================
     Строим «Стандартные» (таблица + tabs_2) в stdContent
     ============================================================ */
  buildPowerStandard(stdContent);

  function buildPowerStandard(host) {
    host.innerHTML = '';

    /* ============ 1. Таблица ============ */
    const tableSection = document.createElement('div');
    tableSection.className = 'section';
    host.appendChild(tableSection);

    const tableTitle = document.createElement('div');
    tableTitle.className = 'section-title';
    tableTitle.textContent = 'Результаты тестирования планов электропитания';
    tableSection.appendChild(tableTitle);

    const tableWrap = document.createElement('div');
    tableWrap.className = 'power-table-wrap';
    tableSection.appendChild(tableWrap);

    const table = document.createElement('table');
    table.className = 'power-table';
    table.innerHTML = `
      <thead>
        <tr>
          <th>План питания</th>
          <th>Ср. задержка (мс)</th>
          <th>Мин. задержка</th>
          <th>Макс. задержка</th>
          <th>Ср. FPS</th>
          <th>Темп. CPU</th>
          <th>Комментарий</th>
        </tr>
      </thead>
      <tbody></tbody>
    `;

    const tbody = table.querySelector('tbody');
    for (const row of POWER_TABLE) {
      const [plan, avg, min, max, fps, temp, comment] = row;
      const isSep = avg === null && min === null && fps === null;

      const tr = document.createElement('tr');
      if (isSep) tr.className = 'power-row-sep';

      tr.innerHTML = `
        <td>${escapeHtml(plan)}</td>
        <td>${avg ?? ''}</td>
        <td>${min ?? ''}</td>
        <td>${max ?? ''}</td>
        <td>${fps ?? ''}</td>
        <td>${temp ?? ''}</td>
        <td>${comment ? escapeHtml(comment) : ''}</td>
      `;
      tbody.appendChild(tr);
    }
    tableWrap.appendChild(table);

    /* Footer со ссылкой — берём из POWER_TABLE_SOURCE */
    const footer = document.createElement('div');
    footer.className = 'power-footer';
    if (POWER_TABLE_SOURCE) {
      footer.innerHTML = `Источник данных: <a href="${escapeHtml(POWER_TABLE_SOURCE)}" target="_blank" rel="noopener">Google Sheets</a>`;
      footer.querySelector('a').addEventListener('click', (e) => {
        e.preventDefault();
        window.api.shell.openExternal(POWER_TABLE_SOURCE);
      });
    } else {
      footer.innerHTML = '<span class="muted">Источник данных не указан.</span>';
    }
    tableSection.appendChild(footer);

    /* ============ 2. Планы питания из tabs_2 ============ */
    const tabsData = state.tabsData || {};
    const tabs2 = tabsData.tabs_2 || {};

    const PLAN_ORDER = [
      'Популярные режимы электропитания',
      'Классика',
      'Адские режимы электропитания',
      'Схемы AMD&INTEL',
      'Схемы где ЗАГРУЖЕННОСТЬ ПРОЦЕССОРА 100%',
      'Все планы электропитания',
      'Твики',
      'Твики от xOS',
      'Электропитание'
    ];

    const known = Object.keys(tabs2);
    const ordered = [
      ...PLAN_ORDER.filter(k => known.includes(k)),
      ...known.filter(k => !PLAN_ORDER.includes(k))
    ];

    const plansSection = document.createElement('div');
    plansSection.className = 'section';
    host.appendChild(plansSection);

    const plansTitle = document.createElement('div');
    plansTitle.className = 'section-title';
    plansTitle.textContent = 'Планы и твики электропитания';
    plansSection.appendChild(plansTitle);

    if (!ordered.length) {
      const emptyMsg = document.createElement('p');
      emptyMsg.className = 'muted';
      emptyMsg.textContent = 'tabs.json не содержит секции "tabs_2".';
      plansSection.appendChild(emptyMsg);
      return;
    }

    const subNav = document.createElement('div');
    subNav.className = 'sub-tabs-nav';
    plansSection.appendChild(subNav);

    const innerHost = document.createElement('div');
    plansSection.appendChild(innerHost);

    const containers = {};

    for (let i = 0; i < ordered.length; i++) {
      const cat = ordered[i];

      const btn = document.createElement('button');
      btn.type = 'button';
      btn.className = 'sub-tab-btn' + (i === 0 ? ' active' : '');
      btn.textContent = cat;
      btn.addEventListener('click', () => {
        Sound.click();
        subNav.querySelectorAll('.sub-tab-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        for (const c of Object.values(containers)) c.style.display = 'none';
        if (containers[cat]) containers[cat].style.display = '';
      });
      subNav.appendChild(btn);

      const catContainer = document.createElement('div');
      catContainer.className = 'sub-tab-content';
      catContainer.style.display = (i === 0 ? '' : 'none');
      innerHost.appendChild(catContainer);
      containers[cat] = catContainer;

      const files = (tabs2[cat] || []).filter(f => /\.(pow|bat|cmd|exe|ps1|reg)$/i.test(f));

      const items = files.map(rel => {
        const relStr = String(rel).replace(/\\/g, '/');
        const seg = relStr.split('/');
        const base = seg[seg.length - 1];
        const sub = seg.length > 1 ? seg.slice(0, -1).join('/') : null;
        const ext = base.includes('.') ? base.split('.').pop() : '';
        return {
          name: base.replace(/\.[^.]+$/, ''),
          path: `tweaks/Электропитание/${cat}/${relStr}`,
          ext,
          category: sub
        };
      });

      const mode = state.config.General?.checkbox_display_mode || 'rectangle';
      const cols = parseInt(state.config.Columns?.default || '3', 10) || 3;

      renderCheckboxGrid(catContainer, {
        items,
        tabId: cat,
        sectionId: 'power',
        mode,
        columns: cols
      });
    }
  }
}

/* ============================================================
   Хелперы
   ============================================================ */
function escapeHtml(s) {
  return String(s)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}