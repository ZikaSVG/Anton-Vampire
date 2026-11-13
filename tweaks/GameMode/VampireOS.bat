@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title VampireOS.bat
cd /d "%~dp0"

rem ============================================================================
rem  VampireOS.bat — полный перечень изменений
rem  ---------------------------------------------------------------------------
rem  Скрипт применяет набор твиков к Windows 10/11 от имени администратора.
rem  Ниже — что именно и зачем меняется, по разделам.
rem
rem  1) ОБЩИЕ СВЕДЕНИЯ
rem     - Проверка прав администратора: без прав — сообщение и выход.
rem     - Проверка наличия рядом с батником двух файлов:
rem         NSudoLG.exe    — удаление защищённых системных файлов
rem                          (Defender, OneDrive в WinSxS/System32).
rem         wallpaper.jpg  — обои текущему пользователю и в Default.
rem       Если файлов нет — шаги пропускаются с сообщением.
rem
rem  2) БРЕНДИНГ / OEM
rem     - EditionSubManufacturer / EditionSubstring / EditionSubVersion
rem       в HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion — видны
rem       в winver и «Параметрах».
rem     - OEMInformation (Manufacturer, SupportProvider, SupportAppURL,
rem       SupportURL, HelpCustomized=1) — блок «Сведения о производителе».
rem
rem  3) ПРОВОДНИК / UI
rem     - Классическое контекстное меню Windows 11: пустой InprocServer32
rem       для CLSID {86ca1aa0-34aa-4e8b-a509-50c905bae2a2}.
rem     - Панель задач: SearchboxTaskbarMode=1, ShowTaskViewButton=0,
rem       TaskbarDa=0, TaskbarMn=0, TaskbarEndTask=1, TaskbarAl=0.
rem     - Секунды в трее: ShowSecondsInSystemClock=1.
rem     - Проводник: Hidden=1, HideFileExt=0, FullPath=1, LaunchTo=1,
rem       MultipleInvokePromptMinimum=100, ShowRecommendations=0,
rem       Start_IrisRecommendations=0, Start_AccountNotifications=0,
rem       Start_TrackDocs=0, ShowRecent=0, ShowFrequent=0,
rem       ShowCloudFilesInQuickAccess=0, EnthusiastMode=1,
rem       StartupDelayInMSec=0, FolderType=NotSpecified,
rem       ShortcutNameTemplate без « - Shortcut».
rem     - Меню и таймауты: MenuShowDelay=0, MouseHoverTime=0,
rem       AutoEndTasks=1, HungAppTimeout=2000, WaitToKillAppTimeOut=2000,
rem       JPEGImportQuality=100, WaitToKillServiceTimeout=2000,
rem       DelayedDesktopSwitchTimeout=0, UserSetting_DisableStartupSound=1.
rem     - Уведомления и реклама: NOC_GLOBAL_SETTING_TOASTS_ENABLED=0,
rem       DisableSearchBoxSuggestions=1, EnableFeeds=0,
rem       AllowNewsAndInterests=0, ShellFeedsTaskbarViewMode=2,
rem       AllowOnlineTips=0 (HKLM + Политики + PolicyManager).
rem     - Кнопки окна: CaptionHeight=-270, CaptionWidth=-270;
rem       CursorBlinkRate=250; MinAnimate=0; DragFullWindows=0;
rem       UserPreferencesMask=9012038012000000.
rem     - Скрытие Gallery/Home: три CLSID ({e88865ea…}, {f874310e…},
rem       {F02C1A0D…}) → System.IsPinnedToNameSpaceTree=0.
rem     - «Take Ownership» в контекстном меню файлов и папок:
rem       HKCR\*\shell\runas и HKCR\Directory\shell\runas,
rem       takeown + icacls /grant *S-1-3-4:F. Для папок AppliesTo
rem       исключает C:\Users, C:\ProgramData, C:\Windows,
rem       C:\Windows\System32, C:\Program Files, C:\Program Files (x86).
rem     - Block shell extensions: {e2bf9676-…}, {596AB062-…}
rem       (HKLM + WOW64).
rem     - Визуальные: ListviewAlphaSelect=0, ListviewShadow=0,
rem       TaskbarAnimations=0, VisualFXSetting=3, EnableAeroPeek=0,
rem       AlwaysHibernateThumbnails=0, PenWorkspaceButtonDesiredVisibility=0,
rem       DirectXUserGlobalSettings=SwapEffectUpgradeEnable=1;VRROptimizeEnable=0,
rem       HwSchMode=2 (если build ≥19041), OverlayTestMode=5 (MPO off),
rem       DisableProjectedShadows=1, MousewheelAnimationDurationMs=0,
rem       DisableGlobalAnimations=1, DisableLogonBackgroundImage=1,
rem       PenVisualization=0, AutoColorization=0, SmoothScroll=0,
rem       Desktop Slideshow AnimationDuration=0,
rem       DisablePreviewDesktop=1, DisablePreviewWindow=1, NoNetCrawling=1.
rem     - W10-specific: TipbandDesiredVisibility=0, PeopleBand=0,
rem       HideSCAMeetNow=1 (user + policy), 3D Objects из This PC удалён.
rem     - W11-specific: TaskbarAl=0, TaskbarEndTask=1, IsResumeAllowed=0.
rem
rem  4) ПРИВАТНОСТЬ / ТЕЛЕМЕТРИЯ
rem     - AllowTelemetry=0 (HKLM Policies, HKLM CurrentVersion,
rem       Wow6432Node, PolicyManager, CPSS).
rem     - AllowDeviceNameInTelemetry=0, AllowDesktopAnalyticsProcessing=0,
rem       AllowCommercialDataPipeline=0, DisableOneSettingsDownloads=1,
rem       DoNotShowFeedbackNotifications=1, LimitDiagnosticLogCollection=1,
rem       LimitDumpCollection=1, MicrosoftEdgeDataOptIn=0.
rem     - Siuf: NumberOfSIUFInPeriod=0, PeriodInNanoSeconds удалён.
rem     - AppCompat: DisableEngine=1, AITEnable=0, DisableUAR=1,
rem       DisablePCA=1, DisableInventory=1.
rem     - CEIP/SQM: SQMClient\Windows CEIPEnable=0,
rem       Microsoft\Windows\SQMClient UploadDisableFlag=1.
rem     - CloudContent (HKLM + HKCU): DisableSoftLanding=1,
rem       DisableWindowsSpotlightFeatures=1, DisableCloudOptimizedContent=1,
rem       DisableWindowsConsumerFeatures=1, DisableThirdPartySuggestions=1,
rem       DisableTailoredExperiencesWithDiagnosticData=1,
rem       DisableWindowsSpotlightOnActionCenter/OnSettings/WelcomeExperience=1.
rem     - Content Delivery Manager: все SubscribedContent-* = 0,
rem       ContentDeliveryAllowed=0, SilentInstalledAppsEnabled=0,
rem       PreInstalledAppsEnabled/EverEnabled=0,
rem       OemPreInstalledAppsEnabled=0, FeatureManagementEnabled=0,
rem       RotatingLockScreen*=0, SystemPaneSuggestions=0;
rem       Subscriptions и SuggestedApps удалены.
rem     - Рекламный ID: AdvertisingInfo Enabled=0 (HKCU + HKLM), Id удалён,
rem       DisabledByGroupPolicy=1.
rem     - Язык и ввод: HttpAcceptLanguageOptOut=1, HasAccepted=0,
rem       AllowLinguisticDataCollection=0, TIPC Enabled=0 (HKCU + HKLM),
rem       AllowInputPersonalization=0, RestrictImplicitInkCollection=1,
rem       RestrictImplicitTextCollection=1, HarvestContacts=0,
rem       AcceptedPrivacyPolicy=0, PreventHandwritingErrorReports=1,
rem       PreventHandwritingDataSharing=1.
rem     - TailoredExperiences=0, EnableActivityFeed=0,
rem       PublishUserActivities=0, UploadUserActivities=0.
rem     - App Permissions (ConsentStore): Deny для location, activity,
rem       userAccountInformation, appointments, userDataTasks, chat, radios,
rem       bluetoothSync, appDiagnostics, documentsLibrary, picturesLibrary,
rem       videosLibrary, broadFileSystemAccess, phoneCallHistory, email,
rem       contacts. Allow для webcam и microphone.
rem     - Wi-Fi Sense: AutoConnectAllowedOEM=0, PaidWifi=0, WiFiSenseOpen=0,
rem       AllowWiFiHotSpotReporting=0, AllowAutoConnectToWiFiSenseHotspots=0.
rem     - WER: Disabled=1 (HKLM + Политики + Политики\WER),
rem       DontSendAdditionalData=1, LoggingDisabled=1, DefaultConsent=1,
rem       DefaultOverrideBehavior=1, DisableArchive=1, DisableWerUpload=1.
rem     - Cortana: AllowCortana=0, AllowCortanaAboveLock=0,
rem       PolicyManager AllowCortana=0, CortanaEnabled=0,
rem       CanCortanaBeEnabled=0, CortanaConsent=0.
rem     - Поиск: BingSearchEnabled=0, DisableSearchBoxSuggestions=1,
rem       HistoryViewEnabled=0, DeviceHistoryEnabled=0, AllowCloudSearch=0,
rem       AllowSearchToUseLocation=0, ConnectedSearchUseWeb=0,
rem       DisableWebSearch=1, ConnectedSearchPrivacy=3,
rem       PreventIndexOnBattery=1, PreventIndexingLowDiskSpaceMB=2048,
rem       DisableRemovableDriveIndexing=1, PreventIndexingOutlook=1,
rem       EnableDynamicContentInWSB=0, SetupCompletedSuccessfully=0.
rem     - Голос: VoiceActivationOn=0, VoiceShortcut=0,
rem       VoiceActivationEnableAboveLockscreen=0, ModelDownloadAllowed=0,
rem       VoiceActivationDefaultOn=0, OOBE DisableVoice=1.
rem     - Облачный буфер: CloudClipboardAutomaticUpload=0,
rem       CloudClipRDPOverride=0, EnableClipboardHistory=0,
rem       AllowCrossDeviceClipboard=0.
rem     - Cross-Device Resume: DisableCrossDeviceResume=1,
rem       IsResumeAllowed=0.
rem     - Find My Device / Location Sync: AllowFindMyDevice=0,
rem       LocationSyncEnabled=0.
rem     - Copilot / AI: DisableAIDataAnalysis=1, TurnOffWindowsCopilot=1,
rem       IsUserEligible=0, ShowCopilotButton=0, AllowRecallEnablement=0,
rem       AutoOpenCopilotLargeScreens=0.
rem     - SettingSync: DisableSettingSync=2, DisableSettingSyncUserOverride=1,
rem       DisableSyncOnPaidNetwork=1, SyncPolicy=5, AllowSyncMySettings=0,
rem       все Groups\* Enabled=0.
rem     - Find My Device, Dsh News and Interests, NoGenTicket,
rem       EnableProtectedEventLogging=0, TIPC=0, MaxTelemetryAllowed=0.
rem     - Автоустановка bloatware: Communications ConfigureChatAutoInstall=0,
rem       SilentInstalledAppsEnabled=0, OemPreInstalledAppsEnabled=0,
rem       PreInstalledAppsEnabled/EverEnabled=0, FeatureManagementEnabled=0,
rem       RotatingLockScreenEnabled/OverlayEnabled=0, SoftLandingEnabled=0,
rem       SystemPaneSuggestionsEnabled=0,
rem       SubscribedContent-310093/338388/338389/353698=0.
rem     - Delivery Optimization: DODownloadMode=0 (HKLM Политики + Config +
rem       HKU\S-1-5-20 + HKCU).
rem     - Запись поведения: Messenger\Client CEIP=2, SQMClient CEIPEnable=0,
rem       AppCompat DisableUAR=1, Personalization NoLockScreenCamera=1.
rem     - Синхронизация: SettingSync Groups\* Enabled=0, mobsync firewall block.
rem     - Геолокация: DisableLocation/Scripting/WindowsLocationProvider=1.
rem     - Обратная связь: Siuf Rules, DoNotShowFeedbackNotifications=1.
rem     - NVIDIA-телеметрия: NvTelemetryContainer=4,
rem       NvTmRep/NvTmRepOnLogon/NvTmMon tasks disabled.
rem
rem  5) БЕЗОПАСНОСТЬ
rem     - SmartScreen off: Explorer\SmartScreenEnabled=Off (HKLM + WOW64),
rem       Политики\System EnableSmartScreen=0, AppHost Enabled=0,
rem       AppHost PreventOverride=0, EnableWebContentEvaluation=0
rem       (HKCU + Политики), AicEnabled=Anywhere,
rem       IFEO\smartscreen.exe Debugger=taskkill, процесс убит.
rem     - BitLocker: PreventDeviceEncryption=1.
rem     - VBS: EnableVirtualizationBasedSecurity=0.
rem     - HVCI: HypervisorEnforcedCodeIntegrity Enabled=0.
rem     - UAC: EnableLUA=0, ConsentPromptBehaviorAdmin=0,
rem       PromptOnSecureDesktop=0, EnableInstallerDetection=0,
rem       EnableSecureUIAPaths=0, EnableVirtualization=0,
rem       FilterAdministratorToken=0.
rem
rem  6) СИСТЕМА / ЯДРО / СЕТЬ
rem     - Планировщик/мультимедиа: NetworkThrottlingIndex=10,
rem       SystemResponsiveness=10, NoLazyMode=1, Psched TimerResolution=10,
rem       NonBestEffortLimit=0, Win32PrioritySeparation=38.
rem     - Память: DisablePageCombining=1, FeatureSettingsOverride=3,
rem       FeatureSettingsOverrideMask=3, CoalescingTimerInterval=0,
rem       Segment Heap=1, BackgroundLoadKnownDlls=1, TaskhostTimeout=2000,
rem       EnableCpuQuota=0, DisableMitigations=1,
rem       EnableSvchostMitigationPolicy=0, BootExecuteNoPnpSync=1,
rem       SleepStudyDisabled=1 (только лог, не питание).
rem     - События/сервисы: EventSystem ParallelFiringTimeoutEnabled=1,
rem       ComServerShutdownDelayMs=1000, RunLogonScriptSync=0,
rem       RunStartupScriptSync=0, CopyFileBufferedSynchronousIo=1,
rem       BrokerInfrastructure DefaultTriggerCoalescingTime=0,
rem       DisableTriggerCoalescing=1, TokenLeakDetectDelaySecs=30,
rem       AllowAutomaticAppArchiving=0, EnableLinkedConnections=1,
rem       RealTimeIsUniversal=1.
rem     - SvcHostSplitDisable=1 для ключевых служб (BFE, DcomLaunch,
rem       mpssvc, PlugPlay, Power, SamSs, EventSystem, CryptSvc, Dhcp,
rem       Dnscache, DisplayEnhancementService, PcaSvc, WdiSystemHost,
rem       AudioEndpointBuilder, Appinfo, BITS, gpsvc, IKEEXT, iphlpsvc,
rem       LanmanServer, lmhosts, NcbService, RasAuto, RasMan, SENS,
rem       ShellHWDetection, SstpSvc, TrkWks, Winmgmt, EventLog, FontCache,
rem       LanmanWorkstation, NlaSvc, nsi, ProfSvc, Schedule, SessionEnv,
rem       Themes, W32Time, Wcmsvc) — это тюнинг, а не отключение.
rem     - Ввод: IsInputAppPreloadEnabled=0, BluebirdDTWMultiplier=0,
rem       DisableExpressiveInputShellHotkey=1, DisablePersonalizationGTKM=1,
rem       DynamicAutocorrectionAllowed=0,
rem       CursorMagnetism\ClosestInteractiveBoundsUpdateIntervalInMilliseconds=0.
rem     - Логи: KeyGuard DisableTelemetry=1, CatalogDB EnablePerformanceCounters=0,
rem       WMF CallStackTracingEnabled/Noisy=0, Schedule AdapterLoggingEnabled=0,
rem       SecEdit PolicyDebugLevel=0, Windows GDIEnableReferenceStackTraces=0,
rem       USERExtraInstrumentations=0, USERPostMortemLogging=0,
rem       Win32kWPP VerboseOn=0, Winlogon NoDebugThread=1, RsopLogging=0,
rem       UIPI EnableMessageSQM=0, Lsa\Audit EtwDirect=0,
rem       Lsa\Tracing TracingDisabled=1, Wdf WdfGlobalLogsDisabled=1,
rem       WdfGlobalSleepStudyDisabled=1,
rem       Diagnostics\Performance DisableDiagnosticTracing=1.
rem     - Сеть: Dnscache EnableNetbios=0, DisableCoalescing=1,
rem       WinHttp DisableWpad=1, DNSClient MaxNegativeCacheTtl=5,
rem       BFE CollectNetEvents=0, Dhcp PdcActivationDisabled=1,
rem       Tcpip/Tcpip6 DefaultTTL=65, TCPNoDelay/TcpAckFrequency/
rem       TcpDelAckTicks на Ethernet (не Wi-Fi).
rem     - Графика: HwSchMode=2 (build ≥19041), MiracastForceDisable=1,
rem       TdrDelay=12, WarpSupportsResourceResidency=1.
rem     - PowerShell: ExecutionPolicy=Unrestricted,
rem       ModuleLogging/ScriptBlockLogging=0, ftype и HKCR-ассоциации
rem       для .ps1 и .psm1.
rem     - Обход требований: LabConfig BypassSecureBootCheck/TPM/CPU/RAM/
rem       Storage=1, MoSetup AllowUpgradesWithUnsupportedTPMOrCPU=1,
rem       OOBE BypassNRO=1.
rem     - CrashControl: AutoReboot=0, CrashDumpEnabled=3.
rem     - IFEO: CompatTelRunner, AggregatorHost, DeviceCensus, FeatureLoader,
rem       BingChatInstaller, BGAUpsell, BCILauncher → Debugger=taskkill.
rem       PerfOptions: SearchIndexer/ctfmon=5, fontdrvhost/lsass/sihost=1.
rem     - Логон: EnableFirstLogonAnimation=0, DisableStartupSound=1,
rem       DisableAutomaticRestartSignOn=1.
rem     - Аудио: UserDuckingPreference=3 (Do Nothing).
rem     - Office: ClickToRun DisableLogManagement=1, TimerInterval=900000,
rem       RSoPLogging=0.
rem     - MSI в Safe Mode: Minimal и Network → MSIServer=Service.
rem     - FTH: Enabled=0, rundll32 fthsvc.dll,FthSysprepSpecialize.
rem     - MPO: OverlayTestMode=5.
rem     - Memory Compression: Disable-MMAgent -MemoryCompression.
rem     - Process mitigations: Set-ProcessMitigation -SYSTEM -Disable <all>
rem       и MitigationOptions/MitigationAuditOptions=0x22 для fontdrvhost,
rem       dwm, lsass, svchost, WmiPrvSE, winlogon, csrss, ntoskrnl, services
rem       и kernel.
rem     - WINEVT channels: все Enabled=0.
rem     - DMA remapping: DmaGuard DeviceEnumerationPolicy=2,
rem       DmaRemappingCompatible=0 для всех служб с этим параметром.
rem     - MSI mode: MSISupported=1 для PCI видеокарт, сетевых, IDE.
rem     - Teredo: type=default, servername=default.
rem     - wevtutil sl SleepStudy/Kernel-Processor-Power/UserModePowerService
rem       /e:false (только лог, не питание).
rem     - NoMobilityCenter=1 (это UI, не питание).
rem
rem  7) СЛУЖБЫ
rem     - Отключаются только телеметрия, диагностика, принтер, факс:
rem       diagsvc, embeddedmode, DPS, Spooler, PrintNotify,
rem       PrintWorkflowUserSvc, PrintDeviceConfigurationService,
rem       PrintScanBrokerService, Fax, wercplsupport, WerSvc, Telemetry,
rem       DiagTrack, diagnosticshub.standardcollector.service,
rem       dmwappushservice, wisvc, PcaSvc, WdiServiceHost, WdiSystemHost,
rem       tcpipreg, Wecsvc, UCPD, MapsBroker, RetailDemo, RemoteRegistry,
rem       TrkWks, WMPNetworkSvc, WaaSMedicSvc, UsoSvc,
rem       RetailDemo, CSC, CSCSERVICE, troubleshootingsvc, svsvc,
rem       GraphicsPerfSvc, Ndu, dusmsvc, DSSvc, InventorySvc,
rem       WSAIFabricSvc, amdfendr, amdfendrmgr, McpManagementService,
rem       stisvc, usbprint, PrintScanBrokerService, TermService,
rem       UmRdpService, SessionEnv, hyperkbd, hypervideo, vmgid, vpci, vid,
rem       dam, NetBT, MSDTC, midisrv, MicrosoftCopilotElevationService.
rem     - condrv → auto, w32time → demand.
rem     - Отключается задача AppxDeploymentClient\UCPD velocity
rem       (без интерактивных запросов).
rem     - НЕ ТРОГАЮТСЯ: Themes, UxSms; Bluetooth (bttflt, Bth*,
rem       BluetoothUserService, BTAGService, RFCOMM); батарея/ACPI
rem       (CmBatt, HidBatt, acpiex, acpipagr, acpipmi, acpitime);
rem       питание/энергосбережение/гибернация (powercfg -h,
rem       PowerThrottlingOff, EnergyEstimationEnabled,
rem       MSPower_DeviceEnable, USB selective suspend, USBHUB3 LPM/D3Cold,
rem       Teredo AllowLowPowerMode, GpuEnergyDrv).
rem
rem  8) ПЛАНИРОВЩИК
rem     - Отключаются: WU, WER, CEIP, диагностика, обновления, совместимость,
rem       карты, геолокация, сертификаты, Help, HelloFace, AutoLogger,
rem       Offline Files, NlaSvc, User Profile Service, ReFsDedupSvc, UNP,
rem       WOF, AppxDeploymentClient, ApplicationData, Setup, SharedPC,
rem       Workplace Join, InstallService, Subscription, International,
rem       LanguageComponentsInstaller, Printing, ContactSupport, RetailDemo,
rem       Ras, DUSM, Windows Filtering Platform, WindowsUpdate,
rem       Storage Tiers Management, WindowsAI, AppID, BrokerInfrastructure,
rem       CEIP, File Classification, FileHistory, DeviceDirectoryClient,
rem       License Manager, Location, Windows Defender, ExploitGuard,
rem       CloudExperienceHost, CloudRestore, PushToInstall, UPnP,
rem       UpdateOrchestrator (все), WaaSMedic.
rem     - Вызовы schtasks с "< nul" и "> nul 2>&1" — не ждут ввод.
rem     - Office-задачи через Get-ScheduledTask + Disable-ScheduledTask
rem       -Confirm:$false с "< nul" — без интерактивных запросов.
rem
rem  9) DISM
rem     - Включаются: DirectPlay, LegacyComponents.
rem     - Отключаются: MicrosoftWindowsPowerShellV2,
rem       MicrosoftWindowsPowerShellV2Root, MSRDC-Infrastructure,
rem       Printing-Foundation-Features,
rem       Printing-Foundation-InternetPrinting-Client, WorkFolders-Client,
rem       SMBDirect, WCF-Services45, WCF-TCP-PortSharing45,
rem       Microsoft-Hyper-V-All / -Hypervisor / -Services / -Tools-All /
rem       -Management-PowerShell / -Management-Clients.
rem     - Remove-Capability: App.StepsRecorder.
rem
rem 10) APPX
rem     - Удаляются: SecureAssessmentBrowser, PeopleExperienceHost, Camera,
rem       WebExperience, WidgetsPlatformRuntime, Alarms, Maps, StickyNotes,
rem       windowscommunicationsapps, People, BingNews, BingSearch,
rem       BingWeather, SolitaireCollection, FeedbackHub, GetHelp,
rem       Getstarted, Todos, PowerAutomateDesktop, Cortana (549981C3F5F10),
rem       QuickAssist, MicrosoftFamily, ZuneMusic, ZuneVideo, SoundRecorder,
rem       Clipchamp, Whiteboard, TeamsforSurfaceHub, MailforSurfaceHub,
rem       PowerBIForWindows, SkypeApp, OfficeHub, Office.Excel/PowerPoint/
rem       Word/OneNote, OutlookForWindows, Spotify, OutlookPWA,
rem       Microsoft3DViewer, Advertising, MixedReality.Portal,
rem       StartExperiencesApp, DevHome, GamingApp, Edge.GameAssist,
rem       YourPhone, CrossDevice, MSTeams, MicrosoftTeams.
rem     - НЕ УДАЛЯЮТСЯ: Notepad, Paint, Snipping Tool / ScreenSketch /
rem       ScreenClippingHost, Photos, Edge, Xbox (отдельным шагом),
rem       Copilot (только политики), OneDrive (отдельный шаг).
rem
rem 11) ONEDRIVE
rem     - Остановка OneDrive.exe / OneDrive.App.exe / FileCoAuth.exe.
rem     - Деинсталляция через System32\OneDriveSetup.exe и
rem       SysWOW64\OneDriveSetup.exe.
rem     - Удаление папок OneDrive у всех C:\Users\*.
rem     - Удаление ярлыков OneDrive.lnk.
rem     - Удаление CLSID {018D5C66-…} из HKCR/HKCU (включая Wow6432Node).
rem     - Политики: DisableFileSyncNGSC=1, DisableFileSync=1,
rem       DisablePersonalSync=1, DisableMeteredNetworkFileSync=1,
rem       DisableLibrariesDefaultSaveToOneDrive=1.
rem     - Удаление задач OneDrive Reporting / Standalone Update
rem       (в т.ч. с суффиксом S-1-5-21).
rem     - Удаление переменных среды OneDrive/OneDriveConsumer/
rem       OneDriveCommercial, ветки HKCU\Software\Microsoft\OneDrive.
rem     - Удаление SyncRootManager-ключей.
rem     - Удаление WinSxS-пакета onedrive-setup и файлов
rem       OneDriveSetup.exe/OneDrive.ico из System32/SysWOW64 — через
rem       NSudoLG, если он есть; иначе takeown/icacls + rd/del.
rem     - Очистка Default\NTUSER.DAT: OneDriveSetup/OneDrive из Run,
rem       CLSID с IsPinnedToNameSpaceTree=0.
rem     - Удаление Appx OneDrive и microsoft.microsoftskydrive.
rem
rem 12) WINDOWS DEFENDER (удаление)
rem     - Остановка NisSrv, MsMpEng, SecurityHealthHost,
rem       SecurityHealthService, SecurityHealthSystray, smartscreen,
rem       MpCmdRun.
rem     - Удаление AppX SecHealthUI, Apprep, WindowsSecurity.
rem     - Политики: DisableAntiSpyware=1, DisableAntiVirus=1,
rem       DisableRoutinelyTakingAction=1, DisableRealtimeMonitoring=1,
rem       DisableBehaviorMonitoring=1, DisableOnAccessProtection=1,
rem       DisableScanOnRealtimeEnable=1, SpynetReporting=0,
rem       SubmitSamplesConsent=2.
rem     - Удаление служб: Sense, WinDefend, MsSecCore, wscsvc, WdFilter,
rem       WdBoot, WdNisDrv, WdNisSvc, MsSecWfp, MsSecFlt, wtd,
rem       webthreatdefusersvc, webthreatdefsvc, SecurityHealthService.
rem     - Удаление файлов в System32 и drivers: SecurityHealthService.exe,
rem       SecurityHealthSystray.exe, MsMpEng.exe, WdNisDrv.sys,
rem       WdFilter.sys, WdBoot.sys, SecurityHealth* .dll/.exe,
rem       smartscreen.exe, smartscreenps.dll, MpClient.dll, MpCommu.dll,
rem       MpOAV.dll, MpSvc.dll — через NSudoLG, если он есть.
rem     - Удаление папок Windows Defender (Program Files, ProgramData,
rem       Security Health).
rem     - Удаление Update Health Tools / rempl / CloudManagedUpdate,
rem       папок Microsoft Update Health Tools и PCHealthCheck.
rem     - Удаление задач Defender (Cache, Cleanup, Scheduled Scan,
rem       Verification), отключение ExploitGuard MDM policy Refresh —
rem       через schtasks с "< nul".
rem     - Удаление контекстного меню EPP для *, Drive, Directory,
rem       AllFilesystemObjects.
rem     - Отключение логов WMI DefenderApiLogger и DefenderAuditLogger.
rem     - SmartScreen off, HVCI off.
rem     - Очистка HKCU Defender и уведомлений SecurityAndMaintenance.
rem     - DISM Windows-Defender и Windows-Defender-Default-Definitions.
rem     - UPDHEALTH: msiexec /x <code> /qn — удаление MSI
rem       Update Health Tools.
rem
rem 13) ОБОИ
rem     - wallpaper.jpg из папки батника ставится текущему пользователю
rem       (Wallpaper, WallpaperStyle=10, TileWallpaper=0) и в профиль
rem       Default через монтирование NTUSER.DAT.
rem     - Если файла нет — шаг пропускается.
rem
rem 14) ФИНАЛИЗАЦИЯ
rem     - bcdedit: удаляются useplatformclock и disabledynamictick,
rem       bootmenupolicy=Legacy, lastknowngood=yes.
rem     - setx DOTNET_CLI_TELEMETRY_OPTOUT=1 и
rem       POWERSHELL_TELEMETRY_OPTOUT=1.
rem     - net accounts /maxpwage:unlimited.
rem     - Teredo default, ipconfig /flushdns.
rem     - w32time: перерегистрация, manual peer list
rem       (time.windows.com, pool.ntp.org, time.nist.gov), resync.
rem     - Остановка bits/appidsvc/dps/wuauserv.
rem     - Очистка CbsTemp, Logs, SoftwareDistribution, LogFiles,
rem       SleepStudy, sru, WDI\LogFiles, winevt\Logs, SystemTemp, Temp,
rem       CrashDumps, WER.
rem     - wevtutil el | % { wevtutil cl } — очистка всех журналов.
rem     - gpupdate /force.
rem     - label C: VampireOS.
rem
rem 15) ДОПОЛНИТЕЛЬНЫЕ ТВИКИ
rem     - Control Panel: JPEGImportQuality=100, Beep=no, MenuShowDelay=0,
rem       ActiveWndTrkTimeout=10, AutoEndTasks=1, HungAppTimeout=2000,
rem       WaitToKillAppTimeout=2000, LowLevelHooksTimeout=1000,
rem       MouseSpeed/Threshold1/2=0, AllowOnlineTips=0.
rem     - Ease of Access: обнуление Flags у AudioDescription, Blind Access,
rem       HighContrast, Keyboard Preference, Keyboard Response, MouseKeys,
rem       On, ShowSounds, SlateLaunch, SoundSentry, StickyKeys, TimeOut,
rem       ToggleKeys (HKCU + HKU\.DEFAULT).
rem     - Explorer general: FolderType=NotSpecified,
rem       GpuPreference=2 для explorer.exe, DisableGraphRecentItems=1,
rem       скрытие Spotlight-иконки, MultipleInvokePromptMinimum=100,
rem       link=00000000, EnthusiastMode=1, DisableAutoplay=1,
rem       NoDriveTypeAutoRun=255, NoLowDiskSpaceChecks=1,
rem       WaitToKillServiceTimeout=1500, LinkResolveIgnoreLinkInfo=1,
rem       AllowWindowsInkWorkspace=1,
rem       AllowSuggestedAppsInWindowsInkWorkspace=0,
rem       Start_IrisRecommendations=0, Start_AccountNotifications=0,
rem       TaskbarEndTask=1, LaunchTo=1, ShowInfoTip=0.
rem     - Уведомления: NoBalloonFeatureAdvertisements=1, NoAutoTrayNotify=1,
rem       NoCloudApplicationNotification=1, UpdateNotificationLevel=2,
rem       ScoobeSystemSettingEnabled=0, ScoobeCheckCompleted=1,
rem       ToastEnabled=0, NOC_GLOBAL_SETTING_ALLOW_NOTIFICATION_SOUND=0,
rem       NOC_GLOBAL_SETTING_ALLOW_CRITICAL_TOASTS_ABOVE_LOCK=0,
rem       NOC_GLOBAL_SETTING_ALLOW_TOASTS_ABOVE_LOCK=0,
rem       ShowSyncProviderNotifications=0,
rem       Windows.SystemToast.SecurityAndMaintenance Enabled=0,
rem       Windows.SystemToast.BackupReminder Enabled=0,
rem       userNotificationListener=Deny.
rem     - Поиск: RespectPowerModes=1, PreventIndexOnBattery=1,
rem       DisableSearchBoxSuggestions=1, AllowCloudSearch=2,
rem       AllowCortana=1, AllowCortanaAboveLock=0, AllowCortanaInAAD=0,
rem       AllowSearchToUseLocation=0, ConnectedSearchUseWeb=0,
rem       DisableWebSearch=1, ConnectedSearchPrivacy=3, CortanaConsent=0,
rem       BingSearchEnabled=0, голосовая активация выключена.
rem     - Пуск: ConfigureStartPins (Store, Settings, Notepad, Paint,
rem       Explorer, Calculator), скрытие папок Start (Documents,
rem       Downloads, FileExplorer, HomeGroup, Music, Network,
rem       PersonalFolder, Pictures, Videos), NoResolveSearch=1.
rem     - Панель задач: SearchboxTaskbarMode=1, ShowTaskViewButton=0,
rem       EnableFeeds=0, ShellFeedsTaskbarViewMode=2, TaskbarDa=0,
rem       AllowNewsAndInterests=0, HidePeopleBar=1, HideSCAMeetNow=1,
rem       ChatIcon=3, TaskbarMn=0.
rem     - Вид: FullPath=1, HideFileExt=0, ShowSyncProviderNotifications=0.
rem     - Параметры Windows: HideInsiderPage=1, TrayIconVisibility=0,
rem       TabletMode=0, TaskbarAppsVisibleInTabletMode=1,
rem       TaskbarAutoHideInTabletMode=0, SubscribedContent-353698Enabled=0,
rem       SystemPaneSuggestionsEnabled=0, EnableClipboardHistory=0,
rem       AllowClipboardHistory=1, AllowCrossDeviceClipboard=1.
rem     - Ввод: EnableAutocorrection=0, EnableSpellchecking=0,
rem       EnableTextPrediction=0, EnablePredictionSpaceInsertion=0,
rem       EnableDoubleTapSpace=0, InsightsEnabled=0,
rem       EnableHwkbTextPrediction=0, EnableHwkbAutocorrection=0,
rem       MultilingualEnabled=0.
rem     - Приватность: CapabilityAccessManager\location=Deny,
rem       webcam=Allow, microphone=Allow, activity/userAccountInformation/
rem       appointments/userDataTasks/chat/radios/bluetoothSync/
rem       appDiagnostics/documentsLibrary/picturesLibrary/videosLibrary/
rem       broadFileSystemAccess=Deny.
rem     - Wi-Fi Sense: AutoConnectAllowedOEM=0, PaidWifi=0,
rem       WiFiSenseOpen=0, AllowWiFiHotSpotReporting=0,
rem       AllowAutoConnectToWiFiSenseHotspots=0.
rem     - Доп.: ValueBanner.IdealStateFeatureControlProvider=disabled,
rem       WindowsAI DisableAIDataAnalysis=1, Sudo Enabled=3.
rem     - Сеть: EnableNetbios=0, DisableWpad=1, MaxNegativeCacheTtl=5,
rem       BFE CollectNetEvents=0, Dhcp PdcActivationDisabled=1,
rem       DefaultTTL=65 (v4/v6), TCPNoDelay/TcpAckFrequency/TcpDelAckTicks.
rem     - Графика: HwSchMode=2, MiracastForceDisable=1, TdrDelay=12.
rem     - PowerShell: ExecutionPolicy=Unrestricted, ассоциации .ps1/.psm1.
rem     - Память: AlwaysUnloadDLL=1, FeatureSettingsOverride=3,
rem       FeatureSettingsOverrideMask=3, HeapDeCommit-пороги.
rem     - Ядро: DisableMitigations=1.
rem     - Логи: GDI/USER/NoDebugThread/RsopLogging/UIPI SQM/LSA ETW/WDF/
rem       Diagnostics Performance Tracing выключены.
rem     - EventLog: AutoBackupLogFiles=0.
rem     - MSI в Safe Mode (Minimal + Network).
rem     - Ввод: IsInputAppPreloadEnabled=0, BluebirdDTWMultiplier=0,
rem       DisableExpressiveInputShellHotkey=1, DisablePersonalizationGTKM=1,
rem       DynamicAutocorrectionAllowed=0, CursorMagnetism=0.
rem     - Яркость (DisplayEnhancementService State): 75%.
rem     - GPU: RmDisableHdcp22=1, RMHdcpKeyglobZero=1, RmSkipHdcp22Init=1.
rem     - Принтер/факс: Spooler, PrintNotify, PrintWorkflowUserSvc,
rem       PrintDeviceConfigurationService, PrintScanBrokerService,
rem       Fax = disabled.
rem     - WU: NoAutoUpdate=1, PausedFeature/QualityStatus=1, даты 2077,
rem       DontOfferThroughWUAU=1, Stop wuauserv + очистка
rem       SoftwareDistribution, SearchOrderConfig=0,
rem       ExcludeWUDriversInQualityUpdate=1,
rem       PreventDeviceMetadataFromNetwork=1 (HKLM + Политики),
rem       PauseFeature/Quality/UpdatesStartTime=2025-01-01,
rem       EndTime=2038-01-19T03:14:07Z, FlightSettingsMaxPauseDays=5269,
rem       TargetReleaseVersionInfo=<ver>.
rem     - Журналирование: diagnosticshub.standardcollector.service=4.
rem     - Запись поведения: Messenger\Client CEIP=2, SQMClient CEIPEnable=0,
rem       AppCompat DisableUAR=1, Personalization NoLockScreenCamera=1.
rem     - Office-телеметрия: задачи Office ClickToRun/Telemetry/
rem       Subscription Heartbeat отключены.
rem     - Телеметрия Windows: Diagtrack-Listener Start=0,
rem       Attachments SaveZoneInformation=1, DiagTrack/dmwappushservice=4,
rem       CompatTelRunner firewall blocks (netsh).
rem     - Синхронизация: SettingSync\Groups\* Enabled=0, mobsync firewall.
rem     - Геолокация: DisableLocation/Scripting/WindowsLocationProvider=1.
rem     - Обратная связь: Siuf Rules, DoNotShowFeedbackNotifications=1.
rem     - Рекламный ID: AdvertisingInfo Enabled=0, Bluetooth AllowAdvertising=0.
rem     - Сбор данных приложений: AppCompat DisableInventory=1.
rem     - Сбор через планировщик: WinSAT, Autochk Proxy, AppCompat,
rem       PI Sqm-Tasks, NetTrace, CEIP Consolidator/KernelCeipTask/UsbCeip,
rem       DiskDiagnostic*.
rem     - Рукописный ввод: TabletPC PreventHandwritingDataSharing=1,
rem       HandwritingErrorReports PreventHandwritingErrorReports=1, TIPC=0.
rem     - Статистика приложений: AllowTelemetry=0, AITEnable=0,
rem       Explorer\Advanced Start_TrackProgs=0.
rem     - UAC: EnableLUA=0, ConsentPromptBehaviorAdmin=0,
rem       PromptOnSecureDesktop=0, EnableInstallerDetection=0,
rem       EnableSecureUIAPaths=0, EnableVirtualization=0,
rem       FilterAdministratorToken=0.
rem     - CDPUserSvc=4.
rem     - Speech: AllowSpeechModelUpdate=0.
rem     - NVIDIA-телеметрия: NvTelemetryContainer=4,
rem       NvTmRep/NvTmRepOnLogon/NvTmMon tasks.
rem     - AllowExperimentation=0.
rem     - Все служебные задачи диагностики/телеметрии отключены.
rem     - Maps: MapsToastTask/MapsUpdateTask disable.
rem     - Совместимость: Application Experience\* disable.
rem     - Сброс Bags/BagMRU.
rem     - Content Delivery Manager: SoftLandingEnabled=0,
rem       SubscribedContent-338389=0, SilentInstalledAppsEnabled=0,
rem       OemPreInstalledAppsEnabled=0, FeatureManagementEnabled=0,
rem       RotatingLockScreen*=0, SystemPaneSuggestions=0,
rem       SubscribedContent-* = 0.
rem     - Блокировка DeviceCensus.exe (DisallowRun + IFEO Debugger).
rem     - AppPrivacy Background: LetAppsRunInBackground=2,
rem       GlobalUserOverride=1.
rem     - CBS Background App: MicrosoftWindows.Client.CBS Disabled=1.
rem     - CEIP/SQM: CEIPEnable=0, UploadDisableFlag=1,
rem       NoCloudApplicationNotification=1.
rem     - Copilot/AI: TurnOffWindowsCopilot=1, DisableAIDataAnalysis=1,
rem       ShowCopilotButton=0, IsUserEligible=0, AllowRecallEnablement=0.
rem     - Cortana Consent: CortanaConsent=0, ShowCortanaButton=0,
rem       IsMSACloudSearchEnabled=0, IsAADCloudSearchEnabled=0.
rem     - Cross Device Resume: DisableCrossDeviceResume=1,
rem       IsResumeAllowed=0.
rem     - Delivery Optimization: DownloadMode=0.
rem     - DisplayName NoGenTicket: dontdisplaylastusername=0.
rem     - Dsh News and Interests: AllowNewsAndInterests=0.
rem     - FeatureManagement Override 1387020943: 0.
rem     - Find My Device / Location Sync: AllowFindMyDevice=0,
rem       LocationSyncEnabled=0.
rem     - MaxTelemetryAllowed=0.
rem     - NoGenTicket: NoGenTicket=1.
rem     - PolicyManager AllowCortana: AllowCortana=0, CortanaEnabled=0,
rem       CortanaInAmbientMode=0.
rem     - Protected Event Logging: EnableProtectedEventLogging=0.
rem     - TIPC: Enabled=0.
rem     - Tailored Experiences: TailoredExperiencesWithDiagnosticDataEnabled=0,
rem       DisableTailoredExperiencesWithDiagnosticData=1.
rem     - Wi-Fi Sense power management: fDisablePowerManagement=1
rem       (WcmSvc Local + GroupPolicy).
rem     - Windows Feedback: DoNotShowFeedbackNotifications=1,
rem       Siuf NumberOfSIUFInPeriod=0.
rem     - Windows Search индексация: PreventIndexingLowDiskSpaceMB=2048,
rem       DisableBackoff=0, DisableRemovableDriveIndexing=1,
rem       PreventIndexOnBattery=1, PreventIndexingOutlook=1,
rem       EnableDynamicContentInWSB=0, SetupCompletedSuccessfully=0,
rem       DisableSearchBoxSuggestions=1.
rem     - Handwriting/Maps: PreventHandwritingErrorReports=1,
rem       PreventHandwritingDataSharing=1, AutoDownloadAndUpdateMapData=0,
rem       AllowUntriggeredNetworkTrafficOnSettingsPage=0,
rem       HKLM\SYSTEM\Maps AutoUpdateEnabled=0.
rem     - Голосовая активация: VoiceActivationOn=0, VoiceShortcut=0,
rem       VoiceActivationEnableAboveLockscreen=0, ModelDownloadAllowed=0,
rem       VoiceActivationDefaultOn=0, OOBE DisableVoice=1.
rem     - История поиска: HistoryViewEnabled=0, DeviceHistoryEnabled=0.
rem     - Облачный буфер: CloudClipboardAutomaticUpload=0,
rem       CloudClipRDPOverride=0, AllowCrossDeviceClipboard=0.
rem     - Облачный контент: DisableSoftLanding=1,
rem       DisableWindowsSpotlightFeatures=1, DisableCloudOptimizedContent=1,
rem       DisableWindowsConsumerFeatures=1.
rem     - Облачный поиск Bing: BingSearchEnabled=0,
rem       DisableSearchBoxSuggestions=1, AllowCloudSearch=0.
rem     - Онлайн-советы: AllowOnlineTips=0.
rem     - Отчёты об ошибках: WER Disabled/LoggingDisabled/DisableArchive/
rem       DisableWerUpload, DefaultConsent=1, DefaultOverrideBehavior=1.
rem     - Персонализация ввода: AllowInputPersonalization=0,
rem       RestrictImplicitInkCollection=1, RestrictImplicitTextCollection=1,
rem       HarvestContacts=0, AcceptedPrivacyPolicy=0, HasAccepted=0.
rem     - Рекламный ID: AdvertisingInfo Enabled=0, DisabledByGroupPolicy=1.
rem     - Реклама/рекомендации: AdvertisingInfo DisabledByGroupPolicy=1,
rem       AdvertisingInfo Enabled=0, ShowRecommendations=0.
rem     - Сбор лингвистических данных: AllowLinguisticDataCollection=0.
rem     - Телеметрия PowerShell/.NET: setx /M
rem       DOTNET_CLI_TELEMETRY_OPTOUT=1, POWERSHELL_TELEMETRY_OPTOUT=1.
rem     - Недавние элементы: NoInstrumentation=1, ClearRecentDocsOnExit=1,
rem       NoRecentDocsHistory=1, NoRemoteDestinations=1,
rem       NoStartMenuMFUprogramsList=1, ShowOrHideMostUsedApps=1,
rem       HideRecentlyAddedApps=1, Start_TrackProgs=0, Start_TrackDocs=0,
rem       рестарт explorer.
rem     - Серый цвет выделения: Hilight=80 80 80, HotTrackingColor=60 60 60.
rem     - Ярлыки Accessories\System Tools: удалены.
rem     - Визуальная обратная связь касания: GestureVisualization/
rem       ContactVisualization удалены.
rem     - Навязчивые уведомления WU: NoAUAsDefaultShutdownOption/HideMCTLink
rem       удалены.
rem     - Телеметрия MSRT: DontReportInfectionInformation/RemovalTools\
rem       MpGears HeartbeatTrackingIndex/SpyNetReportingLocation удалены.
rem     - Автообновление Store: AutoDownload удалён.
rem     - Автоустановка DevHome/Outlook: UScheduler\DevHomeUpdate/
rem       OutlookUpdate удалены.
rem     - Удалённая помощь: fAllowToGetHelp=0, fAllowFullControl=0,
rem       firewall Remote Assistance off.
rem     - RDP: fDenyTSConnections=1, UserAuthentication=0.
rem     - Удаление приложений: Teams (Appx + MSI), Hello Face (DISM),
rem       Internet Explorer (DISM + папки + UScheduler_Oobe),
rem       MathRecognizer (DISM), OpenSSH.Client (DISM),
rem       PowerShell.ISE (DISM), Print.Management.Console (DISM),
rem       StepsRecorder (DISM), Windows Media Player (DISM +
rem       MediaPlayback/SMBDirect/MSRDC/Workfolders/WCF), WSL
rem       (OptionalFeature + файлы), Xbox (Appx).
rem     - Классическое меню Win11 (CLSID {86ca1aa0-…}).
rem     - Скрытие Gallery/Home в Explorer.
rem     - Секунды в трее.
rem     - «Завершить задачу» на панели задач.
rem     - Показ скрытых файлов и папок.
rem     - Показ расширений файлов.
rem     - Полный путь в заголовке.
rem     - Открывать Проводник на «Этот компьютер».
rem     - Убрать « - Shortcut» у ярлыков.
rem     - Уменьшить кнопки окна.
rem     - Ускорить меню/проводник.
rem     - Ускорить выключение приложений.
rem     - WaitToKillServiceTimeout=1500.
rem     - Ускорение частоты мерцания курсора.
rem     - Ускорить запуск Windows.
rem     - Ускорить открытие папок.
rem     - Take Ownership для файлов и папок.
rem     - Отключение принтера/факса.
rem
rem 16) ВКЛЮЧЕНИЕ СКРИНШОТЕРА WINDOWS 11
rem     - Проверяется наличие пакетов Microsoft.ScreenSketch и
rem       Microsoft.Windows.SnippingTool; если нет — добавляется из
rem       ProvisionedPackage.
rem     - Снимаются блокировки AppKey\17 (PrintScreen) и AppKey\18
rem       (Snipping): удаляются Disable, восстанавливаются
rem       Association=ScreenClipping / SnippingTool.
rem     - Удаляются IFEO-подмены для SnippingTool.exe, ScreenSketch.exe,
rem       ScreenClippingHost.exe.
rem     - Включаются: DisableScreenClipping=0, SnipButtonEnabled=1,
rem       SnippingToolPrintScreenEnabled=1, PrintScreenKey=SnippingTool.
rem     - Возвращается ярлык Snipping Tool в Start Menu
rem       (explorer.exe shell:AppsFolder\Microsoft.ScreenSketch_…!App).
rem     - CapabilityAccessManager\ConsentStore\screenCapture=Allow.
rem     - Включаются Printing-Foundation-Features и
rem       Printing-Foundation-InternetPrinting-Client (нужно для печати
rem       из Snipping Tool).
rem     - Восстанавливается ассоциация Win+Shift+S → SnippingTool.
rem
rem 17) ДОПОЛНИТЕЛЬНЫЕ ТВИКИ (из merged_project)
rem     - Desktop heap/timer coalescing: DesktopHeapLogging=0,
rem       TimerCoalescing=0, SvcHostSplitThresholdInKB=3489660927,
rem       BootExecuteNoPnpSync=1, SleepStudyDisabled=1 (только лог).
rem     - Explorer/UI W10/W11: DragFullWindows=0,
rem       UserPreferencesMask=9012038012000000, MinAnimate=0,
rem       ListviewAlphaSelect/Shadow=0, TaskbarAnimations=0,
rem       VisualFXSetting=3, EnableAeroPeek=0,
rem       AlwaysHibernateThumbnails=0, PenWorkspaceButtonDesiredVisibility=0,
rem       DirectXUserGlobalSettings=SwapEffectUpgradeEnable=1;VRROptimizeEnable=0,
rem       HwSchMode=2, TaskbarAl=0, TaskbarEndTask=1, IsResumeAllowed=0.
rem     - W10-specific: TipbandDesiredVisibility=0, PeopleBand=0,
rem       HideSCAMeetNow=1, 3D Objects из This PC удалён.
rem     - Logging/diagnostics: DisableProjectedShadows=1,
rem       MousewheelAnimationDurationMs=0, DisableGlobalAnimations=1,
rem       DisableLogonBackgroundImage=1, InitializePlatformOnStartup=0,
rem       ViewHiddenTasks=1, PenVisualization=0, AutoColorization=0,
rem       SmoothScroll=0, AnimationDuration=0, Insights=0, UserStatsEnabled=0,
rem       DisablePreviewDesktop/Window=1, NoNetCrawling=1,
rem       Start_NotifyNewApps/Track*=0, TaskbarFlashOverrideBreatheCount=0,
rem       DisableWindowHinting=1, NoRecentDocsMenu=1,
rem       NoRemoteChangeNotify=1, NoRemoteRecursiveEvents=1, NoSMHelp=1,
rem       TurnOffSPIAnimations=1, HourlyTelemetyThreshold=0,
rem       DisableCharms=1, DisableRecentApps=1,
rem       DisableThumbsDBOnNetworkFolders=1, SkipNetworkShieldCheck=1.
rem     - MPO: OverlayTestMode=5.
rem     - FTH: Enabled=0, rundll32 fthsvc.dll,FthSysprepSpecialize.
rem     - Memory Compression: Disable-MMAgent -MemoryCompression.
rem     - Process mitigations: Set-ProcessMitigation -SYSTEM -Disable <all>,
rem       MitigationOptions/AuditOptions=0x22 для fontdrvhost, dwm, lsass,
rem       svchost, WmiPrvSE, winlogon, csrss, ntoskrnl, services и kernel.
rem     - WINEVT channels: все Enabled=0.
rem     - DMA remapping: DmaGuard DeviceEnumerationPolicy=2,
rem       DmaRemappingCompatible=0 для всех служб с этим параметром.
rem     - MSI mode: MSISupported=1 для Win32_IDEController,
rem       Win32_VideoController, Win32_NetworkAdapter.
rem     - wevtutil sl SleepStudy/Kernel-Processor-Power/UserModePowerService
rem       /e:false (только лог).
rem     - NoMobilityCenter=1.
rem     - Dnscache DisableCoalescing=1.
rem     - TCPNoDelay/TcpAckFrequency на Ethernet (не Wi-Fi).
rem     - Bloatware auto-install block (Communications, CDM).
rem     - Block shell extensions {e2bf9676-…}, {596AB062-…}.
rem     - Delivery Optimization HKU\S-1-5-20 DownloadMode=0.
rem     - SettingSync Groups\* Enabled=0.
rem     - WU pause: StartTime=2025-01-01, EndTime=2038-01-19T03:14:07Z,
rem       FlightSettingsMaxPauseDays=5269, PausedFeature/QualityStatus=1,
rem       TargetReleaseVersionInfo=<ver>.
rem     - label C: VampireOS.
rem     - wevtutil el | % { wevtutil cl }.
rem     - Доп. Office/update/printing tasks disabled.
rem     - Доп. services Start=4 (RetailDemo, CSC, CSCSERVICE, Telemetry,
rem       WdiSystemHost, WdiServiceHost, troubleshootingsvc, diagsvc, svsvc,
rem       diagtrack, wercplsupport, dps, GraphicsPerfSvc, Ndu, pcasvc,
rem       dusmsvc, DSSvc, wisvc, InventorySvc, WSAIFabricSvc, amdfendr,
rem       amdfendrmgr, McpManagementService, Spooler, printworkflowusersvc,
rem       stisvc, PrintNotify, usbprint, PrintScanBrokerService,
rem       PrintDeviceConfigurationService, TermService, UmRdpService,
rem       SessionEnv, hyperkbd, hypervideo, vmgid, vpci, vid, dam, NetBT,
rem       MSDTC, midisrv, MicrosoftCopilotElevationService).
rem     - OptionalFeatures: SMBDirect, MSRDC-Infrastructure,
rem       Workfolders-Client, WCF-Services45, WCF-TCP-PortSharing45,
rem       Microsoft-Hyper-V-* → disable; DirectPlay → enable;
rem       App.StepsRecorder → remove.
rem     - UPDHEALTH MSI uninstall.
rem
rem 18) ФИНАЛЬНЫЕ ДОПОЛНЕНИЯ
rem     - Take Ownership: добавлены dllfile и exefile (ранее только * и Directory)
rem     - Search: RespectPowerModes=1 (SystemIndex), AllowCloudSearch=2,
rem       WinStore.Tasks.WindowsSearchTask ActivationType=0xFFFFFFFF
rem       (отключение Store-результатов в поиске),
rem       FeatureManagement\Overrides\1694661260=0
rem     - AppCompat: SbEnable=1
rem     - CloudContent: ConfigureWindowsSpotlight=2, IncludeEnterpriseSpotlight=0
rem     - Privacy general: MSAOptional=1, AllowMessageSync=0,
rem       DisableHelpSticker=1, DisableMFUTracking=1
rem     - Restrict Internet Communication: NoPublishingWizard, NoWebServices,
rem       NoGenTicket, NoOnlinePrintsWizard, DisableHTTPPrinting,
rem       DisableWebPnPDownload, WindowsMovieMaker web/codec/publish
rem     - PCHealth/HelpSvc/ErrorReporting, ExitOnMSICW,
rem       MicrosoftEventVwrDisableLinks, NoRegistration,
rem       DisableContentFileUpdates
rem     - NVIDIA: OptInOrOutPreference=0
rem     - Firewall: Block-Unified-Telemetry-Client, Block-Windows-Error-Reporting
rem       (DiagTrack / WerSvc)
rem     - Xbox Gaming Copilot block: ActivationType=0xFFFFFFFF
rem     - Telemetry additional: DisableEnterpriseAuthProxy=1,
rem       DisableTelemetryOptInChangeNotification=1,
rem       DisableTelemetryOptInSettingsUx=1
rem     - Security additional: AccountProtection_MicrosoftAccount_Disconnected=0,
rem       Defender DisableGenericRePorts=1,
rem       DisableScheduledSignatureUpdateOnBattery=1,
rem       SmartScreen ConfigureAppInstallControlEnabled=1,
rem       ConfigureAppInstallControl=Anywhere,
rem       MicrosoftEdge PhishingFilter EnabledV9=0
rem     - BootExecute="autocheck autochk /k:C*" (без проверки C:)
rem     - Mitigations: vgc.exe (Valorant CFG), osu!.exe (ASLR)
rem     - DisableWpbtExecution=1
rem     - OOBE: HideOnlineAccountScreens, HideEULAPage,
rem       HideWirelessSetupInOOBE, NetworkLocation=Home, ProtectYourPC=3,
rem       DisablePrivacyExperience, HideOEMRegistrationScreen,
rem       EnableCortanaVoice=0, DisableVoice=1, HideLocalAccountScreen=0,
rem       Skype consent=0
rem     - Updates additional: UpgradeAvailable=0,
rem       DontReportInfectionInformation=0, MediaPlayer DisableAutoUpdate=0,
rem       BlockedOobeUpdaters, HideMCTLink=1, RestartNotificationsAllowed2=0,
rem       UScheduler DevHome/Outlook workCompleted=1
rem     - MS Store: AutoDownload=4
rem     - EdgeUpdate policies: InstallDefault=0, Install Edge=0,
rem       Install WebView=1, DoNotUpdateToEdgeWithChromium=1
rem       (блокирует установку/обновление Edge, НЕ удаляет Edge)
rem     - System Restore: RPSessionInterval=0, DiskPercent=0,
rem       удаление SPP\Clients
rem     - fsutil: disable8dot3=1, disabledeletenotify=0,
rem       disablelastaccess=1, encryptpagingfile=0
rem     - bcdedit: /timeout 10, /set {current} description "VampireOS"
rem     - Set-WindowsReservedStorageState=Disabled
rem ============================================================================

