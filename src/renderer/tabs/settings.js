import {
  state, toast, Sound, clearBackground,
  reapplyTheme, reapplyFontsAndShape, applyWallpaperAsBackground,
  navigate,
  setUiStyle
} from '../app.js';
import {
  THEMES_META, THEMES, applyVisualEffect,
  FONT_HEADING_LATIN_OPTIONS, FONT_HEADING_CYR_OPTIONS,
  FONT_BODY_LATIN_OPTIONS, FONT_BODY_CYR_OPTIONS,
  FONT_MONO_OPTIONS, DENSITY_OPTIONS, FONT_SIZE_OPTIONS,
  applyFonts, applyDensity, applyCornerRadius
} from '../themes.js';
import { STYLES } from '../styles/style-loader.js';
import { buildToolsSection } from './settings-tools.js';

export async function renderSettings() {
  const tabsNav = document.getElementById('tabs-nav');
  const content = document.getElementById('tab-content');
  tabsNav.innerHTML = ''; content.innerHTML = '';

  const cfg = state.config;

  const wrap = document.createElement('div');
  wrap.className = 'settings-page';
  content.appendChild(wrap);

  const header = document.createElement('div');
  header.className = 'settings-header';
  header.innerHTML = `
    <h2 style="margin:0;font-size:18px;font-weight:700;color:var(--accent)">⚙ Настройки</h2>
    <span class="muted" style="font-size:11px">Настрой внешний вид и поведение приложения</span>
  `;
  wrap.appendChild(header);

  const SUBTABS = [
    { id: 'appearance', label: '🎨 Внешний вид' },
    { id: 'fonts',      label: '🔤 Шрифты' },
    { id: 'interface',  label: '🖥 Интерфейс' },
    { id: 'tools',      label: '🛠 Утилиты' },
    { id: 'wallpapers', label: '🖼 Обои' },
    { id: 'about',      label: 'ℹ О программе' }
  ];

  let currentSubtab = 'appearance';

  const subNav = document.createElement('div');
  subNav.className = 'settings-subtabs';
  wrap.appendChild(subNav);

  const host = document.createElement('div');
  host.className = 'settings-subtabs-host';
  wrap.appendChild(host);

  for (const st of SUBTABS) {
    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'settings-subtab-btn' + (st.id === currentSubtab ? ' active' : '');
    btn.dataset.tab = st.id;
    btn.textContent = st.label;
    btn.addEventListener('click', () => {
      Sound.click();
      subNav.querySelectorAll('.settings-subtab-btn').forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      currentSubtab = st.id;
      renderSubtab();
    });
    subNav.appendChild(btn);
  }

  function renderSubtab() {
    host.innerHTML = '';
    if (currentSubtab === 'appearance') host.appendChild(sectionAppearance());
    else if (currentSubtab === 'fonts')     host.appendChild(sectionFonts());
    else if (currentSubtab === 'interface') host.appendChild(sectionInterface());
    else if (currentSubtab === 'tools')     host.appendChild(sectionTools());
    else if (currentSubtab === 'wallpapers') sectionWallpapers(host);
    else if (currentSubtab === 'about')     host.appendChild(sectionAbout());
  }

  /* ================== ВНЕШНИЙ ВИД ================== */
  function sectionAppearance() {
    const frag = document.createElement('div');

    // ← NEW: выбор CSS-стиля (первым делом)
    frag.appendChild(section('🖌 Стиль оформления', [
      styleSelector(),
      hint(
        'Меняет всю визуальную оболочку приложения: формы, тени, анимации, ' +
        'отступы, декоративные элементы. <b>Цвета берутся из темы</b> ' +
        '(блок «Тема» ниже) — стиль и тема работают независимо.'
      )
    ]));

    frag.appendChild(section('🎨 Тема', [
      themePicker(cfg.General?.theme || 'material3')
    ]));

    frag.appendChild(section('✨ Эффект стекла', [
      effectSelector(),
      hint('Полупрозрачность и размытие. <b>Glass</b> — работает везде, ' +
           '<b>Aero</b> — только на Windows 11 (Mica/Acrylic).')
    ]));

    frag.appendChild(section('🌫 Прозрачность', [
      opacityField('Прозрачность боковой панели', 'General.sidebar_opacity',
        cfg.General?.sidebar_opacity ?? 75)
    ]));

    frag.appendChild(section('🎛 Кнопки', [
      toggleField('Единый цвет всех кнопок', 'General.unified_button_color',
        !!cfg.General?.unified_button_color,
        'Все кнопки окрашиваются в цвет акцента темы')
    ]));

    return frag;
  }

  /* ================== ШРИФТЫ ================== */
  function sectionFonts() {
    const frag = document.createElement('div');
    const g = cfg.General || {};

    frag.appendChild(section('🔠 Шрифт заголовков', [
      hint('Заголовки в приложении. Пиксельные шрифты (Jersey 10, Pixelify Sans, ' +
           'Press Start 2P, VT323) содержат только латиницу — для русских букв ' +
           'используется fallback-шрифт ниже.<br><br>' +
           '<b>★</b> — variable-шрифты: поддерживают тонкую настройку веса (100–900) ' +
           'одним файлом.'),
      fontSelectField(
        'Заголовки — латиница (Aa Bb Cc)',
        'General.font_heading_latin',
        g.font_heading_latin || 'Jersey 10',
        FONT_HEADING_LATIN_OPTIONS
      ),
      fontSelectField(
        'Заголовки — кириллица (Аа Бб Вв)',
        'General.font_heading_cyr',
        g.font_heading_cyr || 'IBM Plex Mono',
        FONT_HEADING_CYR_OPTIONS
      ),
      numberField('Размер заголовков (px)', 'General.heading_font_size',
        g.heading_font_size || 15, { min: 10, max: 32 }),
      weightSlider('Вес заголовков (100–900)', 'General.heading_font_weight',
        g.heading_font_weight ?? 700),
      previewField('Пример заголовка', 'heading')
    ]));

    frag.appendChild(section('🔡 Шрифт основного текста', [
      hint('Текст карточек, кнопок, описаний. Для русских букв используется ' +
           'отдельный шрифт — пиксельные шрифты не имеют кириллицы.'),
      fontSelectField(
        'Текст — латиница (Aa Bb Cc)',
        'General.font_body_latin',
        g.font_body_latin || 'Pixelify Sans',
        FONT_BODY_LATIN_OPTIONS
      ),
      fontSelectField(
        'Текст — кириллица (Аа Бб Вв)',
        'General.font_body_cyr',
        g.font_body_cyr || 'IBM Plex Mono',
        FONT_BODY_CYR_OPTIONS
      ),
      numberField('Размер основного текста (px)', 'General.body_font_size',
        g.body_font_size || 13, { min: 10, max: 22 }),
      weightSlider('Вес основного текста (100–900)', 'General.body_font_weight',
        g.body_font_weight ?? 400),
      previewField('Пример основного текста', 'body')
    ]));

    frag.appendChild(section('⌨️ Моноширинный шрифт', [
      hint('Используется в логах, коде, путях и таблицах.'),
      fontSelectField(
        'Моно-шрифт',
        'General.font_mono',
        g.font_mono || 'JetBrains Mono',
        FONT_MONO_OPTIONS
      ),
      previewField('Пример моно', 'mono')
    ]));

    frag.appendChild(section('📐 Форма и плотность', [
      selectField('Плотность интерфейса', 'General.ui_density',
        g.ui_density || 'comfortable',
        DENSITY_OPTIONS.map(o => o.id),
        { labels: Object.fromEntries(DENSITY_OPTIONS.map(o => [o.id, o.label])) }
      ),
      cornerRadiusField('Скругление углов', 'General.corner_radius',
        g.corner_radius ?? 12),
      hint('M3 Shape Scale: 0 — острые углы, 28 — максимально округлённые. ' +
           '<b>Стиль «Pixel»</b> игнорирует этот параметр — там всегда острые углы.')
    ]));

    return frag;
  }

  /* ================== ИНТЕРФЕЙС ================== */
  function sectionInterface() {
    const frag = document.createElement('div');

    frag.appendChild(section('📋 Чекбоксы', [
      selectField('Режим чекбоксов', 'General.checkbox_display_mode',
        cfg.General?.checkbox_display_mode,
        ['regular', 'rectangle', 'wide', 'expandable'],
        {
          labels: {
            'regular':    'Hone',
            'rectangle':  'All Tweaker',
            'wide':       'BoosterX',
            'expandable': 'Sapphire'
          }
        }),
      numberField('Колонок по умолчанию', 'Columns.default', cfg.Columns?.default ?? 3),

      // ─── NEW ─────────────────────────────────────────────────
      toggleField(
        'Разрешить выделение чекбоксов',
        'General.checkbox_selection_enabled',
        !!cfg.General?.checkbox_selection_enabled,
        'Включено — можно кликать по карточкам твиков, чтобы выделить их ' +
        'и применить пакетом. Выключено — чекбоксы отображаются, но неактивны, ' +
        'случайно включить твик нельзя. ' +
        '<b>Применяется при следующем переходе на вкладку с твиками.</b>'
      )
      // ─────────────────────────────────────────────────────────
    ]));

    frag.appendChild(section('🔊 Звук', [soundToggle(), soundVolume()]));

    frag.appendChild(section('🚀 Запуск твиков', [
      selectField('Способ запуска', 'General.tweak_execution_mode',
        cfg.General?.tweak_execution_mode,
        ['default', 'no_launcher', 'launcher', 'powerrun', 'nsudolg', 'cmd'],
        {
          labels: {
            'default':     'По умолчанию',
            'no_launcher': 'Без лаунчера',
            'launcher':    'launcher.exe',
            'powerrun':    'PowerRun.exe',
            'nsudolg':     'NSudoLG.exe (TrustedInstaller)',
            'cmd':         'cmd.exe'
          }
        }),
      numberField('Таймаут твика (сек)', 'General.tweak_timeout_ms',
        Math.round((cfg.General?.tweak_timeout_ms ?? 300000) / 1000),
        { min: 10, max: 3600, factor: 1000 }),
      hint('Как именно запускать твики. По умолчанию — <b>cmd /c</b> в фоне без окон. ' +
           'Таймаут — сколько ждать до принудительного убийства процесса.')
    ]));

    frag.appendChild(section('↩ Кнопки отмены', [
      toggleField('Показывать кнопки отмены',
        'General.show_cancel_buttons',
        cfg.General?.show_cancel_buttons !== false,
        'Рядом с твиками, у которых есть парный файл отмены, показывать кнопку ↩ для быстрого отката. ' +
        'Работает во вкладках XOS / ReviOS / Atlas / VainOS и других наборах.')
    ]));

    frag.appendChild(section('⚡ Загрузка вкладок', [
      toggleField(
        'Динамическая загрузка (lazy)',
        'General.lazy_tabs',
        cfg.General?.lazy_tabs !== false,
        'Включено — вкладки грузятся по требованию, при открытии. ' +
        'Выключено — приложение прогреет тяжёлые данные до показа интерфейса. ' +
        '<b>Требуется перезапуск.</b>'
      ),
      toggleField(
        'Предзагружать тяжёлые вкладки',
        'General.preload_heavy_tabs',
        cfg.General?.preload_heavy_tabs !== false,
        'В фоне загружать данные для «Автозагрузка» и «Приложения». ' +
        '<b>Требуется перезапуск.</b>'
      ),
      toggleField(
        'Показывать экран загрузки',
        'General.show_splash',
        cfg.General?.show_splash !== false,
        'Заставка с логотипом и прогресс-баром при запуске.'
      ),
      hint('Изменения загрузки применяются при следующем запуске приложения.')
    ]));

    frag.appendChild(section('📟 Логи', [
      toggleField('Вести логи',
        'General.logs_enabled',
        !!cfg.General?.logs_enabled,
        'Запись действий и ошибок в файлы.'),
      hint('Переключение применяется мгновенно, без перезапуска.')
    ]));

    frag.appendChild(section('🛡 Вкладка «Безопасность»', [
      toggleField(
        'Автоматически запускать аудиты',
        'General.security_auto_audit',
        cfg.General?.security_auto_audit !== false,
        'Включено — при заходе на вкладку «Безопасность» (и её под-вкладки ' +
        '«Приватность», «Удобство») аудит запускается автоматически. ' +
        'Выключено — аудит запускается только по кнопке <b>«▶ Запустить аудит»</b>.'
      ),
      hint('Авто-аудит может замедлить первый заход на вкладку — он запускает ' +
           'несколько PowerShell-скриптов.')
    ]));

    frag.appendChild(section('🌐 Сетевой монитор', [
      selectField('Отображение сайтов (Hostname)', 'General.netmon_host_mode',
        cfg.General?.netmon_host_mode || 'ptr',
        ['none', 'ptr', 'brand'],
        {
          labels: {
            'none':  'Скрыть (только IP)',
            'ptr':   'Показывать ссылки (1e100.net)',
            'brand': 'Показывать бренды (Google, Telegram)'
          },
          onChange: (v) => {
             state.dataCache.netmon = null;
             navigate('security');
          }
        }),
      hint('Настройка вступает в силу сразу после перезагрузки вкладки «Безопасность». ' +
           '<br><b>Скрыть</b> — оставить только IP.' +
           '<br><b>Ссылки</b> — стандартные PTR-записи (cloudfront.net).' +
           '<br><b>Бренды</b> — Google, YouTube, Telegram (запрашивается у ip-api.com).')
    ]));

    return frag;
  }

  /* ================== УТИЛИТЫ ================== */
  function sectionTools() {
    return buildToolsSection();
  }

  /* ================== ОБОИ ================== */
  async function sectionWallpapers(host) {
    const s = document.createElement('section');
    s.className = 'settings-section';
    const head = document.createElement('h3');
    head.className = 'settings-section-title';
    head.textContent = '🖼️ Обои';
    s.appendChild(head);

    const body = document.createElement('div');
    body.className = 'settings-section-body';
    s.appendChild(body);

    let lastDir = state.config.General?.wallpaper_last_dir || '';
    if (!lastDir) {
      try { lastDir = await window.api.app.userDataPath(); } catch { lastDir = ''; }
    }

    const dirBar = document.createElement('div');
    dirBar.style.display = 'flex';
    dirBar.style.gap = '8px';
    dirBar.style.alignItems = 'center';
    dirBar.style.padding = '8px 10px';
    dirBar.style.background = 'color-mix(in srgb, var(--bg-alt) 60%, transparent)';
    dirBar.style.borderRadius = '6px';
    dirBar.style.fontSize = '11px';
    dirBar.style.marginBottom = '8px';

    const dirLabel = document.createElement('span');
    dirLabel.className = 'muted';
    dirLabel.style.flex = '1';
    dirLabel.style.overflow = 'hidden';
    dirLabel.style.textOverflow = 'ellipsis';
    dirLabel.style.whiteSpace = 'nowrap';
    dirLabel.textContent = '📁 ' + (lastDir || '(папка не выбрана)');
    dirLabel.title = lastDir || '';
    dirBar.appendChild(dirLabel);

    const chooseDirBtn = document.createElement('button');
    chooseDirBtn.type = 'button';
    chooseDirBtn.className = 'btn';
    chooseDirBtn.style.fontSize = '11px';
    chooseDirBtn.style.padding = '4px 10px';
    chooseDirBtn.textContent = '📂 Сменить папку';
    chooseDirBtn.addEventListener('click', async () => {
      Sound.click();
      const folder = await window.api.dialog.pickFolder({
        title: 'Выберите папку с обоями',
        defaultPath: lastDir || undefined
      });
      if (!folder) return;
      lastDir = folder;
      state.config.General = state.config.General || {};
      state.config.General.wallpaper_last_dir = folder;
      await window.api.config.set('General.wallpaper_last_dir', folder);
      dirLabel.textContent = '📁 ' + folder;
      dirLabel.title = folder;
      toast('Папка сохранена', 'success', 1500);
    });
    dirBar.appendChild(chooseDirBtn);
    body.appendChild(dirBar);

    const toolbar = document.createElement('div');
    toolbar.className = 'wallpaper-toolbar';
    toolbar.innerHTML = `
      <button class="btn" id="wp-add-files">📁 Добавить файлы</button>
      <button class="btn" id="wp-add-url">🔗 Загрузить по ссылке</button>
      <button class="btn" id="wp-open-folder">📂 Открыть папку обоев</button>
      <button class="btn danger" id="wp-clear">✕ Убрать фон</button>
    `;
    body.appendChild(toolbar);

    const grid = document.createElement('div');
    grid.className = 'wallpaper-grid';
    body.appendChild(grid);

    const status = document.createElement('div');
    status.className = 'muted';
    status.style.fontSize = '11px';
    status.style.marginTop = '8px';
    body.appendChild(status);

    async function reload() {
      grid.innerHTML = '<div class="muted">Загрузка...</div>';
      const data = await window.api.wallpapers.list();
      grid.innerHTML = '';

      const all = [
        ...data.bundled.map(w => ({ ...w, tag: 'Встроенные' })),
        ...data.user.map(w => ({ ...w, tag: 'Мои' }))
      ];

      if (!all.length) {
        grid.innerHTML = '<div class="muted">Пока ни одной обоины. Добавь файлы или загрузи по ссылке.</div>';
        status.textContent = 'Папка: ' + data.userDir;
        return;
      }

      for (const w of all) {
        const card = document.createElement('div');
        card.className = 'wallpaper-card';
        card.innerHTML = `
          <img src="file://${w.path.replace(/\\/g, '/')}?t=${Date.now()}" alt="">
          <div class="wallpaper-name" title="${w.name}">${w.name}</div>
          <div class="wallpaper-actions">
            <button class="btn success" data-role="apply">Применить</button>
            ${w.source === 'user' ? '<button class="btn danger" data-role="del">Удалить</button>' : ''}
          </div>
        `;
        card.querySelector('[data-role="apply"]').addEventListener('click', async () => {
          Sound.click();
          const ok = await applyWallpaperAsBackground(w.path);
          if (ok) { Sound.success(); toast('Обои применены', 'success'); }
          else toast('Не удалось применить', 'error');
        });
        const delBtn = card.querySelector('[data-role="del"]');
        if (delBtn) {
          delBtn.addEventListener('click', async () => {
            if (!confirm(`Удалить «${w.name}»?`)) return;
            const ok = await window.api.wallpapers.remove(w.path);
            if (ok) { toast('Удалено', 'success', 1200); reload(); }
            else toast('Не удалось удалить', 'error');
          });
        }
        grid.appendChild(card);
      }
      status.textContent = `Всего: ${all.length}. Папка: ${data.userDir}`;
    }

    toolbar.querySelector('#wp-add-files').addEventListener('click', async () => {
      Sound.click();
      const files = await window.api.dialog.pickFiles({
        title: 'Выберите обои (можно несколько)',
        defaultPath: lastDir || undefined,
        filters: [{ name: 'Изображения', extensions: ['png', 'jpg', 'jpeg', 'bmp', 'webp', 'gif'] }],
        properties: ['openFile', 'multiSelections']
      });
      if (!files || !files.length) return;

      try {
        const firstDir = files[0].replace(/[\\/][^\\/]+$/, '');
        if (firstDir) {
          lastDir = firstDir;
          state.config.General = state.config.General || {};
          state.config.General.wallpaper_last_dir = firstDir;
          await window.api.config.set('General.wallpaper_last_dir', firstDir);
          dirLabel.textContent = '📁 ' + firstDir;
          dirLabel.title = firstDir;
        }
      } catch { /* ignore */ }

      let added = 0, failed = 0;
      for (const f of files) {
        try {
          const saved = await window.api.wallpapers.addFromFile(f);
          if (saved) added++; else failed++;
        } catch { failed++; }
      }

      if (added > 0) {
        Sound.success();
        toast(`Добавлено: ${added}${failed ? ' · ошибок: ' + failed : ''}`,
              failed ? 'warning' : 'success', 3000);
        reload();
      } else {
        Sound.error();
        toast('Не удалось добавить ни одной обоины', 'error', 4000);
      }
    });

    toolbar.querySelector('#wp-add-url').addEventListener('click', async () => {
      Sound.click();
      const url = prompt('Введите прямую ссылку на изображение (https://...)');
      if (!url) return;
      toast('Скачивание...', 'info', 2000);
      const saved = await window.api.wallpapers.addFromUrl(url, 'from_url');
      if (saved) { toast('Скачано', 'success'); reload(); }
      else toast('Ошибка загрузки', 'error', 5000);
    });

    toolbar.querySelector('#wp-open-folder').addEventListener('click', async () => {
      Sound.click();
      try {
        if (typeof window.api.wallpapers.openFolder === 'function') {
          await window.api.wallpapers.openFolder();
        }
      } catch (e) {
        toast('Не удалось открыть папку: ' + e.message, 'error');
      }
    });

    toolbar.querySelector('#wp-clear').addEventListener('click', async () => {
      Sound.click();
      await clearBackground();
      toast('Фон убран', 'success', 1500);
    });

    await reload();
    host.appendChild(s);
  }

  /* ================== О ПРОГРАММЕ ================== */
  function sectionAbout() {
    const frag = document.createElement('div');
    const s = document.createElement('section');
    s.className = 'settings-section';
    s.innerHTML = `
      <h3 class="settings-section-title">🩸 Anton Vampire</h3>
      <div class="settings-section-body" style="font-size:12px;line-height:1.6">
        <div><b>Версия:</b> <span id="about-version">…</span></div>
        <div><b>Движок:</b> Electron + Node.js</div>
        <div><b>Стиль:</b> Material 3 (Material You)</div>
        <div><b>Режим:</b> Портативный (данные рядом с приложением)</div>
        <div><b>Автор:</b> Anton18-PNG</div>
        <div><b>Сайт:</b>
          <a href="#" id="about-site" style="color:var(--accent)">anton18-png.github.io/Extreme</a>
        </div>
        <div><b>Telegram:</b>
          <a href="#" id="about-tg" style="color:var(--accent)">@all_tweaker</a>
        </div>
        <div style="margin-top:12px;opacity:0.8">
          Anton Vampire — твой игровой оптимизатор Windows.
        </div>
      </div>
    `;
    frag.appendChild(s);

    setTimeout(async () => {
      try {
        const v = await window.api.app.version();
        const el = s.querySelector('#about-version');
        if (el) el.textContent = 'v' + v;
      } catch { /* ignore */ }
    }, 0);

    s.querySelector('#about-site')?.addEventListener('click', (e) => {
      e.preventDefault();
      window.api.shell.openExternal('https://anton18-png.github.io/Anton-Vampire/web/index.html');
    });
    s.querySelector('#about-tg')?.addEventListener('click', (e) => {
      e.preventDefault();
      window.api.shell.openExternal('https://t.me/all_tweaker');
    });

    const resetWrap = document.createElement('div');
    resetWrap.className = 'settings-reset-wrap';
    resetWrap.style.marginTop = '14px';
    const reset = document.createElement('button');
    reset.className = 'btn danger';
    reset.textContent = '↺ Сбросить все настройки';
    reset.addEventListener('click', async () => {
      Sound.click();
      if (!confirm('Сбросить все настройки? Приложение перезагрузится.')) return;
      await window.api.config.reset();
      location.reload();
    });
    resetWrap.appendChild(reset);
    frag.appendChild(resetWrap);

    return frag;
  }

  /* ==================== Общие хелперы ==================== */

  function section(title, fields) {
    const s = document.createElement('section');
    s.className = 'settings-section';
    const head = document.createElement('h3');
    head.className = 'settings-section-title';
    head.textContent = title;
    s.appendChild(head);
    const body = document.createElement('div');
    body.className = 'settings-section-body';
    for (const f of fields) body.appendChild(f);
    s.appendChild(body);
    return s;
  }

  function hint(html) {
    const el = document.createElement('div');
    el.className = 'muted';
    el.style.fontSize = '11px';
    el.style.lineHeight = '1.5';
    el.innerHTML = html;
    return el;
  }

  /* ---------- выбор CSS-стиля ---------- */
  function styleSelector() {
    const wrap = document.createElement('div');
    wrap.className = 'style-picker';
  
    const current = cfg.General?.ui_style || 'default';
  
    const INFO = {
      default:   { icon: '🎨', title: 'Material 3',         desc: 'Стандарт: скруглённые углы, мягкие тени' },
      pixel:     { icon: '🕹', title: 'Pixel Style',        desc: '8-bit ретро: острые углы, ступенчатые анимации' },
      material3: { icon: '✨', title: 'Material You',       desc: 'Полный M3: круглые кнопки, elevation, state layers' },
      kitty:     { icon: '🎀', title: 'Pretty Kitty Pixel', desc: 'Милый пиксельный стиль с пастельными акцентами ♥' },
      cyberpunk: { icon: '🌆', title: 'Cyberpunk 2077',     desc: 'Неон, сканлайны, острые углы и жёлто-красные акценты' },
      minipunk:  { icon: '📟', title: 'Mini Punk',          desc: 'Ультра-компактный киберпанк: максимальная плотность UI, мелкие шрифты, минимум отступов' },
      altpunk:   { icon: '⚡', title: 'Alt Punk',           desc: 'Альтернативный компактный киберпанк: переработанная сетка, агрессивные срезы и высокая контрастность' },
    };

    const grid = document.createElement('div');
    grid.className = 'style-picker-grid';
    wrap.appendChild(grid);

    const cards = [];

    const apply = async (id) => {
      Sound.click();
      await setUiStyle(id);
      for (const c of cards) c.el.classList.toggle('active', c.id === id);
      Sound.success();
      toast('Стиль: ' + (INFO[id]?.title || id), 'success', 1200);
    };

    for (const [id, info] of Object.entries(INFO)) {
      const card = document.createElement('button');
      card.type = 'button';
      card.className = 'style-card' + (id === current ? ' active' : '');
      card.dataset.style = id;
      card.innerHTML = `
        <div class="style-card-icon">${info.icon}</div>
        <div class="style-card-title">${info.title}</div>
        <div class="style-card-desc">${info.desc}</div>
      `;
      card.addEventListener('click', () => apply(id));
      grid.appendChild(card);
      cards.push({ id, el: card });
    }

    return wrap;
  }

  /* ---------- выбор шрифта с превью ---------- */
  function fontSelectField(label, key, value, options) {
    const wrap = document.createElement('div');
    wrap.className = 'field';
    wrap.innerHTML = `<label class="field-label">${label}</label>`;

    const row = document.createElement('div');
    row.style.display = 'flex';
    row.style.gap = '8px';
    row.style.alignItems = 'center';

    const sel = document.createElement('select');
    sel.className = 'field-control';
    sel.style.flex = '1';

    for (const opt of options) {
      const o = document.createElement('option');
      o.value = opt.id;
      o.textContent = opt.label;
      if (String(value) === String(opt.id)) o.selected = true;
      sel.appendChild(o);
    }
    if (sel.selectedIndex < 0 && options.length) sel.selectedIndex = 0;

    const previewBox = document.createElement('span');
    previewBox.style.cssText = `
      display: inline-flex; align-items: center; justify-content: center;
      min-width: 90px; height: 34px; padding: 0 10px;
      background: color-mix(in srgb, var(--bg-alt) 60%, transparent);
      border: 1px solid color-mix(in srgb, var(--border) 30%, transparent);
      border-radius: var(--radius-sm, 8px);
      font-size: 13px;
      color: var(--fg);
      white-space: nowrap;
      overflow: hidden;
    `;
    previewBox.textContent = 'Aa Аа 123';
    previewBox.style.fontFamily = `'${sel.value}', 'IBM Plex Mono', monospace`;

    sel.addEventListener('change', async () => {
      Sound.click();
      const v = sel.value;
      await window.api.config.set(key, v);

      const [sec, sub] = key.split('.');
      if (state.config[sec]) state.config[sec][sub] = v;

      previewBox.style.fontFamily = `'${v}', 'IBM Plex Mono', monospace`;

      const g = state.config.General || {};
      applyFonts(g);
      toast('Шрифт сохранён: ' + v, 'success', 1200);
    });

    row.appendChild(sel);
    row.appendChild(previewBox);
    wrap.appendChild(row);
    return wrap;
  }

  /* ---------- превью для секции ---------- */
  function previewField(title, kind) {
    const box = document.createElement('div');
    box.style.cssText = `
      padding: 12px 14px;
      background: color-mix(in srgb, var(--card) 80%, transparent);
      border: 1px dashed color-mix(in srgb, var(--border) 40%, transparent);
      border-radius: var(--radius-md, 12px);
      margin-top: 6px;
    `;

    const t = document.createElement('div');
    t.className = 'muted';
    t.style.fontSize = '10.5px';
    t.style.marginBottom = '6px';
    t.textContent = title;
    box.appendChild(t);

    const sample = document.createElement('div');
    if (kind === 'heading') {
      sample.style.cssText = `
        font-family: var(--font-heading, 'Jersey 10', 'IBM Plex Mono', monospace);
        font-size: var(--heading-font-size, 15px);
        font-weight: var(--heading-font-weight, 700);
        color: var(--accent);
        line-height: 1.3;
      `;
      sample.textContent = 'Anton Vampire — Оптимизация Windows 12345';
    } else if (kind === 'body') {
      sample.style.cssText = `
        font-family: var(--font-body, 'Pixelify Sans', 'IBM Plex Mono', sans-serif);
        font-size: var(--body-font-size, 13px);
        font-weight: var(--body-font-weight, 400);
        color: var(--fg);
        line-height: 1.5;
      `;
      sample.textContent = 'Быстрая настройка системы: твики, службы, автозагрузка. The quick brown fox jumps over the lazy dog. 12345';
    } else {
      sample.style.cssText = `
        font-family: var(--font-mono, 'JetBrains Mono', monospace);
        font-size: 12px;
        color: var(--fg);
        background: rgba(0,0,0,.25);
        padding: 6px 8px;
        border-radius: 6px;
        line-height: 1.4;
        white-space: pre;
        overflow-x: auto;
      `;
      sample.textContent = 'C:\\> tweaks\\optimization\\svchost.bat\n[OK] exit code 0';
    }
    box.appendChild(sample);
    return box;
  }

  /* ---------- ползунок веса шрифта ---------- */
  function weightSlider(label, key, value) {
    const wrap = document.createElement('div');
    wrap.className = 'field';
    const head = document.createElement('div');
    head.className = 'field-head';
    head.innerHTML = `<label class="field-label">${label}</label>
      <span class="muted" data-role="val">${value}</span>`;
    wrap.appendChild(head);

    const inp = document.createElement('input');
    inp.type = 'range';
    inp.min = '100'; inp.max = '900'; inp.step = '50';
    inp.value = String(value);
    inp.className = 'field-control';
    const valEl = head.querySelector('[data-role="val"]');

    let timer = null;
    inp.addEventListener('input', () => {
      const v = Number(inp.value);
      valEl.textContent = v;
      document.documentElement.style.setProperty(
        key.includes('heading') ? '--heading-font-weight' : '--body-font-weight',
        String(v)
      );
      if (timer) clearTimeout(timer);
      timer = setTimeout(async () => {
        await window.api.config.set(key, v);
        const [sec, sub] = key.split('.');
        if (state.config[sec]) state.config[sec][sub] = v;
        const g = state.config.General || {};
        applyFonts(g);
      }, 200);
    });
    inp.addEventListener('change', () => Sound.click());
    wrap.appendChild(inp);
    return wrap;
  }

  /* ---------- радиус скругления ---------- */
  function cornerRadiusField(label, key, value) {
    const wrap = document.createElement('div');
    wrap.className = 'field';
    const head = document.createElement('div');
    head.className = 'field-head';
    head.innerHTML = `<label class="field-label">${label}</label>
      <span class="muted" data-role="val">${value}px</span>`;
    wrap.appendChild(head);

    const inp = document.createElement('input');
    inp.type = 'range';
    inp.min = '0'; inp.max = '28'; inp.step = '1';
    inp.value = String(value);
    inp.className = 'field-control';
    const valEl = head.querySelector('[data-role="val"]');

    let timer = null;
    inp.addEventListener('input', () => {
      const v = Number(inp.value);
      valEl.textContent = v + 'px';
      applyCornerRadius(v);
      if (timer) clearTimeout(timer);
      timer = setTimeout(async () => {
        await window.api.config.set(key, v);
        const [sec, sub] = key.split('.');
        if (state.config[sec]) state.config[sec][sub] = v;
      }, 200);
    });
    inp.addEventListener('change', () => Sound.click());
    wrap.appendChild(inp);
    return wrap;
  }

  function effectSelector() {
    const row = document.createElement('div');
    row.className = 'effect-row';
    row.style.display = 'flex';
    row.style.gap = '8px';
    row.style.flexWrap = 'wrap';

    const current = cfg.General?.visual_effect || 'none';

    const OPTIONS = [
      { id: 'none',  label: '🚫 Обычный',  hint: 'Стандартный вид без прозрачности' },
      { id: 'glass', label: '🧊 Glass',    hint: 'Полупрозрачность + blur (везде)' },
      { id: 'aero',  label: '✨ Aero',     hint: 'Mica/Acrylic (только Win 11)' }
    ];

    const cards = [];

    const apply = async (id) => {
      state.config.General = state.config.General || {};
      state.config.General.visual_effect = id;
      await window.api.config.set('General.visual_effect', id);
      applyVisualEffect(id);
      for (const c of cards) {
        c.el.classList.toggle('active', c.id === id);
      }
      Sound.success();
      toast('Эффект: ' + id, 'success', 1200);
    };

    for (const opt of OPTIONS) {
      const el = document.createElement('button');
      el.type = 'button';
      el.className = 'effect-card' + (opt.id === current ? ' active' : '');
      el.innerHTML = `
        <div class="effect-card-label">${opt.label}</div>
        <div class="effect-card-hint">${opt.hint}</div>
      `;
      el.addEventListener('click', () => { Sound.click(); apply(opt.id); });
      row.appendChild(el);
      cards.push({ id: opt.id, el });
    }

    return row;
  }

  function themePicker(current) {
    const wrap = document.createElement('div');
    wrap.className = 'theme-picker';

    const toolbar = document.createElement('div');
    toolbar.className = 'theme-toolbar';
    toolbar.innerHTML = `
      <button class="btn" data-role="collapse">Свернуть все</button>
      <span class="muted" data-role="current"></span>
    `;
    wrap.appendChild(toolbar);

    const currentLabel = toolbar.querySelector('[data-role="current"]');
    const setCurrentLabel = (name) => { currentLabel.textContent = 'Текущая: ' + name; };
    setCurrentLabel(current);

    for (const group of THEMES_META.groups) {
      const themes = group.themes.filter(t => THEMES[t]);
      if (!themes.length) continue;

      const g = document.createElement('div');
      g.className = 'theme-group';

      const head = document.createElement('button');
      head.type = 'button';
      head.className = 'theme-group-head';
      head.innerHTML = `<span>${group.title}</span><span class="chev">▾</span>`;
      g.appendChild(head);

      const grid = document.createElement('div');
      grid.className = 'theme-grid';
      g.appendChild(grid);

      head.addEventListener('click', () => {
        Sound.click();
        g.classList.toggle('collapsed');
        head.querySelector('.chev').textContent = g.classList.contains('collapsed') ? '▸' : '▾';
      });

      for (const name of themes) grid.appendChild(themeTile(name, name === current));
      wrap.appendChild(g);
    }

    toolbar.querySelector('[data-role="collapse"]').addEventListener('click', () => {
      Sound.click();
      const allCollapsed = [...wrap.querySelectorAll('.theme-group')].every(g => g.classList.contains('collapsed'));
      for (const g of wrap.querySelectorAll('.theme-group')) {
        g.classList.toggle('collapsed', !allCollapsed);
        const chev = g.querySelector('.chev');
        if (chev) chev.textContent = !allCollapsed ? '▸' : '▾';
      }
    });

    function themeTile(name, isActive) {
      const t = THEMES[name];
      const tile = document.createElement('button');
      tile.type = 'button';
      tile.className = 'theme-tile' + (isActive ? ' active' : '');
      tile.dataset.theme = name;

      tile.innerHTML = `
        <div class="theme-preview" style="
          --p-bg: ${t.bg};
          --p-card: ${t.card};
          --p-accent: ${t.accent};
          --p-accent2: ${t.accent2};
          --p-fg: ${t.fg};
          --p-border: ${t.border};
        ">
          <div class="tp-top"></div>
          <div class="tp-side"></div>
          <div class="tp-main">
            <div class="tp-row"><div class="tp-dot"></div><div class="tp-line"></div></div>
            <div class="tp-row"><div class="tp-dot"></div><div class="tp-line"></div></div>
            <div class="tp-row"><div class="tp-dot"></div><div class="tp-line"></div></div>
          </div>
        </div>
        <div class="theme-name">${name}</div>
      `;

      tile.addEventListener('click', async () => {
        Sound.click();
        await window.api.config.set('General.theme', name);
        state.config.General = state.config.General || {};
        state.config.General.theme = name;
        reapplyTheme();
        wrap.querySelectorAll('.theme-tile').forEach(x => x.classList.remove('active'));
        tile.classList.add('active');
        setCurrentLabel(name);
        toast('Тема: ' + name, 'success', 1200);
      });

      return tile;
    }

    return wrap;
  }

  function selectField(label, key, value, options, opts = {}) {
    const wrap = document.createElement('div');
    wrap.className = 'field';
    wrap.innerHTML = `<label class="field-label">${label}</label>`;
    const sel = document.createElement('select');
    sel.className = 'field-control';
    const sample = options[0];
    const labels = opts.labels || {};
    for (const opt of options) {
      const o = document.createElement('option');
      o.value = String(opt);
      const display = labels[opt] !== undefined
        ? labels[opt]
        : (typeof opt === 'boolean' ? (opt ? 'Вкл' : 'Выкл') : String(opt));
      o.textContent = display;
      if (String(value) === String(opt)) o.selected = true;
      sel.appendChild(o);
    }
    if (sel.selectedIndex < 0 && options.length) sel.selectedIndex = 0;

    sel.addEventListener('change', async () => {
      Sound.click();
      let v = sel.value;
      if (typeof sample === 'boolean') v = v === 'true';
      else if (typeof sample === 'number') v = Number(v);
      await window.api.config.set(key, v);
      toast('Сохранено: ' + label, 'success', 1500);
      const [sec, sub] = key.split('.');
      if (state.config[sec]) state.config[sec][sub] = v;
      if (typeof opts.onChange === 'function') opts.onChange(v);
    });
    wrap.appendChild(sel);
    return wrap;
  }

  function numberField(label, key, value, opts = {}) {
    const wrap = document.createElement('div');
    wrap.className = 'field';
    wrap.innerHTML = `<label class="field-label">${label}</label>`;
    const inp = document.createElement('input');
    inp.type = 'number';
    inp.min = String(opts.min ?? 1);
    inp.max = String(opts.max ?? 6);
    inp.value = value;
    inp.className = 'field-control';
    inp.addEventListener('change', async () => {
      let v = Number(inp.value) || Number(opts.min ?? 1);
      v = Math.max(Number(opts.min ?? 1), Math.min(Number(opts.max ?? 6), v));
      inp.value = v;

      const stored = opts.factor ? v * opts.factor : v;
      await window.api.config.set(key, stored);
      toast('Сохранено', 'success', 1500);
      const [sec, sub] = key.split('.');
      if (state.config[sec]) state.config[sec][sub] = stored;

      if (key === 'General.body_font_size' || key === 'General.heading_font_size') {
        const g = state.config.General || {};
        applyFonts(g);
      }
    });
    wrap.appendChild(inp);
    return wrap;
  }

  function opacityField(label, key, value) {
    const wrap = document.createElement('div');
    wrap.className = 'field';
    const head = document.createElement('div');
    head.className = 'field-head';
    head.innerHTML = `<label class="field-label">${label}</label>
      <span class="muted" data-role="val">${value}%</span>`;
    wrap.appendChild(head);

    const inp = document.createElement('input');
    inp.type = 'range';
    inp.min = '0'; inp.max = '100'; inp.step = '1';
    inp.value = String(value);
    inp.className = 'field-control';
    const valEl = head.querySelector('[data-role="val"]');

    let timer = null;
    inp.addEventListener('input', () => {
      const v = Number(inp.value);
      valEl.textContent = v + '%';
      document.documentElement.style.setProperty('--sidebar-alpha', String(v / 100));
      if (timer) clearTimeout(timer);
      timer = setTimeout(async () => {
        await window.api.config.set(key, v);
        const [sec, sub] = key.split('.');
        if (state.config[sec]) state.config[sec][sub] = v;
      }, 200);
    });
    inp.addEventListener('change', () => Sound.click());
    wrap.appendChild(inp);
    return wrap;
  }

  function toggleField(label, key, value, hint = '') {
    const row = document.createElement('div');
    row.className = 'toggle-row';
    row.innerHTML = `
      <div class="toggle-info">
        <div class="toggle-title">${label}</div>
        ${hint ? `<div class="toggle-desc">${hint}</div>` : ''}
      </div>
      <div class="toggle ${value ? 'on' : ''}"><div class="toggle-thumb"></div></div>`;
    const t = row.querySelector('.toggle');
    t.addEventListener('click', async () => {
      const nv = !t.classList.contains('on');
      t.classList.toggle('on', nv);
      await window.api.config.set(key, nv);
      const [sec, sub] = key.split('.');
      if (state.config[sec]) state.config[sec][sub] = nv;
  
      if (key === 'General.logs_enabled' && window.api?.logger?.setEnabled) {
        try { await window.api.logger.setEnabled(nv); } catch { /* ignore */ }
      }
  
      // ─── Выделение чекбоксов: мгновенно скрыть/показать всё ───
      if (key === 'General.checkbox_selection_enabled') {
        try { state.checkboxes?.clear?.(); } catch { /* ignore */ }
  
        document.body.classList.toggle('cbx-selection-off', !nv);
  
        for (const id of ['btn-select-all', 'btn-execute']) {
          const el = document.getElementById(id);
          if (el) el.style.display = nv ? '' : 'none';
        }
      }
  
      toast('Сохранено: ' + label, 'success', 1200);
      reapplyTheme();
    });
    return row;
  }

  function soundToggle() {
    const row = document.createElement('div');
    row.className = 'toggle-row';
    row.innerHTML = `
      <div class="toggle-info">
        <div class="toggle-title">Звуки интерфейса</div>
        <div class="toggle-desc">Клики, hover, успех/ошибка</div>
      </div>
      <div class="toggle ${Sound.enabled ? 'on' : ''}"><div class="toggle-thumb"></div></div>`;
    row.querySelector('.toggle').addEventListener('click', (e) => {
      Sound.enabled = !Sound.enabled;
      Sound.save();
      e.currentTarget.classList.toggle('on', Sound.enabled);
      if (Sound.enabled) Sound.success();
    });
    return row;
  }

  function soundVolume() {
    const row = document.createElement('div');
    row.className = 'toggle-row';
    row.innerHTML = `
      <div class="toggle-info">
        <div class="toggle-title">Громкость</div>
        <div class="toggle-desc" id="vol-desc">${Math.round(Sound.volume * 100)}%</div>
      </div>`;
    const inp = document.createElement('input');
    inp.type = 'range';
    inp.min = '0'; inp.max = '100';
    inp.value = String(Math.round(Sound.volume * 100));
    inp.style.maxWidth = '200px';
    inp.addEventListener('input', () => {
      Sound.volume = Number(inp.value) / 100;
      Sound.save();
      row.querySelector('#vol-desc').textContent = inp.value + '%';
    });
    inp.addEventListener('change', () => Sound.click());
    row.appendChild(inp);
    return row;
  }

  renderSubtab();
  applyVisualEffect(cfg.General?.visual_effect || 'none');
}