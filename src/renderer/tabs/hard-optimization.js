import { toast } from '../app.js';
import { papirusUrl } from '../utils/icons.js';

const APPLY_BAT = 'GameMode/Hard_Optimization.bat';

const OPTIMIZATION_CATEGORIES = [
  {
    icon: '📊',
    name: 'Телеметрия и диагностика',
    desc: 'Отключение телеметрии, диагностических служб, WER, TIP, Speech/Ink, рекламных идентификаторов, ContentDelivery и CloudContent.',
    items: [
      'AllowTelemetry = 0 (HKLM, Policies, AppCompat, DataCollection)',
      'DiagTrack, dmwappushservice, diagnosticshub.standardcollector.service, diagsvc, DPS, WdiServiceHost, WdiSystemHost, pla, wmiApSrv, Wecsvc, WerSvc, wercplsupport, TroubleshootingSvc, Telemetry, PcaSvc, DusmSvc, DsSvc, DSSvc, kdnic, ndu, PimIndexMaintenanceSvc → Start=4',
      'Windows Error Reporting: Disabled=1, LoggingDisabled=1, DontSendAdditionalData=1, AutoApproveOSDumps=0',
      'WER Consent: DefaultConsent=0, DefaultOverrideBehavior=1',
      'TIP AggregateResults очистка, TestResults удаление',
      'CapabilityAccessManager: activity, appDiagnostics, appointments, bluetoothSync, broadFileSystemAccess, chat, contacts, documentsLibrary, email, phoneCallHistory, picturesLibrary, radios, userAccountInformation, userDataTasks, videosLibrary = Deny',
      'AppPrivacy: LetAppsAccess* = 2',
      'Speech_OneCore HasAccepted=0, VoiceActivation =0',
      'InputPersonalization RestrictImplicitInkCollection / TextCollection = 1',
      'ContentDeliveryManager: SubscribedContent* = 0',
      'CloudContent: DisableSoftLanding, DisableWindowsSpotlightFeatures, DisableThirdPartySuggestions = 1',
      'Siuf Rules PeriodInNanoSeconds удалён',
    ],
  },
  {
    icon: '🔄',
    name: 'Обновления, Store и Edge',
    desc: 'Отключение Центра обновления, доставки, установки Store, фоновых режимов Edge, SmartScreen Edge.',
    items: [
      'wuauserv, UsoSvc, WaaSMedicSvc, BITS, DoSvc, InstallService, ClipSVC, LicenseManager, PushToInstall, AppXSvc, AppReadiness, AppVClient, Appinfo, AppIDSvc, AppMgmt → Start=4',
      'edgeupdate, edgeupdatem, MicrosoftEdgeElevationService → Start=4',
      'Edge BackgroundModeEnabled = 0, StartupBoostEnabled = 0',
      'DeliveryOptimization DODownloadMode = 0',
      'WindowsStore AutoDownload = 2',
      'HKCU Edge SmartScreenEnabled = Off',
      'WindowsUpdate ExcludeWUDriversInQualityUpdate = 1',
    ],
  },
  {
    icon: '⚡',
    name: 'Питание и производительность',
    desc: 'Отключение гибернации и Power Throttling, схема CrystalCry Max Performance, отключение файла подкачки, твики памяти и митигаций.',
    items: [
      'HibernateEnabled = 0',
      'PowerThrottlingOff = 1',
      'ActivePowerScheme = 90a358c8-3bbc-4fb3-8b4e-d7ab065d2614 (CrystalCry Max Performance) + параметры AC/DC',
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
    ],
  },
  {
    icon: '🌐',
    name: 'Сеть и TCP',
    desc: 'Твики TCP/IP, отключение Wi-Fi Sense, авто-подключения к хотспотам, NonBestEffortLimit.',
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
    desc: 'Ускорение оболочки, отключение анимаций, теней, AeroPeek, прозрачности, уведомлений, поиска Bing и Copilot.',
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
    ],
  },
  {
    icon: '🖱️',
    name: 'Мышь и клавиатура',
    desc: 'Отключение ускорения мыши, нулевые задержки hover и MenuShowDelay, сброс Accessibility Flags.',
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
    ],
  },
  {
    icon: '🖨️',
    name: 'Службы и драйверы',
    desc: 'Отключение/удаление большого списка служб и драйверов: печать, Bluetooth, Wi-Fi, RDP, Hyper-V, хранилища, USB, Xbox, Search.',
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
      'Большой список драйверов и служб (1394ohci, 3ware, acpiex, ADP80XX, …) удалён',
    ],
  },
  {
    icon: '📜',
    name: 'Журналы и события',
    desc: 'Отключение журналирования, EventLog AutoBackupLogFiles, очистка TIP и FveDetect.',
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
    desc: 'Отключение ReserveManager, StorageSense, Mobility Center, рукописного ввода, GameDVR, FSO, планировщика, кэша доставки.',
    items: [
      'ReserveManager ShippedWithReserves = 0',
      'StorageSense StoragePolicy01 / StoragePolicy04 = 0',
      'MobilityCenter = 0',
      'GameBar AllowAutoGameMode / AutoGameModeEnabled = 0',
      'GameDVR AllowGameDVR = 0',
      'DisableFullscreenOptimizations = 1',
      'GameConfigStore FSEBehavior = 2, HonorUserFSEBehaviorMode = 1',
      'HandwritingErrorReports PreventHandwritingErrorReports = 1',
      'TabletPC PreventHandwritingDataSharing = 1',
      'CloudStore StoreInitState = 5',
      'DeliveryOptimization Usage сброс',
    ],
  },
];