set "NS=%~dp0NSudoLG.exe"
set "WP=%~dp0wallpaper.jpg"

net session >nul 2>&1 || (
    echo [!] Запустите от имени администратора.
    pause & exit /b 1
)

echo ============================================================
echo  VampireOS.bat
echo ============================================================
echo.
if exist "%NS%" (echo [OK] NSudoLG: %NS%) else (echo [!] NSudoLG.exe не найден рядом)
if exist "%WP%" (echo [OK] wallpaper.jpg: %WP%) else (echo [!] wallpaper.jpg не найден рядом)
echo.

rem ============================================================
rem 1. OS INFO / OEM
rem ============================================================
echo [*] OS info...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v EditionSubManufacturer /t REG_SZ /d "ZikaSVG" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v EditionSubstring       /t REG_SZ /d "ZikaSVG" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v EditionSubVersion      /t REG_SZ /d "VampireOS" /f >nul

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v HelpCustomized  /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v Manufacturer    /t REG_SZ    /d "ZikaSVG" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v SupportProvider /t REG_SZ    /d "ZikaSVG Support" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v SupportAppURL   /t REG_SZ    /d "zikasvg-support-help" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v SupportURL      /t REG_SZ    /d "https://t.me/all_tweaker" /f >nul

rem --- bcdedit timeout/description ---
bcdedit /timeout 10 >nul 2>&1
bcdedit /set {current} description "VampireOS" >nul 2>&1

