import { state, clearCheckboxes, navigate, toast, Sound } from '../app.js';
import { renderCheckboxGrid } from '../components/checkbox.js';
import {
  logLine, logSeparator,
  loggedRunStream, loggedRunCommandStream
} from '../logger.js';

const FIXES_DIR = 'src/renderer/tabs/fixes';
const TWEAKS_DIR = 'tweaks/Исправления';

function iconForFix(item) {
  const t = (String(item.title || '') + ' ' + String(item.file || item.cmd || '')).toLowerCase();

  if (/revert|de3nake|восстановить всё|полный откат/.test(t)) return '🛠';
  if (/dism/.test(t))                                 return '💠';
  if (/sfc/.test(t))                                  return '🔧';
  if (/chkdsk|диск/.test(t))                          return '💾';
  if (/store|xbox/.test(t))                           return '🛍';
  if (/shader|шейдер/.test(t))                        return '🎞';
  if (/bsod|логи|журнал/.test(t))                     return '📋';
  if (/dns/.test(t))                                  return '🌐';
  if (/tcp|ip|сеть|network|wifi|wi-fi/.test(t))       return '📡';
  if (/wu|update|обновл/.test(t))                     return '🔄';
  if (/device|устройств|микрофон|камер|bt|bluetooth/.test(t)) return '🎧';
  if (/defender|security|защит|firewall|брандмауэр/.test(t))  return '🛡';
  if (/ghost|призрак/.test(t))                        return '👻';
  if (/font|шрифт|win\+v|ui/.test(t))                 return '🅰';
  if (/service|служб|поиск|уведомл/.test(t))          return '⚙';
  if (/power|питани/.test(t))                         return '🔋';
  if (/password|пароль|powershell/.test(t))           return '🔑';
  if (/fortnite|gta/.test(t))                         return '🎮';
  if (/valorant|vanguard|cfg/.test(t))                return '🎯';
  if (/mouse|мыш/.test(t))                            return '🖱';
  if (/gpu|nvidia|fps|gamedvr/.test(t))               return '🎬';
  if (/bcd|hpet|tick|timer/.test(t))                  return '⏱';
  if (/hags/.test(t))                                 return '🧩';
  if (/audio|звук/.test(t))                           return '🔊';
  if (/wmi/.test(t))                                  return '🧬';
  if (/log|temp|очистк/.test(t))                      return '🧹';
    /* --- Очистка диска --- */
  if (/recycle|корзин/.test(t))                               return '🗑';
  if (/temp пользователя|user temp/.test(t))                  return '🌡';
  if (/temp windows|системный temp/.test(t))                  return '🧊';
  if (/temp/.test(t))                                         return '🗑';
  if (/thumb|миниатюр|iconcache/.test(t))                     return '🖼';
  if (/crashdump|дамп/.test(t))                               return '💥';
  if (/delivery|optimization\b/.test(t))                      return '🚚';
  if (/wer|отчёт/.test(t))                                    return '📋';
  if (/d3d|directx/.test(t))                                  return '🎞';
  if (/prefetch/.test(t))                                     return '⏩';
  if (/indexeddb|браузер/.test(t))                            return '🌍';
  if (/softwaredistribution|кэш обновл/.test(t))              return '📦';
  if (/log|логи/.test(t))                                     return '📜';

  return '⚡';
}

