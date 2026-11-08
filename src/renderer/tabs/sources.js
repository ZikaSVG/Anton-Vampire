/* ============================================================
   Общий модуль «источники твиков» с парами «твик ↔ отмена».

   Используется в разделах, где нужно рендерить наборы твиков
   из внешних JSON-файлов с парными кнопками отмены.

   Поддерживает ДВА формата JSON:

   1. ПЛОСКИЙ (одна группа, без категорий):
      {
        "tabs": {
          "Root":   [ "Отключить X.bat", ... ],
          "отмена": [ "Включить X.bat", ... ]
        }
      }
      → рендерим карточки сразу, без под-вкладок.
      → path = baseDir / file

   2. С КАТЕГОРИЯМИ (как в x_os_tabs.json):
      {
        "tabs": {
          "Категория1": { "Root": [...], "отмена": [...] },
          "Категория2": { "Root": [...], "отмена": [...] }
        }
      }
      → рендерим под-вкладки категорий.
      → path зависит от флага flatCategories у источника:
          • flatCategories = false (по умолчанию):
              path = baseDir / Категория1 / file
              (как в tweaks/Оптимизация/XOS-Tweaks/Безопасная оптимизация/…)
          • flatCategories = true:
              path = baseDir / file
              (категория — логическая метка, файлы лежат прямо в baseDir,
               как в tweaks/Приватность/AtlasOS/… с категорией «Приватность»)

   ВАЖНО: id источника должен быть уникальным внутри секции,
   потому что registerCheckbox использует ключ
   `${sectionId}::${src.id}::${category}::${path}`.
   ============================================================ */

   import { state, clearCheckboxes, Sound } from '../app.js';
   import { renderCheckboxGrid } from '../components/checkbox.js';
   
   /* Регексп файлов-твиков. */
   const TWEAK_RE = /\.(bat|cmd|exe|ps1|reg|pow)$/i;
   
   /* Ключи, под которыми может лежать массив отмены. */
   const CANCEL_KEYS = ['отмена', 'Отмена', 'ОТМЕНА', 'cancel', 'Cancel'];
   
   /* ============================================================
      coreName / verbs / buildPairMap
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
   
     'удалить', 'удалять', 'удали',
     'отменить удаление',
   
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
   
   export function normalizeWhitespace(s) {
     return String(s)
       .replace(/[\u00A0\u2007\u202F\u2009\u200A\uFEFF]/g, ' ')
       .replace(/[\t\r\n]+/g, ' ')
       .replace(/\s+/g, ' ')
       .trim();
   }
   
   export function coreName(fileName) {
     let s = String(fileName);
   
     s = s.replace(/^[\uFEFF\u00A0]+/, '');
     s = s.replace(/\.(bat|cmd|ps1|reg|exe|pow)$/i, '');
     s = s.replace(/^\s*отмена\s*[\\\/]\s*/i, '');
     s = normalizeWhitespace(s);
   
     let changed = true;
     while (changed) {
       changed = false;
       for (const verb of ACTION_VERBS_SORTED) {
         const v = normalizeWhitespace(verb);
         if (s.toLowerCase().startsWith(v.toLowerCase() + ' ')) {
           s = s.slice(v.length).trim();
           changed = true;
           break;
         }
       }
     }
   
     s = normalizeWhitespace(s).toLowerCase();
     s = s.replace(/\.\s*$/, '');
     return s;
   }
   
   export function buildPairMap(rootFiles, cancelFiles) {
     const cancels = new Map();
     for (const f of cancelFiles) {
       const base = String(f).replace(/\\/g, '/').split('/').pop();
       const core = coreName(base);
       if (!core) continue;
       if (!cancels.has(core)) cancels.set(core, base);
     }
   
     const validCores = new Set();
     for (const f of rootFiles) {
       const base = String(f).replace(/\\/g, '/').split('/').pop();
       const core = coreName(base);
       if (core) validCores.add(core);
     }
   
     const filtered = new Map();
     for (const [core, file] of cancels) {
       if (validCores.has(core)) filtered.set(core, file);
     }
     return filtered;
   }
   
   /* ============================================================
      Парсинг JSON-файла источника.
   
      Возвращает:
        { kind: 'flat',    rootFiles: [...], cancelFiles: [...] }
        { kind: 'grouped', categories: { ... }, cancels: { ... } }
        null — если структура не распознана.
      ============================================================ */
   function parseSourceJson(data) {
     if (!data || typeof data !== 'object') return null;
     const tabs = data.tabs;
     if (!tabs || typeof tabs !== 'object') return null;
   
     /* Плоский вариант: Root на верхнем уровне. */
     if (Array.isArray(tabs.Root)) {
       const rootFiles = tabs.Root.filter(f => TWEAK_RE.test(f));
       let cancelFiles = [];
       let cancelKey = null;
       for (const ck of CANCEL_KEYS) {
         if (Array.isArray(tabs[ck])) {
           cancelFiles = tabs[ck].filter(f => TWEAK_RE.test(f));
           cancelKey = ck;
           break;
         }
       }
       return { kind: 'flat', rootFiles, cancelFiles, cancelKey };
     }
   
     /* Группированный вариант. */
     const categories = {};
     const cancels = {};
   
     for (const [cat, payload] of Object.entries(tabs)) {
       if (!payload || typeof payload !== 'object') continue;
   
       if (Array.isArray(payload.Root)) {
         const filtered = payload.Root.filter(f => TWEAK_RE.test(f));
         if (filtered.length) categories[cat] = filtered;
   
         for (const ck of CANCEL_KEYS) {
           if (Array.isArray(payload[ck]) && payload[ck].length) {
             cancels[cat] = {
               key: ck,
               files: payload[ck].filter(f => TWEAK_RE.test(f))
             };
             break;
           }
         }
       } else if (Array.isArray(payload)) {
         const filtered = payload.filter(f => TWEAK_RE.test(f));
         if (filtered.length) categories[cat] = filtered;
       }
     }
   
     if (!Object.keys(categories).length) return null;
     return { kind: 'grouped', categories, cancels };
   }
   
   /* ============================================================
      Загрузка одного источника.
   
      source = {
        id, label, desc,
        json,             // путь к JSON относительно rootDir
        baseDir,          // папка с .bat, относительно rootDir
        flatCategories    // true → категория в JSON = метка, файлы в baseDir
      }
      ============================================================ */
   export async function loadSourceData(source) {
     let parsed = null;
   
     if (source.json) {
       try {
         const res = await window.api.tabs.readJson(source.json);
         if (res && res.ok && res.data) {
           parsed = parseSourceJson(res.data);
         }
       } catch { /* ignore */ }
     }
   
     /* Fallback — сканируем папку. scanDir возвращает {подпапка: [файлы]},
        категории = реальные подпапки baseDir, flatCategories не применяется. */
     if (!parsed) {
       try {
         const res = await window.api.tabs.scanDir(source.baseDir);
         if (res && res.ok && res.data && Object.keys(res.data).length) {
           return { kind: 'grouped', categories: res.data, cancels: {}, _fromScanDir: true };
         }
       } catch { /* ignore */ }
     }
   
     return parsed;
   }
   
   /* ============================================================
      Вспомогательное: собрать items[] для renderCheckboxGrid.
   
      Возвращает массив объектов { name, path, ext, category,
      cancelPath, cancelName }.
      ============================================================ */
   function buildItems({ files, cancelFiles, cancelDirName, baseDir, category, flatCategories, isFlat }) {
     const pairMap = buildPairMap(files, cancelFiles);
   
     /* Куда класть файлы:
        - flat:                 baseDir / file
        - grouped + flatCats:   baseDir / file
        - grouped без flatCats: baseDir / category / file */
     const fileBase = (isFlat || flatCategories)
       ? baseDir
       : `${baseDir}/${category}`;
   
     /* Куда класть отмену (аналогично): */
     const cancelBase = (isFlat || flatCategories)
       ? `${baseDir}/${cancelDirName}`
       : `${baseDir}/${category}/${cancelDirName}`;
   
     return files.map(f => {
       const baseName = String(f).replace(/\\/g, '/').split('/').pop();
       const ext = baseName.includes('.') ? baseName.split('.').pop() : '';
       const core = coreName(baseName);
       const cancelFile = pairMap.get(core) || null;
   
       return {
         name: baseName.replace(/\.[^.]+$/, ''),
         path: `${fileBase}/${f}`,
         ext,
         category,
         cancelPath: cancelFile ? `${cancelBase}/${cancelFile}` : null,
         cancelName: cancelFile ? cancelFile.replace(/\.[^.]+$/, '') : null
       };
     });
   }
   
   /* ============================================================
      Рендер источников в хосте.
   
      opts = {
        host,                 // DOM-элемент, куда рендерим
        sources,              // массив источников
        sectionId,            // 'security' | 'power' | ...
        subtitle,             // подпись сверху (опционально)
        initialSourceId       // с какого источника начать (опционально)
      }
   
      Возвращает объект с методом destroy().
      ============================================================ */
   export function renderSources(opts) {
     const {
       host,
       sources,
       sectionId,
       subtitle = null,
       initialSourceId = null
     } = opts;
   
     if (!host) return { destroy() {} };
     if (!Array.isArray(sources) || !sources.length) {
       host.innerHTML = '<div class="apps-empty">Нет источников</div>';
       return { destroy() {} };
     }
   
     const st = {
       sourceId: initialSourceId || sources[0].id,
       dataCache: {}
     };
   
     /* ---------- Общий каркас ---------- */
     host.innerHTML = '';
   
     const wrap = document.createElement('div');
     wrap.className = 'opt-root';
     host.appendChild(wrap);
   
     if (subtitle) {
       const title = document.createElement('div');
       title.className = 'opt-extra-header';
       title.innerHTML = `
         <div class="opt-extra-title">${escapeHtml(subtitle)}</div>
         <div class="opt-extra-desc">Твики с парными кнопками отмены (↩)</div>
       `;
       wrap.appendChild(title);
     }
   
     const srcNav = document.createElement('div');
     srcNav.className = 'opt-src-nav';
     wrap.appendChild(srcNav);
   
     const srcBody = document.createElement('div');
     srcBody.className = 'opt-src-body';
     wrap.appendChild(srcBody);
   
     /* ---------- Кнопки источников ---------- */
     for (const s of sources) {
       const btn = document.createElement('button');
       btn.type = 'button';
       btn.className = 'opt-src-btn' + (s.id === st.sourceId ? ' active' : '');
       btn.dataset.src = s.id;
       btn.innerHTML = `<span class="opt-src-lbl">${escapeHtml(s.label)}</span>`;
       btn.title = s.desc || '';
       btn.addEventListener('click', async () => {
         if (st.sourceId === s.id) return;
         Sound.click();
         st.sourceId = s.id;
         srcNav.querySelectorAll('.opt-src-btn').forEach(b => {
           b.classList.toggle('active', b.dataset.src === s.id);
         });
         srcBody.innerHTML = '';
         clearCheckboxes();
         await renderCurrent();
       });
       srcNav.appendChild(btn);
     }
   
     /* ---------- Рендер текущего источника ---------- */
     async function renderCurrent() {
       const src = sources.find(s => s.id === st.sourceId);
       if (!src) {
         srcBody.innerHTML = '<div class="apps-empty">Источник не выбран</div>';
         return;
       }
   
       let data = st.dataCache[src.id];
       if (data === undefined) {
         srcBody.innerHTML = `<p class="muted" style="padding:20px">Загрузка ${escapeHtml(src.label)}…</p>`;
         try {
           data = await loadSourceData(src);
         } catch (e) {
           srcBody.innerHTML = `<div class="apps-empty" style="padding:20px">Ошибка: ${escapeHtml(e.message)}</div>`;
           return;
         }
         st.dataCache[src.id] = data;
       }
   
       if (!data) {
         srcBody.innerHTML = `<div class="apps-empty" style="padding:20px">Не удалось получить твики ${escapeHtml(src.label)}</div>`;
         return;
       }
   
       srcBody.innerHTML = '';
   
       const mode = state.config.General?.checkbox_display_mode || 'rectangle';
       const cols = parseInt(state.config.Columns?.default || '3', 10) || 3;
       const showCancelButton = state.config.General?.show_cancel_buttons !== false;
   
       /* ---------- Плоский источник ---------- */
       if (data.kind === 'flat') {
         /* Имя папки отмены: если в JSON был ключ — используем его,
            иначе пробуем «отмена» (при отсутствии папки cancelPath всё
            равно не будет использоваться, т.к. pairMap пуст). */
         const cancelDirName = data.cancelKey || 'отмена';
   
         const items = buildItems({
           files: data.rootFiles,
           cancelFiles: data.cancelFiles || [],
           cancelDirName,
           baseDir: src.baseDir,
           category: src.label,
           flatCategories: true,   // flat всегда кладёт файлы в baseDir
           isFlat: true
         });
   
         renderCheckboxGrid(srcBody, {
           items,
           tabId: `${sectionId}:${src.id}:root`,
           sectionId,
           mode,
           columns: cols,
           showCancelButton
         });
         return;
       }
   
       /* ---------- Группированный источник ---------- */
       const categories = Object.keys(data.categories);
       if (!categories.length) {
         srcBody.innerHTML = '<div class="apps-empty">Категорий не найдено</div>';
         return;
       }
   
       const subNav = document.createElement('div');
       subNav.className = 'sub-tabs-nav';
       srcBody.appendChild(subNav);
   
       const catsHost = document.createElement('div');
       srcBody.appendChild(catsHost);
   
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
   
         const items = buildItems({
           files,
           cancelFiles,
           cancelDirName,
           baseDir: src.baseDir,
           category: cat,
           flatCategories: !!src.flatCategories,
           isFlat: false
         });
   
         renderCheckboxGrid(catContainer, {
           items,
           tabId: `${sectionId}:${src.id}:${cat}`,
           sectionId,
           mode,
           columns: cols,
           showCancelButton
         });
       }
     }
   
     renderCurrent();
   
     return {
       destroy() {
         host.innerHTML = '';
       }
     };
   }
   
   /* ============================================================
      Хелпер
      ============================================================ */
   export function escapeHtml(s) {
     return String(s)
       .replace(/&/g, '&amp;').replace(/</g, '&lt;')
       .replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/'/g, '&#39;');
   }