rem ============================================================
rem 12. WALLPAPER
rem ============================================================
echo [*] Wallpaper...
if exist "%WP%" (
    reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "%WP%" /f >nul
    reg add "HKCU\Control Panel\Desktop" /v WallpaperStyle /t REG_SZ /d "10" /f >nul
    reg add "HKCU\Control Panel\Desktop" /v TileWallpaper /t REG_SZ /d "0" /f >nul
    rundll32.exe user32.dll,UpdatePerUserSystemParameters >nul 2>&1

    reg load "HKU\DefaultHiveWP" "%SystemDrive%\Users\Default\NTUSER.DAT" >nul 2>&1
    if not errorlevel 1 (
        reg add "HKU\DefaultHiveWP\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "%WP%" /f >nul
        reg add "HKU\DefaultHiveWP\Control Panel\Desktop" /v WallpaperStyle /t REG_SZ /d "10" /f >nul
        reg add "HKU\DefaultHiveWP\Control Panel\Desktop" /v TileWallpaper /t REG_SZ /d "0" /f >nul
        reg unload "HKU\DefaultHiveWP" >nul 2>&1
    )
) else (
    echo   [SKIP] wallpaper.jpg не найден.
)

rem ============================================================
rem 2. EXPLORER / UI
rem ============================================================
echo [*] Explorer / UI...
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /t REG_SZ /d "" /f >nul

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarMn" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" /v "TaskbarEndTask" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSecondsInSystemClock" /t REG_DWORD /d 1 /f >nul

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /v "FullPath" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "MultipleInvokePromptMinimum" /t REG_DWORD /d 100 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecommendations" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_IrisRecommendations" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_AccountNotifications" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowCloudFilesInQuickAccess" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v "EnthusiastMode" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "StartupDelayInMSec" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" /v "FolderType" /t REG_SZ /d "NotSpecified" /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates" /v "ShortcutNameTemplate" /t REG_SZ /d ""%s.lnk"" /f >nul

reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "MouseHoverTime" /t REG_SZ /d "0" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "2000" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeOut" /t REG_SZ /d "2000" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "JPEGImportQuality" /t REG_DWORD /d 100 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "2000" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DelayedDesktopSwitchTimeout" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\EditionOverrides" /v "UserSetting_DisableStartupSound" /t REG_DWORD /d 1 /f >nul

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_TOASTS_ENABLED" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d 2 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "AllowOnlineTips" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "AllowOnlineTips" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Settings\AllowOnlineTips" /v "value" /t REG_DWORD /d 0 /f >nul

reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionHeight" /t REG_SZ /d "-270" /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionWidth"  /t REG_SZ /d "-270" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "CursorBlinkRate" /t REG_SZ /d "250" /f >nul

reg add "HKCU\SOFTWARE\Classes\CLSID\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Classes\CLSID\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Classes\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >nul

for %%K in ("HKCR\*\shell\runas" "HKCR\Directory\shell\runas") do (
    reg add %%K /f >nul
    reg add %%K /ve /t REG_SZ /d "Take Ownership" /f >nul
    reg add %%K /v HasLUAShield /t REG_SZ /d "" /f >nul
    reg add %%K /v NoWorkingDirectory /t REG_SZ /d "" /f >nul
    reg add %%K /v Position /t REG_SZ /d "middle" /f >nul
)
reg add "HKCR\*\shell\runas\command" /ve /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant *S-1-3-4:F /c /l" /f >nul
reg add "HKCR\*\shell\runas\command" /v IsolatedCommand /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant *S-1-3-4:F /c /l" /f >nul
reg add "HKCR\Directory\shell\runas\command" /ve /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant *S-1-3-4:F /t /c /l /q" /f >nul
reg add "HKCR\Directory\shell\runas\command" /v IsolatedCommand /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant *S-1-3-4:F /t /c /l /q" /f >nul
reg add "HKCR\Directory\shell\runas" /v "AppliesTo" /t REG_SZ /d "NOT (System.ItemPathDisplay:=\"C:\Users\" OR System.ItemPathDisplay:=\"C:\ProgramData\" OR System.ItemPathDisplay:=\"C:\Windows\" OR System.ItemPathDisplay:=\"C:\Windows\System32\" OR System.ItemPathDisplay:=\"C:\Program Files\" OR System.ItemPathDisplay:=\"C:\Program Files (x86)\")" /f >nul

rem ============================================================
rem 3. PRIVACY / TELEMETRY
rem ============================================================
echo [*] Privacy / telemetry...
for %%P in (
    "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
    "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
    "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
) do reg add %%P /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowTelemetry" /v value /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowDeviceNameInTelemetry /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowDesktopAnalyticsProcessing /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowCommercialDataPipeline /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DisableOneSettingsDownloads /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v LimitDiagnosticLogCollection /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v LimitDumpCollection /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v MicrosoftEdgeDataOptIn /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f >nul
reg delete "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v PeriodInNanoSeconds /f >nul 2>&1

reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v DisableEngine /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v AITEnable /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v DisableUAR /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v DisablePCA /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v DisableInventory /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Microsoft\Windows\SQMClient" /v UploadDisableFlag /t REG_DWORD /d 1 /f >nul

reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v DisableSoftLanding /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightFeatures /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableCloudOptimizedContent /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableThirdPartySuggestions /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableTailoredExperiencesWithDiagnosticData /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v DisableThirdPartySuggestions /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightFeatures /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightOnActionCenter /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightOnSettings /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightWindowsWelcomeExperience /t REG_DWORD /d 1 /f >nul

for %%V in (
    ContentDeliveryAllowed SubscribedContentEnabled SoftLandingEnabled
    SubscribedContent-338389Enabled SilentInstalledAppsEnabled PreInstalledAppsEnabled
    PreInstalledAppsEverEnabled OemPreInstalledAppsEnabled FeatureManagementEnabled
    RemediationRequired SubscribedContent-314559Enabled SubscribedContent-280815Enabled
    SubscribedContent-314563Enabled SubscribedContent-202914Enabled SubscribedContent-338387Enabled
    SubscribedContent-280810Enabled SubscribedContent-280811Enabled RotatingLockScreenEnabled
    RotatingLockScreenOverlayEnabled SubscribedContent-338388Enabled SubscribedContent-353694Enabled
    SubscribedContent-353696Enabled SubscribedContent-353698Enabled SubscribedContent-338393Enabled
    SubscribedContent-310093Enabled SystemPaneSuggestionsEnabled
) do reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v %%V /t REG_DWORD /d 0 /f >nul
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /f >nul 2>&1

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Id /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Id /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f >nul

reg add "HKCU\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v HasAccepted /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\TextInput" /v AllowLinguisticDataCollection /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Input\TIPC" /v Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Input\TIPC" /v Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v AllowInputPersonalization /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v HarvestContacts /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /v PreventHandwritingErrorReports /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /v PreventHandwritingDataSharing /t REG_DWORD /d 1 /f >nul

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v TailoredExperiencesWithDiagnosticDataEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v UploadUserActivities /t REG_DWORD /d 0 /f >nul

for %%C in (
    location activity userAccountInformation appointments userDataTasks chat
    radios bluetoothSync appDiagnostics documentsLibrary picturesLibrary videosLibrary
    broadFileSystemAccess phoneCallHistory email contacts
) do reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\%%C" /v Value /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" /v Value /t REG_SZ /d "Allow" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v Value /t REG_SZ /d "Allow" /f >nul

reg add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" /v AutoConnectAllowedOEM /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features" /v PaidWifi /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features" /v WiFiSenseOpen /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v value /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v value /t REG_DWORD /d 0 /f >nul

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v DontSendAdditionalData /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v LoggingDisabled /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\Consent" /v DefaultConsent /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\Consent" /v DefaultOverrideBehavior /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v DisableArchive /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v DisableWerUpload /t REG_DWORD /d 1 /f >nul

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortanaAboveLock /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowCortana" /v value /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v CortanaEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v CanCortanaBeEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v CortanaConsent /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v HistoryViewEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v DeviceHistoryEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCloudSearch /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowSearchToUseLocation /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v ConnectedSearchUseWeb /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableWebSearch /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v ConnectedSearchPrivacy /t REG_DWORD /d 3 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v PreventIndexOnBattery /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v PreventIndexingLowDiskSpaceMB /t REG_DWORD /d 2048 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableRemovableDriveIndexing /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v PreventIndexingOutlook /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f >nul

reg add "HKCU\Software\Microsoft\Speech_OneCore\Preferences" /v VoiceActivationOn /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v VoiceShortcut /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Speech_OneCore\Preferences" /v VoiceActivationEnableAboveLockscreen /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Speech_OneCore\Preferences" /v ModelDownloadAllowed /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Microsoft\Speech_OneCore\Preferences" /v VoiceActivationDefaultOn /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v DisableVoice /t REG_DWORD /d 1 /f >nul

reg add "HKCU\SOFTWARE\Microsoft\Clipboard" /v CloudClipboardAutomaticUpload /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Clipboard" /v CloudClipRDPOverride /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Clipboard" /v EnableClipboardHistory /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v AllowCrossDeviceClipboard /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Connectivity\DisableCrossDeviceResume" /v value /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CrossDeviceResume\Configuration" /v IsResumeAllowed /t REG_DWORD /d 0 /f >nul

reg add "HKLM\SOFTWARE\Policies\Microsoft\FindMyDevice" /v AllowFindMyDevice /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\MdmCommon\SettingValues" /v LocationSyncEnabled /t REG_DWORD /d 0 /f >nul

reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsCopilot" /v DisableAIDataAnalysis /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\Shell\Copilot\BingChat" /v IsUserEligible /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsAI" /v DisableAIDataAnalysis /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsAI" /v AllowRecallEnablement /t REG_DWORD /d 0 /f >nul

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v DisableSettingSync /t REG_DWORD /d 2 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v DisableSettingSyncUserOverride /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v DisableSyncOnPaidNetwork /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v SyncPolicy /t REG_DWORD /d 5 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" /v SyncPolicy /t REG_DWORD /d 5 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Experience" /v AllowSyncMySettings /t REG_DWORD /d 0 /f >nul

rem ============================================================
rem 4. SECURITY / SMARTSCREEN
rem ============================================================
echo [*] Security / SmartScreen...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f >nul
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "Enabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "PreventOverride" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "AicEnabled" /t REG_SZ /d "Anywhere" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\smartscreen.exe" /v "Debugger" /t REG_SZ /d "%SYSTEMROOT%\System32\taskkill.exe" /f >nul
taskkill /f /im smartscreen.exe >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Control\BitLocker" /v "PreventDeviceEncryption" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 0 /f >nul

rem ============================================================
rem 5. SYSTEM / KERNEL
rem ============================================================
echo [*] System / kernel...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 10 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 10 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NoLazyMode" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "TimerResolution" /t REG_DWORD /d 10 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Psched" /v "NonBestEffortLimit" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePageCombining" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d 3 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d 3 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "Segment Heap" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "BackgroundLoadKnownDlls" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "TaskhostTimeout" /t REG_DWORD /d 2000 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Quota System" /v "EnableCpuQuota" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableMitigations" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SCMConfig" /v "EnableSvchostMitigationPolicy" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\EventSystem" /v "ParallelFiringTimeoutEnabled" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Audio" /v "AudioHealthMonitorLimit" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager" /v "ComServerShutdownDelayMs" /t REG_DWORD /d 1000 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "RunLogonScriptSync" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "RunStartupScriptSync" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "CopyFileBufferedSynchronousIo" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BrokerInfrastructure\Parameters" /v "DefaultTriggerCoalescingTime" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BrokerInfrastructure\Parameters" /v "DisableTriggerCoalescing" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "TokenLeakDetectDelaySecs" /t REG_DWORD /d 30 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\Appx" /v "AllowAutomaticAppArchiving" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLinkedConnections" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\System\CurrentControlSet\Control\TimeZoneInformation" /v "RealTimeIsUniversal" /t REG_DWORD /d 1 /f >nul

powershell -NoProfile -ExecutionPolicy Bypass -Command "$svc=@('BFE','DcomLaunch','mpssvc','PlugPlay','Power','SamSs','EventSystem','CryptSvc','Dhcp','Dnscache','DisplayEnhancementService','PcaSvc','WdiSystemHost','AudioEndpointBuilder','Appinfo','BITS','gpsvc','IKEEXT','iphlpsvc','LanmanServer','lmhosts','NcbService','RasAuto','RasMan','SENS','ShellHWDetection','SstpSvc','TrkWks','Winmgmt','EventLog','FontCache','LanmanWorkstation','NlaSvc','nsi','ProfSvc','Schedule','SessionEnv','Themes','W32Time','Wcmsvc'); foreach($s in $svc){$p='HKLM:\SYSTEM\CurrentControlSet\Services\'+$s; if(Test-Path $p){New-ItemProperty -Path $p -Name 'SvcHostSplitDisable' -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null}}" >nul 2>&1

reg add "HKLM\SOFTWARE\Microsoft\Input" /v "IsInputAppPreloadEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings" /v "BluebirdDTWMultiplier" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings" /v "DisableExpressiveInputShellHotkey" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings" /v "DisablePersonalizationGTKM" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings" /v "DynamicAutocorrectionAllowed" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\ControllerProcessor\CursorMagnetism" /v "ClosestInteractiveBoundsUpdateIntervalInMilliseconds" /t REG_DWORD /d 0 /f >nul

reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\KeyGuard" /v "DisableTelemetry" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Cryptography\CatalogDB" /v "EnablePerformanceCounters" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Media Foundation\Platform" /v "CallStackTracingEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Media Foundation\Platform" /v "CallStackTracingNoisy" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Configuration" /v "AdapterLoggingEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Configuration" /v "EnableAt" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SecEdit" /v "PolicyDebugLevel" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v "GDIEnableReferenceStackTraces" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v "USERExtraInstrumentations" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v "USERPostMortemLogging" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows\Win32kWPP\Parameters" /v "VerboseOn" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "NoDebugThread" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "RsopLogging" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\UIPI" /v "EnableMessageSQM" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa\Audit" /v "EtwDirect" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa\Tracing" /v "TracingDisabled" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Wdf" /v "WdfGlobalLogsDisabled" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Wdf" /v "WdfGlobalSleepStudyDisabled" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Diagnostics\Performance" /v "DisableDiagnosticTracing" /t REG_DWORD /d 1 /f >nul

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "EnableNetbios" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" /v "DisableWpad" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v "MaxNegativeCacheTtl" /t REG_DWORD /d 5 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BFE\Parameters\Policy\Options" /v "CollectNetEvents" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dhcp" /v "PdcActivationDisabled" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DefaultTTL" /t REG_DWORD /d 65 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v "DefaultTTL" /t REG_DWORD /d 65 /f >nul

powershell -NoProfile -ExecutionPolicy Bypass -Command "if([int](Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').CurrentBuildNumber -ge 19041){Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers' -Name 'HwSchMode' -Value 2 -Type DWord -Force}" >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "MiracastForceDisable" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d 12 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "WarpSupportsResourceResidency" /t REG_DWORD /d 1 /f >nul

reg add "HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "Unrestricted" /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging" /v "EnableModuleLogging" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" /v "EnableScriptBlockLogging" /t REG_DWORD /d 0 /f >nul
ftype Microsoft.PowerShellScript.1="%windir%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -EP Unrestricted -File "%1" %* >nul 2>&1
reg add "HKCR\Microsoft.PowerShellScript.1\Shell" /ve /t REG_SZ /d "Open" /f >nul
reg add "HKCR\Microsoft.PowerShellScript.1\Shell\Open\Command" /ve /t REG_EXPAND_SZ /d "\"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe\" \"%1\"" /f >nul
reg add "HKCR\Microsoft.PowerShellScript.1\Shell\RunAs" /v "HasLUAShield" /t REG_SZ /d "" /f >nul
reg add "HKCR\Microsoft.PowerShellScript.1\Shell\RunAs\Command" /ve /t REG_EXPAND_SZ /d "\"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe\" \"%1\"" /f >nul
reg add "HKCR\.psm1" /ve /t REG_SZ /d "Microsoft.PowerShellModule.1" /f >nul
reg add "HKCR\Microsoft.PowerShellModule.1\Shell" /ve /t REG_SZ /d "Open" /f >nul
reg add "HKCR\.psm1\OpenWithProgids" /f >nul 2>&1
reg add "HKCR\.ps1\OpenWithProgids" /f >nul 2>&1

reg add "HKLM\SYSTEM\Setup\LabConfig" /v BypassSecureBootCheck /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\Setup\LabConfig" /v BypassTPMCheck /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\Setup\LabConfig" /v BypassCPUCheck /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\Setup\LabConfig" /v BypassRAMCheck /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\Setup\LabConfig" /v BypassStorageCheck /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\Setup\MoSetup" /v AllowUpgradesWithUnsupportedTPMOrCPU /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v BypassNRO /t REG_DWORD /d 1 /f >nul

reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v AutoReboot /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v CrashDumpEnabled /t REG_DWORD /d 3 /f >nul

for %%E in (CompatTelRunner.exe AggregatorHost.exe DeviceCensus.exe FeatureLoader.exe BingChatInstaller.exe BGAUpsell.exe BCILauncher.exe) do (
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%E" /v Debugger /t REG_SZ /d "%windir%\System32\taskkill.exe" /f >nul
)
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchIndexer.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 5 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ctfmon.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 5 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\fontdrvhost.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\sihost.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 1 /f >nul

reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableFirstLogonAnimation /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableStartupSound /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableAutomaticRestartSignOn /t REG_DWORD /d 1 /f >nul

reg add "HKCU\Software\Microsoft\Multimedia\Audio" /v UserDuckingPreference /t REG_DWORD /d 3 /f >nul

reg add "HKLM\SOFTWARE\Microsoft\ClickToRun\OverRide" /v DisableLogManagement /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Office\ClickToRun\Configuration" /v TimerInterval /t REG_SZ /d "900000" /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v RSoPLogging /t REG_DWORD /d 0 /f >nul

reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\MSIServer" /ve /t REG_SZ /d "Service" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\MSIServer" /ve /t REG_SZ /d "Service" /f >nul

rem ============================================================
rem 6. SERVICES — только телеметрия/диагностика/принтер/факс
rem    НЕ ТРОГАЕМ: темы (Themes/UxSms), Bluetooth, батарею, тачпад, питание
rem ============================================================
echo [*] Services...
for %%S in (
    diagsvc embeddedmode DPS
    Spooler PrintNotify PrintWorkflowUserSvc PrintDeviceConfigurationService PrintScanBrokerService
    Fax
    wercplsupport WerSvc Telemetry DiagTrack diagnosticshub.standardcollector.service
    dmwappushservice wisvc PcaSvc WdiServiceHost WdiSystemHost tcpipreg Wecsvc
    UCPD MapsBroker RetailDemo RemoteRegistry TrkWks WMPNetworkSvc
    WaaSMedicSvc UsoSvc
) do (
    sc config "%%S" start= disabled >nul 2>&1
    sc stop   "%%S" >nul 2>&1
)

sc config "condrv" start= auto >nul 2>&1
sc config "w32time" start= demand >nul 2>&1
powershell -NoProfile -Command "Disable-ScheduledTask -TaskPath '\Microsoft\Windows\AppxDeploymentClient' -TaskName 'UCPD velocity' -ErrorAction SilentlyContinue" >nul 2>&1