/* Фишки-плитки справа в шапке */
const HERO_FEATURES = [
  { icon: '🔍', title: 'Диагностика',  text: 'CPU, GPU, RAM, диск и BSOD' },
  { icon: '💠', title: 'Файлы ОС',     text: 'DISM, SFC, CHKDSK' },
  { icon: '🌐', title: 'Сеть и DNS',   text: 'Wi-Fi, VPN, Winsock' },
  { icon: '🎧', title: 'Устройства',   text: 'Микрофон, камера, BT' },
  { icon: '🛡', title: 'Защита',       text: 'Брандмауэр, Defender' },
  { icon: '🎮', title: 'Игры',         text: 'EAC, BattlEye, CFG' },
  { icon: '🖱', title: 'Input lag',    text: 'Акселерация, HPET' },
  { icon: '⚙',  title: 'Службы',       text: 'wuauserv, BITS, DoSvc' }
];
// const HERO_FEATURES = [
//   { icon: '🔍', title: 'Диагностика',  text: 'CPU, GPU, RAM, диск' },
//   { icon: '🧩', title: 'Файлы ОС',     text: 'DISM, SFC, CHKDSK' },
//   { icon: '🌐', title: 'Сеть и DNS',   text: 'Wi-Fi, VPN, Winsock' },
//   { icon: '🖥', title: 'Устройства',   text: 'Микрофон, камера, BT' },
//   { icon: '🔐', title: 'Защита',       text: 'Брандмауэр, Defender' },
//   { icon: '🎮', title: 'Игры',         text: 'EAC, BattlEye, CFG' },
//   { icon: '🖱', title: 'Input lag',    text: 'Акселерация, HPET' },
//   { icon: '⚡', title: 'Службы',       text: 'wuauserv, BITS, DoSvc' },
//   { icon: '🧹', title: 'Очистка',      text: 'Temp, кэши, корзина' }
// ];

