import { toast, Sound } from '../app.js';
import { papirusUrl } from '../utils/icons.js';
import { loggedRunStream } from '../logger.js';

const APPLY_BAT = 'GameMode/Hard_Optimization.bat';

const OPTIMIZATION_CATEGORIES = [
  {
    icon: '📊',
    name: 'Телеметрия и диагностика',
    desc: 'Сбор данных, диагностические службы, отчёты об ошибках, рекламные идентификаторы.',
    items: [
      'AllowTelemetry = 0 (HKLM, Policies, AppCompat, DataCollection)',
      'DiagTrack, dmwappushservice, diagnosticshub.standardcollector.service, diagsvc, DPS, WdiServiceHost, WdiSystemHost, pla, wmiApSrv, Wecsvc, WerSvc, wercplsupport, TroubleshootingSvc, Telemetry, PcaSvc, DusmSvc, DsSvc, DSSvc, kdnic, ndu, PimIndexMaintenanceSvc → Start=4 / удалены',
      'Windows Error Reporting: Disabled=1, LoggingDisabled=1, DontSendAdditionalData=1, AutoApproveOSDumps=0',
      'WER Consent: DefaultConsent=0, DefaultOverrideBehavior=1',
      'TIP AggregateResults очистка, TestResults удаление',
      'CapabilityAccessManager: activity, appDiagnostics, appointments, bluetoothSync, broadFileSystemAccess, chat, contacts, documentsLibrary, email, phoneCallHistory, picturesLibrary, radios, userAccountInformation, userDataTasks, videosLibrary = Deny',
      'AppPrivacy: LetAppsAccess* = 2',
      'Speech_OneCore HasAccepted=0, VoiceActivation =0',
      'InputPersonalization RestrictImplicitInkCollection / TextCollection = 1',
      'ContentDeliveryManager: SubscribedContent* = 0, ContentDeliveryAllowed=0',
      'CloudContent: DisableSoftLanding, DisableWindowsSpotlightFeatures, DisableThirdPartySuggestions = 1',
      'Siuf Rules PeriodInNanoSeconds удалён',
      'Wbem: AmsiEnable=0, CIMOM LastServiceReady удалён, LastServiceStart/PreviousServiceShutdown/SetupDate перезаписаны',
      'CompatTelRunner.exe / AggregatorHost.exe / DeviceCensus.exe → Debugger = taskkill',
    ],
  },
  {
    icon: '🔄',
    name: 'Обновления, Store и Edge',
    desc: 'Центр обновления, доставка обновлений, установка Store, фоновые режимы Edge, SmartScreen Edge.',
    items: [
      'wuauserv, UsoSvc, WaaSMedicSvc, BITS, DoSvc, InstallService, ClipSVC, LicenseManager, PushToInstall, AppXSvc, AppReadiness, AppVClient, Appinfo, AppIDSvc, AppMgmt → Start=4 / удалены',
      'edgeupdate, edgeupdatem, MicrosoftEdgeElevationService → Start=4',
      'Edge BackgroundModeEnabled = 0, StartupBoostEnabled = 0',
      'DeliveryOptimization DODownloadMode = 0',
      'WindowsStore AutoDownload = 2',
      'HKCU Edge SmartScreenEnabled = Off',
      'WindowsUpdate ExcludeWUDriversInQualityUpdate = 1',
      'UpdatePolicy Settings PausedFeatureDate / PausedQualityDate = 2026-10-30',
      'DriverSearching SearchOrderConfig = 3',
    ],
  },
  {
    icon: '⚡',
    name: 'Питание и производительность',
    desc: 'Гибернация, фоновый троттлинг, память, митигации, приоритеты, NTFS.',
    items: [
      'HibernateEnabled = 0',
      'PowerThrottlingOff = 1',
      'PagingFiles = "" (файл подкачки отключён)',
      'AlwaysUnloadDLL = 1',
      'LargeSystemCache = 0',
      'HeapDeCommitFreeBlockThreshold = 2498884',
      'HeapDeCommitTotalFreeThreshold = 5390984',
      'DisablePagingExecutive = 0',
      'DisableMitigations = 1',
      'Win32PrioritySeparation = 2',
      'NtfsDisableLastAccessUpdate = 2147483649',
      'SCMApiConnectionParam = 1000',
      'Memory Management PagingFiles = ""',
      'VulnerableDriverBlocklistEnable = 0',
    ],
  },
  {
    icon: '🌐',
    name: 'Сеть и TCP',
    desc: 'TCP/IP, Wi-Fi Sense, авто-подключение к хотспотам, ограничение фоновой сети.',
    items: [
      'Tcpip / Tcpip6 DefaultTTL = 65',
      'TcpAckFrequency = 1',
      'TcpDelAckTicks = 0',
      'TCPNoDelay = 1',
      'Psched NonBestEffortLimit = 0',
      'Wifi AllowAutoConnectToWiFiSenseHotspots = 0',
      'Wifi AllowWiFiHotSpotReporting = 0',
      'WcmSvc AutoConnectAllowedOEM = 0',
      'WcmSvc AutoConnect ProvidersList = ""',
    ],
  },
  {
    icon: '🖥️',
    name: 'Проводник, UI и уведомления',
    desc: 'Анимации, тени, AeroPeek, прозрачность, уведомления, поиск Bing, Copilot.',
    items: [
      'MenuShowDelay = 0',
      'MinAnimate = 0',
      'DragFullWindows = 0',
      'ListviewAlphaSelect = 0, ListviewShadow = 0, TaskbarAnimations = 0',
      'EnableTransparency = 0, EnableAeroPeek = 0',
      'ToastEnabled = 0, NOC_GLOBAL_SETTING_TOASTS_ENABLED = 0',
      'BingSearchEnabled = 0, DisableSearchBoxSuggestions = 1',
      'TurnOffWindowsCopilot = 1, DisableAIDataAnalysis = 1',
      'BackgroundAccessApplications GlobalUserDisabled = 1',
      'TaskbarMn = 0, TaskbarEndTask = 1',
      'NoInternetOpenWith = 1',
      'PushNotifications NoTileApplicationNotification / NoToastApplicationNotification = 1',
      'DisableNotificationCenter = 1',
      'IconsOnly = 1',
      'Serialize WaitforIdleState = 0',
      'MobCenter MobilityCenter = 0',
      'Privacy TailoredExperiencesWithDiagnosticDataEnabled = 0',
    ],
  },
  {
    icon: '🖱️',
    name: 'Мышь и клавиатура',
    desc: 'Ускорение мыши, задержки hover, Accessibility Flags.',
    items: [
      'MouseSpeed = 0, MouseThreshold1 = 0, MouseThreshold2 = 0',
      'MouseHoverTime = 0',
      'Keyboard Response Flags = 0',
      'StickyKeys Flags = 0',
      'ToggleKeys Flags = 0',
      'MouseKeys Flags = 0',
      'HungAppTimeout = 1000',
      'WaitToKillAppTimeout = 5000',
      'MenuShowDelay = 0',
      'UserPreferencesMask = 9012018010000000',
    ],
  },
  {
    icon: '🖨️',
    name: 'Службы и драйверы',
    desc: 'Печать, Bluetooth, Wi-Fi, RDP, Hyper-V, хранилища, USB, Xbox, Search.',
    items: [
      'Spooler → Start=4 и удалён',
      'Bth*, BluetoothUserService → удалены',
      'WlanSvc, WwanSvc, WEPHOSTSVC → удалены',
      'TermService, SessionEnv, UmRdpService → удалены',
      'Xbl*, XboxGipSvc, xboxgip, xinputhid → удалены',
      'WSearch, wuauserv, UsoSvc, WaaSMedicSvc → удалены',
      'STORAGE, RAID, iSCSI, Hyper-V, VMBus, vmic* → удалены',
      'embeddedmode, WdiServiceHost, WdiSystemHost → удалены',
      'DoSvc, DPS, Spooler, WerSvc, wercplsupport, embeddedmode → Start=4',
      'cphs, cplspcon → Start=4, DelayedAutoStart=0',
      'Большой список драйверов и служб (1394ohci, 3ware, acpiex, ADP80XX, …) удалён',
    ],
  },
  {
    icon: '📜',
    name: 'Журналы и события',
    desc: 'Журналирование, EventLog AutoBackupLogFiles, TIP, FveDetect.',
    items: [
      'EventLog\\Application AutoBackupLogFiles = 0',
      'Wbem CIMOM LastServiceReady удалён, LastServiceStart / PreviousServiceShutdown / SetupDate перезаписаны',
      'TIP TestResults удалены',
      'FveDetect Cache = 0',
    ],
  },
  {
    icon: '🧹',
    name: 'Прочее',
    desc: 'ReserveManager, StorageSense, Mobility Center, рукописный ввод, GameDVR, FSO, кэш доставки.',
    items: [
      'ReserveManager ShippedWithReserves = 0',
      'StorageSense StoragePolicy01 / StoragePolicy04 = 0',
      'MobilityCenter = 0',
      'GameBar AllowAutoGameMode / AutoGameModeEnabled = 0',
      'GameDVR AllowGameDVR = 0',
      'DisableFullscreenOptimizations = 1',
      'GameConfigStore FSEBehavior = 2, HonorUserFSEBehaviorMode = 1, DXGIHonorFSEWindowsCompatible = 1',
      'HandwritingErrorReports PreventHandwritingErrorReports = 1',
      'TabletPC PreventHandwritingDataSharing = 1',
      'CloudStore StoreInitState = 5',
      'DeliveryOptimization Usage сброс',
      'SettingSync SyncPolicy = 5',
      'Search BackgroundAppGlobalToggle = 0',
      'CloudContent DisableWindowsSpotlightOnActionCenter / OnSettings / WindowsWelcomeExperience = 1',
      'Policies Psched NonBestEffortLimit = 0',
      'Policies System DisableFullscreenOptimizations = 1',
      'Policies GameDVR AllowGameDVR = 0',
      'Policies Explorer DisableNotificationCenter = 1',
      'CI Config VulnerableDriverBlocklistEnable = 0',
    ],
  },
];