:: ============================================================
:: 7. SCHEDULED TASKS
::    Отключение задач без интерактивных запросов.
::    < nul гарантирует, что schtasks не будет ждать ввод.
:: ============================================================
echo [*] Disabling scheduled tasks...
for %%T in (
  "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
  "\Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvents"
  "\Microsoft\Windows\MemoryDiagnostic\RunFullMemoryDiagnostic"
  "\Microsoft\Windows\WindowsUpdate\Scheduled Start"
  "\Microsoft\Windows\Windows Error Reporting\QueueReporting"
  "\Microsoft\Windows\Application Experience\AitAgent"
  "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
  "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
  "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
  "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
  "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask"
  "\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScanAfterUpdate"
  "\Microsoft\Windows\UpdateOrchestrator\Start Oobe Expedite Work"
  "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan"
  "\Microsoft\Windows\Data Integrity Scan\Data Integrity Check And Scan"
  "\Microsoft\Windows\Data Integrity Scan\Data Integrity Scan"
  "\Microsoft\Windows\Data Integrity Scan\Data Integrity Scan for Crash Recovery"
  "\Microsoft\Windows\Registry\RegIdleBackup"
  "\Microsoft\Windows\Feedback\Siuf\DmClient"
  "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
  "\Microsoft\Windows\Device Information\Device"
  "\Microsoft\Windows\Device Information\Device User"
  "\Microsoft\Windows\Device Setup\Driver Recovery on Reboot"
  "\Microsoft\Windows\Device Setup\Metadata Refresh"
  "\Microsoft\Windows\Maps\MapsToastTask"
  "\Microsoft\Windows\Maps\MapsUpdateTask"
  "\Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask"
  "\Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner"
  "\Microsoft\Windows\Diagnosis\Scheduled"
  "\Microsoft\Windows\Diagnosis\UnexpectedCodepath"
  "\Microsoft\Windows\DiskCleanup\SilentCleanup"
  "\Microsoft\Windows\DiskFootprint\Diagnostics"
  "\Microsoft\Windows\DiskFootprint\StorageSense"
  "\Microsoft\Windows\Maintenance\WinSAT"
  "\Microsoft\Windows\Autochk\Proxy"
  "\Microsoft\Windows\PI\Sqm-Tasks"
  "\Microsoft\Windows\NetTrace\GatherNetworkInfo"
  "\Microsoft\Windows\Shell\FamilySafetyMonitor"
  "\Microsoft\Windows\Shell\FamilySafetyRefresh"
  "\Microsoft\Windows\Shell\FamilySafetyUpload"
  "\Microsoft\Windows\Shell\IndexerAutomaticMaintenance"
  "\Microsoft\Windows\Shell\ThemeAssetTask_SyncFODState"
  "\Microsoft\Windows\Shell\ThemesSyncedImageDownload"
  "\Microsoft\Windows\Shell\UndockedFlightingUpdate"
  "\Microsoft\Windows\Shell\UpdateUserPictureTask"
  "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance"
  "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup"
  "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
  "\Microsoft\Windows\Windows Defender\Windows Defender Verification"
  "\Microsoft\Windows\ExploitGuard\ExploitGuard MDM policy Refresh"
  "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask"
  "\Microsoft\Windows\CloudExperienceHost\SyncHost"
  "\Microsoft\Windows\CloudRestore\Backup"
  "\Microsoft\Windows\CloudRestore\Restore"
  "\Microsoft\Windows\PushToInstall\LoginCheck"
  "\Microsoft\Windows\PushToInstall\Registration"
  "\Microsoft\Windows\UPnP\UPnPHostConfig"
  "\Microsoft\Windows\UpdateOrchestrator\CleanupUpdateTask"
  "\Microsoft\Windows\WaaSMedic\PerformRemediation"
  "\Microsoft\Windows\WaaSMedic\ScanForUpdates"
  "\Microsoft\Windows\WaaSMedic\WsusScan"
  "\Microsoft\Windows\WindowsAI\Recall\InitialConfiguration"
  "\Microsoft\Windows\WindowsAI\Recall\PolicyConfiguration"
  "\Microsoft\Windows\WindowsAI\Settings\InitialConfiguration"
  "\Microsoft\Windows\WindowsAI\Copilot\CopilotDataCollectionTask"
  "\Microsoft\Windows\WindowsAI\Insights\InsightsDataCollectionTask"
  "\Microsoft\Windows\AppID\EDP Policy Manager"
  "\Microsoft\Windows\AppID\PolicyConverter"
  "\Microsoft\Windows\AppID\SmartScreenSpecific"
  "\Microsoft\Windows\BrokerInfrastructure\BgTaskRegistrationMaintenanceTask"
  "\Microsoft\Windows\CEIP\Uploader"
  "\Microsoft\Windows\File Classification Infrastructure\Property Definition Sync"
  "\Microsoft\Windows\FileHistory\File History (maintenance mode)"
  "\Microsoft\Windows\DeviceDirectoryClient\HandleCommand"
  "\Microsoft\Windows\DeviceDirectoryClient\HandleWnsCommand"
  "\Microsoft\Windows\DeviceDirectoryClient\IntegrityCheck"
  "\Microsoft\Windows\DeviceDirectoryClient\LocateCommandUserSession"
  "\Microsoft\Windows\DeviceDirectoryClient\RegisterDeviceAccountChange"
  "\Microsoft\Windows\DeviceDirectoryClient\RegisterDeviceLocationRightsChange"
  "\Microsoft\Windows\DeviceDirectoryClient\RegisterDevicePeriodic24"
  "\Microsoft\Windows\DeviceDirectoryClient\RegisterDevicePolicyChange"
  "\Microsoft\Windows\DeviceDirectoryClient\RegisterDeviceProtectionStateChanged"
  "\Microsoft\Windows\DeviceDirectoryClient\RegisterDeviceSettingChange"
  "\Microsoft\Windows\DeviceDirectoryClient\RegisterUserDevice"
  "\Microsoft\Windows\License Manager\TempSignedLicenseExchange"
  "\Microsoft\Windows\Location\WindowsActionDialog"
  "\Microsoft\Windows\Printing\EduPrintProv"
  "\Microsoft\Windows\Printing\PrintJobCleanupTask"
  "\Microsoft\Windows\ContactSupport\Scheduled"
  "\Microsoft\Windows\Customer Experience Improvement Program\Server\ServerCeipAssistant"
  "\Microsoft\Windows\Customer Experience Improvement Program\Server\ServerRoleCollector"
  "\Microsoft\Windows\Customer Experience Improvement Program\Server\ServerRoleUsageCollector"
  "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM"
  "\Microsoft\Windows\Customer Experience Improvement Program\Uploader"
  "\Microsoft\Windows\RetailDemo\CleanupOfflineContent"
  "\Microsoft\Windows\Ras\MobilityManager"
  "\Microsoft\Windows\DUSM\dusmtask"
  "\Microsoft\Windows\Windows Filtering Platform\BfeOnServiceStartTypeChange"
  "\Microsoft\Windows\WindowsUpdate\Refresh Group Policy Cache"
  "\Microsoft\Windows\Storage Tiers Management\Storage Tiers Optimization"
  "\Microsoft\Windows\Workplace Join\Automatic-Device-Join"
  "\Microsoft\Windows\Workplace Join\Device-Sync"
  "\Microsoft\Windows\Workplace Join\Recovery-Check"
  "\Microsoft\Windows\InstallService\WakeUpAndContinueUpdates"
  "\Microsoft\Windows\InstallService\WakeUpAndScanForUpdates"
  "\Microsoft\Windows\Subscription\EnableLicenseAcquisition"
  "\Microsoft\Windows\Subscription\LicenseAcquisition"
  "\Microsoft\Windows\International\Synchronize Language Settings"
  "\Microsoft\Windows\LanguageComponentsInstaller\Installation"
  "\Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources"
  "\Microsoft\Windows\LanguageComponentsInstaller\Uninstallation"
  "\Microsoft\Windows\AppxDeploymentClient\Pre-staged app cleanup"
  "\Microsoft\Windows\AppxDeploymentClient\UCPD velocity"
  "\Microsoft\Windows\ApplicationData\appuriverifierdaily"
  "\Microsoft\Windows\ApplicationData\appuriverifierinstall"
  "\Microsoft\Windows\ApplicationData\DsSvcCleanup"
  "\Microsoft\Windows\Setup\SetupCleanupTask"
  "\Microsoft\Windows\SharedPC\Account Cleanup"
  "\Microsoft\Windows\CertificateServicesClient\AikCertEnrollTask"
  "\Microsoft\Windows\CertificateServicesClient\CryptoPolicyTask"
  "\Microsoft\Windows\CertificateServicesClient\KeyPreGenTask"
  "\Microsoft\Windows\CertificateServicesClient\SystemTask"
  "\Microsoft\Windows\Help\OEMSupport"
  "\Microsoft\Windows\Help\WindowsHelpUpdateTask"
  "\Microsoft\Windows\HelloFace\FODCleanupTask"
  "\Microsoft\Windows\HelloFace\FeatureCleanup"
  "\Microsoft\Windows\AutoLogger\AutoLogger-Diagtrack-Listener"
  "\Microsoft\Windows\AutoLogger\AutoLogger-FileSizeTracking"
  "\Microsoft\Windows\Offline Files\Background Synchronization"
  "\Microsoft\Windows\Offline Files\Logon Synchronization"
  "\Microsoft\Windows\NlaSvc\WiFiTask"
  "\Microsoft\Windows\User Profile Service\HiveUploadTask"
  "\Microsoft\Windows\ReFsDedupSvc\Initialization"
  "\Microsoft\Windows\UNP\RunCampaignManager"
  "\Microsoft\Windows\WOF\WIM-Hash-Management"
  "\Microsoft\Windows\WOF\WIM-Hash-Validation"
) do schtasks /Change /TN "%%~T" /Disable < nul > nul 2>&1

rem Office-задачи: без интерактивных запросов, через PowerShell с -Confirm:$false
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ScheduledTask -TaskPath '\Microsoft\Office\*' -ErrorAction SilentlyContinue | ForEach-Object { try { Disable-ScheduledTask -TaskName $_.TaskName -TaskPath $_.TaskPath -Confirm:$false -ErrorAction SilentlyContinue | Out-Null } catch {} }" < nul > nul 2>&1

echo [OK] Scheduled tasks processed.

rem ============================================================
rem 8. DISM / CAPABILITIES
rem ============================================================
echo [*] Optional features...
dism /online /enable-feature  /featurename:DirectPlay /all /norestart >nul 2>&1
dism /online /enable-feature  /featurename:LegacyComponents /all /norestart >nul 2>&1
for %%F in (MicrosoftWindowsPowerShellV2 MicrosoftWindowsPowerShellV2Root MSRDC-Infrastructure Printing-Foundation-Features Printing-Foundation-InternetPrinting-Client WorkFolders-Client) do (
    dism /online /disable-feature /featurename:%%F /norestart >nul 2>&1
)

