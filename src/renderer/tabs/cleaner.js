import { state, clearCheckboxes, toast, Sound } from '../app.js';
import {
  logLine, logSeparator,
  loggedRunStream, loggedRunCommandStream
} from '../logger.js';

const CLEANER_DIR = 'src/renderer/tabs/cleaner';
const FIXES_DIR   = 'src/renderer/tabs/fixes';

/* ------------------------------------------------------------
   Иконка по названию/имени файла
   ------------------------------------------------------------ */
function iconForCleaner(item) {
  const t = (String(item.title || '') + ' ' + String(item.file || item.cmd || '')).toLowerCase();

  if (/delivery|optimization/.test(t))                return '🚚';
  if (/indexeddb/.test(t))                            return '🌍';
  if (/winsock|tcp\/ip|сеть|network/.test(t))         return '📡';
  if (/shader|шейдер/.test(t))                        return '🎞';
  if (/nvidia/.test(t))                               return '🎞';
  if (/amd|radeon/.test(t))                           return '🎞';
  if (/intel/.test(t))                                return '🎞';
  if (/directx|d3d/.test(t))                          return '🎞';
  if (/prefetch/.test(t))                             return '⚡';
  if (/log|журнал|event|логи/.test(t))                return '📋';
  if (/dns/.test(t))                                  return '🌐';
  if (/update|обновл|wu|softwaredistribution|edgeupdate/.test(t)) return '🔄';
  if (/winsxs|dism|componentstore/.test(t))           return '💠';
  if (/temp|временн/.test(t))                         return '🗑';
  if (/recycle|корзин/.test(t))                       return '♻️';
  if (/thumb|эскиз|icon|иконок/.test(t))              return '🖼';
  if (/discord/.test(t))                              return '💬';
  if (/steam|epic|game|игров/.test(t))                return '🎮';
  if (/browser|браузер|chrome|edge|firefox|opera|yandex/.test(t)) return '🌍';
  if (/download|загрузк/.test(t))                     return '📥';
  if (/font|шрифт/.test(t))                           return '🅰';
  if (/defender|защитник/.test(t))                    return '🛡';
  if (/dmp|dump|дамп|minidump|memory|crashdump/.test(t)) return '💥';
  if (/wer|отчёт|report/.test(t))                     return '📝';
  if (/hiber|гиберн/.test(t))                         return '💤';
  if (/trim|ssd/.test(t))                             return '💾';
  if (/defrag|дефраг|оптимиз/.test(t))                return '📊';
  if (/xapic|apic/.test(t))                           return '🧩';
  if (/bluestacks/.test(t))                           return '📱';
  if (/spotify/.test(t))                              return '🎵';
  if (/telegram/.test(t))                             return '✈';
  if (/wsreset|store|xbox/.test(t))                   return '🛒';
  if (/inetpub|perflogs|windows_old|windows\.old/.test(t)) return '🗑';
  if (/driver|драйвер/.test(t))                       return '🧩';
  if (/cache|кэш/.test(t))                            return '📦';

  return '🧹';
}

/* ------------------------------------------------------------
   Секции. Каждый item — ОДНО конкретное действие.
     kind: 'bat' — запустить .bat
     kind: 'cmd' — выполнить команду cmd /c
   dir — опционально, папка с .bat (по умолчанию CLEANER_DIR)
   ------------------------------------------------------------ */