export async function renderHardMode() {
  const tabsNav = document.getElementById('tabs-nav');
  const content = document.getElementById('tab-content');
  tabsNav.innerHTML = '';
  content.innerHTML = '';

  const skullIcon = papirusUrl('status', 'dialog-warning');

  // ─── Стили: огненный текст + свечение + искры + лог ───
  const styleTag = document.createElement('style');
  styleTag.textContent = `
    @keyframes firePulse {
      0%, 100% {
        filter: drop-shadow(0 0 8px rgba(255,120,0,0.65))
                drop-shadow(0 0 22px rgba(255,60,0,0.45))
                drop-shadow(0 0 44px rgba(255,0,0,0.20));
        transform: scale(1);
      }
      50% {
        filter: drop-shadow(0 0 16px rgba(255,170,0,0.95))
                drop-shadow(0 0 40px rgba(255,80,0,0.65))
                drop-shadow(0 0 80px rgba(255,0,0,0.35));
        transform: scale(1.02);
      }
    }
    @keyframes fireFlicker {
      0%   { background-position: 0% 50%; }
      25%  { background-position: 50% 50%; }
      50%  { background-position: 100% 50%; }
      75%  { background-position: 50% 50%; }
      100% { background-position: 0% 50%; }
    }
    @keyframes emberRise {
      0%   { opacity: 0; transform: translateY(0) scale(1); }
      15%  { opacity: .95; }
      100% { opacity: 0; transform: translateY(-90px) scale(.35); }
    }
    @keyframes heatHaze {
      0%, 100% { opacity: .55; transform: scale(1); }
      50%      { opacity: .85; transform: scale(1.06); }
    }
    @keyframes metalSheen {
      0%, 100% { filter: brightness(1) contrast(1.05); }
      50%      { filter: brightness(1.12) contrast(1.15); }
    }

    .fire-title {
      font-family: 'Old English Text MT', 'Blackadder ITC',
                   'Segoe Script', 'Impact', 'Arial Black', sans-serif;
      font-weight: 900;
      letter-spacing: 4px;
      line-height: 1.02;
      text-transform: uppercase;
      background: linear-gradient(90deg,
        #7a0e00 0%, #ff2d00 12%, #ff6a00 28%, #ffb300 42%,
        #fff6b0 50%, #ffb300 58%, #ff6a00 72%, #ff2d00 88%, #7a0e00 100%);
      background-size: 300% 100%;
      -webkit-background-clip: text;
      background-clip: text;
      color: transparent;
      -webkit-text-fill-color: transparent;
      animation: firePulse 2.6s ease-in-out infinite,
                 fireFlicker 3.4s linear infinite,
                 metalSheen 5s ease-in-out infinite;
      will-change: filter, transform, background-position;
    }
    .fire-glow {
      position: absolute;
      inset: -10%;
      background: radial-gradient(circle at 50% 55%,
        rgba(255,90,0,0.30) 0%,
        rgba(255,40,0,0.18) 30%,
        transparent 65%);
      filter: blur(28px);
      animation: heatHaze 3.2s ease-in-out infinite;
      pointer-events: none;
      z-index: 0;
    }
    .ember {
      position: absolute;
      bottom: 10%;
      width: 6px;
      height: 6px;
      border-radius: 50%;
      background: radial-gradient(circle, #ffe08a 0%, #ff6a00 55%, transparent 100%);
      pointer-events: none;
      z-index: 1;
      animation: emberRise 2.8s ease-out infinite;
    }

    /* Лог выполнения — как в optimization.js */
    .deadly-log {
      margin-top: 12px;
      background: var(--bg-alt);
      border: 1px solid var(--border);
      border-radius: 8px;
      padding: 10px 12px;
      font-family: Consolas, "Courier New", monospace;
      font-size: 11.5px;
      line-height: 1.45;
      color: var(--fg-muted);
      max-height: 260px;
      overflow-y: auto;
      white-space: pre-wrap;
      word-break: break-word;
      display: none;
    }
    .deadly-log.active { display: block; }
    .deadly-log .log-line { display: block; }
    .deadly-log .log-ok    { color: var(--success); }
    .deadly-log .log-err   { color: var(--danger);  }
    .deadly-log .log-info  { color: var(--fg);      }

    @media (prefers-reduced-motion: reduce) {
      .fire-title, .fire-glow, .ember { animation: none !important; }
      .ember { display: none; }
    }
  `;
  content.appendChild(styleTag);

  // Внешняя обёртка-сетка — БЕЗ рамки/фона (убрана «сквозная» рамка)
  const root = document.createElement('div');
  root.style.cssText = `
    display: grid;
    grid-template-columns: minmax(260px, 320px) 1fr minmax(300px, 380px);
    gap: 18px;
    align-items: stretch;
    min-height: calc(100vh - 140px);
    background: transparent;
    border: none;
  `;

  // ─────────────── ЛЕВАЯ ПАНЕЛЬ (panel — с фоном и рамкой) ───────────────
  const left = document.createElement('div');
  left.className = 'panel';
  left.style.cssText = 'display:flex;flex-direction:column;gap:14px;';
  left.innerHTML = `
    <div style="
      background: rgba(217,59,59,0.16);
      border: 2px solid var(--danger);
      border-radius: 10px;
      padding: 16px;
      text-align: center;
    ">
      <div style="display:flex;align-items:center;justify-content:center;gap:8px;margin-bottom:8px;">
        <img src="${skullIcon}" alt="" style="width:22px;height:22px;object-fit:contain;" onerror="this.style.display='none'">
        <b style="color:var(--danger);font-size:15px;letter-spacing:.5px;">ОПАСНО</b>
        <img src="${skullIcon}" alt="" style="width:22px;height:22px;object-fit:contain;" onerror="this.style.display='none'">
      </div>
      <p style="color:var(--danger);font-weight:700;font-size:12.5px;margin:0 0 6px;">
        ТОЛЬКО ДЛЯ СТАЦИОНАРНЫХ ПК.<br>
        НА НОУТБУКАХ И ПЛАНШЕТАХ НЕ ЗАПУСКАТЬ.
      </p>
      <p style="color:var(--danger);font-weight:700;font-size:12.5px;margin:0;border-top:1px dashed var(--danger);padding-top:8px;">
        ОТМЕНЫ НЕТ. ИЗМЕНЕНИЯ НЕОБРАТИМЫ.
      </p>
    </div>

    <button class="btn danger" id="btn-deadly-apply"
      style="
        width:100%;padding:14px;font-size:14px;font-weight:700;
        white-space:normal;word-break:break-word;
      ">
      ЗАПУСТИТЬ СМЕРТЕЛЬНУЮ ОПТИМИЗАЦИЮ
    </button>

    <div id="deadly-status"
      style="font-size:12px;white-space:pre-line;font-weight:600;color:var(--fg-muted);min-height:16px;">
    </div>

    <!-- Лог выполнения -->
    <div id="deadly-log" class="deadly-log"></div>

    <div style="background:var(--bg-alt);border-radius:10px;padding:14px;font-size:12px;color:var(--fg-muted);line-height:1.6;">
      <b style="color:var(--fg);">Перед запуском:</b>
      <ul style="margin:8px 0 0;padding-left:16px;">
        <li>Создайте точку восстановления или образ.</li>
        <li>Закройте браузеры, игры, мессенджеры.</li>
        <li>После применения перезагрузите ПК.</li>
      </ul>
    </div>
  `;
  root.appendChild(left);

  // ─────────────── ЦЕНТР: ОГНЕННЫЙ ТЕКСТ ───────────────
  const center = document.createElement('div');
  center.style.cssText = `
    position:relative;
    display:flex;align-items:center;justify-content:center;
    text-align:center;padding:20px;overflow:hidden;
    background:
      radial-gradient(circle at 50% 60%, rgba(255,80,0,0.10), transparent 65%),
      radial-gradient(circle at 50% 40%, rgba(217,59,59,0.08), transparent 55%);
    border-radius:10px;
  `;
  center.innerHTML = `
    <span class="ember" style="left:18%;animation-delay:0s;"></span>
    <span class="ember" style="left:32%;animation-delay:.7s;"></span>
    <span class="ember" style="left:47%;animation-delay:1.4s;"></span>
    <span class="ember" style="left:61%;animation-delay:.4s;"></span>
    <span class="ember" style="left:74%;animation-delay:1.1s;"></span>
    <span class="ember" style="left:86%;animation-delay:1.9s;"></span>
  `;
  root.appendChild(center);

  // ─────────────── ПРАВАЯ ПАНЕЛЬ (panel — с фоном и рамкой) ───────────────
  const right = document.createElement('div');
  right.className = 'panel';
  right.style.cssText = 'display:flex;flex-direction:column;gap:10px;overflow-y:auto;max-height:calc(100vh - 140px);';

  const rightHeader = document.createElement('div');
  rightHeader.style.cssText = 'font-size:13px;font-weight:700;color:var(--fg);padding-bottom:6px;border-bottom:1px solid var(--border);';
  rightHeader.textContent = 'Что будет сделано';
  right.appendChild(rightHeader);

  OPTIMIZATION_CATEGORIES.forEach((cat) => {
    const block = document.createElement('div');
    block.style.cssText = `
      background: var(--bg-alt);
      border-radius: 8px;
      padding: 10px 12px;
    `;
    block.innerHTML = `
      <div style="display:flex;align-items:center;gap:8px;margin-bottom:4px;">
        <span style="font-size:14px;">${cat.icon}</span>
        <b style="font-size:12.5px;flex:1;">${cat.name}</b>
      </div>
      <div style="color:var(--fg-muted);font-size:11.5px;line-height:1.5;">
        ${cat.desc}
      </div>
    `;
    right.appendChild(block);
  });

  root.appendChild(right);
  content.appendChild(root);

  // ─────────────── Лог ───────────────
  const logEl = left.querySelector('#deadly-log');

  function logLine(text, kind = 'info') {
    logEl.classList.add('active');
    const line = document.createElement('span');
    line.className = 'log-line' + (kind === 'ok' ? ' log-ok' : kind === 'err' ? ' log-err' : ' log-info');
    line.textContent = text;
    logEl.appendChild(line);
    logEl.scrollTop = logEl.scrollHeight;
  }

  function logReset() {
    logEl.innerHTML = '';
    logEl.classList.remove('active');
  }

  // ─────────────── Запуск BAT с логом ───────────────
  const statusEl = left.querySelector('#deadly-status');
  const applyBtn = left.querySelector('#btn-deadly-apply');

  async function runBat(rel, label) {
    statusEl.textContent = `Запуск: ${label}… Не выключайте ПК.`;
    statusEl.style.color = 'var(--fg)';
    applyBtn.disabled = true;
    applyBtn.style.opacity = '.6';
    logReset();
    logLine(`▶ Запуск: ${label}`, 'info');
    logLine(`  Файл: ${rel}`, 'info');

    try {
      await loggedRunStream('tweaks/' + rel, {
        onChunk: (chunk) => {
          if (chunk && chunk.text) logLine(chunk.text, chunk.stream === 'stderr' ? 'err' : 'info');
        },
        onEnd: (r) => {
          const code = r?.code ?? '?';
          if (r && r.code === 0) {
            logLine(`✔ Завершено успешно (exit 0)`, 'ok');
            statusEl.textContent = `✅ Готово. Рекомендуется перезагрузка.`;
            statusEl.style.color = 'var(--success)';
            toast(`Успех: ${label}`, 'success');
            Sound.success();
          } else {
            logLine(`✖ Ошибка (exit ${code})`, 'err');
            statusEl.textContent = `❌ Ошибка: exit ${code}`;
            statusEl.style.color = 'var(--danger)';
            toast(`Ошибка: ${label} (exit ${code})`, 'error', 5000);
            Sound.error();
          }
          applyBtn.disabled = false;
          applyBtn.style.opacity = '1';
        }
      });
    } catch (e) {
      logLine(`✖ Исключение: ${e?.message || e}`, 'err');
      statusEl.textContent = `❌ Ошибка: ${e?.message || e}`;
      statusEl.style.color = 'var(--danger)';
      toast('Ошибка: ' + (e?.message || e), 'error', 6000);
      Sound.error();
      applyBtn.disabled = false;
      applyBtn.style.opacity = '1';
    }
  }

  applyBtn.addEventListener('click', () => {
    Sound.click();
    runBat(APPLY_BAT, 'Смертельная оптимизация');
  });
}