rem ============================================================
rem 9. APPX REMOVAL
rem    НЕ УДАЛЯЕМ: Notepad, Paint, Snipping Tool / ScreenSketch /
rem    ScreenClippingHost, Photos, Edge, Xbox, Copilot
rem ============================================================
echo [*] Removing Appx packages...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; $list='Microsoft.Windows.SecureAssessmentBrowser Microsoft.Windows.PeopleExperienceHost Microsoft.WindowsCamera MicrosoftWindows.Client.WebExperience Microsoft.WidgetsPlatformRuntime Microsoft.WindowsAlarms Microsoft.WindowsMaps Microsoft.MicrosoftStickyNotes microsoft.windowscommunicationsapps Microsoft.People Microsoft.BingNews Microsoft.BingSearch Microsoft.BingWeather Microsoft.MicrosoftSolitaireCollection Microsoft.WindowsFeedbackHub Microsoft.GetHelp Microsoft.Getstarted Microsoft.Todos Microsoft.PowerAutomateDesktop Microsoft.549981C3F5F10 MicrosoftCorporationII.QuickAssist MicrosoftCorporationII.MicrosoftFamily Microsoft.ZuneMusic Microsoft.ZuneVideo Microsoft.WindowsSoundRecorder Clipchamp.Clipchamp Microsoft.Whiteboard Microsoft.MicrosoftTeamsforSurfaceHub MicrosoftCorporationII.MailforSurfaceHub Microsoft.MicrosoftPowerBIForWindows Microsoft.SkypeApp Microsoft.MicrosoftOfficeHub Microsoft.Office.Excel Microsoft.Office.PowerPoint Microsoft.Office.Word Microsoft.Office.OneNote Microsoft.OutlookForWindows SpotifyAB.SpotifyMusic OutlookPWA Microsoft.Microsoft3DViewer Microsoft.Advertising MixedReality.Portal Microsoft.StartExperiencesApp Microsoft.Windows.DevHome Microsoft.GamingApp Microsoft.Edge.GameAssist Microsoft.YourPhone MicrosoftWindows.CrossDevice'.Split(' '); foreach($n in $list){ Get-AppxPackage -AllUsers -Name $n | ForEach-Object { $d='HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned\'+$_.PackageFamilyName; if(!(Test-Path $d)){New-Item -Path $d -Force|Out-Null}; Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue }; Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -like ($n+'*')} | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue }" >nul 2>&1

rem ============================================================
rem 10. ONEDRIVE (полное удаление)
rem ============================================================
echo [*] OneDrive removal...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; Stop-Process -Name OneDrive* -Force; $p=@($env:SystemRoot+'\System32\OneDriveSetup.exe',$env:SystemRoot+'\SysWOW64\OneDriveSetup.exe'); foreach($f in $p){ if(Test-Path $f){ Start-Process $f '/uninstall' -Wait -NoNewWindow } }; Get-ChildItem 'C:\Users' -Directory | ForEach-Object { $od=$_.FullName+'\AppData\Local\Microsoft\OneDrive'; if(Test-Path $od){Remove-Item $od -Recurse -Force}; $lnk=$_.FullName+'\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk'; if(Test-Path $lnk){Remove-Item $lnk -Force} }; Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' -Name OneDrive -ErrorAction SilentlyContinue; Get-AppxPackage -AllUsers -Name OneDrive | Remove-AppxPackage -AllUsers; Get-AppxPackage -AllUsers -Name microsoft.microsoftskydrive | Remove-AppxPackage -AllUsers" >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v OneDrive /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSync /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisablePersonalSync /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableMeteredNetworkFileSync /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableLibrariesDefaultSaveToOneDrive /t REG_DWORD /d 1 /f >nul
for %%K in (
    "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
    "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
    "HKCU\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
    "HKCU\Software\Classes\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
) do reg delete %%K /f >nul 2>&1

schtasks /delete /tn "\OneDrive Reporting Task" /f >nul 2>&1
schtasks /delete /tn "\OneDrive Standalone Update Task" /f >nul 2>&1
schtasks /delete /tn "\OneDrive Per-Machine Standalone Update" /f >nul 2>&1
schtasks /delete /tn "\OneDrive Reporting Task-S-1-5-21" /f >nul 2>&1
schtasks /delete /tn "\OneDrive Standalone Update Task-S-1-5-21" /f >nul 2>&1

reg delete "HKCU\Environment" /v "OneDrive" /f >nul 2>&1
reg delete "HKCU\Environment" /v "OneDriveConsumer" /f >nul 2>&1
reg delete "HKCU\Environment" /v "OneDriveCommercial" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\OneDrive" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\OneDrive\Accounts" /f >nul 2>&1

for /f "usebackq delims=" %%a in (`reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SyncRootManager" 2^>nul ^| findstr /i /c:"OneDrive"`) do reg delete "%%a" /f >nul 2>&1

if exist "%NS%" (
    for /d %%D in ("%SYSTEMROOT%\WinSxS\amd64_microsoft-windows-onedrive-setup*") do (
        "%NS%" -U:T -P:E -ShowWindowMode:Hide -Wait cmd.exe /c "rd /s /q ""%%D""" >nul 2>&1
    )
    "%NS%" -U:T -P:E -ShowWindowMode:Hide -Wait cmd.exe /c "del /f /q ""%SYSTEMROOT%\System32\OneDriveSetup.exe"" >nul 2>&1"
    "%NS%" -U:T -P:E -ShowWindowMode:Hide -Wait cmd.exe /c "del /f /q ""%SYSTEMROOT%\System32\OneDrive.ico"" >nul 2>&1"
    "%NS%" -U:T -P:E -ShowWindowMode:Hide -Wait cmd.exe /c "del /f /q ""%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe"" >nul 2>&1"
) else (
    for /d %%D in ("%SYSTEMROOT%\WinSxS\amd64_microsoft-windows-onedrive-setup*") do (
        takeown /f "%%D" /r /d y >nul 2>&1
        icacls "%%D" /grant administrators:F /t >nul 2>&1
        rd "%%D" /Q /S >nul 2>&1
    )
    del /f /q "%SYSTEMROOT%\System32\OneDriveSetup.exe" >nul 2>&1
    del /f /q "%SYSTEMROOT%\System32\OneDrive.ico" >nul 2>&1
    del /f /q "%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe" >nul 2>&1
)

reg load "HKU\DefaultHiveOD" "%SystemDrive%\Users\Default\NTUSER.DAT" >nul 2>&1
if not errorlevel 1 (
    reg delete "HKU\DefaultHiveOD\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f >nul 2>&1
    reg delete "HKU\DefaultHiveOD\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f >nul 2>&1
    reg add "HKU\DefaultHiveOD\SOFTWARE\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >nul 2>&1
    reg unload "HKU\DefaultHiveOD" >nul 2>&1
)

rem ============================================================
rem 11. DEFENDER HARD REMOVAL
rem ============================================================
echo [*] Defender hard removal...
for %%P in (NisSrv.exe MsMpEng.exe SecurityHealthHost.exe SecurityHealthService.exe SecurityHealthSystray.exe smartscreen.exe MpCmdRun.exe) do taskkill /f /im %%P >nul 2>&1
timeout /t 2 /nobreak >nul

powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage '*SecHealthUI*' | Remove-AppxPackage -ErrorAction SilentlyContinue; Get-AppxPackage '*Apprep*' | Remove-AppxPackage -ErrorAction SilentlyContinue; Get-AppxPackage '*WindowsSecurity*' | Remove-AppxPackage -ErrorAction SilentlyContinue" >nul 2>&1

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiVirus" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SpynetReporting" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d 2 /f >nul

for %%S in (Sense WinDefend MsSecCore wscsvc WdFilter WdBoot WdNisDrv WdNisSvc MsSecWfp MsSecFlt wtd webthreatdefusersvc webthreatdefsvc SecurityHealthService) do reg delete "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /f >nul 2>&1

if exist "%NS%" (
    "%NS%" -U:T -P:E -ShowWindowMode:Hide -Wait cmd.exe /c "del /f /q ""%windir%\System32\SecurityHealthService.exe""" >nul 2>&1
    "%NS%" -U:T -P:E -ShowWindowMode:Hide -Wait cmd.exe /c "del /f /q ""%windir%\System32\SecurityHealthSystray.exe""" >nul 2>&1
    "%NS%" -U:T -P:E -ShowWindowMode:Hide -Wait cmd.exe /c "del /f /q ""%windir%\System32\MsMpEng.exe""" >nul 2>&1
    "%NS%" -U:T -P:E -ShowWindowMode:Hide -Wait cmd.exe /c "del /f /q ""%windir%\System32\drivers\WdNisDrv.sys""" >nul 2>&1
    "%NS%" -U:T -P:E -ShowWindowMode:Hide -Wait cmd.exe /c "del /f /q ""%windir%\System32\drivers\WdFilter.sys""" >nul 2>&1
    "%NS%" -U:T -P:E -ShowWindowMode:Hide -Wait cmd.exe /c "del /f /q ""%windir%\System32\drivers\WdBoot.sys""" >nul 2>&1
) else (
    del /f /q "%windir%\System32\SecurityHealthService.exe" >nul 2>&1
    del /f /q "%windir%\System32\SecurityHealthSystray.exe" >nul 2>&1
    del /f /q "%windir%\System32\MsMpEng.exe" >nul 2>&1
    del /f /q "%windir%\System32\drivers\WdNisDrv.sys" >nul 2>&1
    del /f /q "%windir%\System32\drivers\WdFilter.sys" >nul 2>&1
    del /f /q "%windir%\System32\drivers\WdBoot.sys" >nul 2>&1
)
for %%F in (SecurityHealthAgent.dll SecurityHealthHost.exe SecurityHealthSSO.dll SecurityHealthCore.dll SecurityHealthProxyStub.dll SecurityHealthUdk.dll smartscreen.exe smartscreenps.dll MpClient.dll MpCommu.dll MpOAV.dll MpSvc.dll) do (
    if exist "%NS%" (
        "%NS%" -U:T -P:E -ShowWindowMode:Hide -Wait cmd.exe /c "del /f /q ""%windir%\System32\%%F""" >nul 2>&1
    ) else (
        del /f /q "%windir%\System32\%%F" >nul 2>&1
    )
)

for %%P in (
    "%ProgramW6432%\Windows Defender"
    "%ProgramW6432%\Windows Defender Advanced Thread Protection"
    "%ProgramFiles(x86)%\Windows Defender"
    "%ProgramData%\Microsoft\Windows Defender"
    "%ProgramData%\Microsoft\Windows Defender Advanced Threat Protection"
    "%ProgramData%\Microsoft\Windows Security Health"
) do (
    if exist %%P (
        takeown /f %%P /r /d y >nul 2>&1
        icacls %%P /grant administrators:F /t >nul 2>&1
        rd %%P /Q /S >nul 2>&1
    )
)

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\UpdateHealthTools" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\rempl" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\CloudManagedUpdate" /f >nul 2>&1
rd "%ProgramW6432%\Microsoft Update Health Tools" /Q /S >nul 2>&1
rd "%ProgramW6432%\PCHealthCheck" /Q /S >nul 2>&1

schtasks /change /tn "\Microsoft\Windows\ExploitGuard\ExploitGuard MDM policy Refresh" /disable >nul 2>&1
schtasks /delete /tn "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /f >nul 2>&1
schtasks /delete /tn "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /f >nul 2>&1
schtasks /delete /tn "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /f >nul 2>&1
schtasks /delete /tn "\Microsoft\Windows\Windows Defender\Windows Defender Verification" /f >nul 2>&1

for %%K in (
    "HKLM\SOFTWARE\Classes\*\ShellEx\ContextMenuHandlers\EPP"
    "HKLM\SOFTWARE\Classes\Drive\ShellEx\ContextMenuHandlers\EPP"
    "HKLM\SOFTWARE\Classes\Directory\ShellEx\ContextMenuHandlers\EPP"
    "HKLM\SOFTWARE\Classes\AllFilesystemObjects\ShellEx\ContextMenuHandlers\EPP"
) do reg delete %%K /f >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" /v "Start" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" /v "Start" /t REG_DWORD /d 0 /f >nul

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 0 /f >nul

reg delete "HKCU\Software\Microsoft\Windows Defender" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /f >nul 2>&1

DISM.exe /Online /Disable-Feature /FeatureName:"Windows-Defender-Default-Definitions" /NoRestart >nul 2>&1
DISM.exe /Online /Disable-Feature /FeatureName:"Windows-Defender" /NoRestart >nul 2>&1

rem ============================================================
rem A. ПРОФИЛЬНЫЕ ТВИКИ (HKCU / HKU\.DEFAULT / HKLM)
rem ============================================================
echo [*] Profile tweaks...

rem --- Control Panel ---
reg add "HKCU\Control Panel\Desktop" /v JPEGImportQuality /t REG_DWORD /d 100 /f >nul
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v JPEGImportQuality /t REG_DWORD /d 100 /f >nul
reg add "HKCU\Control Panel\Sound" /v Beep /t REG_SZ /d "no" /f >nul
reg add "HKU\.DEFAULT\Control Panel\Sound" /v Beep /t REG_SZ /d "no" /f >nul
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d "0" /f >nul
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d "0" /f >nul
reg add "HKCU\Control Panel\Desktop" /v ActiveWndTrkTimeout /t REG_DWORD /d 10 /f >nul
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v ActiveWndTrkTimeout /t REG_DWORD /d 10 /f >nul
reg add "HKCU\Control Panel\Desktop" /v AutoEndTasks /t REG_SZ /d "1" /f >nul
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v AutoEndTasks /t REG_SZ /d "1" /f >nul
reg add "HKCU\Control Panel\Desktop" /v HungAppTimeout /t REG_SZ /d "2000" /f >nul
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v HungAppTimeout /t REG_SZ /d "2000" /f >nul
reg add "HKCU\Control Panel\Desktop" /v WaitToKillAppTimeout /t REG_SZ /d "2000" /f >nul
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v WaitToKillAppTimeout /t REG_SZ /d "2000" /f >nul
reg add "HKCU\Control Panel\Desktop" /v LowLevelHooksTimeout /t REG_SZ /d "1000" /f >nul
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v LowLevelHooksTimeout /t REG_SZ /d "1000" /f >nul
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d "0" /f >nul
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d "0" /f >nul
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d "0" /f >nul
reg add "HKU\.DEFAULT\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d "0" /f >nul
reg add "HKU\.DEFAULT\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d "0" /f >nul
reg add "HKU\.DEFAULT\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d "0" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v AllowOnlineTips /t REG_DWORD /d 0 /f >nul

rem --- Ease of Access: обнуление наследия ---
for %%H in (HKCU HKU\.DEFAULT) do (
  for %%K in (AudioDescription "Blind Access" HighContrast "Keyboard Preference" "Keyboard Response" MouseKeys On ShowSounds SlateLaunch SoundSentry StickyKeys TimeOut ToggleKeys) do (
    reg delete "%%H\Control Panel\Accessibility\%%~K" /f >nul 2>&1
    reg add    "%%H\Control Panel\Accessibility\%%~K" /v Flags /t REG_SZ /d "0" /f >nul
  )
)

rem --- Explorer general ---
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" /v FolderType /t REG_SZ /d "NotSpecified" /f >nul
reg add "HKU\.DEFAULT\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" /v FolderType /t REG_SZ /d "NotSpecified" /f >nul
reg add "HKCU\Software\Microsoft\DirectX\UserGpuPreferences" /v "C:\Windows\explorer.exe" /t REG_SZ /d "GpuPreference=2;" /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\DirectX\UserGpuPreferences" /v "C:\Windows\explorer.exe" /t REG_SZ /d "GpuPreference=2;" /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v DisableGraphRecentItems /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{2cc5ca98-6485-489a-920e-b3e88a6ccce3}" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v MultipleInvokePromptMinimum /t REG_DWORD /d 100 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer" /v MultipleInvokePromptMinimum /t REG_DWORD /d 100 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v link /t REG_BINARY /d 00000000 /f >nul
reg add "HKU\.DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v link /t REG_BINARY /d 00000000 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v EnthusiastMode /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v EnthusiastMode /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v DisableAutoplay /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v DisableAutoplay /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 255 /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 255 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoLowDiskSpaceChecks /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoLowDiskSpaceChecks /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v WaitToKillServiceTimeout /t REG_SZ /d "1500" /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v LinkResolveIgnoreLinkInfo /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v LinkResolveIgnoreLinkInfo /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" /v AllowWindowsInkWorkspace /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" /v AllowSuggestedAppsInWindowsInkWorkspace /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_IrisRecommendations /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_IrisRecommendations /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_AccountNotifications /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_AccountNotifications /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" /v TaskbarEndTask /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" /v TaskbarEndTask /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowInfoTip /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowInfoTip /t REG_DWORD /d 0 /f >nul

rem --- Notifications / Search / Start / Taskbar / View ---
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v NoBalloonFeatureAdvertisements /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Policies\Microsoft\Windows\Explorer" /v NoBalloonFeatureAdvertisements /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v NoAutoTrayNotify /t REG_DWORD /d 1

rem ============================================================
rem B. ВКЛЮЧЕНИЕ/ВОССТАНОВЛЕНИЕ СКРИНШОТЕРА WINDOWS 11
rem    PrtScn -> Snipping Tool (с выделением области)
rem    Win+Shift+S -> ScreenClippingHost
rem ============================================================
echo [*] Enabling Windows 11 Snipping Tool / ScreenClippingHost...

rem Убеждаемся что приложения установлены (не удалены)
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$pkgs = @('Microsoft.ScreenSketch_8wekyb3d8bbwe','Microsoft.Windows.SnippingTool_8wekyb3d8bbwe');" ^
  "foreach($p in $pkgs){ $q = Get-AppxPackage -AllUsers -Name $p -ErrorAction SilentlyContinue; if(-not $q){ Write-Host '[!] $p не установлен — ставим из Store через ProvisionedPackage'; $prov = Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -like ($p+'*')}; if($prov){ Add-AppxProvisionedPackage -Online -PackagePath $prov.PackagePath -SkipLicense -ErrorAction SilentlyContinue | Out-Null } } }" >nul 2>&1

rem Снимаем возможные блокировки через AppKey (PrintScreen = 17, Snipping = 18)
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AppKey\17" /v "Disable" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AppKey\18" /v "Disable" /f >nul 2>&1
reg add    "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AppKey\17" /ve /t REG_SZ /d "ScreenClipping" /f >nul
reg add    "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AppKey\17" /v "Association" /t REG_SZ /d "ScreenClipping" /f >nul
reg add    "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AppKey\18" /ve /t REG_SZ /d "SnippingTool" /f >nul
reg add    "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AppKey\18" /v "Association" /t REG_SZ /d "SnippingTool" /f >nul

rem Убираем возможные IFEO-подмены
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SnippingTool.exe" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ScreenSketch.exe" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ScreenClippingHost.exe" /f >nul 2>&1

rem Политика: использовать PrtScn для открытия Snipping Tool
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisableScreenClipping" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SnipButtonEnabled" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SnippingToolPrintScreenEnabled" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Control Panel\Keyboard" /v "PrintScreenKey" /t REG_SZ /d "SnippingTool" /f >nul

rem Возвращаем ярлык Snipping Tool в Start Menu
if not exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Snipping Tool.lnk" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
      "$lnk = (New-Object -ComObject WScript.Shell).CreateShortcut('%APPDATA%\Microsoft\Windows\Start Menu\Programs\Snipping Tool.lnk');" ^
      "$lnk.TargetPath = 'explorer.exe';" ^
      "$lnk.Arguments = 'shell:AppsFolder\Microsoft.ScreenSketch_8wekyb3d8bbwe!App';" ^
      "$lnk.Save()" >nul 2>&1
)

rem Убеждаемся что Capabilities ScreenSketch не отключены
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\screenCapture" /v "Value" /t REG_SZ /d "Allow" /f >nul

rem Включаем необязательные компоненты (если вдруг отключены ранее)
dism /online /enable-feature /featurename:Printing-Foundation-Features /norestart >nul 2>&1
dism /online /enable-feature /featurename:Printing-Foundation-InternetPrinting-Client /norestart >nul 2>&1

rem Восстанавливаем ассоциацию Win+Shift+S
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AppKey\18" /ve /t REG_SZ /d "SnippingTool" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AppKey\18" /v "Association" /t REG_SZ /d "SnippingTool" /f >nul

echo [OK] Snipping Tool / ScreenClippingHost восстановлен.

echo [*] Additional tweaks...

rem --- Windows Desktop heap / timer coalescing ---
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v DesktopHeapLogging /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v TimerCoalescing /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v SvcHostSplitThresholdInKB /t REG_DWORD /d 3489660927 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v BootExecuteNoPnpSync /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v SleepStudyDisabled /t REG_DWORD /d 1 /f >nul

rem --- Explorer / UI (W10/W11 specific) ---
reg add "HKCU\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d "0" /f >nul
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038012000000 /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d "0" /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f >nul
reg add "HKCU\Software\Microsoft\Windows\DWM" /v EnableAeroPeek /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\DWM" /v AlwaysHibernateThumbnails /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PenWorkspace" /v PenWorkspaceButtonDesiredVisibility /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\DirectX\UserGpuPreferences" /v DirectXUserGlobalSettings /t REG_SZ /d "SwapEffectUpgradeEnable=1;VRROptimizeEnable=0;" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" /v TaskbarEndTask /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CrossDeviceResume\Configuration" /v IsResumeAllowed /t REG_DWORD /d 0 /f >nul

rem --- W10-specific ---
reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v TipbandDesiredVisibility /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v PeopleBand /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f >nul
rd "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /q >nul 2>&1
rd "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /q >nul 2>&1

rem --- Logging / diagnostics (из XOS detect-windows-build) ---
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v DisableProjectedShadows /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v MousewheelAnimationDurationMs /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\XAML" /v DisableGlobalAnimations /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v DisableLogonBackgroundImage /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v InitializePlatformOnStartup /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\SchedulingAgent" /v ViewHiddenTasks /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Control Panel\Cursors" /v PenVisualization /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Control Panel\Desktop" /v AutoColorization /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Control Panel\Desktop" /v SmoothScroll /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Control Panel\Personalization\Desktop Slideshow" /v AnimationDuration /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Input\Settings" /v Insights /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Input\Settings" /v UserStatsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisablePreviewDesktop /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisablePreviewWindow /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v NoNetCrawling /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_NotifyNewApps /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackCachedFileUpdaterContract /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackConnectedSearchHistory /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackOpenPickerContract /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackSavePickerContract /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackSearchContract /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackShareContractMFU /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarFlashOverrideBreatheCount /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\BamThrottling" /v DisableWindowHinting /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoNetCrawling /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoRecentDocsMenu /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoRemoteChangeNotify /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoRemoteRecursiveEvents /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoSMHelp /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v TurnOffSPIAnimations /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v HourlyTelemetyThreshold /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" /v DisableCharms /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" /v DisableRecentApps /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v DisableThumbsDBOnNetworkFolders /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v SkipNetworkShieldCheck /t REG_DWORD /d 1 /f >nul

rem --- MPO disable ---
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v OverlayTestMode /t REG_DWORD /d 5 /f >nul

rem --- Fault Tolerant Heap disable ---
reg add "HKLM\SOFTWARE\Microsoft\FTH" /v Enabled /t REG_DWORD /d 0 /f >nul
rundll32.exe fthsvc.dll,FthSysprepSpecialize >nul 2>&1

rem --- Memory Compression disable (memory, not power) ---
powershell -NoProfile -Command "Disable-MMAgent -MemoryCompression -ErrorAction SilentlyContinue" >nul 2>&1

rem --- Process mitigations disable ---
powershell -NoProfile -ExecutionPolicy Bypass -Command "$WarningPreference='SilentlyContinue'; try { ForEach ($v in (Get-Command -Name 'Set-ProcessMitigation').Parameters['Disable'].Attributes.ValidValues) { Set-ProcessMitigation -SYSTEM -Disable $v.ToString() -ErrorAction SilentlyContinue } } catch {}; $kernelKey='HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\kernel'; $maskLength=38; try { $existing=(Get-ItemProperty -Path $kernelKey -ErrorAction SilentlyContinue).MitigationAuditOptions; if ($existing -and $existing.Length -gt 0) { $maskLength=$existing.Length } } catch {}; $mask=[byte[]]::new($maskLength); for ($i=0; $i -lt $maskLength; $i++) { $mask[$i]=0x22 }; $exes=@('fontdrvhost.exe','dwm.exe','lsass.exe','svchost.exe','WmiPrvSE.exe','winlogon.exe','csrss.exe','ntoskrnl.exe','services.exe'); foreach ($exe in $exes) { $path='HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\'+$exe; try { if (-not (Test-Path $path)) { New-Item -Path $path -Force | Out-Null }; Set-ItemProperty -Path $path -Name 'MitigationOptions' -Value $mask -Type Binary -Force -ErrorAction SilentlyContinue; Set-ItemProperty -Path $path -Name 'MitigationAuditOptions' -Value $mask -Type Binary -Force -ErrorAction SilentlyContinue } catch {} }; try { if (-not (Test-Path $kernelKey)) { New-Item -Path $kernelKey -Force | Out-Null }; Set-ItemProperty -Path $kernelKey -Name 'MitigationOptions' -Value $mask -Type Binary -Force -ErrorAction SilentlyContinue; Set-ItemProperty -Path $kernelKey -Name 'MitigationAuditOptions' -Value $mask -Type Binary -Force -ErrorAction SilentlyContinue } catch {}" >nul 2>&1

rem --- WINEVT channels disable ---
powershell -NoProfile -ExecutionPolicy Bypass -Command "try { $root=[Microsoft.Win32.Registry]::LocalMachine.OpenSubKey('SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels',$true); if ($root) { foreach ($name in $root.GetSubKeyNames()) { $sub=$null; try { $sub=$root.OpenSubKey($name,$true); if ($sub -and ($sub.GetValue('Enabled') -eq 1)) { $sub.SetValue('Enabled',0,'DWord') } } catch {} finally { if ($sub) { $sub.Close() } } }; $root.Close() } } catch {}" >nul 2>&1

rem --- DMA remapping disable ---
powershell -NoProfile -ExecutionPolicy Bypass -Command "$policyPath='HKLM:\SOFTWARE\Microsoft\PolicyManager\default\DmaGuard\DeviceEnumerationPolicy'; try { if (-not (Test-Path $policyPath)) { New-Item -Path $policyPath -Force | Out-Null }; Set-ItemProperty -Path $policyPath -Name 'value' -Value 2 -Type DWord -Force -ErrorAction SilentlyContinue } catch {}; try { Get-ChildItem 'HKLM:\SYSTEM\CurrentControlSet\Services' -ErrorAction SilentlyContinue | ForEach-Object { $paramsPath=$_.PSPath+'\Parameters'; if (Test-Path $paramsPath) { try { $val=(Get-ItemProperty -Path $paramsPath -Name 'DmaRemappingCompatible' -ErrorAction SilentlyContinue).DmaRemappingCompatible; if ($null -ne $val) { Set-ItemProperty -Path $paramsPath -Name 'DmaRemappingCompatible' -Value 0 -Type DWord -Force -ErrorAction SilentlyContinue } } catch {} } } } catch {}" >nul 2>&1

rem --- MSI mode enable ---
powershell -NoProfile -ExecutionPolicy Bypass -Command "function Set-MSIForClass { param([string]$WmiClass,[int]$MsiValue); try { Get-WmiObject -Class $WmiClass -ErrorAction SilentlyContinue | Where-Object { $_.PNPDeviceID -like 'PCI\VEN_*' } | ForEach-Object { try { $regPath='HKLM:\SYSTEM\CurrentControlSet\Enum\'+$_.PNPDeviceID+'\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties'; if (-not (Test-Path $regPath)) { New-Item -Path $regPath -Force | Out-Null }; Set-ItemProperty -Path $regPath -Name 'MSISupported' -Value $MsiValue -Type DWord -Force -ErrorAction SilentlyContinue } catch {} } } catch {} }; Set-MSIForClass 'Win32_IDEController' 1; Set-MSIForClass 'Win32_VideoController' 1; Set-MSIForClass 'Win32_NetworkAdapter' 1" >nul 2>&1

rem --- wevtutil sl for power-related diagnostic logs (logging only, not power settings) ---
wevtutil sl Microsoft-Windows-SleepStudy/Diagnostic /e:false >nul 2>&1
wevtutil sl Microsoft-Windows-Kernel-Processor-Power/Diagnostic /e:false >nul 2>&1
wevtutil sl Microsoft-Windows-UserModePowerService/Diagnostic /e:false >nul 2>&1

rem --- NoMobilityCenter ---
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\MobilityCenter" /v NoMobilityCenter /t REG_DWORD /d 1 /f >nul

rem --- Dnscache DisableCoalescing + TCPNoDelay on Ethernet (не Wi-Fi) ---
reg add "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v DisableCoalescing /t REG_DWORD /d 1 /f >nul
set "WIFI_GUIDS= "
for /f %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /v "*PhyType" /s 2^>nul ^| findstr "HKEY"') do (
    for /f "tokens=3" %%g in ('reg query "%%a" /v "NetCfgInstanceId" 2^>nul ^| findstr /i "NetCfgInstanceId"') do set "WIFI_GUIDS=!WIFI_GUIDS!%%g "
)
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" 2^>nul ^| findstr "HKEY"') do (
    set "IFGUID=%%~ni"
    echo !WIFI_GUIDS! | findstr /i /c:"!IFGUID!" >nul
    if errorlevel 1 (
        reg add "%%i" /v "TcpAckFrequency" /t REG_DWORD /d 1 /f >nul 2>&1
        reg add "%%i" /v "TCPNoDelay" /t REG_DWORD /d 1 /f >nul 2>&1
    )
)