const FIX_SECTIONS = [
  {
    title: '🔧 Базовое восстановление ОС',
    items: [
      { file: 'dism.bat',      title: 'DISM /RestoreHealth',   desc: 'Восстанавливает целостность системного образа Windows через официальные серверы Microsoft.' },
      { file: 'sfc.bat',       title: 'SFC /scannow',          desc: 'Сканирует и чинит повреждённые системные файлы Windows.' },
      { file: 'chkdsk.bat',    title: 'CHKDSK C: /f',          desc: 'Проверяет диск C: на логические ошибки и битые сектора.' },
      { file: 'store_fix.bat', title: 'Microsoft Store / Xbox', desc: 'Сбрасывает зависший кэш Microsoft Store и перерегистрирует сервисы Xbox.' },
      { file: 'shaders.bat',   title: 'Кэш шейдеров',          desc: 'Очищает кэш шейдеров DirectX, NVIDIA и AMD. Полезно при артефактах и после обновления драйвера.' },
      { file: 'bsod_logs.bat', title: 'Показать BSOD',         desc: 'Выводит последние 5 критических ошибок и коды BSOD из системного журнала.' }
    ]
  },
  {
    title: '🛡 Сеть и устройства',
    items: [
      { file: 'network_wifi.bat',  title: 'Wi-Fi, сеть, VPN, QoS', desc: 'Поднимает дерево сетевых зависимостей: WlanSvc, NlaSvc, Dhcp, QoS. Возвращает Wi-Fi, VPN и нормальную загрузку.' },
      { file: 'devices.bat',       title: 'Микрофон, камера, BT',  desc: 'Возвращает права доступа к микрофону и камере, запускает службы Bluetooth и диспетчер печати.' },
      { file: 'security.bat',      title: 'Защита системы',        desc: 'Включает обратно брандмауэр и Центр безопасности. Нужно для мультиплеера и работы некоторых игр.' },
      { file: 'ghost_devices.bat', title: 'Призрачные устройства', desc: 'Удаляет скрытые и отключённые устройства из диспетчера, которые конфликтуют с текущими.' }
    ]
  },
  {
    title: '🖥 Система и интерфейс',
    items: [
      { file: 'ui_fonts.bat',         title: 'Шрифты, Win+V, меню', desc: 'Чинит шрифты, историю буфера обмена и меню Пуск. Помогает, когда UI выглядит сломанным.' },
      { file: 'system_services.bat',  title: 'Поиск и уведомления', desc: 'Возвращает индексацию поиска, службы уведомлений, дефрагментацию и управление дисками.' },
      { file: 'power.bat',            title: 'Схемы электропитания', desc: 'Сбрасывает схемы питания, возвращает AmdPPM / IntelPPM на место.' },
      { file: 'password_scripts.bat', title: 'Пароль и PowerShell',  desc: 'Отключает принудительную смену пароля, разрешает выполнение локальных скриптов.' }
    ]
  },
  {
    title: '🎮 Игровые фиксы',
    items: [
      { file: 'fortnite_gta.bat', title: 'Fortnite / GTA V',        desc: 'Сбрасывает зависшие EasyAntiCheat и BattlEye, перерегистрирует сервисы авторизации Xbox Live.' },
      { file: 'valorant.bat',     title: 'Valorant (CFG)',          desc: 'Возвращает защиту потока управления — без неё некоторые игры не стартуют.' },
      { file: 'mouse.bat',        title: 'Акселерация мыши',        desc: 'Отключает системное ускорение и сглаживание курсора. Снижает input lag.' },
      { file: 'gpu_fps.bat',      title: 'GameDVR / панель NVIDIA', desc: 'Отключает Game DVR и возвращает панель управления NVIDIA в контекстное меню.' },
      { file: 'bcd_timers.bat',   title: 'BCD таймеры',             desc: 'Сбрасывает HPET и системный таймер. Помогает от микрофризов и просадок FPS.' },
      { file: 'hags.bat',         title: 'HAGS (RTX 30/40)',        desc: 'Включает аппаратный планировщик GPU. Даёт прирост на новых видеокартах.' }
    ]
  },
  {
    title: '⚡ Точечная реанимация',
    items: [
      { file: 'network_reset.bat', title: 'Сброс TCP/IP',          desc: 'Полный сброс сети: Winsock, IP-стек, DNS. Лечит отвалившийся интернет.' },
      { file: 'audio_reset.bat',   title: 'Перезапуск звука',      desc: 'Жёстко перезапускает аудио-движок. Убирает писк, шум, пропажу звука.' },
      { file: 'update_reset.bat',  title: 'Сброс Windows Update',  desc: 'Сбрасывает кэш обновлений и хранилище сертификатов (Catroot2).' },
      { file: 'wmi_reset.bat',     title: 'Ремонт WMI',            desc: 'Восстанавливает WMI. Помогает, когда не работают ползунки и датчики.' },
      { kind: 'cmd', cmd: 'ipconfig /flushdns',                        title: 'Сброс DNS',        desc: 'Очищает кэш DNS. Сайты начнут открываться заново, если кэш был битым.' },
      { kind: 'cmd', cmd: 'net stop wuauserv && net start wuauserv',   title: 'Перезапуск WU',    desc: 'Перезапускает службу Windows Update без сброса кэша.' }
    ]
  }
];

const NETWORK_FIX_ITEMS = [
  {
    file: 'net_fix_all.bat',
    title: 'Полное восстановление сети',
    desc: 'Очистка DNS, возврат DNS в авто, сброс IP, Winsock и TCP/IP — одной кнопкой. Лечит большинство проблем с интернетом.',
    recommended: true
  },
  {
    file: 'net_dns_flush.bat',
    title: 'Очистка DNS-кэша',
    desc: 'Сбрасывает кэш DNS. Если интернет есть, а сайты не открываются — это первый шаг.'
  },
  {
    file: 'net_dns_to_auto.bat',
    title: 'DNS в автоматический режим',
    desc: 'Возвращает DNS, вручную прописанные на адаптерах, обратно на DHCP.'
  },
  {
    file: 'net_winsock_reset.bat',
    title: 'Сброс Winsock',
    desc: 'Сбрасывает каталог Winsock. Лечит проблемы с сокетами и прокси-перехватом.'
  },
  {
    file: 'net_tcpip_reset.bat',
    title: 'Сброс TCP/IP',
    desc: 'Возвращает стек TCP/IP к заводскому состоянию.'
  },
  {
    file: 'net_ip_renew.bat',
    title: 'Обновление IP-адреса',
    desc: 'Release + Renew. Переподключает адаптер к DHCP. На пару секунд оборвёт сеть.',
    danger: true
  }
];