const TOTAL_ITEMS = OPTIMIZATION_CATEGORIES.reduce((s, c) => s + c.items.length, 0);

export async function renderHardMode() {
  const tabsNav = document.getElementById('tabs-nav');
  const content = document.getElementById('tab-content');
  tabsNav.innerHTML = '';
  content.innerHTML = '';

  const wrap = document.createElement('div');
  wrap.className = 'split';

  const skullIcon    = papirusUrl('status', 'dialog-warning');
  const powerIcon    = papirusUrl('devices', 'battery');
  const shieldIcon   = papirusUrl('apps', 'preferences-system');
  const servicesIcon = papirusUrl('apps', 'preferences-system');

  const ICON_STYLE = 'width:1.2em !important;height:1.2em !important;vertical-align:-0.2em;margin-right:6px;display:inline-block;object-fit:contain;';

  const left = document.createElement('div');
  left.className = 'panel';

  left.innerHTML = `
    <div style="background:rgba(217,59,59,0.18); border:2px solid var(--danger); border-radius:8px; padding:16px; margin-bottom:20px; text-align:center;">
      <h2 style="color:var(--danger); margin:0 0 8px 0; font-size:18px; display:flex; align-items:center; justify-content:center; gap:6px;">
        <img src="${skullIcon}" alt="" style="width:20px;height:20px;object-fit:contain;" onerror="this.style.display='none'">
        <span>СМЕРТЕЛЬНАЯ ОПТИМИЗАЦИЯ</span>
        <img src="${skullIcon}" alt="" style="width:20px;height:20px;object-fit:contain;" onerror="this.style.display='none'">
      </h2>
      <p style="color:var(--danger); font-weight:bold; font-size:13px; margin:0 0 8px 0;">
        НА НОУТБУКАХ И ПЛАНШЕТАХ НЕ ЗАПУСКАТЬ!<br>
        ТОЛЬКО ДЛЯ СТАЦИОНАРНЫХ ПК.
      </p>
      <p style="color:var(--danger); font-weight:bold; font-size:13px; margin:0; border-top:1px dashed var(--danger); padding-top:8px;">
        ⚠️ ОТМЕНЫ НЕТ. ИЗМЕНЕНИЯ НЕОБРАТИМЫ.<br>
        ДЕЛАЙТЕ РЕЗЕРВНУЮ КОПИЮ СИСТЕМЫ ПЕРЕД ЗАПУСКОМ.
      </p>
    </div>

    <h3 class="game-title">
      <span>Смертельная оптимизация</span>
    </h3>
    <p>Максимальное выжимание FPS и отклика системы за счёт отключения безопасности, телеметрии, обновлений, служб, питания и сетевых твиков. <b style="color:var(--danger)">Откат не предусмотрен.</b></p>

    <div style="margin-top: 16px">
      <button class="btn danger" id="btn-deadly-apply" style="width:100%; padding:14px; font-size:14px; font-weight:bold; white-space:normal; word-break:break-word;">ЗАПУСТИТЬ СМЕРТЕЛЬНУЮ ОПТИМИЗАЦИЮ</button>
    </div>

    <div id="deadly-status" style="margin-top:16px;color:var(--fg-muted);font-size:12px;white-space:pre-line; font-weight:bold;"></div>

    <div style="margin-top:20px; padding:12px; background:var(--bg-alt); border-radius:8px; font-size:12px; color:var(--fg-muted);">
      <b>Что будет сделано:</b> ${TOTAL_ITEMS} групп изменений в реестре и службах.
      Подробный список — справа. Перед запуском закройте все приложения.
    </div>
  `;
  wrap.appendChild(left);

  const right = document.createElement('div');
  right.className = 'panel';

  const intro = document.createElement('section');
  intro.className = 'apps-detected-section';
  intro.style.background = 'color-mix(in srgb, var(--card) 60%, transparent)';
  intro.style.borderColor = 'color-mix(in srgb, var(--danger) 40%, transparent)';
  intro.style.marginBottom = '16px';
  intro.innerHTML = `
    <div class="section-title"><img src="${shieldIcon}" style="${ICON_STYLE}"> Что делает оптимизация (${TOTAL_ITEMS} пунктов)</div>
    <p style="font-size:12px; color:var(--fg-muted); margin: -4px 0 12px 0;">
      Все изменения применяются одним BAT-файлом. Отката нет.
    </p>
    <div style="display:flex;gap:8px;margin-bottom:12px">
      <button class="btn" id="btn-deadly-expand-all">Развернуть все</button>
      <button class="btn" id="btn-deadly-collapse-all">Свернуть все</button>
    </div>
    <div id="deadly-catalog" style="display:flex;flex-direction:column;gap:6px"></div>
  `;
  right.appendChild(intro);

  const powerSection = document.createElement('section');
  powerSection.className = 'apps-detected-section';
  powerSection.style.background = 'color-mix(in srgb, var(--card) 60%, transparent)';
  powerSection.style.borderColor = 'color-mix(in srgb, var(--border) 30%, transparent)';
  powerSection.style.marginBottom = '16px';
  powerSection.innerHTML = `
    <div class="section-title"><img src="${powerIcon}" style="${ICON_STYLE}"> Питание и производительность</div>
    <p style="font-size:12px; color:var(--fg-muted); margin: -4px 0 12px 0;">
      Отключение гибернации и Power Throttling, схема CrystalCry Max Performance, отключение файла подкачки, твики памяти и митигаций, Win32PrioritySeparation.
    </p>
    <div class="apps-grid fixes-grid">
      ${[
        ['🛌','Гибернация','HibernateEnabled = 0.'],
        ['🚫','Power Throttling','PowerThrottlingOff = 1 — отключает фоновое троттлинг-ограничение процессов.'],
        ['✅','Схема питания','ActivePowerScheme = 90a358c8-… (CrystalCry Max Performance) + параметры AC/DC.'],
        ['🧠','Память','PagingFiles="", AlwaysUnloadDLL=1, LargeSystemCache=0, HeapDeCommit*.'],
        ['⚙️','Приоритеты','Win32PrioritySeparation = 2.'],
        ['🛡️','Митигации','DisableMitigations = 1.'],
        ['💾','NTFS','NtfsDisableLastAccessUpdate = 2147483649.'],
      ].map(([i,n,d]) => `
        <div class="apps-card">
          <div class="apps-icon">${i}</div>
          <div class="apps-name">${n}</div>
          <div class="apps-sub fix-desc">${d}</div>
          <div style="display:flex;gap:4px;justify-content:center;min-height:14px;margin-top:2px;">
            <span style="font-size:9.5px;font-weight:700;color:var(--danger);background:color-mix(in srgb, var(--danger) 15%, transparent);border:1px solid color-mix(in srgb, var(--danger) 40%, transparent);padding:1px 6px;border-radius:6px;">☠️ необратимо</span>
          </div>
          <button class="apps-run" disabled style="opacity:0.6;cursor:default;pointer-events:none;">☠️ Применяется</button>
        </div>
      `).join('')}
    </div>
  `;
  right.appendChild(powerSection);

  const servicesSection = document.createElement('section');
  servicesSection.className = 'apps-detected-section';
  servicesSection.style.background = 'color-mix(in srgb, var(--card) 60%, transparent)';
  servicesSection.style.borderColor = 'color-mix(in srgb, var(--border) 30%, transparent)';
  servicesSection.innerHTML = `
    <div class="section-title"><img src="${servicesIcon}" style="${ICON_STYLE}"> Отключаемые и удаляемые службы</div>
    <p style="font-size:12px; color:var(--fg-muted); margin: -4px 0 12px 0;">
      Службы переводятся в <code>Start=4</code> или удаляются из реестра. Отката нет.
    </p>
    <div class="apps-grid fixes-grid">
      ${[
        ['📊','Телеметрия','DiagTrack, dmwappushservice, DPS, Wdi*, WerSvc, pla, wmiApSrv и др. → Start=4.'],
        ['🔄','Обновления и Store','wuauserv, UsoSvc, WaaSMedicSvc, BITS, DoSvc, InstallService, ClipSVC, LicenseManager, PushToInstall, AppXSvc, AppReadiness, AppVClient, Appinfo, AppIDSvc, AppMgmt → Start=4.'],
        ['🌐','Edge','edgeupdate, edgeupdatem, MicrosoftEdgeElevationService → Start=4.'],
        ['🖨️','Печать','Spooler → Start=4 и удалён. PrintNotify, PrintWorkflowUserSvc удалены.'],
        ['📶','Bluetooth и Wi-Fi','Bth*, BluetoothUserService, WlanSvc, WwanSvc, WEPHOSTSVC → удалены.'],
        ['🖥️','RDP и Hyper-V','TermService, SessionEnv, UmRdpService, VMBus, vmic*, HyperVideo → удалены.'],
        ['🎮','Xbox','Xbl*, XboxGipSvc, xboxgip, xinputhid → удалены.'],
        ['💾','Хранилища и RAID','STORAGE, RAID, iSCSI, 3ware, ADP80XX, LSI_*, megasas*, nvraid, nvstor и др. → удалены.'],
        ['🧩','Прочие','embeddedmode, WdiServiceHost, WdiSystemHost, WSearch, DoSvc, DPS, WerSvc, wercplsupport → удалены/Start=4.'],
      ].map(([i,n,d]) => `
        <div class="apps-card">
          <div class="apps-icon">${i}</div>
          <div class="apps-name">${n}</div>
          <div class="apps-sub fix-desc">${d}</div>
          <div style="display:flex;gap:4px;justify-content:center;min-height:14px;margin-top:2px;">
            <span style="font-size:9.5px;font-weight:700;color:var(--danger);background:color-mix(in srgb, var(--danger) 15%, transparent);border:1px solid color-mix(in srgb, var(--danger) 40%, transparent);padding:1px 6px;border-radius:6px;">☠️ необратимо</span>
          </div>
          <button class="apps-run" disabled style="opacity:0.6;cursor:default;pointer-events:none;">☠️ Применяется</button>
        </div>
      `).join('')}
    </div>
  `;
  right.appendChild(servicesSection);

  wrap.appendChild(right);
  content.appendChild(wrap);

  const catalogEl = right.querySelector('#deadly-catalog');
  OPTIMIZATION_CATEGORIES.forEach((cat) => {
    const item = document.createElement('details');
    item.style.cssText = 'background:var(--bg-alt);border-radius:8px;padding:10px 12px;';
    item.innerHTML = `
      <summary style="cursor:pointer;list-style:none;display:flex;align-items:center;gap:8px;user-select:none;">
        <span class="chevron" style="font-size:10px;color:var(--fg-muted);transition:transform .15s;display:inline-block;">▶</span>
        <span style="font-size:16px">${cat.icon}</span>
        <b style="flex:1">${cat.name}</b>
        <span style="color:var(--fg-muted);font-size:12px">${cat.items.length}</span>
      </summary>
      <div style="color:var(--fg-muted);font-size:12px;margin:6px 0 8px;">${cat.desc}</div>
      <div style="font-family:Consolas,monospace;font-size:11px;line-height:1.6;">
        ${cat.items.map(s => `<div style="break-inside:avoid">• ${s}</div>`).join('')}
      </div>
    `;
    item.addEventListener('toggle', () => {
      item.querySelector('.chevron').style.transform = item.open ? 'rotate(90deg)' : 'rotate(0deg)';
    });
    catalogEl.appendChild(item);
  });

  right.querySelector('#btn-deadly-expand-all').addEventListener('click', () => {
    right.querySelectorAll('details').forEach(d => d.open = true);
  });
  right.querySelector('#btn-deadly-collapse-all').addEventListener('click', () => {
    right.querySelectorAll('details').forEach(d => d.open = false);
  });

  const statusEl = left.querySelector('#deadly-status');

  async function runBat(rel, label) {
    statusEl.textContent = `Запуск: ${label}...\nНе выключайте ПК.`;
    statusEl.style.color = 'var(--fg)';
    try {
      await window.api.tweaks.run('tweaks/' + rel, { wait: true });
      statusEl.textContent = `✅ ${label} успешно выполнено!\nРекомендуется перезагрузка.`;
      statusEl.style.color = 'var(--success)';
      toast(`Успех: ${label}`, 'success');
    } catch (e) {
      statusEl.textContent = `❌ Ошибка: ${e.message}`;
      statusEl.style.color = 'var(--danger)';
      toast('Ошибка: ' + e.message, 'error');
    }
  }

  left.querySelector('#btn-deadly-apply').addEventListener('click', () => {
    if (!confirm('СМЕРТЕЛЬНАЯ ОПТИМИЗАЦИЯ\n\nОтмены НЕ БУДЕТ. Продолжить?')) return;
    runBat(APPLY_BAT, 'Смертельная оптимизация');
  });
}