rem --- Bloatware auto-install block ---
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Communications" /v ConfigureChatAutoInstall /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v OemPreInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEverEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v FeatureManagementEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RotatingLockScreenEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RotatingLockScreenOverlayEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SoftLandingEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-310093Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353698Enabled /t REG_DWORD /d 0 /f >nul

rem --- Block shell extensions (не темы, а именно шелл-расширения) ---
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{e2bf9676-5f8f-435c-97eb-11607a5bedf7}" /t REG_SZ /d "" /f >nul
reg add "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{e2bf9676-5f8f-435c-97eb-11607a5bedf7}" /t REG_SZ /d "" /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{596AB062-B4D2-4215-9F74-E9109B0A8153}" /t REG_SZ /d "" /f >nul
reg add "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{596AB062-B4D2-4215-9F74-E9109B0A8153}" /t REG_SZ /d "" /f >nul

rem --- Delivery Optimization (LocalService user) ---
reg add "HKU\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v DownloadMode /t REG_DWORD /d 0 /f >nul

rem --- SettingSync Groups (все группы) ---
for %%G in (Accessibility AppSync Browsersettings Credentials DesktopTheme Language PackageState Personalization StartLayout Windows) do (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\%%G" /v Enabled /t REG_DWORD /d 0 /f >nul
)

rem --- WU pause правильные даты ---
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v PauseFeatureUpdatesStartTime /t REG_SZ /d "2025-01-01T00:00:00Z" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v PauseFeatureUpdatesEndTime /t REG_SZ /d "2038-01-19T03:14:07Z" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v PauseQualityUpdatesStartTime /t REG_SZ /d "2025-01-01T00:00:00Z" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v PauseQualityUpdatesEndTime /t REG_SZ /d "2038-01-19T03:14:07Z" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v PauseUpdatesStartTime /t REG_SZ /d "2025-01-01T00:00:00Z" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v PauseUpdatesExpiryTime /t REG_SZ /d "2038-01-19T03:14:07Z" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v PausedQualityDate /t REG_SZ /d "2025-01-01T00:00:00Z" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v PausedFeatureDate /t REG_SZ /d "2025-01-01T00:00:00Z" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v FlightSettingsMaxPauseDays /t REG_DWORD /d 5269 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v PausedFeatureStatus /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v PausedQualityStatus /t REG_DWORD /d 1 /f >nul
powershell -NoProfile -ExecutionPolicy Bypass -Command "$cv=Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -ErrorAction SilentlyContinue; $ver=if ($cv.DisplayVersion) { $cv.DisplayVersion } elseif ($cv.ReleaseId) { $cv.ReleaseId } else { $null }; if ($ver) { $key='HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate'; if (-not (Test-Path $key)) { New-Item -Path $key -Force -ErrorAction SilentlyContinue | Out-Null }; New-ItemProperty -Path $key -Name 'TargetReleaseVersionInfo' -Value $ver -PropertyType String -Force -ErrorAction SilentlyContinue | Out-Null }" >nul 2>&1

rem --- label C: VampireOS ---
label C: VampireOS >nul 2>&1

rem --- Clear all event logs ---
wevtutil el | ForEach-Object { wevtutil cl $_ } 2>&1 | Out-Null

rem --- Office telemetry tasks (additional) ---
for %%T in (
  "\Microsoft\Windows\Application Experience\MareBackup"
  "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser Exp"
  "\Microsoft\Windows\AccountHealth\RecoverabilityToastTask"
  "\Microsoft\Windows\Hotpatch\Monitoring"
  "\Microsoft\Windows\MemoryDiagnostic\AutomaticOfflineMemoryDiagnostic"
  "\Microsoft\Windows\PerformanceTrace\RequestTrace"
  "\Microsoft\Windows\PerformanceTrace\WhesvcToast"
  "\Microsoft\Windows\Shell\FamilySafetyRefreshTask"
  "\Microsoft\Windows\UsageAndQualityInsights\UsageAndQualityInsights-MaintenanceTask"
  "\Microsoft\Windows\WindowsAI\ClickToDo\ModelCachingIdle"
  "\Microsoft\Windows\WindowsAI\ClickToDo\ModelCachingLimit"
  "\Microsoft\Windows\WindowsAI\ClickToDo\ModelCachingUpdate"
  "\Microsoft\Windows\Sustainability\PowerGridForecastTask"
  "\Microsoft\Windows\Sustainability\SustainabilityTelemetry"
  "\Microsoft\Windows\InstallService\RestoreDevice"
  "\Microsoft\Windows\InstallService\ScanForUpdates"
  "\Microsoft\Windows\InstallService\ScanForUpdatesAsUser"
  "\Microsoft\Windows\InstallService\SmartRetry"
  "\Microsoft\Windows\UpdateOrchestrator\Report policies"
  "\Microsoft\Windows\UpdateOrchestrator\Schedule Maintenance Work"
  "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task"
  "\Microsoft\Windows\UpdateOrchestrator\Schedule Wake To Work"
  "\Microsoft\Windows\UpdateOrchestrator\Schedule Work"
  "\Microsoft\Windows\UpdateOrchestrator\UIEOrchestrator"
  "\Microsoft\Windows\UpdateOrchestrator\UpdateModelTask"
  "\Microsoft\Windows\UpdateOrchestrator\UUS Failover Task"
  "\Microsoft\Windows\UpdateOrchestrator\AC Power Download"
  "\Microsoft\Windows\UpdateOrchestrator\AC Power Install"
  "\Microsoft\Windows\UpdateOrchestrator\Backup Scan"
  "\Microsoft\Windows\UpdateOrchestrator\Battery Saver Deferred Install"
  "\Microsoft\Windows\UpdateOrchestrator\Driver Install"
  "\Microsoft\Windows\UpdateOrchestrator\Maintenance Install"
  "\Microsoft\Windows\UpdateOrchestrator\MusUx_LogonUpdateResults"
  "\Microsoft\Windows\UpdateOrchestrator\MusUx_UpdateInterval"
  "\Microsoft\Windows\UpdateOrchestrator\Policy Install"
  "\Microsoft\Windows\UpdateOrchestrator\Reboot"
  "\Microsoft\Windows\UpdateOrchestrator\Reboot_AC"
  "\Microsoft\Windows\UpdateOrchestrator\Reboot_Battery"
  "\Microsoft\Windows\UpdateOrchestrator\Refresh Settings"
  "\Microsoft\Windows\UpdateOrchestrator\Resume On Boot"
  "\Microsoft\Windows\UpdateOrchestrator\Schedule Retry Scan"
  "\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScan"
  "\Microsoft\Windows\UpdateOrchestrator\USO_Broker_Display"
  "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker_Display"
  "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker_ReadyToReboot"
  "\Microsoft\Windows\UpdateOrchestrator\Universal Orchestrator Start"
  "\Microsoft\Windows\UpdateOrchestrator\Universal Orchestrator Idle Start"
  "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistant"
  "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistantAllUsersRun"
  "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistantCalendarRun"
  "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistantWakeupRun"
  "\Microsoft\Windows\WindowsUpdate\AUScheduledInstall"
  "\Microsoft\Windows\WindowsUpdate\AUSessionConnect"
  "\Microsoft\Windows\WindowsUpdate\Automatic App Update"
  "\Microsoft\Windows\WindowsUpdate\RUXIM\PLUGScheduler"
  "\Microsoft\Windows\WindowsUpdate\Scheduled Start With Network"
  "\Microsoft\Windows\WindowsUpdate\sih"
  "\Microsoft\Windows\WindowsUpdate\sihboot"
  "\Microsoft\Windows\WindowsUpdate\sihpostreboot"
  "\Microsoft\Windows\Printing\PrinterCleanupTask"
) do schtasks /Change /TN "%%~T" /Disable < nul > nul 2>&1

rem --- Additional services Start=4 (без Themes/UxSms/SessionEnv — SessionEnv оставляем как RDP) ---
for %%S in (
    RetailDemo MapsBroker CSC CSCSERVICE Telemetry WdiSystemHost WdiServiceHost
    troubleshootingsvc diagsvc svsvc diagtrack wercplsupport dps GraphicsPerfSvc
    Ndu pcasvc dusmsvc DSSvc wisvc InventorySvc WSAIFabricSvc amdfendr amdfendrmgr
    McpManagementService Spooler printworkflowusersvc stisvc PrintNotify usbprint
    PrintScanBrokerService PrintDeviceConfigurationService TermService UmRdpService
    SessionEnv hyperkbd hypervideo vmgid vpci vid dam NetBT tcpipreg UCPD MSDTC midisrv
    MicrosoftCopilotElevationService
) do (
    sc config "%%S" start= disabled >nul 2>&1
    sc stop   "%%S" >nul 2>&1
)

rem --- OptionalFeatures (без Edge, Notepad, Paint, Photos, Snipping Tool) ---
dism /online /disable-feature /featurename:SMBDirect /norestart >nul 2>&1
dism /online /disable-feature /featurename:MSRDC-Infrastructure /norestart >nul 2>&1
dism /online /disable-feature /featurename:Workfolders-Client /norestart >nul 2>&1
dism /online /disable-feature /featurename:WCF-Services45 /norestart >nul 2>&1
dism /online /disable-feature /featurename:WCF-TCP-PortSharing45 /norestart >nul 2>&1
dism /online /disable-feature /featurename:Microsoft-Hyper-V-All /norestart >nul 2>&1
dism /online /disable-feature /featurename:Microsoft-Hyper-V /norestart >nul 2>&1
dism /online /disable-feature /featurename:Microsoft-Hyper-V-Tools-All /norestart >nul 2>&1
dism /online /disable-feature /featurename:Microsoft-Hyper-V-Management-PowerShell /norestart >nul 2>&1
dism /online /disable-feature /featurename:Microsoft-Hyper-V-Hypervisor /norestart >nul 2>&1
dism /online /disable-feature /featurename:Microsoft-Hyper-V-Services /norestart >nul 2>&1
dism /online /disable-feature /featurename:Microsoft-Hyper-V-Management-Clients /norestart >nul 2>&1
dism /online /enable-feature  /featurename:DirectPlay /all /norestart >nul 2>&1
dism /online /remove-capability /capabilityname:App.StepsRecorder~~~~0.0.1.0 /norestart >nul 2>&1

rem --- UPDHEALTH MSI uninstall (Update Health Tools) ---
set "code="
for /f "delims=" %%k in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s /f "Update Health Tools" /d 2^>nul ^| findstr /i /c:"\Uninstall\{"') do (
    for %%g in (%%~nxk) do set "code=%%g"
)
if defined code msiexec /x !code! /qn /norestart >nul 2>&1

echo [OK] Additional tweaks applied.

rem ============================================================
rem 18. ФИНАЛЬНЫЕ ДОПОЛНЕНИЯ
rem ============================================================
echo [*] Final additions...

rem --- Take Ownership для dllfile и exefile ---
for %%K in ("HKCR\dllfile\shell\runas" "HKCR\exefile\shell\runas") do (
    reg add %%K /f >nul
    reg add %%K /ve /t REG_SZ /d "Take Ownership" /f >nul
    reg add %%K /v HasLUAShield /t REG_SZ /d "" /f >nul
    reg add %%K /v NoWorkingDirectory /t REG_SZ /d "" /f >nul
    reg add %%K /v Position /t REG_SZ /d "middle" /f >nul
)
reg add "HKCR\dllfile\shell\runas\command" /ve /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant *S-1-3-4:F /c /l" /f >nul
reg add "HKCR\dllfile\shell\runas\command" /v IsolatedCommand /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant *S-1-3-4:F /c /l" /f >nul
reg add "HKCR\exefile\shell\runas\command" /ve /t REG_SZ /d "\"%%1\" %%*" /f >nul
reg add "HKCR\exefile\shell\runas\command" /v IsolatedCommand /t REG_SZ /d "\"%%1\" %%*" /f >nul

rem --- Search ---
reg add "HKLM\Software\Microsoft\Windows Search\Gather\Windows\SystemIndex" /v RespectPowerModes /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCloudSearch /t REG_DWORD /d 2 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\WinStore.Tasks.WindowsSearchTask" /v ActivationType /t REG_DWORD /d 4294967295 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\WinStore.Tasks.WindowsSearchTask" /v Server /t REG_SZ /d "" /f >nul
reg add "HKLM\SYSTEM\ControlSet001\Policies\Microsoft\FeatureManagement\Overrides" /v 1694661260 /t REG_DWORD /d 0 /f >nul

rem --- AppCompat SbEnable ---
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v SbEnable /t REG_DWORD /d 1 /f >nul

rem --- CloudContent Spotlight ---
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v ConfigureWindowsSpotlight /t REG_DWORD /d 2 /f >nul
reg add "HKU\.DEFAULT\Software\Policies\Microsoft\Windows\CloudContent" /v ConfigureWindowsSpotlight /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v IncludeEnterpriseSpotlight /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Software\Policies\Microsoft\Windows\CloudContent" /v IncludeEnterpriseSpotlight /t REG_DWORD /d 0 /f >nul

rem --- Privacy general ---
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v MSAOptional /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\Messaging" /v AllowMessageSync /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\EdgeUI" /v DisableHelpSticker /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\EdgeUI" /v DisableMFUTracking /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Policies\Microsoft\Windows\EdgeUI" /v DisableMFUTracking /t REG_DWORD /d 1 /f >nul

rem --- Restrict Internet Communication ---
for %%R in (HKCU HKLM) do (
    reg add "%%R\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoPublishingWizard /t REG_DWORD /d 1 /f >nul
    reg add "%%R\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoWebServices /t REG_DWORD /d 1 /f >nul
    reg add "%%R\Software\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" /v NoGenTicket /t REG_DWORD /d 1 /f >nul
    reg add "%%R\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoOnlinePrintsWizard /t REG_DWORD /d 1 /f >nul
    reg add "%%R\Software\Policies\Microsoft\Windows NT\Printers" /v DisableHTTPPrinting /t REG_DWORD /d 1 /f >nul
    reg add "%%R\Software\Policies\Microsoft\Windows NT\Printers" /v DisableWebPnPDownload /t REG_DWORD /d 1 /f >nul
    reg add "%%R\Software\Policies\Microsoft\WindowsMovieMaker" /v WebHelp /t REG_DWORD /d 1 /f >nul
    reg add "%%R\Software\Policies\Microsoft\WindowsMovieMaker" /v CodecDownload /t REG_DWORD /d 1 /f >nul
    reg add "%%R\Software\Policies\Microsoft\WindowsMovieMaker" /v WebPublish /t REG_DWORD /d 1 /f >nul
)
reg add "HKLM\Software\Policies\Microsoft\PCHealth\HelpSvc" /v Headlines /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\PCHealth\HelpSvc" /v MicrosoftKBSearch /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\PCHealth\ErrorReporting" /v DoReport /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\Internet Connection Wizard" /v ExitOnMSICW /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\EventViewer" /v MicrosoftEventVwrDisableLinks /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\Registration Wizard Control" /v NoRegistration /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\SearchCompanion" /v DisableContentFileUpdates /t REG_DWORD /d 1 /f >nul

rem --- NVIDIA telemetry ---
reg add "HKCU\Software\NVIDIA Corporation\NVControlPanel2\Client" /v OptInOrOutPreference /t REG_DWORD /d 0 /f >nul

rem --- Firewall blocks ---
reg add "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Defaults\FirewallPolicy\FirewallRules" /v Block-Unified-Telemetry-Client /t REG_SZ /d "v2.31|Action=Block|Active=TRUE|Dir=Out|RA42=IntErnet|RA62=IntErnet|App=%%SystemRoot%%\system32\svchost.exe|Svc=DiagTrack|Name=Block-Unified-Telemetry-Client|Desc=Block-Unified-Telemetry-Client|EmbedCtxt=DiagTrack|" /f >nul
reg add "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Defaults\FirewallPolicy\FirewallRules" /v Block-Windows-Error-Reporting /t REG_SZ /d "v2.31|Action=Block|Active=TRUE|Dir=Out|RA42=IntErnet|RA62=IntErnet|App=%%SystemRoot%%\system32\svchost.exe|Svc=WerSvc|Name=Block-Unified-Error-Reporting|Desc=Block-Windows-Error-Reporting|EmbedCtxt=WerSvc|" /f >nul
reg add "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /v Block-Unified-Telemetry-Client /t REG_SZ /d "v2.31|Action=Block|Active=TRUE|Dir=Out|RA42=IntErnet|RA62=IntErnet|App=%%SystemRoot%%\system32\svchost.exe|Svc=DiagTrack|Name=Block-Unified-Telemetry-Client|Desc=Block-Unified-Telemetry-Client|EmbedCtxt=DiagTrack|" /f >nul
reg add "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /v Block-Windows-Error-Reporting /t REG_SZ /d "v2.31|Action=Block|Active=TRUE|Dir=Out|RA42=IntErnet|RA62=IntErnet|App=%%SystemRoot%%\system32\svchost.exe|Svc=WerSvc|Name=Block-Unified-Telemetry-Client|Desc=Block-Windows-Error-Reporting|EmbedCtxt=WerSvc|" /f >nul

rem --- Xbox Gaming Copilot block ---
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Microsoft.Xbox.GamingAI.Companion.Host.GamingCompanionHostOptions" /v ActivationType /t REG_DWORD /d 4294967295 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Microsoft.Xbox.GamingAI.Companion.Host.GamingCompanionHostOptions" /v Server /t REG_SZ /d "" /f >nul

rem --- Telemetry additional ---
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v DisableEnterpriseAuthProxy /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v DisableTelemetryOptInChangeNotification /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v DisableTelemetryOptInSettingsUx /t REG_DWORD /d 1 /f >nul

rem --- Security additional ---
reg add "HKCU\Software\Microsoft\Windows Security Health\State" /v AccountProtection_MicrosoftAccount_Disconnected /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows Security Health\State" /v AccountProtection_MicrosoftAccount_Disconnected /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Reporting" /v DisableGenericRePorts /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v DisableScheduledSignatureUpdateOnBattery /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\SmartScreen" /v ConfigureAppInstallControlEnabled /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\SmartScreen" /v ConfigureAppInstallControl /t REG_SZ /d "Anywhere" /f >nul
reg add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v EnabledV9 /t REG_DWORD /d 0 /f >nul

rem --- System additional ---
reg add "HKLM\SYSTEM\ControlSet001\Control\Session Manager" /v BootExecute /t REG_MULTI_SZ /d "autocheck autochk /k:C*" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vgc.exe" /v MitigationOptions /t REG_BINARY /d 000000000001000000000000000000000000000000000000 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vgc.exe" /v MitigationAuditOptions /t REG_BINARY /d 000000000000000000000000000000000000000000000000 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vgc.exe" /v EAFModules /t REG_SZ /d "" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\osu!.exe" /v MitigationOptions /t REG_BINARY /d 000021000000000000000000000000000000000000000000 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\osu!.exe" /v MitigationAuditOptions /t REG_BINARY /d 000000000000000000000000000000000000000000000000 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\osu!.exe" /v EAFModules /t REG_SZ /d "" /f >nul
reg add "HKLM\SYSTEM\ControlSet001\Control\Session Manager" /v DisableWpbtExecution /t REG_DWORD /d 1 /f >nul