const SYSTEM_FIX_ITEMS = [
  {
    file: 'sys_fix_all.bat',
    title: 'Полное восстановление системы',
    desc: 'Службы + кэш обновлений + Microsoft Store + DISM + SFC одной кнопкой. Долго, но лечит почти всё.',
    recommended: true
  },
  {
    file: 'sys_services.bat',
    title: 'Запуск служб Windows',
    desc: 'Проверяет и запускает wuauserv, BITS, cryptsvc, msiserver, DoSvc, UsoSvc, ClipSVC, InstallService.'
  },
  {
    file: 'sys_update_cache.bat',
    title: 'Сброс кэша обновлений',
    desc: 'Переименовывает SoftwareDistribution и catroot2 в *.old. Старый кэш обновлений перестаёт мешать.'
  },
  {
    file: 'sys_store_reset.bat',
    title: 'Сброс Microsoft Store',
    desc: 'Запускает wsreset.exe — сбрасывает кэш Microsoft Store. Помогает при бесконечной загрузке.'
  },
  {
    file: 'clear_logs.bat',
    title: 'Очистка логов',
    desc: 'Удаляет старые системные логи, дампы памяти и временные файлы.'
  }
];

const CLEAN_FIX_ITEMS = [
  {
    file: 'clean_temp_user.bat',
    title: 'Temp пользователя',
    desc: 'Очищает %TEMP% текущего пользователя. Самый безопасный шаг.'
  },
  {
    file: 'clean_temp_windows.bat',
    title: 'Temp Windows',
    desc: 'Очищает C:\\Windows\\Temp. Может потребоваться закрыть часть программ.'
  },
  {
    file: 'clean_recycle.bat',
    title: 'Корзина',
    desc: 'Удаляет $Recycle.Bin на всех дисках. Восстановление невозможно.'
  },
  {
    file: 'clean_thumbs.bat',
    title: 'Кэш миниатюр',
    desc: 'Удаляет thumbcache и iconcache. Проводник пересоздаст их при следующем открытии.'
  },
  {
    file: 'clean_crashdumps.bat',
    title: 'CrashDumps',
    desc: 'Удаляет дампы упавших приложений из %LocalAppData%\\CrashDumps.'
  },
  {
    file: 'clean_update_cache.bat',
    title: 'Кэш Windows Update',
    desc: 'Останавливает wuauserv/BITS/DoSvc и чистит SoftwareDistribution\\Download.',
    recommended: true
  },
  {
    file: 'clean_delivery_optimization.bat',
    title: 'Delivery Optimization',
    desc: 'Чистит кэш раздачи обновлений между устройствами в локальной сети.'
  },
  {
    file: 'clean_wer.bat',
    title: 'Отчёты об ошибках (WER)',
    desc: 'Удаляет WER и в Local, и в ProgramData — все отчёты о сбоях.'
  },
  {
    file: 'clean_d3d_cache.bat',
    title: 'Кэш DirectX (D3DSCache)',
    desc: 'Удаляет кэш шейдеров DirectX. Полезно после смены драйвера GPU.'
  },
  {
    file: 'clean_prefetch.bat',
    title: 'Prefetch',
    desc: 'Чистит C:\\Windows\\Prefetch. Первые запуски программ будут чуть медленнее.',
    danger: true
  },
  {
    file: 'clean_indexeddb.bat',
    title: 'IndexedDB браузеров',
    desc: 'Удаляет локальные данные сайтов (IndexedDB) в Yandex, Chrome и Edge. Профили, закладки и пароли НЕ трогает.',
    danger: true
  }
];