const CLEANER_SECTIONS = [

  /* ============================================================
     1. ШЕЙДЕРЫ
     ============================================================ */
  {
    title: '🎞 Кэш шейдеров',
    items: [
      {
        kind: 'bat',
        file: 'shaders_all.bat',
        title: 'Все шейдеры',
        desc: 'Удаляет кэш шейдеров DirectX, NVIDIA, AMD и Intel. Помогает после смены драйвера GPU.',
        recommended: true
      },
      {
        kind: 'bat',
        file: 'shaders_nvidia.bat',
        title: 'Шейдеры NVIDIA',
        desc: 'Только кэш NVIDIA: DXCache и GLCache.'
      },
      {
        kind: 'bat',
        file: 'shaders_amd.bat',
        title: 'Шейдеры AMD',
        desc: 'Только кэш AMD: DxCache.'
      },
      {
        kind: 'bat',
        file: 'shaders_intel.bat',
        title: 'Шейдеры Intel',
        desc: 'Только кэш Intel: ShaderCache.'
      },
      {
        kind: 'bat',
        file: 'shaders_directx.bat',
        title: 'Шейдеры DirectX',
        desc: 'Только D3DSCache — общий кэш DirectX.'
      }
    ]
  },

  /* ============================================================
     2. ЛОГИ И ДАМПЫ
     ============================================================ */
  {
    title: '📋 Логи и дампы',
    items: [
      {
        kind: 'bat',
        file: 'logs_events.bat',
        title: 'Журналы событий',
        desc: 'Очищает все журналы событий Windows (Система, Приложения, Безопасность и т.д.).',
        warning: 'История сбоев и ошибок будет удалена.'
      },
      {
        kind: 'bat',
        file: 'logs_system.bat',
        title: 'Системные логи',
        desc: 'Удаляет *.log, *.old, *.bak из C:\\Windows и подпапок.'
      },
      {
        kind: 'bat',
        file: 'logs_cbs.bat',
        title: 'Логи CBS',
        desc: 'Журналы обслуживания компонентов: C:\\Windows\\Logs\\CBS.'
      },
      {
        kind: 'bat',
        file: 'dumps_memory.bat',
        title: 'Дампы памяти',
        desc: 'Удаляет memory.dmp и Minidump\\*.dmp после BSOD.'
      },
      {
        kind: 'bat',
        file: 'crash_dumps.bat',
        title: 'CrashDumps приложений',
        desc: 'Удаляет %LOCALAPPDATA%\\CrashDumps — дампы упавших программ.'
      },
      {
        kind: 'bat',
        file: 'wer_reports.bat',
        title: 'Отчёты WER',
        desc: 'Windows Error Reporting: ProgramData\\Microsoft\\Windows\\WER.'
      }
    ]
  },

  /* ============================================================
     3. WINDOWS UPDATE
     ============================================================ */
  {
    title: '🔄 Windows Update',
    items: [
      {
        kind: 'bat',
        file: 'wu_cache.bat',
        title: 'Полный сброс WU',
        desc: 'Останавливает wuauserv, UsoSvc, bits. Удаляет SoftwareDistribution целиком.',
        warning: 'Останавливает 3 службы. Windows заново соберёт список обновлений.',
        recommended: true
      },
      {
        kind: 'bat',
        file: 'wu_download.bat',
        title: 'Скачанные обновления',
        desc: 'Удаляет SoftwareDistribution\\Download — скачанные обновления Windows.'
      },
      {
        kind: 'bat',
        file: 'wu_datastore.bat',
        title: 'DataStore обновлений',
        desc: 'Удаляет SoftwareDistribution\\DataStore — база данных обновлений.'
      },
      {
        kind: 'bat',
        file: 'wu_service_restart.bat',
        title: 'Перезапустить WU',
        desc: 'Перезапускает wuauserv, UsoSvc, bits.'
      },
      {
        kind: 'bat',
        file: 'catroot2_reset.bat',
        title: 'Catroot2 (БД подписей)',
        desc: 'Сброс C:\\Windows\\System32\\catroot2 — база подписей обновлений.'
      },
      {
        kind: 'bat',
        file: 'edge_update_cache.bat',
        title: 'Кэш Edge Update',
        desc: 'Удаляет EdgeUpdate\\Download — загрузки обновлений Microsoft Edge.'
      }
    ]
  },

  /* ============================================================
     4. TEMP
     ============================================================ */
  {
    title: '🗑 Temp',
    items: [
      {
        kind: 'bat',
        file: 'temp_user.bat',
        title: 'Temp пользователя',
        desc: 'Чистит %LOCALAPPDATA%\\Temp и %TEMP%. Безопасно.'
      },
      {
        kind: 'bat',
        file: 'temp_windows.bat',
        title: 'Temp Windows',
        desc: 'Чистит C:\\Windows\\Temp с повышением прав.'
      },
      {
        kind: 'bat',
        file: 'temp_all.bat',
        title: 'Обе Temp-папки',
        desc: '%temp% + %windir%\\Temp одновременно.',
        recommended: true
      },
      {
        kind: 'bat',
        file: 'temp_drivers.bat',
        title: 'Temp драйверов',
        desc: 'DriverStore\\Temp, Macromed\\Temp в System32 и SysWOW64.'
      }
    ]
  },

  /* ============================================================
     5. PREFETCH И КОРЗИНА
     ============================================================ */
  {
    title: '⚡ Prefetch и корзина',
    items: [
      {
        kind: 'bat',
        file: 'prefetch.bat',
        title: 'Prefetch',
        desc: 'Удаляет C:\\Windows\\Prefetch. Windows пересоздаст при запуске программ.'
      },
      {
        kind: 'bat',
        file: 'recycle_bin.bat',
        title: 'Корзина',
        desc: 'Удаляет всё из $Recycle.Bin на всех дисках.'
      },
      {
        kind: 'cmd',
        cmd: 'cleanmgr /sagerun:1',
        title: 'cleanmgr (профиль 1)',
        desc: 'Запуск стандартной очистки Windows по сохранённому профилю 1.'
      }
    ]
  },

  /* ============================================================
     6. КЭШ ИКОНОК И ЭСКИЗОВ
     ============================================================ */
  {
    title: '🖼 Кэш иконок и эскизов',
    items: [
      {
        kind: 'bat',
        file: 'thumbcache.bat',
        title: 'Эскизы проводника',
        desc: 'Удаляет thumbcache_*.db. Explorer перезапустится.',
        warning: 'Explorer будет перезапущен.'
      },
      {
        kind: 'bat',
        file: 'iconcache.bat',
        title: 'Кэш иконок',
        desc: 'Удаляет IconCache.db. Полезно, если иконки отображаются неправильно.',
        warning: 'Explorer будет перезапущен.'
      },
      {
        kind: 'bat',
        file: 'iconcache_and_thumb.bat',
        title: 'Иконки + эскизы',
        desc: 'Обновляет и кэш иконок, и thumbcache. Explorer перезапустится.',
        warning: 'Explorer будет перезапущен.'
      }
    ]
  },

  /* ============================================================
     7. СИСТЕМНЫЕ КЭШИ
     ============================================================ */
  {
    title: '📦 Системные кэши',
    items: [
      {
        kind: 'bat',
        file: 'fontcache.bat',
        title: 'Кэш шрифтов',
        desc: 'Останавливает FontCache, чистит кэш шрифтов, запускает службу.'
      },
      {
        kind: 'bat',
        file: 'defender_cache.bat',
        title: 'Кэш Защитника',
        desc: 'Кэш и история сканирования Windows Defender.'
      },
      {
        kind: 'bat',
        file: 'dns_cache.bat',
        title: 'Кэш DNS',
        desc: 'ipconfig /flushdns. Полезно при проблемах с сайтами.'
      },
      {
        kind: 'bat',
        file: 'wsreset.bat',
        title: 'Microsoft Store',
        desc: 'wsreset — сброс кэша Microsoft Store.'
      },
      {
        kind: 'bat',
        file: 'store_cache.bat',
        title: 'Кэш Microsoft Store (папка)',
        desc: 'Удаляет LocalCache Microsoft.WindowsStore.'
      },
      {
        kind: 'bat',
        file: 'explorer_cache.bat',
        title: 'Кэш проводника',
        desc: 'Очищает Bags/BagMRU в реестре — сбрасывает настройки папок.'
      }
    ]
  },

  /* ============================================================
     8. ДИСК И SSD
     ============================================================ */
  {
    title: '💾 Диск и SSD',
    items: [
      {
        kind: 'bat',
        file: 'trim_on.bat',
        title: 'Включить TRIM',
        desc: 'fsutil DisableDeleteNotify 0. Обязательно для SSD.'
      },
      {
        kind: 'bat',
        file: 'trim_off.bat',
        title: 'Отключить TRIM',
        desc: 'fsutil DisableDeleteNotify 1. Только для особых случаев.'
      },
      {
        kind: 'cmd',
        cmd: 'defrag C: /O',
        title: 'Оптимизировать C:',
        desc: 'TRIM для SSD или дефрагментация для HDD.'
      },
      {
        kind: 'bat',
        file: 'winsxs_analyze.bat',
        title: 'Анализ WinSxS',
        desc: 'DISM /AnalyzeComponentStore. Только показывает размер, ничего не удаляет.'
      },
      {
        kind: 'bat',
        file: 'winsxs_cleanup.bat',
        title: 'Очистка WinSxS',
        desc: 'DISM /StartComponentCleanup. Удаляет устаревшие версии компонентов.',
        warning: 'Опасные изменения. Делай точку восстановления.'
      },
      {
        kind: 'bat',
        file: 'winsxs_resetbase.bat',
        title: 'WinSxS + ResetBase',
        desc: 'Дополнительно сбрасывает базу компонентов.',
        warning: 'ResetBase делает невозможным удаление установленных обновлений.'
      },
      {
        kind: 'bat',
        file: 'driver_duplicates.bat',
        title: 'Дубликаты драйверов',
        desc: 'Удаляет старые версии драйверов через PowerShell + pnputil.',
        warning: 'Опасные изменения. Делай точку восстановления.'
      }
    ]
  },

  /* ============================================================
     9. ИГРЫ И ПРИЛОЖЕНИЯ
     ============================================================ */
  {
    title: '🎮 Игры и приложения',
    items: [
      {
        kind: 'bat',
        file: 'discord.bat',
        title: 'Кэш Discord',
        desc: 'Закрывает Discord и чистит Cache, Code Cache, GPUCache.'
      },
      {
        kind: 'bat',
        file: 'steam.bat',
        title: 'Кэш Steam',
        desc: 'htmlcache, appcache, browser cache Steam.'
      },
      {
        kind: 'bat',
        file: 'epic.bat',
        title: 'Кэш Epic Games',
        desc: 'webcache, logs, cached data Epic Games Launcher.'
      },
      {
        kind: 'bat',
        file: 'browsers.bat',
        title: 'Кэш браузеров',
        desc: 'Chrome, Edge, Yandex, Opera, Firefox. Браузеры будут закрыты.',
        warning: 'Браузеры будут принудительно закрыты.'
      }
    ]
  },

  /* ============================================================
     10. УДАЛЕНИЕ СИСТЕМНЫХ ПАПОК
     ============================================================ */
  {
    title: '🗑 Удаление системных папок',
    items: [
      {
        kind: 'bat',
        file: 'windows_old.bat',
        title: 'Windows.old',
        desc: 'Удаляет папку старой установки Windows.',
        warning: 'Откат к предыдущей версии Windows станет невозможен.'
      },
      {
        kind: 'bat',
        file: 'perflogs.bat',
        title: 'PerfLogs',
        desc: 'Удаляет C:\\PerfLogs — логи производительности.'
      },
      {
        kind: 'bat',
        file: 'inetpub.bat',
        title: 'inetpub',
        desc: 'Удаляет C:\\inetpub — корень IIS.',
        warning: 'Если IIS не используется — безопасно.'
      }
    ]
  },

  /* ============================================================
     11. СЕТЬ И СЛУЖБЫ (из fixes)
     ============================================================ */
  {
    title: '🌐 Сеть и службы',
    dir: FIXES_DIR,
    items: [
      {
        kind: 'bat',
        file: 'net_dns_to_auto.bat',
        title: 'DNS в автоматический режим',
        desc: 'Возвращает DNS, вручную прописанные на адаптерах, обратно на DHCP.'
      },
      {
        kind: 'bat',
        file: 'net_winsock_reset.bat',
        title: 'Сброс Winsock',
        desc: 'Сбрасывает каталог Winsock. Лечит проблемы с сокетами и прокси-перехватом.'
      },
      {
        kind: 'bat',
        file: 'net_tcpip_reset.bat',
        title: 'Сброс TCP/IP',
        desc: 'Возвращает стек TCP/IP к заводскому состоянию.'
      },
      {
        kind: 'bat',
        file: 'net_ip_renew.bat',
        title: 'Обновление IP-адреса',
        desc: 'Release + Renew. Переподключает адаптер к DHCP. На пару секунд оборвёт сеть.',
        danger: true
      },
      {
        kind: 'bat',
        file: 'sys_update_cache.bat',
        title: 'Переименование кэша обновлений',
        desc: 'Переименовывает SoftwareDistribution и catroot2 в *.old. Альтернатива полному удалению.',
        recommended: true
      },
      {
        kind: 'bat',
        file: 'store_fix.bat',
        title: 'Microsoft Store / Xbox',
        desc: 'Сбрасывает зависший кэш Microsoft Store и перерегистрирует сервисы Xbox.'
      }
    ]
  },

  /* ============================================================
     12. ПРОЧЕЕ
     ============================================================ */
     {
      title: '🧩 Прочее',
      items: [
        /* --- из CLEANER_DIR --- */
        {
          kind: 'bat',
          file: 'downloads.bat',
          title: 'Очистить Загрузки',
          desc: 'Удаляет всё из %USERPROFILE%\\Downloads.',
          warning: 'Все файлы из папки Загрузки будут удалены без возможности восстановления.',
          danger: true
        },
        {
          kind: 'bat',
          file: 'screenshot_counter.bat',
          title: 'Сбросить счётчик скриншотов',
          desc: 'ScreenshotIndex = 1. Следующий скриншот будет «Снимок экрана (1).png».'
        },
        {
          kind: 'bat',
          file: 'bluestacks_logs.bat',
          title: 'Логи BlueStacks',
          desc: 'ProgramData\\BlueStacks\\Logs и Engine\\Android\\Logs.'
        },
        /* --- из FIXES_DIR --- */
        {
          kind: 'bat',
          dir: FIXES_DIR,
          file: 'clean_delivery_optimization.bat',
          title: 'Delivery Optimization',
          desc: 'Чистит кэш раздачи обновлений между устройствами в локальной сети.'
        },
        {
          kind: 'bat',
          dir: FIXES_DIR,
          file: 'clean_indexeddb.bat',
          title: 'IndexedDB браузеров',
          desc: 'Удаляет локальные данные сайтов (IndexedDB) в Yandex, Chrome и Edge. Профили, закладки и пароли НЕ трогает.',
          danger: true
        }
      ]
    }
  ];

