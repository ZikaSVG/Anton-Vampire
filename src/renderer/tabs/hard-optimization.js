import { toast, Sound } from '../app.js';
import { papirusUrl } from '../utils/icons.js';
import { loggedRunStream } from '../logger.js';

const APPLY_BAT               = 'GameMode/VampireOS.bat';
const POWER_MAX_BAT           = 'GameMode/VampireOS-Power-Max.bat';
const POWER_MAX_RESTORE_BAT   = 'GameMode/VampireOS-Power-Restore.bat';
const POWER_SAVE_BAT          = 'GameMode/VampireOS-Power-Save.bat';
const POWER_SAVE_RESTORE_BAT  = 'GameMode/VampireOS-Power-Save-Restore.bat';

// ============================================================================
//  OPTIMIZATION_CATEGORIES — что реально произойдёт после запуска VampireOS.bat
//  Каждая категория: icon, name, desc, items[].
//  desc — вводная, items — конкретные изменения (рендерятся списком).
// ============================================================================
const OPTIMIZATION_CATEGORIES = [
  {
    icon: '📊',
    name: 'Телеметрия и диагностика',
    desc: 'Windows перестаёт отправлять в Microsoft отчёты о работе системы, ошибках и приложениях. Отключаются службы и задачи, которые собирают эту статистику.',
    items: [
      'Уровень телеметрии → 0 (Security / Off) во всех ветках реестра',
      'DiagTrack, dmwappushservice, WdiServiceHost, WdiSystemHost, PcaSvc, WerSvc → отключены',
      'WER: Disabled=1, LoggingDisabled=1, DontSendAdditionalData=1, DisableArchive=1, DisableWerUpload=1',
      'AppCompat: DisableEngine=1, AITEnable=0, DisableUAR=1, DisablePCA=1, DisableInventory=1, SbEnable=1',
      'CEIP/SQM: CEIPEnable=0, UploadDisableFlag=1',
      'CapabilityAccessManager: activity, appDiagnostics, appointments, bluetoothSync, broadFileSystemAccess, chat, contacts, documentsLibrary, email, phoneCallHistory, picturesLibrary, radios, userAccountInformation, userDataTasks, videosLibrary = Deny',
      'AppPrivacy: LetAppsAccess* = 2',
      'Speech_OneCore HasAccepted=0, VoiceActivationOn=0, VoiceActivationEnableAboveLockscreen=0, ModelDownloadAllowed=0',
      'InputPersonalization RestrictImplicitInkCollection=1, RestrictImplicitTextCollection=1, HarvestContacts=0, AllowInputPersonalization=0',
      'TIPC Enabled=0 (HKCU + HKLM)',
      'AllowLinguisticDataCollection=0, HttpAcceptLanguageOptOut=1',
      'ContentDeliveryManager: все SubscribedContent-* = 0, ContentDeliveryAllowed=0, SilentInstalledAppsEnabled=0, OemPreInstalledAppsEnabled=0, FeatureManagementEnabled=0',
      'CloudContent: DisableSoftLanding=1, DisableWindowsSpotlightFeatures=1, DisableCloudOptimizedContent=1, DisableWindowsConsumerFeatures=1, DisableThirdPartySuggestions=1, DisableTailoredExperiencesWithDiagnosticData=1',
      'CloudContent: ConfigureWindowsSpotlight=2, IncludeEnterpriseSpotlight=0',
      'Siuf Rules NumberOfSIUFInPeriod=0, PeriodInNanoSeconds удалён',
      'AdvertisingInfo Enabled=0 (HKCU+HKLM), Id удалён, DisabledByGroupPolicy=1',
      'Privacy general: MSAOptional=1, AllowMessageSync=0, DisableHelpSticker=1, DisableMFUTracking=1',
      'Restrict Internet Communication: NoPublishingWizard, NoWebServices, NoGenTicket, NoOnlinePrintsWizard, DisableHTTPPrinting, DisableWebPnPDownload, WindowsMovieMaker web/codec/publish',
      'PCHealth/HelpSvc/ErrorReporting: Headlines=0, MicrosoftKBSearch=0, DoReport=0; ExitOnMSICW=1, MicrosoftEventVwrDisableLinks=1, NoRegistration=1, DisableContentFileUpdates=1',
      'Search: RespectPowerModes=1, AllowCloudSearch=2, WinStore.Tasks.WindowsSearchTask ActivationType=0xFFFFFFFF, FeatureManagement Overrides 1694661260=0',
      'Telemetry additional: DisableEnterpriseAuthProxy=1, DisableTelemetryOptInChangeNotification=1, DisableTelemetryOptInSettingsUx=1',
      'Firewall: Block-Unified-Telemetry-Client (DiagTrack), Block-Windows-Error-Reporting (WerSvc)',
      'Xbox Gaming Copilot block: ActivationType=0xFFFFFFFF',
      'NVIDIA: NvControlPanel2\\Client OptInOrOutPreference=0, NvTelemetryContainer=4 + NvTm* задачи',
      'Wbem: AmsiEnable=0',
      'IFEO: CompatTelRunner.exe, AggregatorHost.exe, DeviceCensus.exe, FeatureLoader.exe, BingChatInstaller.exe, BGAUpsell.exe, BCILauncher.exe → Debugger=taskkill',
      'DeviceCensus: DisallowRun + IFEO Debugger',
      'CDPUserSvc=4, AllowSpeechModelUpdate=0',
    ],
  },
  {
    icon: '🔄',
    name: 'Обновления и Store',
    desc: 'Автоматическая установка обновлений и драйверов без спроса отключается. Обновления ставятся вручную — через «Центр обновления» или через установочный образ.',
    items: [
      'wuauserv, UsoSvc, WaaSMedicSvc, DoSvc → отключены',
      'NoAutoUpdate=1, PausedFeatureStatus=1, PausedQualityStatus=1, даты 2077',
      'DontOfferThroughWUAU=1',
      'DeliveryOptimization DODownloadMode=0 (HKLM + HKU\\S-1-5-20 + HKCU)',
      'MS Store: AutoDownload=4, DisableOSUpgrade=1',
      'ExcludeWUDriversInQualityUpdate=1',
      'SearchOrderConfig=0',
      'PreventDeviceMetadataFromNetwork=1 (HKLM + Политики)',
      'UScheduler DevHomeUpdate / OutlookUpdate workCompleted=1, UScheduler_Oobe удалены',
      'PauseFeature/Quality/UpdatesStartTime=2025-01-01, EndTime=2038-01-19T03:14:07Z, FlightSettingsMaxPauseDays=5269',
      'TargetReleaseVersionInfo=<ver>',
      'UpgradeAvailable=0, DontReportInfectionInformation=0, MediaPlayer DisableAutoUpdate=0',
      'BlockedOobeUpdaters=["MS_Outlook"], HideMCTLink=1, RestartNotificationsAllowed2=0',
      'Задачи WindowsUpdate: Scheduled Start, Schedule Scan, Refresh Group Policy Cache, UpdateOrchestrator* отключены',
      'WaaSMedic PerformRemediation / ScanForUpdates / WsusScan отключены',
      'EdgeUpdate policies: InstallDefault=0, Install Edge=0, Install WebView=1, DoNotUpdateToEdgeWithChromium=1 (блокирует установку/обновление Edge, не удаляет)',
    ],
  },
  {
    icon: '🧠',
    name: 'Система и ядро',
    desc: 'Настройки планировщика, памяти и приоритетов. Windows быстрее отзывается на действия, фоновые задачи не конкурируют с активным приложением.',
    items: [
      'Планировщик: Win32PrioritySeparation=38',
      'Сеть/мультимедиа: NetworkThrottlingIndex=10, SystemResponsiveness=10, NoLazyMode=1',
      'Память: DisablePageCombining=1, FeatureSettingsOverride=3, FeatureSettingsOverrideMask=3',
      'Segment Heap=1, BackgroundLoadKnownDlls=1, TaskhostTimeout=2000, EnableCpuQuota=0',
      'DisableMitigations=1, EnableSvchostMitigationPolicy=0, BootExecuteNoPnpSync=1',
      'SvcHostSplitThresholdInKB=3489660927',
      'RealTimeIsUniversal=1, EnableLinkedConnections=1',
      'SvcHostSplitDisable=1 для ключевых служб',
      'PowerShell ExecutionPolicy=Unrestricted, ассоциации .ps1/.psm1',
      'Bypass TPM/SecureBoot/RAM/CPU/Storage, BypassNRO=1',
      'CrashControl AutoReboot=0, CrashDumpEnabled=3',
      'IFEO PerfOptions: SearchIndexer/ctfmon=5, fontdrvhost/lsass/sihost=1',
      'FTH Enabled=0, rundll32 fthsvc.dll,FthSysprepSpecialize',
      'MPO OverlayTestMode=5',
      'Memory Compression: Disable-MMAgent -MemoryCompression',
      'Process mitigations: Set-ProcessMitigation -SYSTEM -Disable <all>, MitigationOptions/AuditOptions=0x22 для fontdrvhost/dwm/lsass/svchost/WmiPrvSE/winlogon/csrss/ntoskrnl/services и kernel',
      'Mitigations: vgc.exe (Valorant CFG), osu!.exe (ASLR)',
      'WINEVT channels: все Enabled=0',
      'DMA remapping: DmaGuard DeviceEnumerationPolicy=2, DmaRemappingCompatible=0',
      'MSI mode: MSISupported=1 для PCI видеокарт, сетевых, IDE',
      'wevtutil sl SleepStudy/Kernel-Processor-Power/UserModePowerService /e:false',
      'BootExecute="autocheck autochk /k:C*" (без проверки C:)',
      'DisableWpbtExecution=1',
      'fsutil: disable8dot3=1, disabledeletenotify=0, disablelastaccess=1, encryptpagingfile=0',
      'bcdedit: /timeout 10, /set {current} description "VampireOS"',
    ],
  },
  {
    icon: '🌐',
    name: 'Сеть и TCP',
    desc: 'TCP-параметры настраиваются на низкую задержку. Wi-Fi Sense и авто-подключение к открытым хотспотам отключаются.',
    items: [
      'TCP/IP: DefaultTTL=65 (v4/v6), TcpAckFrequency=1, TcpDelAckTicks=0, TCPNoDelay=1 (Ethernet, не Wi-Fi)',
      'Psched: NonBestEffortLimit=0, TimerResolution=10',
      'Dnscache: EnableNetbios=0, DisableCoalescing=1',
      'WinHttp: DisableWpad=1',
      'DNSClient: MaxNegativeCacheTtl=5',
      'BFE: CollectNetEvents=0',
      'Dhcp: PdcActivationDisabled=1',
      'Wi-Fi Sense: AutoConnectAllowedOEM=0, PaidWifi=0, WiFiSenseOpen=0',
      'Wi-Fi: AllowWiFiHotSpotReporting=0, AllowAutoConnectToWiFiSenseHotspots=0',
    ],
  },
  {
    icon: '🖥️',
    name: 'Проводник, UI и уведомления',
    desc: 'Интерфейс ускоряется: меню без задержки, анимации отключены, лишние элементы скрыты. Уведомления и рекомендации отключены.',
    items: [
      'Классическое контекстное меню Windows 11 (CLSID {86ca1aa0-...})',
      'Take Ownership для *, Directory, dllfile, exefile (takeown + icacls /grant *S-1-3-4:F)',
      'MenuShowDelay=0, MinAnimate=0, DragFullWindows=0, VisualFXSetting=3',
      'ListviewAlphaSelect=0, ListviewShadow=0, TaskbarAnimations=0',
      'EnableAeroPeek=0, AlwaysHibernateThumbnails=0, PenWorkspaceButtonDesiredVisibility=0',
      'TaskbarAl=0, TaskbarEndTask=1, ShowTaskViewButton=0, TaskbarDa=0, TaskbarMn=0',
      'SearchboxTaskbarMode=1, ShowSecondsInSystemClock=1',
      'Показ скрытых файлов, показ расширений, полный путь в заголовке',
      'Проводник открывается на «Этот компьютер»',
      'Убран « - Shortcut» у ярлыков, уменьшены кнопки окна (CaptionHeight/Width=-270)',
      'Скрыты Gallery/Home ({e88865ea…}, {f874310e…}, {F02C1A0D…})',
      'Отключены недавние/частые файлы, история поиска, рекомендации в Пуске',
      'ToastEnabled=0, NoCloudApplicationNotification=1, NoBalloonFeatureAdvertisements=1, NoAutoTrayNotify=1',
      'SecurityAndMaintenance и BackupReminder уведомления — отключены',
      'DisableProjectedShadows=1, MousewheelAnimationDurationMs=0, DisableGlobalAnimations=1, DisableLogonBackgroundImage=1',
      'Блок shell extensions: {e2bf9676-…}, {596AB062-…}',
    ],
  },
  {
    icon: '🖱️',
    name: 'Мышь, клавиатура, ввод',
    desc: 'Ускорение мыши и задержки hover отключены. Автозамена и предиктивный ввод отключены.',
    items: [
      'MouseSpeed=0, MouseThreshold1=0, MouseThreshold2=0',
      'MouseHoverTime=0',
      'Keyboard Response / StickyKeys / ToggleKeys / MouseKeys Flags=0',
      'HungAppTimeout=2000, WaitToKillAppTimeout=2000, LowLevelHooksTimeout=1000',
      'UserPreferencesMask=9012038012000000',
      'EnableAutocorrection=0, EnableSpellchecking=0, EnableTextPrediction=0',
      'EnablePredictionSpaceInsertion=0, EnableDoubleTapSpace=0',
      'InsightsEnabled=0, EnableHwkbTextPrediction=0, EnableHwkbAutocorrection=0',
      'Input: IsInputAppPreloadEnabled=0, BluebirdDTWMultiplier=0, DisableExpressiveInputShellHotkey=1, DisablePersonalizationGTKM=1, DynamicAutocorrectionAllowed=0, CursorMagnetism=0',
    ],
  },
  {
    icon: '🖨️',
    name: 'Службы, принтер и факс',
    desc: 'Отключаются службы печати и факса, а также фоновые диагностические службы. Драйверы принтеров остаются — службы включаются обратно вручную за 10 секунд.',
    items: [
      'Spooler, PrintNotify, PrintWorkflowUserSvc, PrintDeviceConfigurationService, PrintScanBrokerService → отключены',
      'Fax → отключён',
      'diagsvc, embeddedmode, DPS, wercplsupport, WerSvc, Telemetry, DiagTrack → отключены',
      'diagnosticshub.standardcollector.service, dmwappushservice, wisvc, PcaSvc → отключены',
      'WdiServiceHost, WdiSystemHost, tcpipreg, Wecsvc, UCPD → отключены',
      'MapsBroker, RetailDemo, RemoteRegistry, TrkWks, WMPNetworkSvc → отключены',
      'WaaSMedicSvc, UsoSvc → отключены',
      'condrv → auto, w32time → demand',
      'Темы (Themes, UxSms), Bluetooth, батарея, тачпад, питание — не трогаются',
    ],
  },
  {
    icon: '📜',
    name: 'Журналы и события',
    desc: 'Диагностическое и отладочное журналирование отключается. Event Viewer и сами журналы остаются на месте.',
    items: [
      'EventLog\\Application AutoBackupLogFiles=0',
      'DefenderApiLogger Start=0, DefenderAuditLogger Start=0',
      'GDIEnableReferenceStackTraces=0, USERExtraInstrumentations=0, USERPostMortemLogging=0',
      'Win32kWPP VerboseOn=0, Winlogon NoDebugThread=1, RsopLogging=0',
      'UIPI EnableMessageSQM=0, LSA EtwDirect=0, LSA TracingDisabled=1',
      'Wdf WdfGlobalLogsDisabled=1, WdfGlobalSleepStudyDisabled=1',
      'Diagnostics\\Performance DisableDiagnosticTracing=1',
      'wevtutil el | % { wevtutil cl } — очистка всех журналов',
    ],
  },
  {
    icon: '🧹',
    name: 'Прочее',
    desc: 'Отключаются ReserveManager, Storage Sense, GameDVR, FSO, Office-логи, bloatware-автоустановка и лишние политики.',
    items: [
      'ReserveManager ShippedWithReserves=0',
      'StorageSense StoragePolicy01 / StoragePolicy04=0',
      'MobilityCenter=0',
      'GameBar AllowAutoGameMode / AutoGameModeEnabled=0',
      'GameDVR AllowGameDVR=0',
      'DisableFullscreenOptimizations=1',
      'GameConfigStore FSEBehavior=2, HonorUserFSEBehaviorMode=1, DXGIHonorFSEWindowsCompatible=1',
      'CloudStore StoreInitState=5',
      'SettingSync SyncPolicy=5',
      'CI Config VulnerableDriverBlocklistEnable=0',
      'Office ClickToRun DisableLogManagement=1, TimerInterval=900000, RSoPLogging=0',
      'Bloatware auto-install: ConfigureChatAutoInstall=0, SilentInstalledAppsEnabled=0, OemPreInstalledAppsEnabled=0, PreInstalledAppsEnabled=0, FeatureManagementEnabled=0, RotatingLockScreen*=0',
      'OOBE: HideOnlineAccountScreens, HideEULAPage, HideWirelessSetupInOOBE, NetworkLocation=Home, ProtectYourPC=3, DisablePrivacyExperience, HideOEMRegistrationScreen, EnableCortanaVoice=0, DisableVoice=1, HideLocalAccountScreen=0, Skype consent=0',
      'System Restore: RPSessionInterval=0, DiskPercent=0, удаление SPP\\Clients',
      'Set-WindowsReservedStorageState=Disabled',
      'label C: VampireOS',
    ],
  },
  {
    icon: '📂',
    name: 'Меню «Создать» и подменю питания',
    desc: 'В правый клик Windows добавляются готовые пункты для быстрого создания файлов, а на рабочем столе — подменю переключения схем электропитания VampireOS. Всё создаётся тем же VampireOS.bat — отдельного сетапа нет.',
    items: [
      'Контекстное меню «Создать» (правый клик по папке/рабочему столу) — добавлены пункты для .bat, .reg, .ps1, .vbs',
      'Реализовано через ShellNew + NullFile: пустой файл с нужным расширением создаётся в один клик',
      'Три схемы электропитания VampireOS создаются на базе стандартных схем Windows:',
      '  • Balanced Performance VampireOS — база «Сбалансированная», GUID 90a358c8-3bbc-4fb3-8b4e-d7ab065d2614',
      '  • Maximum Performance VampireOS — база «Высокая производительность», GUID a1b2c3d4-e5f6-4789-a0ab-cdef12345678',
      '  • Power Saving VampireOS — база «Экономия энергии», GUID d8e76bb7-6943-4b7c-ab30-441296b72264',
      'Безопасные твики во всех трёх схемах: HDD не отключается (disk-idle 0), USB selective suspend отключён, разумные таймауты экрана',
      'Таймауты экрана по схемам: Balanced 15/5 мин, Maximum 15/10 мин, Power Saving 5/2 мин (сеть/батарея)',
      'Подменю «Выбор плана электропитания» в правом клике на рабочем столе (HKCR\\DesktopBackground\\Shell\\PowerPlan)',
      'В подменю: 3 схемы VampireOS + стандартная «Сбалансированная» + «Электропитание...» (control.exe powercfg.cpl)',
      'По умолчанию после запуска активна «Balanced Performance VampireOS»',
      'Идемпотентно: повторный запуск VampireOS.bat пересоздаёт схемы — старые копии удаляются перед созданием, дубликатов не будет',
      'Перед удалением кастомных схем скрипт принудительно переключается на стандартную «Сбалансированную» (Windows не даёт удалить активную схему)',
    ],
  },
  {
    icon: '🛡️',
    name: 'Что остаётся на месте',
    desc: 'Базовые инструменты и системные компоненты. Ничего из этого не удаляется и не блокируется.',
    items: [
      'Notepad, Paint — работают как обычно',
      'Snipping Tool / ScreenSketch / ScreenClippingHost — скриншотер Windows 11 с выделением области',
      'PrtScn → Snipping Tool, Win+Shift+S → ScreenClippingHost',
      'Microsoft Edge — не удаляется и не блокируется (EdgeUpdate policies лишь блокируют установку/обновление)',
      'Службы тем: Themes, UxSms',
      'Bluetooth, батарея, тачпад — службы и драйверы ноутбука',
      'Питание и энергосбережение: HibernateEnabled, PowerThrottlingOff, PagingFiles',
      'Сжатие: compact / WOF / fsutil compression',
      'Сторонние оптимизаторы: службы и планы питания',
    ],
  },
  {
    icon: '⚡',
    name: 'Питание (Power Max / Power Save)',
    desc: 'Отдельные батники, не входят в VampireOS.bat. УБИТЬ KCAS И XEON — максимум производительности, РЕЖИМ ДЕДА — максимум энергосбережения. Оба обратимы кнопкой ↺. Три схемы VampireOS при этом создаются основным VampireOS.bat, а не этими кнопками.',
    items: [
      'УБИТЬ KCAS И XEON: Ultimate Performance, CPU 100% на AC, idle off, core parking off, гибернация off, Power Throttling off, BCD disabledynamictick yes, USB suspend off, Memory Compression off, MSI mode on, DMA remapping off, MPO off, NIC power saving off',
      'УБИТЬ KCAS И XEON — таймауты «никогда»: powercfg /x monitor-timeout-ac 0 / -dc 0; disk-timeout-ac 0 / -dc 0; standby-timeout-ac 0 / -dc 0; hibernate-timeout-ac 0 / -dc 0',
      'УБИТЬ KCAS И XEON — службы: serial / sermouse / serenum Start=3 (manual), wlansvc / wmiacpi Start=2 (auto)',
      'УБИТЬ KCAS И XEON — Power Throttling off (PowerThrottlingOff=1). ⚠️ Не путать: =0 включает throttling и относится к Saver/Restore',
      'РЕЖИМ ДЕДА: Power Saver, CPU 5%/50%, idle on, core parking aggressive, boost off, cool passive, monitor 5, disk 5, sleep 15, hibernate 60, яркость 30%, Power Throttling on, гибернация on, USB suspend on, NIC power saving on, battery saver 20%',
      '↺ (после УБИТЬ KCAS И XEON) — возврат таймаутов: monitor 10/5, disk 20/10, sleep 30/15, hibernate 180/60; PowerThrottlingOff=0; serial/sermouse/serenum/wlansvc/wmiacpi Start=2 (auto)',
      '↺ (после УБИТЬ KCAS И XEON) → Power Restore: Balanced, CPU 5%/100%, idle on, гибернация on, Power Throttling on, USB suspend on, Memory Compression on, MSI mode off, DMA remapping on, MPO on',
      '↺ (после РЕЖИМ ДЕДА) → Power Save Restore: Balanced, таймауты по умолчанию, яркость 100%',
      'Оба батника: Themes, UxSms, Bluetooth, CmBatt, HidBatt, acpiex, acpipagr, acpipmi, acpitime, GpuEnergyDrv — НЕ ТРОГАЮТСЯ',
      '⚠️ УБИТЬ KCAS И XEON на ноутбуке: быстрее садится батарея, возможны BSOD из-за MSI mode, гибернация off → потеря данных при разряде, DMA remapping off → слабее защита Thunderbolt/M.2',
      '⚠️ УБИТЬ KCAS И XEON НЕ рекомендуется на ноутбуках. Для ноутбука используй РЕЖИМ ДЕДА или Balanced.',
    ],
  },
];