export async function renderFixes() {
  const tabsNav = document.getElementById('tabs-nav');
  const content = document.getElementById('tab-content');
  tabsNav.innerHTML = '';
  content.innerHTML = '';
  clearCheckboxes();

  const wrap = document.createElement('div');
  wrap.className = 'apps-page';
  content.appendChild(wrap);

  /* Header */
  const header = document.createElement('div');
  header.className = 'apps-header';
  header.innerHTML = `
    <div class="apps-title">
      <span class="apps-title-icon">🛠</span>
      <span>Исправления и восстановление</span>
      <span class="apps-count" id="fixes-count">…</span>
    </div>
  `;
  wrap.appendChild(header);

  const totalFixes =
    FIX_SECTIONS.reduce((n, s) => n + s.items.length, 0) +
    NETWORK_FIX_ITEMS.length +
    SYSTEM_FIX_ITEMS.length +
    CLEAN_FIX_ITEMS.length;
  header.querySelector('#fixes-count').textContent = totalFixes;

  /* 0. Hero-шапка */
  wrap.appendChild(buildHero());

  /* 1. Фреймы-секции */
  for (const sec of FIX_SECTIONS) {
    wrap.appendChild(buildSection(sec.title, sec.items.map(makeFixCard)));
  }

  wrap.appendChild(buildSection(
    '🌐 Восстановление сети и DNS',
    NETWORK_FIX_ITEMS.map(makeFixCard)
  ));

  wrap.appendChild(buildSection(
    '⚙ Восстановление служб и системных файлов',
    SYSTEM_FIX_ITEMS.map(makeFixCard)
  ));

  wrap.appendChild(buildSection(
    '🧹 Очистка диска',
    CLEAN_FIX_ITEMS.map(makeFixCard)
  ));

  /* 2. Твики — внизу */
  const tweaksSection = document.createElement('div');
  tweaksSection.className = 'apps-detected-section';
  tweaksSection.style.background = 'color-mix(in srgb, var(--card) 60%, transparent)';
  tweaksSection.style.borderColor = 'color-mix(in srgb, var(--border) 30%, transparent)';

  const twTitle = document.createElement('div');
  twTitle.className = 'section-title';
  twTitle.textContent = '⚙️ Твики исправлений';
  tweaksSection.appendChild(twTitle);

  const dict = state.tabsData.tabs_3 || {};
  const allFiles = Object.entries(dict);

  const mode = state.config.General?.checkbox_display_mode || 'rectangle';
  const cols = parseInt(state.config.Columns?.default || '3', 10) || 3;

  const items = [];
  for (const [cat, files] of allFiles) {
    for (const f of files) {
      const relStr = String(f).replace(/\\/g, '/');
      const base = relStr.split('/').pop();
      const ext = base.includes('.') ? base.split('.').pop() : '';
      items.push({
        name: base.replace(/\.[^.]+$/, ''),
        path: `${TWEAKS_DIR}/${cat}/${relStr}`,
        ext,
        category: cat
      });
    }
  }

  const tweaksHost = document.createElement('div');
  tweaksSection.appendChild(tweaksHost);
  wrap.appendChild(tweaksSection);

  renderCheckboxGrid(tweaksHost, {
    items,
    tabId: 'Исправления',
    sectionId: 'fixes',
    mode,
    columns: cols
  });

  /* ===================== Hero-шапка ===================== */

  function buildHero() {
    const hero = document.createElement('div');
    hero.className = 'fixes-hero';

    /* Левая часть */
    const left = document.createElement('div');
    left.className = 'fixes-hero-left';
    left.innerHTML = `
      <div class="fixes-hero-icon">🛠</div>
      <div class="fixes-hero-text">
        <div class="fixes-hero-title">Восстановление Windows</div>
        <div class="fixes-hero-sub">
          Быстрая реанимация системы после оптимизаций: файлы ОС, сеть, устройства, службы и игры.
          Всё через встроенные средства Windows, без ручного ввода команд.
        </div>
        <div class="fixes-hero-actions">
          <button class="btn danger" id="hero-revert">♻ Полный откат</button>
        </div>
      </div>
    `;

    left.querySelector('#hero-revert').addEventListener('click', () => {
      Sound.click();
      if (!confirm('Запустить полный откат?\nОткроется отдельное окно консоли с меню.')) return;
      runVisibleBat('REVERT DE3NAKE.bat', 'Полный откат системы');
    });

    hero.appendChild(left);

    /* Правая часть — плитки фишек */
    const right = document.createElement('div');
    right.className = 'fixes-hero-features';

    for (const f of HERO_FEATURES) {
      const tile = document.createElement('div');
      tile.className = 'fixes-hero-tile';
      tile.innerHTML = `
        <div class="fixes-hero-tile-icon">${f.icon}</div>
        <div class="fixes-hero-tile-title">${escapeHtml(f.title)}</div>
        <div class="fixes-hero-tile-text">${escapeHtml(f.text)}</div>
      `;
      right.appendChild(tile);
    }

    hero.appendChild(right);
    return hero;
  }

  /* ===================== Общие строители ===================== */

  function buildSection(title, cards) {
    const section = document.createElement('section');
    section.className = 'apps-detected-section';
    section.style.background = 'color-mix(in srgb, var(--card) 60%, transparent)';
    section.style.borderColor = 'color-mix(in srgb, var(--border) 30%, transparent)';

    const h = document.createElement('div');
    h.className = 'section-title';
    h.textContent = title;
    section.appendChild(h);

    const grid = document.createElement('div');
    grid.className = 'apps-grid fixes-grid';

    for (const c of cards) grid.appendChild(c);
    section.appendChild(grid);
    return section;
  }

  function makeFixCard(item) {
    const card = document.createElement('div');
    card.className = 'apps-card';

    const icon = document.createElement('div');
    icon.className = 'apps-icon';
    icon.textContent = iconForFix(item);

    const title = document.createElement('div');
    title.className = 'apps-name';
    title.textContent = item.title;

    const sub = document.createElement('div');
    sub.className = 'apps-sub fix-desc';
    sub.textContent = item.desc;

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

      if (item.danger) {
        if (!confirm(`⚠️ ВНИМАНИЕ!\n\n${item.title}\n\n${item.desc}\n\nПродолжить?`)) return;
      }

      if (item.kind === 'cmd') {
        runLoggedCmd(item.cmd, item.title);
      } else {
        runLoggedFix(item.file, item.title, btn);
      }
    });

    card.appendChild(icon);
    card.appendChild(title);
    card.appendChild(sub);
    card.appendChild(badges);
    card.appendChild(btn);
    return card;
  }

  /* ===================== Запуски ===================== */

  async function runVisibleBat(file, title) {
    logSeparator(`${title}  (${file})`);
    try {
      await window.api.tweaks.run(`${FIXES_DIR}/${file}`, { visible: true });
      logLine(`✅ Запущено в отдельном окне: ${title}`);
      toast(`${title} запущен`, 'success');
      Sound.success();
    } catch (e) {
      logLine(`❌ Ошибка: ${e.message}`);
      toast('Ошибка: ' + e.message, 'error');
      Sound.error();
    }
  }

  async function runLoggedFix(file, title, btn) {
    if (btn.disabled) return;
    btn.disabled = true;
    Sound.click();

    await loggedRunStream(`${FIXES_DIR}/${file}`, {
      onEnd: (r) => {
        btn.disabled = false;
        if (r.code === 0) Sound.success();
        else Sound.error();
      }
    });
  }

  async function runLoggedCmd(cmd, label) {
    await loggedRunCommandStream(cmd, {
      onEnd: (r) => {
        if (r.code === 0) Sound.success();
        else Sound.error();
      }
    });
  }
}

function escapeHtml(s) {
  return String(s)
    .replace(/&/g, '&amp;').replace(/</g, '&lt;')
    .replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/'/g, '&#39;');
}