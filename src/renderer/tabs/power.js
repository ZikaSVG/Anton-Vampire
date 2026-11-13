import { state, clearCheckboxes, toast, Sound } from '../app.js';
import { renderCheckboxGrid } from '../components/checkbox.js';
import { renderSources, loadSourceData, buildPairMap, coreName } from './sources.js';

/* ============================================================
   POWER KILLER — гранулированные функции (отдельные запуски)
   ============================================================ */
const PK_FEATURES = [
  {
    id: 'timeouts',
    icon: '🕒',
    title: 'Отключение таймаутов AC/DC',
    desc: 'Запрещает монитору, диску и системе уходить в сон. Убирает микро-лаги при простое.',
    file: 'Электропитание/PowerKiller/PK_Timeouts.bat'
  },
  {
    id: 'cpu',
    icon: '🧠',
    title: 'Отключение CPU Throttle',
    desc: 'Запрещает Windows ограничивать частоту процессора. CPU всегда работает на максимуме.',
    file: 'Электропитание/PowerKiller/PK_CPU_Throttle.bat'
  },
  {
    id: 'throttling',
    icon: '⚙️',
    title: 'Power Throttling & Dynamic Tick',
    desc: 'Отключает фоновое энергосбережение ядра и динамический таймер. Снижает DPC latency.',
    file: 'Электропитание/PowerKiller/PK_Power_Throttling_DynamicTick.bat'
  },
  {
    id: 'usb',
    icon: '🔌',
    title: 'Управление питанием USB',
    desc: 'Предотвращает "засыпание" USB-портов. Критично для мышек с опросом 1000Hz+.',
    file: 'Электропитание/PowerKiller/PK_USB_Power.bat'
  },
  {
    id: 'pci',
    icon: '🎛️',
    title: 'PCI D3Cold (Энергосбережение PCIe)',
    desc: 'Запрещает глубокий сон для видеокарты и NVMe. Устраняет микро-фризы.',
    file: 'Электропитание/PowerKiller/PK_PCI_D3Cold.bat'
  },
  {
    id: 'logs',
    icon: '📓',
    title: 'Диагностические журналы питания',
    desc: 'Отключает SleepStudy и Kernel-Processor-Power. Снижает нагрузку на диск и CPU.',
    file: 'Электропитание/PowerKiller/PK_Disable_Logs.bat'
  }
];

/* ============================================================
   POWER KILLER: MAXIMUM — всё сразу одним батником
   ============================================================ */
const PK_MAXIMUM_FILE = 'Электропитание/PowerKiller/PK_Maximum.bat';
const PK_REVERT_FILE = 'Электропитание/PowerKiller/PK_Revert_All.bat';

/* ============================================================
   ТАБЛИЦА ПЛАНОВ ПИТАНИЯ
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
   ИСТОЧНИКИ ЭЛЕКТРОПИТАНИЯ (ВЕРНУЛ ВСЕ НА МЕСТО)
   ============================================================ */