/* ============================================================
   Рендер вкладки
   ============================================================ */
export async function renderCleaner() {
  const tabsNav = document.getElementById('tabs-nav');
  const content = document.getElementById('tab-content');
  tabsNav.innerHTML = '';
  content.innerHTML = '';
  clearCheckboxes();

  const wrap = document.createElement('div');
  wrap.className = 'apps-page';
  content.appendChild(wrap);

  const total = CLEANER_SECTIONS.reduce((n, s) => n + s.items.length, 0);

  /* Header */
  const header = document.createElement('div');
  header.className = 'apps-header';
  header.innerHTML = `
    <div class="apps-title">
      <span class="apps-title-icon">🧹</span>
      <span>Очистка Windows</span>
      <span class="apps-count" id="cleaner-count">${total}</span>
    </div>
    <div class="apps-toolbar">
      <button class="btn" id="cleaner-expand-all">↕ Развернуть все</button>
      <button class="btn" id="cleaner-collapse-all">↕ Свернуть все</button>
    </div>
  `;
  wrap.appendChild(header);

  /* Секции */
  const refs = [];
  for (const sec of CLEANER_SECTIONS) {
    const s = buildSection(sec);
    wrap.appendChild(s.el);
    refs.push(s);
  }

  document.getElementById('cleaner-expand-all')?.addEventListener('click', () => {
    Sound.click();
    for (const s of refs) s.setExpanded(true);
  });
  document.getElementById('cleaner-collapse-all')?.addEventListener('click', () => {
    Sound.click();
    for (const s of refs) s.setExpanded(false);
  });

  /* ============================================================
     Строители
     ============================================================ */

  function buildSection(sec) {
    const el = document.createElement('section');
    el.className = 'apps-detected-section';
    el.style.background = 'color-mix(in srgb, var(--card) 60%, transparent)';
    el.style.borderColor = 'color-mix(in srgb, var(--border) 30%, transparent)';
    el.style.marginBottom = '14px';

    const title = document.createElement('div');
    title.className = 'section-title';
    title.style.marginTop = '0';
    title.style.cursor = 'pointer';
    title.style.userSelect = 'none';
    title.innerHTML = `
      <span class="cleaner-chev">▾</span>
      <span>${sec.title}</span>
      <span class="muted" style="font-weight:400;font-size:11px">· ${sec.items.length}</span>
    `;
    el.appendChild(title);

    const grid = document.createElement('div');
    grid.className = 'apps-grid fixes-grid';
    grid.style.marginTop = '10px';
    for (const item of sec.items) grid.appendChild(makeCard(item, sec));
    el.appendChild(grid);

    const chev = title.querySelector('.cleaner-chev');

    function setExpanded(open) {
      grid.style.display = open ? '' : 'none';
      chev.textContent = open ? '▾' : '▸';
    }

    title.addEventListener('click', () => {
      Sound.hover();
      setExpanded(grid.style.display === 'none');
    });

    return { el, setExpanded };
  }

  function makeCard(item, sec) {
    const card = document.createElement('div');
    card.className = 'apps-card';

    const icon = document.createElement('div');
    icon.className = 'apps-icon';
    icon.textContent = iconForCleaner(item);

    const title = document.createElement('div');
    title.className = 'apps-name';
    title.textContent = item.title;

    const sub = document.createElement('div');
    sub.className = 'apps-sub fix-desc';
    sub.textContent = item.desc || '';

    const badges = document.createElement('div');
    badges.style.cssText = 'display:flex;gap:4px;flex-wrap:wrap;justify-content:center;min-height:14px;margin-top:2px;';

    if (item.recommended) {
      const b = document.createElement('span');
      b.style.cssText = 'font-size:9.5px;font-weight:700;color:var(--success);background:color-mix(in srgb, var(--success) 15%, transparent);border:1px solid color-mix(in srgb, var(--success) 40%, transparent);padding:1px 6px;border-radius:6px;';
      b.textContent = '★ Рекомендуется';
      badges.appendChild(b);
    }
    if (item.danger) {
      const b = document.createElement('span');
      b.style.cssText = 'font-size:9.5px;font-weight:700;color:var(--danger);background:color-mix(in srgb, var(--danger) 15%, transparent);border:1px solid color-mix(in srgb, var(--danger) 40%, transparent);padding:1px 6px;border-radius:6px;';
      b.textContent = '⚠ Опасно';
      badges.appendChild(b);
    } else if (item.warning) {
      const b = document.createElement('span');
      b.style.cssText = 'font-size:9.5px;font-weight:700;color:var(--warning);background:color-mix(in srgb, var(--warning) 15%, transparent);border:1px solid color-mix(in srgb, var(--warning) 40%, transparent);padding:1px 6px;border-radius:6px;';
      b.textContent = '⚠ Внимание';
      badges.appendChild(b);
    }

    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'apps-run';
    btn.textContent = '▶ Запустить';

    if (item.danger) {
      btn.style.background = 'rgba(217,59,59,.15)';
      btn.style.borderColor = 'var(--danger)';
      btn.style.color = 'var(--danger)';
    }

    btn.addEventListener('click', (e) => {
      e.stopPropagation();
      Sound.click();

      if (item.warning || item.danger) {
        const msg =
          `⚠️ ${item.danger ? 'ОПАСНО' : 'ВНИМАНИЕ'}\n\n` +
          `Действие: ${item.title}\n\n` +
          `${item.warning || ''}\n\n` +
          `Продолжить?`;
        if (!confirm(msg)) return;
      } else {
        if (!confirm(`Запустить «${item.title}»?`)) return;
      }

      if (item.kind === 'cmd') {
        runLoggedCmd(item.cmd, item.title, btn);
      } else {
        const dir = item.dir || sec?.dir || CLEANER_DIR;
        runLoggedBat(dir, item.file, item.title, btn);
      }
    });

    card.append(icon, title, sub, badges, btn);
    return card;
  }

  /* ============================================================
     Запуск
     ============================================================ */

  async function runLoggedBat(dir, file, title, btn) {
    if (btn.disabled) return;
    btn.disabled = true;
    const old = btn.textContent;
    btn.textContent = '…';
    Sound.click();

    try {
      await loggedRunStream(`${dir}/${file}`, {
        onEnd: (r) => {
          btn.disabled = false;
          btn.textContent = old;
          if (r && r.code === 0) {
            Sound.success();
            toast(`✓ ${title}`, 'success', 2500);
          } else {
            Sound.error();
            toast(`Ошибка: ${title} (exit ${r?.code ?? '?'})`, 'error', 5000);
          }
        }
      });
    } catch (err) {
      btn.disabled = false;
      btn.textContent = old;
      Sound.error();
      toast('❌ ' + (err?.message || err), 'error', 6000);
    }
  }

  async function runLoggedCmd(cmd, title, btn) {
    if (btn.disabled) return;
    btn.disabled = true;
    const old = btn.textContent;
    btn.textContent = '…';
    Sound.click();

    try {
      await loggedRunCommandStream(cmd, {
        onEnd: (r) => {
          btn.disabled = false;
          btn.textContent = old;
          if (r && r.code === 0) {
            Sound.success();
            toast(`✓ ${title}`, 'success', 2500);
          } else {
            Sound.error();
            toast(`Ошибка: ${title} (exit ${r?.code ?? '?'})`, 'error', 5000);
          }
        }
      });
    } catch (err) {
      btn.disabled = false;
      btn.textContent = old;
      Sound.error();
      toast('❌ ' + (err?.message || err), 'error', 6000);
    }
  }
}