export async function renderHardMode() {
  const tabsNav = document.getElementById('tabs-nav');
  const content = document.getElementById('tab-content');
  tabsNav.innerHTML = '';
  content.innerHTML = '';

  const skullIcon = papirusUrl('status', 'dialog-warning');

  const styleTag = document.createElement('style');
  styleTag.textContent = `
    @keyframes firePulse {
      0%, 100% { filter: drop-shadow(0 0 8px rgba(255,120,0,0.65)) drop-shadow(0 0 22px rgba(255,60,0,0.45)) drop-shadow(0 0 44px rgba(255,0,0,0.20)); transform: scale(1); }
      50% { filter: drop-shadow(0 0 16px rgba(255,170,0,0.95)) drop-shadow(0 0 40px rgba(255,80,0,0.65)) drop-shadow(0 0 80px rgba(255,0,0,0.35)); transform: scale(1.02); }
    }
    @keyframes fireFlicker {
      0% { background-position: 0% 50%; } 25% { background-position: 50% 50%; }
      50% { background-position: 100% 50%; } 75% { background-position: 50% 50%; }
      100% { background-position: 0% 50%; }
    }
    @keyframes emberRise {
      0% { opacity: 0; transform: translateY(0) scale(1); }
      15% { opacity: .95; }
      100% { opacity: 0; transform: translateY(-90px) scale(.35); }
    }
    @keyframes heatHaze {
      0%, 100% { opacity: .55; transform: scale(1); }
      50% { opacity: .85; transform: scale(1.06); }
    }
    @keyframes metalSheen {
      0%, 100% { filter: brightness(1) contrast(1.05); }
      50% { filter: brightness(1.12) contrast(1.15); }
    }
    .fire-title {
      font-family: 'Old English Text MT', 'Blackadder ITC', 'Segoe Script', 'Impact', 'Arial Black', sans-serif;
      font-weight: 900; letter-spacing: 4px; line-height: 1.02; text-transform: uppercase;
      background: linear-gradient(90deg, #7a0e00 0%, #ff2d00 12%, #ff6a00 28%, #ffb300 42%, #fff6b0 50%, #ffb300 58%, #ff6a00 72%, #ff2d00 88%, #7a0e00 100%);
      background-size: 300% 100%; -webkit-background-clip: text; background-clip: text;
      color: transparent; -webkit-text-fill-color: transparent;
      animation: firePulse 2.6s ease-in-out infinite, fireFlicker 3.4s linear infinite, metalSheen 5s ease-in-out infinite;
    }
    .fire-glow { position: absolute; inset: -10%; background: radial-gradient(circle at 50% 55%, rgba(255,90,0,0.30) 0%, rgba(255,40,0,0.18) 30%, transparent 65%); filter: blur(28px); animation: heatHaze 3.2s ease-in-out infinite; pointer-events: none; z-index: 0; }
    .ember { position: absolute; bottom: 10%; width: 6px; height: 6px; border-radius: 50%; background: radial-gradient(circle, #ffe08a 0%, #ff6a00 55%, transparent 100%); pointer-events: none; z-index: 1; animation: emberRise 2.8s ease-out infinite; }
    .deadly-log { margin-top: 12px; background: var(--bg-alt); border: 1px solid var(--border); border-radius: 8px; padding: 10px 12px; font-family: Consolas, "Courier New", monospace; font-size: 11.5px; line-height: 1.45; color: var(--fg-muted); max-height: 260px; overflow-y: auto; white-space: pre-wrap; word-break: break-word; display: none; }
    .deadly-log.active { display: block; }
    .deadly-log .log-line { display: block; }
    .deadly-log .log-ok { color: var(--success); }
    .deadly-log .log-err { color: var(--danger); }
    .deadly-log .log-info { color: var(--fg); }

    .btn-power-max {
      width: 100%; padding: 12px; font-size: 13px; font-weight: 700;
      white-space: normal; word-break: break-word;
      background: rgba(217,59,59,0.18); border: 1px solid var(--danger); color: var(--danger);
    }
    .btn-power-save {
      width: 100%; padding: 12px; font-size: 13px; font-weight: 700;
      white-space: normal; word-break: break-word;
      background: rgba(64,160,64,0.18); border: 1px solid var(--success); color: var(--success);
    }
    .btn-cancel {
      width: 100%; padding: 12px; font-size: 18px; font-weight: 700;
      background: var(--bg-alt); border: 1px solid var(--border); color: var(--fg);
    }
    .power-grid {
      display: grid; grid-template-columns: 1fr 48px; gap: 8px;
    }

    @media (prefers-reduced-motion: reduce) { .fire-title, .fire-glow, .ember { animation: none !important; } .ember { display: none; } }
  `;
  content.appendChild(styleTag);

  const root = document.createElement('div');
  root.style.cssText = `display: grid; grid-template-columns: minmax(260px, 320px) 1fr minmax(300px, 380px); gap: 18px; align-items: stretch; min-height: calc(100vh - 140px); background: transparent; border: none;`;

  const left = document.createElement('div');
  left.className = 'panel';
  left.style.cssText = 'display:flex;flex-direction:column;gap:14px;';
  left.innerHTML = `
    <div style="background: rgba(217,59,59,0.16); border: 2px solid var(--danger); border-radius: 10px; padding: 16px; text-align: center;">
      <div style="display:flex;align-items:center;justify-content:center;gap:8px;margin-bottom:8px;">
        <img src="${skullIcon}" alt="" style="width:22px;height:22px;object-fit:contain;" onerror="this.style.display='none'">
        <b style="color:var(--danger);font-size:15px;letter-spacing:.5px;">ВНИМАНИЕ</b>
        <img src="${skullIcon}" alt="" style="width:22px;height:22px;object-fit:contain;" onerror="this.style.display='none'">
      </div>
      <p style="color:var(--danger);font-weight:700;font-size:12.5px;margin:0 0 6px;">
        ИЗМЕНЕНИЯ ВНОСЯТСЯ В РЕЕСТР, СЛУЖБЫ И СИСТЕМНЫЕ ФАЙЛЫ.<br>
        ЧАСТЬ ИЗМЕНЕНИЙ (DEFENDER, ONEDRIVE) НЕОБРАТИМА.
      </p>
      <p style="color:var(--danger);font-weight:700;font-size:12.5px;margin:0;border-top:1px dashed var(--danger);padding-top:8px;">
        ПЕРЕД ЗАПУСКОМ СОЗДАЙТЕ ТОЧКУ ВОССТАНОВЛЕНИЯ.
      </p>
    </div>

    <button class="btn danger" id="btn-deadly-apply"
      style="width:100%;padding:14px;font-size:14px;font-weight:700;white-space:normal;word-break:break-word;">
      УСТАНОВИТЬ VAMPIREOS
    </button>

    <div class="power-grid">
      <button class="btn btn-power-max" id="btn-power-max">УБИТЬ KCAS И XEON</button>
      <button class="btn btn-cancel" id="btn-power-max-cancel" title="Вернуть Balanced после УБИТЬ KCAS И XEON">↺</button>

      <button class="btn btn-power-save" id="btn-power-save">РЕЖИМ ДЕДА</button>
      <button class="btn btn-cancel" id="btn-power-save-cancel" title="Вернуть Balanced после РЕЖИМ ДЕДА">↺</button>
    </div>

    <div id="deadly-status" style="font-size:12px;white-space:pre-line;font-weight:600;color:var(--fg-muted);min-height:16px;"></div>
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

  const center = document.createElement('div');
  center.style.cssText = `position:relative; display:flex; align-items:center; justify-content:center; text-align:center; padding:20px; overflow:hidden; background: radial-gradient(circle at 50% 60%, rgba(255,80,0,0.10), transparent 65%), radial-gradient(circle at 50% 40%, rgba(217,59,59,0.08), transparent 55%); border-radius:10px;`;
  center.innerHTML = `
    <span class="ember" style="left:18%;animation-delay:0s;"></span>
    <span class="ember" style="left:32%;animation-delay:.7s;"></span>
    <span class="ember" style="left:47%;animation-delay:1.4s;"></span>
    <span class="ember" style="left:61%;animation-delay:.4s;"></span>
    <span class="ember" style="left:74%;animation-delay:1.1s;"></span>
    <span class="ember" style="left:86%;animation-delay:1.9s;"></span>
  `;
  root.appendChild(center);

  const right = document.createElement('div');
  right.className = 'panel';
  right.style.cssText = 'display:flex;flex-direction:column;gap:10px;overflow-y:auto;max-height:calc(100vh - 140px);';
  const rightHeader = document.createElement('div');
  rightHeader.style.cssText = 'font-size:13px;font-weight:700;color:var(--fg);padding-bottom:6px;border-bottom:1px solid var(--border);';
  rightHeader.textContent = 'Что будет сделано';
  right.appendChild(rightHeader);
  OPTIMIZATION_CATEGORIES.forEach((cat) => {
    const block = document.createElement('div');
    block.style.cssText = `background: var(--bg-alt); border-radius: 8px; padding: 10px 12px;`;
    const itemsHtml = (cat.items || []).map((it) => `<li style="margin:4px 0 0;">${it}</li>`).join('');
    block.innerHTML = `
      <div style="display:flex;align-items:center;gap:8px;margin-bottom:4px;">
        <span style="font-size:14px;">${cat.icon}</span>
        <b style="font-size:12.5px;flex:1;">${cat.name}</b>
      </div>
      <div style="color:var(--fg-muted);font-size:11.5px;line-height:1.5;">${cat.desc}</div>
      ${itemsHtml ? `<ul style="margin:8px 0 0;padding-left:16px;color:var(--fg-muted);font-size:11px;line-height:1.5;">${itemsHtml}</ul>` : ''}
    `;
    right.appendChild(block);
  });
  root.appendChild(right);
  content.appendChild(root);

  const logEl = left.querySelector('#deadly-log');
  function logLine(text, kind = 'info') {
    logEl.classList.add('active');
    const line = document.createElement('span');
    line.className = 'log-line' + (kind === 'ok' ? ' log-ok' : kind === 'err' ? ' log-err' : ' log-info');
    line.textContent = text;
    logEl.appendChild(line);
    logEl.scrollTop = logEl.scrollHeight;
  }
  function logReset() { logEl.innerHTML = ''; logEl.classList.remove('active'); }

  const statusEl = left.querySelector('#deadly-status');
  const applyBtn = left.querySelector('#btn-deadly-apply');
  const powerMaxBtn = left.querySelector('#btn-power-max');
  const powerMaxCancelBtn = left.querySelector('#btn-power-max-cancel');
  const powerSaveBtn = left.querySelector('#btn-power-save');
  const powerSaveCancelBtn = left.querySelector('#btn-power-save-cancel');
  const allBtns = [applyBtn, powerMaxBtn, powerMaxCancelBtn, powerSaveBtn, powerSaveCancelBtn];

  async function runBat(rel, label) {
    statusEl.textContent = `Запуск: ${label}… Не выключайте ПК.`;
    statusEl.style.color = 'var(--fg)';
    allBtns.forEach(b => { b.disabled = true; b.style.opacity = '.6'; });
    logReset();
    logLine(`▶ Запуск: ${label}`, 'info');
    logLine(`  Файл: ${rel}`, 'info');
    try {
      await loggedRunStream('tweaks/' + rel, {
        onChunk: (chunk) => { if (chunk && chunk.text) logLine(chunk.text, chunk.stream === 'stderr' ? 'err' : 'info'); },
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
          allBtns.forEach(b => { b.disabled = false; b.style.opacity = '1'; });
        }
      });
    } catch (e) {
      logLine(`✖ Исключение: ${e?.message || e}`, 'err');
      statusEl.textContent = `❌ Ошибка: ${e?.message || e}`;
      statusEl.style.color = 'var(--danger)';
      toast('Ошибка: ' + (e?.message || e), 'error', 6000);
      Sound.error();
      allBtns.forEach(b => { b.disabled = false; b.style.opacity = '1'; });
    }
  }

  applyBtn.addEventListener('click', () => { Sound.click(); runBat(APPLY_BAT, 'Оптимизация VampireOS'); });

  powerMaxBtn.addEventListener('click', () => {
    Sound.click();
    const ok = window.confirm(
      'УБИТЬ KCAS И XEON — только для десктопов.\n\n' +
      'На ноутбуке:\n' +
      '• быстрее садится батарея (USB suspend off, disabledynamictick, Power Throttling off)\n' +
      '• возможны BSOD/зависания из-за принудительного MSI mode\n' +
      '• гибернация off → потеря данных при разряде батареи\n' +
      '• DMA remapping off → слабее защита Thunderbolt/M.2\n\n' +
      'Для ноутбука используй РЕЖИМ ДЕДА.\n' +
      '↺ возвращает всё обратно.\n\n' +
      'Продолжить?'
    );
    if (ok) runBat(POWER_MAX_BAT, 'УБИТЬ KCAS И XEON');
  });

  powerMaxCancelBtn.addEventListener('click', () => { Sound.click(); runBat(POWER_MAX_RESTORE_BAT, 'Power Restore (после УБИТЬ KCAS И XEON)'); });

  powerSaveBtn.addEventListener('click', () => { Sound.click(); runBat(POWER_SAVE_BAT, 'РЕЖИМ ДЕДА'); });

  powerSaveCancelBtn.addEventListener('click', () => { Sound.click(); runBat(POWER_SAVE_RESTORE_BAT, 'Power Restore (после РЕЖИМ ДЕДА)'); });
}