rem --- OOBE package ---
for %%R in ("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE") do (
    reg add %%R /v HideOnlineAccountScreens /t REG_DWORD /d 1 /f >nul
    reg add %%R /v HideEULAPage /t REG_DWORD /d 1 /f >nul
    reg add %%R /v SkipMachineOOBE /t REG_DWORD /d 0 /f >nul
    reg add %%R /v SkipUserOOBE /t REG_DWORD /d 0 /f >nul
    reg add %%R /v HideWirelessSetupInOOBE /t REG_DWORD /d 1 /f >nul
    reg add %%R /v NetworkLocation /t REG_SZ /d "Home" /f >nul
    reg add %%R /v ProtectYourPC /t REG_DWORD /d 3 /f >nul
    reg add %%R /v HideLocalAccountScreen /t REG_DWORD /d 0 /f >nul
    reg add %%R /v DisablePrivacyExperience /t REG_DWORD /d 1 /f >nul
    reg add %%R /v HideOEMRegistrationScreen /t REG_DWORD /d 1 /f >nul
    reg add %%R /v EnableCortanaVoice /t REG_DWORD /d 0 /f >nul
    reg add %%R /v DisableVoice /t REG_DWORD /d 1 /f >nul
)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE\AppSettings" /v Skype-UserConsentAccepted /t REG_DWORD /d 0 /f >nul

rem --- Updates additional ---
reg add "HKLM\SYSTEM\Setup\UpgradeNotification" /v UpgradeAvailable /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\MRT" /v DontReportInfectionInformation /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\WindowsMediaPlayer" /v DisableAutoUpdate /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe" /v BlockedOobeUpdaters /t REG_SZ /d "[\"MS_Outlook\"]" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v HideMCTLink /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v RestartNotificationsAllowed2 /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\WindowsStore" /v AutoDownload /t REG_DWORD /d 4 /f >nul
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\DevHomeUpdate" /f >nul 2>&1
reg add    "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\UScheduler\DevHomeUpdate" /v workCompleted /t REG_DWORD /d 1 /f >nul
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\OutlookUpdate" /f >nul 2>&1
reg add    "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\UScheduler\OutlookUpdate" /v workCompleted /t REG_DWORD /d 1 /f >nul

rem --- EdgeUpdate policies (блокирует установку/обновление Edge, НЕ удаляет Edge) ---
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v InstallDefault /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "Install{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "Install{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v DoNotUpdateToEdgeWithChromium /t REG_DWORD /d 1 /f >nul

rem --- System Restore ---
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SPP\Clients" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v RPSessionInterval /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore\cfg" /v DiskPercent /t REG_DWORD /d 0 /f >nul

rem --- fsutil ---
fsutil behavior set disable8dot3 1 >nul 2>&1
fsutil behavior set disabledeletenotify 0 >nul 2>&1
fsutil behavior set disablelastaccess 1 >nul 2>&1
fsutil behavior set encryptpagingfile 0 >nul 2>&1

rem --- Reserved Storage ---
powershell -NoProfile -Command "Set-WindowsReservedStorageState -State Disabled -ErrorAction SilentlyContinue" >nul 2>&1

echo [OK] Final additions applied.

rem ============================================================
rem 13. BOOT / FINALIZE
rem ============================================================
echo [*] Boot / finalize...
bcdedit /deletevalue useplatformclock >nul 2>&1
bcdedit /deletevalue disabledynamictick >nul 2>&1
bcdedit /set bootmenupolicy Legacy >nul 2>&1
bcdedit /set lastknowngood yes >nul 2>&1

setx DOTNET_CLI_TELEMETRY_OPTOUT 1 >nul
setx POWERSHELL_TELEMETRY_OPTOUT 1 >nul
net accounts /maxpwage:unlimited >nul 2>&1
netsh interface Teredo set state type=default >nul 2>&1
netsh interface Teredo set state servername=default >nul 2>&1
ipconfig /flushdns >nul

sc config w32time start= demand >nul 2>&1
net stop w32time >nul 2>&1
w32tm /unregister >nul 2>&1
w32tm /register >nul 2>&1
net start w32time >nul 2>&1
w32tm /config /manualpeerlist:"time.windows.com,0x9 pool.ntp.org,0x9 time.nist.gov,0x9" /syncfromflags:manual /reliable:yes /update >nul 2>&1
net stop w32time >nul 2>&1
net start w32time >nul 2>&1
w32tm /resync /rediscover >nul 2>&1

Stop-Service bits -Force >nul 2>&1
Stop-Service appidsvc -Force >nul 2>&1
Stop-Service dps -Force >nul 2>&1
Stop-Service wuauserv -Force >nul 2>&1
for %%F in (CbsTemp Logs SoftwareDistribution System32\LogFiles System32\SleepStudy System32\sru System32\WDI\LogFiles System32\winevt\Logs SystemTemp Temp) do (
    if exist "%SystemRoot%\%%F" del /f /q /s "%SystemRoot%\%%F\*" >nul 2>&1
)
if exist "%LOCALAPPDATA%\CrashDumps" del /f /q /s "%LOCALAPPDATA%\CrashDumps\*" >nul 2>&1
if exist "%ProgramData%\Microsoft\Windows\WER" del /f /q /s "%ProgramData%\Microsoft\Windows\WER\*" >nul 2>&1
if exist "%LOCALAPPDATA%\Microsoft\Windows\WER" del /f /q /s "%LOCALAPPDATA%\Microsoft\Windows\WER\*" >nul 2>&1

:: =====================================================================
::  VAMPIREOS — КОМПЛЕКСНЫЙ СКРИПТ НАСТРОЙКИ WINDOWS
:: =====================================================================
::
::  ОПИСАНИЕ:
::  Скрипт выполняет три независимые задачи одним запуском.
::  Все изменения вносятся в реестр и в схемы электропитания.
::  Требуются права администратора (запрашиваются автоматически).
::
::  ЧТО ДЕЛАЕТ:
::
::  1) КОНТЕКСТНОЕ МЕНЮ «СОЗДАТЬ»
::     Добавляет в правый клик -> Создать пункты для файлов:
::     .bat, .reg, .ps1, .vbs
::     Используется параметр NullFile в ветке ShellNew —
::     Windows создаёт пустой файл с нужным расширением.
::
::  2) ТРИ СХЕМЫ ЭЛЕКТРОПИТАНИЯ
::     Создаёт пользовательские схемы на основе стандартных:
::       • "Balanced Performance VampireOS"  (база: Сбалансированная)
::       • "Maximum Performance VampireOS"   (база: Высокая производительность)
::       • "Power Saving VampireOS"          (база: Экономия энергии)
::
::     Безопасные оптимизации (применяются ко всем трём схемам):
::       • HDD: никогда не отключать диск (0 = never)
::         Предотвращает частые остановки/раскрутки механического HDD.
::         На SSD эта настройка не влияет.
::       • USB: отключить selective suspend (0 = disabled)
::         Внешние диски, мыши и хабы не «засыпают» и не дают задержек.
::       • Экран: разумные тайм-ауты отключения (разные для каждой схемы):
::           Balanced   — 15 мин (сеть) / 5 мин (батарея)
::           Maximum    — 15 мин (сеть) / 10 мин (батарея)
::           PowerSaving— 5 мин (сеть) / 2 мин (батарея)
::
::     По умолчанию активируется "Balanced Performance VampireOS".
::
::  3) КОНТЕКСТНОЕ МЕНЮ РАБОЧЕГО СТОЛА
::     Добавляет подменю «Выбор плана электропитания» с пунктами:
::       • Balanced Performance VampireOS
::       • Maximum Performance VampireOS
::       • Power Saving VampireOS
::       • Стандартная «Сбалансированная» (резерв на случай удаления кастомных)
::       • Электропитание... (открывает классическую панель powercfg.cpl)
::
::  ОТМЕНА ИЗМЕНЕНИЙ (выполнять в cmd от администратора):
::
::     :: Удалить пункты «Создать»
::     reg delete "HKCR\.bat\ShellNew" /f
::     reg delete "HKCR\.reg\ShellNew" /f
::     reg delete "HKCR\.ps1\ShellNew" /f
::     reg delete "HKCR\.vbs\ShellNew" /f
::
::     :: Удалить подменю планов
::     reg delete "HKCR\DesktopBackground\Shell\PowerPlan" /f
::
::     :: Удалить пользовательские схемы
::     powercfg /delete 90a358c8-3bbc-4fb3-8b4e-d7ab065d2614
::     powercfg /delete a1b2c3d4-e5f6-4789-a0ab-cdef12345678
::     powercfg /delete d8e76bb7-6943-4b7c-ab30-441296b72264
::
::  ТРЕБОВАНИЯ: Windows 10 / 11, права администратора.
:: =====================================================================

:: =====================================================================
::  ЧАСТЬ 1. КОНТЕКСТНОЕ МЕНЮ «СОЗДАТЬ»
:: =====================================================================
echo.
echo ============================================================
echo  ЧАСТЬ 1: Добавление пунктов в меню «Создать»
echo ============================================================

:: NullFile = пустой строковый параметр. Windows видит его в ShellNew
:: и добавляет соответствующий пункт в подменю «Создать».
reg add "HKCR\.bat\ShellNew" /v "NullFile" /t REG_SZ /d "" /f >nul
reg add "HKCR\.reg\ShellNew" /v "NullFile" /t REG_SZ /d "" /f >nul
reg add "HKCR\.ps1\ShellNew" /v "NullFile" /t REG_SZ /d "" /f >nul
reg add "HKCR\.vbs\ShellNew" /v "NullFile" /t REG_SZ /d "" /f >nul

echo [OK] .bat .reg .ps1 .vbs добавлены в «Создать»

:: =====================================================================
::  ЧАСТЬ 2. СОЗДАНИЕ СХЕМ ЭЛЕКТРОПИТАНИЯ
:: =====================================================================
echo.
echo ============================================================
echo  ЧАСТЬ 2: Создание схем электропитания VampireOS
echo ============================================================

:: --- GUID пользовательских схем (генерируются один раз, далее константы) ---
set "GUID_BAL=90a358c8-3bbc-4fb3-8b4e-d7ab065d2614"
set "GUID_MAX=a1b2c3d4-e5f6-4789-a0ab-cdef12345678"
set "GUID_SAV=d8e76bb7-6943-4b7c-ab30-441296b72264"

:: --- GUID стандартных схем Windows (базы для клонирования) ---
set "BASE_BAL=381b4222-f694-41f0-9685-ff5bb260df2e"
set "BASE_MAX=8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"
set "BASE_SAV=a1841308-3541-4fab-bc81-f71556f20b4a"

:: --- GUID подсистем и конкретных параметров ---
set "SUB_DISK=0012ee47-9041-4b5d-9b77-535fba8b1442"
set "DISKIDLE=6738e2c4-e8a5-4a42-b16a-e040e769756e"
set "SUB_USB=2a737441-1930-4402-8d77-b2bebba308a3"
set "USBSUSPEND=48e6b7a6-50f5-4782-a5d4-53bb8f07e226"
set "SUB_VIDEO=7516b95f-f776-4464-8c53-06167f40cc99"
set "VIDEOIDLE=3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e"

:: --- Переключаемся на стандартную схему перед удалением старых кастомных ---
:: (нельзя удалить активную схему — Windows выдаст ошибку)
echo Switching to standard Balanced scheme before cleanup...
powercfg /setactive %BASE_BAL% >nul 2>&1

echo Removing old custom schemes...
powercfg /delete %GUID_BAL% >nul 2>&1
powercfg /delete %GUID_MAX% >nul 2>&1
powercfg /delete %GUID_SAV% >nul 2>&1

:: --- Клонируем базовые схемы и задаём им наши GUID ---
echo Creating schemes...
powercfg /duplicatescheme %BASE_BAL% %GUID_BAL% >nul || goto :fail
powercfg /duplicatescheme %BASE_MAX% %GUID_MAX% >nul || goto :fail
powercfg /duplicatescheme %BASE_SAV% %GUID_SAV% >nul || goto :fail

:: --- Переименовываем и задаём описания ---
powercfg /changename %GUID_BAL% "Balanced Performance VampireOS" "Balanced performance for everyday tasks and gaming." >nul
powercfg /changename %GUID_MAX% "Maximum Performance VampireOS" "Maximum performance in games and work applications." >nul
powercfg /changename %GUID_SAV% "Power Saving VampireOS" "Reduced power consumption and maximum battery life." >nul

echo Applying safe tweaks...

:: --- HDD: никогда не отключать диск (0 = never) ---
:: setacvalueindex — от сети, setdcvalueindex — от батареи.
powercfg /setacvalueindex %GUID_BAL% %SUB_DISK% %DISKIDLE% 0
powercfg /setdcvalueindex %GUID_BAL% %SUB_DISK% %DISKIDLE% 0
powercfg /setacvalueindex %GUID_MAX% %SUB_DISK% %DISKIDLE% 0
powercfg /setdcvalueindex %GUID_MAX% %SUB_DISK% %DISKIDLE% 0
powercfg /setacvalueindex %GUID_SAV% %SUB_DISK% %DISKIDLE% 0
powercfg /setdcvalueindex %GUID_SAV% %SUB_DISK% %DISKIDLE% 0

:: --- USB: отключить selective suspend (0 = disabled) ---
powercfg /setacvalueindex %GUID_BAL% %SUB_USB% %USBSUSPEND% 0
powercfg /setdcvalueindex %GUID_BAL% %SUB_USB% %USBSUSPEND% 0
powercfg /setacvalueindex %GUID_MAX% %SUB_USB% %USBSUSPEND% 0
powercfg /setdcvalueindex %GUID_MAX% %SUB_USB% %USBSUSPEND% 0
powercfg /setacvalueindex %GUID_SAV% %SUB_USB% %USBSUSPEND% 0
powercfg /setdcvalueindex %GUID_SAV% %SUB_USB% %USBSUSPEND% 0

:: --- Экран: безопасные тайм-ауты (в секундах) ---
:: Balanced: 15 мин от сети / 5 мин от батареи
powercfg /setacvalueindex %GUID_BAL% %SUB_VIDEO% %VIDEOIDLE% 900
powercfg /setdcvalueindex %GUID_BAL% %SUB_VIDEO% %VIDEOIDLE% 300

:: Maximum: 15 мин от сети / 10 мин от батареи
powercfg /setacvalueindex %GUID_MAX% %SUB_VIDEO% %VIDEOIDLE% 900
powercfg /setdcvalueindex %GUID_MAX% %SUB_VIDEO% %VIDEOIDLE% 600

:: Power Saving: 5 мин от сети / 2 мин от батареи
powercfg /setacvalueindex %GUID_SAV% %SUB_VIDEO% %VIDEOIDLE% 300
powercfg /setdcvalueindex %GUID_SAV% %SUB_VIDEO% %VIDEOIDLE% 120

:: --- Активируем Balanced как схему по умолчанию ---
powercfg /setactive %GUID_BAL%
echo [OK] Схемы созданы, активна: Balanced Performance VampireOS

:: =====================================================================
::  ЧАСТЬ 3. ПОДМЕНЮ «ВЫБОР ПЛАНА ЭЛЕКТРОПИТАНИЯ» НА РАБОЧЕМ СТОЛЕ
:: =====================================================================
echo.
echo ============================================================
echo  ЧАСТЬ 3: Подменю планов электропитания на рабочем столе
echo ============================================================

:: --- Корневой пункт подменю ---
:: MUIVerb      — отображаемое имя
:: Icon         — иконка из powercpl.dll (стандартная иконка электропитания)
:: Position     — положение в меню (Middle = между группировками)
:: SubCommands  — пустая строка означает «использовать дочерние ключи Shell\»
reg add "HKCR\DesktopBackground\Shell\PowerPlan" /v "MUIVerb"     /t REG_SZ /d "Выбор плана электропитания" /f >nul
reg add "HKCR\DesktopBackground\Shell\PowerPlan" /v "Icon"        /t REG_SZ /d "powercpl.dll"                /f >nul
reg add "HKCR\DesktopBackground\Shell\PowerPlan" /v "Position"    /t REG_SZ /d "Middle"                       /f >nul
reg add "HKCR\DesktopBackground\Shell\PowerPlan" /v "SubCommands" /t REG_SZ /d ""                             /f >nul

:: --- Пункт 1: Balanced Performance VampireOS ---
:: В команде %GUID_BAL% разворачивается в GUID на этапе выполнения скрипта.
reg add "HKCR\DesktopBackground\Shell\PowerPlan\Shell\01bal" /v "MUIVerb" /t REG_SZ /d "Balanced Performance VampireOS" /f >nul
reg add "HKCR\DesktopBackground\Shell\PowerPlan\Shell\01bal" /v "Icon"    /t REG_SZ /d "powercpl.dll"                     /f >nul
reg add "HKCR\DesktopBackground\Shell\PowerPlan\Shell\01bal\command" /ve /t REG_SZ /d "powercfg.exe /setactive %GUID_BAL%" /f >nul

:: --- Пункт 2: Maximum Performance VampireOS ---
reg add "HKCR\DesktopBackground\Shell\PowerPlan\Shell\02max" /v "MUIVerb" /t REG_SZ /d "Maximum Performance VampireOS" /f >nul
reg add "HKCR\DesktopBackground\Shell\PowerPlan\Shell\02max" /v "Icon"    /t REG_SZ /d "powercpl.dll"                    /f >nul
reg add "HKCR\DesktopBackground\Shell\PowerPlan\Shell\02max\command" /ve /t REG_SZ /d "powercfg.exe /setactive %GUID_MAX%" /f >nul

:: --- Пункт 3: Power Saving VampireOS ---
reg add "HKCR\DesktopBackground\Shell\PowerPlan\Shell\03sav" /v "MUIVerb" /t REG_SZ /d "Power Saving VampireOS" /f >nul
reg add "HKCR\DesktopBackground\Shell\PowerPlan\Shell\03sav" /v "Icon"    /t REG_SZ /d "powercpl.dll"             /f >nul
reg add "HKCR\DesktopBackground\Shell\PowerPlan\Shell\03sav\command" /ve /t REG_SZ /d "powercfg.exe /setactive %GUID_SAV%" /f >nul

:: --- Пункт 4: Стандартная «Сбалансированная» (резерв) ---
:: На случай, если пользовательские схемы будут удалены обновлением Windows.
reg add "HKCR\DesktopBackground\Shell\PowerPlan\Shell\04std" /v "MUIVerb" /t REG_SZ /d "Сбалансированная (стандартная)" /f >nul
reg add "HKCR\DesktopBackground\Shell\PowerPlan\Shell\04std" /v "Icon"    /t REG_SZ /d "powercpl.dll"                    /f >nul
reg add "HKCR\DesktopBackground\Shell\PowerPlan\Shell\04std\command" /ve /t REG_SZ /d "powercfg.exe /setactive %BASE_BAL%" /f >nul

:: --- Пункт 5: Открыть классическую панель «Электропитание» ---
reg add "HKCR\DesktopBackground\Shell\PowerPlan\Shell\05cpl" /v "MUIVerb" /t REG_SZ /d "Электропитание..." /f >nul
reg add "HKCR\DesktopBackground\Shell\PowerPlan\Shell\05cpl" /v "Icon"    /t REG_SZ /d "powercpl.dll"       /f >nul
reg add "HKCR\DesktopBackground\Shell\PowerPlan\Shell\05cpl\command" /ve /t REG_SZ /d "control.exe powercfg.cpl" /f >nul

echo [OK] Подменю «Выбор плана электропитания» добавлено на рабочий стол

gpupdate /force >nul 2>&1

echo.
echo ============================================================
echo  DONE. VampireOS configuration applied.
echo  A reboot is recommended.
echo ============================================================
echo.