const POWER_SOURCES = [
  {
    id: '__standard__',
    label: '📦 Стандартные',
    desc: 'Power Killer, таблица планов + встроенные твики',
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

  /* Контейнер «Стандартные» — сюда рендерится Power Killer + таблица + tabs_2 */
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
      buildPowerStandard(stdContent); // Перестраиваем стандартную вкладку
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
     Рендер контента одного источника (XOS, Immortal и т.д.)
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
          cancelPath: cancelFile ? `${src.baseDir}/${cat}/${cancelDirName}/${cancelFile}` : null,
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
     Строим «Стандартные»: Power Killer + таблица + tabs_2
     ============================================================ */
  function buildPowerStandard(host) {
    host.innerHTML = '';

    /* ============ 0. POWER KILLER (Отдельные карточки, как в fixes.js) ============ */
    const pkSection = document.createElement('div');
    pkSection.className = 'apps-detected-section';
    pkSection.style.background = 'color-mix(in srgb, var(--card) 60%, transparent)';
    pkSection.style.borderColor = 'color-mix(in srgb, var(--border) 30%, transparent)';
    pkSection.style.marginBottom = '24px';
    host.appendChild(pkSection);

    const pkTitle = document.createElement('div');
    pkTitle.className = 'section-title';
    pkTitle.textContent = '💀 Power Killer — Смертельная настройка';
    pkSection.appendChild(pkTitle);

    const pkDesc = document.createElement('p');
    pkDesc.className = 'muted';
    pkDesc.style.cssText = 'font-size:13px; line-height:1.5; margin: 0 0 16px 0;';
    pkDesc.innerHTML = 'Нажмите "Запустить" на нужной карточке. Каждая функция применяется независимо. <span style="color:var(--danger);">⚠️ Для ноутбуков:</span> при работе от батареи может привести к быстрому разряду.';
    pkSection.appendChild(pkDesc);

    const pkGrid = document.createElement('div');
    pkGrid.className = 'apps-grid fixes-grid'; // Используем сетку из fixes.js
    pkSection.appendChild(pkGrid);

    PK_FEATURES.forEach(f => {
      const card = document.createElement('div');
      card.className = 'apps-card';
      card.innerHTML = `
        <div class="apps-icon">${f.icon}</div>
        <div class="apps-name">${f.title}</div>
        <div class="apps-sub">${f.desc}</div>
        <button class="apps-run" data-file="${f.file}">▶ Запустить</button>
      `;

      const btn = card.querySelector('.apps-run');
      btn.addEventListener('click', async (e) => {
        e.stopPropagation();
        if (btn.disabled) return;
        btn.disabled = true;
        Sound.click();
        try {
          await window.api.tweaks.run(`tweaks/${f.file}`, { wait: true });
          Sound.success();
          toast(`${f.title} применено`, 'success');
        } catch (err) {
          Sound.error();
          toast(`Ошибка: ${err.message}`, 'error');
        } finally {
          btn.disabled = false;
        }
      });

      pkGrid.appendChild(card);
    });

    // ===== Кнопки действий Power Killer: MAXIMUM + REVERT =====
    const pkFooter = document.createElement('div');
    pkFooter.style.cssText = 'margin-top:16px; display:flex; gap:12px; flex-wrap:wrap; justify-content:flex-end;';
    pkFooter.innerHTML = `
      <button class="btn" id="btn-pk-max" style="flex:1; min-width:220px; background:#7c3aed; color:#fff; font-weight:600;">💀 Применить Смертельный Максимум (всё сразу)</button>
      <button class="btn danger" id="btn-pk-revert" style="flex:1; min-width:220px;">↩ Откатить все настройки Power Killer</button>
    `;
    pkSection.appendChild(pkFooter);

    // MAXIMUM — всё сразу одним батником
    pkFooter.querySelector('#btn-pk-max').addEventListener('click', async () => {
      if (!confirm('Применить ВСЕ настройки Power Killer сразу?\n\n• Ultimate Performance\n• CPU 100% (AC)\n• Таймауты off\n• Гибернация off\n• Power Throttling off + disabledynamictick\n• USB LPM/D3Cold off\n• PCI D3Cold off + MSI mode + DMA remapping off + MPO off\n• Диагностические логи off + CEIP off\n• Ethernet TCP-твики\n\nПродолжить?')) return;

      const btn = pkFooter.querySelector('#btn-pk-max');
      btn.disabled = true;
      Sound.click();
      try {
        await window.api.tweaks.run(`tweaks/${PK_MAXIMUM_FILE}`, { wait: true });
        Sound.success();
        toast('Power Killer: Смертельный Максимум применён', 'success');
      } catch (err) {
        Sound.error();
        toast(`Ошибка: ${err.message}`, 'error');
      } finally {
        btn.disabled = false;
      }
    });

    // REVERT — сброс к Balanced
    pkFooter.querySelector('#btn-pk-revert').addEventListener('click', async () => {
      if (!confirm('Это сбросит все настройки электропитания к стандартным значениям Windows (Balanced). Продолжить?')) return;
      const btn = pkFooter.querySelector('#btn-pk-revert');
      btn.disabled = true;
      Sound.click();
      try {
        await window.api.tweaks.run(`tweaks/${PK_REVERT_FILE}`, { wait: true });
        Sound.success();
        toast('Настройки питания сброшены к стандартным', 'success');
      } catch (err) {
        Sound.error();
        toast(`Ошибка отката: ${err.message}`, 'error');
      } finally {
        btn.disabled = false;
      }
    });


    /* ============ 1. Таблица планов питания ============ */
    const tableSection = document.createElement('div');
    tableSection.className = 'section';
    host.appendChild(tableSection);

    const tableTitle = document.createElement('div');
    tableTitle.className = 'section-title';
    tableTitle.textContent = '📊 Результаты тестирования планов электропитания';
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

    if (!ordered.length) return;

    const plansSection = document.createElement('div');
    plansSection.className = 'section';
    plansSection.style.marginTop = '24px';
    host.appendChild(plansSection);

    const plansTitle = document.createElement('div');
    plansTitle.className = 'section-title';
    plansTitle.textContent = '🔋 Планы и твики электропитания';
    plansSection.appendChild(plansTitle);

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

  // Инициализация стандартной вкладки при первом рендере
  buildPowerStandard(stdContent);
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