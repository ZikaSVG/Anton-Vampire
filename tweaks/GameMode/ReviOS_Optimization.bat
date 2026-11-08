@echo off
setlocal EnableExtensions EnableDelayedExpansion
title ReviOS-like configuration
:: ============================================================================
::  ReviOS-lite.bat
::  Воспроизводит основную конфигурацию ReviOS (реестр / службы / компоненты /
::  удаление приложений / задачи / загрузка) БЕЗ тем, обоев и helper-скриптов.
::  Запуск: от имени администратора (скрипт сам запросит UAC).
:: ============================================================================
::
::  ЧТО ДЕЛАЕТ СКРИПТ (по разделам):
::
::
::  ── 1. EXPLORER ─────────────────────────────────────────────────────────────
::    Контекстное меню:
::      • Классическое меню ПКМ (Win11) через пустой InprocServer32 CLSID
::      • Пункт "Take Ownership" для * / Directory / dllfile / exefile
::        (takeown + icacls grant S-1-3-4:F, без подтверждения UAC-шилда)
::    Control Panel:
::      • JPEGImportQuality=100, Beep=no, MenuShowDelay=0
::      • ActiveWndTrkTimeout=10, AutoEndTasks=1
::      • HungAppTimeout=2000, WaitToKillAppTimeout=2000, LowLevelHooksTimeout=1000
::      • Отключение ускорения указателя (MouseSpeed/Threshold1/2=0)
::      • AllowOnlineTips=0
::      • Удаление наследия Ease of Access (AudioDescription/StickyKeys/...)
::    Explorer (общее):
::      • Отключение авто-определения типа папки (FolderType=NotSpecified)
::      • explorer.exe → GpuPreference=2 (high-perf GPU)
::      • DisableGraphRecentItems=1 (OneDrive-инсайты в проводнике)
::      • Скрытие Spotlight-иконки на рабочем столе (24H2)
::      • MultipleInvokePromptMinimum=100 (больше пунктов в ПКМ)
::      • Убрать " - Shortcut" у ярлыков (link=0)
::      • EnthusiastMode=1 (детали копирования)
::      • Отключение AutoPlay/AutoRun (DisableAutoplay=1, NoDriveTypeAutoRun=255)
::      • NoLowDiskSpaceChecks=1, WaitToKillServiceTimeout=1500
::      • LinkResolveIgnoreLinkInfo=1, InkWorkspace политики
::      • Отключение Start_IrisRecommendations / Start_AccountNotifications
::      • TaskbarEndTask=1, LaunchTo=1 (открывать "Этот компьютер")
::      • ShowInfoTip=0
::    Notifications:
::      • NoBalloonFeatureAdvertisements=1, NoAutoTrayNotify=1
::      • NoCloudApplicationNotification=1
::      • UpdateNotificationLevel=2 (без рестарт-варнингов)
::      • Отключение SCOOBE ("Давайте завершим настройку")
::    Search:
::      • RespectPowerModes=1, PreventIndexOnBattery=1
::      • DisableSearchBoxSuggestions=1 (без истории поиска + без Bing в Start)
::      • AllowCloudSearch=2, Cortana полностью выключена
::        (AllowCortana/AboveLock/InAAD=0)
::      • AllowSearchToUseLocation=0, ConnectedSearchUseWeb=0
::      • ConnectedSearchPrivacy=3, BingSearchEnabled=0, CortanaConsent=0
::      • Отключение Store-результатов и WebView2 в SearchHost
::    Start Menu:
::      • ConfigureStartPins (Store/Settings/Notepad/Paint/Explorer/Calc)
::      • Скрытие папок Start: Documents, Downloads, FileExplorer, Music,
::        Network, PersonalFolder, Pictures, Videos, HomeGroup
::      • Settings остаётся видимой
::      • NoResolveSearch=1
::    Taskbar:
::      • SearchboxTaskbarMode=1, ShowTaskViewButton=0
::      • Отключение Widgets/News/Feeds (EnableFeeds=0, AllowNewsAndInterests=0,
::        ShellFeedsTaskbarViewMode=2, TaskbarDa=0)
::      • HidePeopleBar=1, HideSCAMeetNow=1, ChatIcon=3, TaskbarMn=0
::    View:
::      • FullPath=1, HideFileExt=0 (показывать расширения)
::      • ShowSyncProviderNotifications=0
::    Windows Settings:
::      • Скрытие Insider-страницы, TrayIconVisibility=0
::      • Tablet mode → всегда desktop, отключение tablet-taskbar-опций
::      • Отключение timeline-подсказок и clipboard-history
::      • Typing: autocorrect/spellcheck/prediction/insights = off
::      • Color accents (Custom), отключение value-banners
::      • Resume/CrossDevice — отключение
::      • Sync settings — все под-политики SettingSync отключены
::      • GameDVR_Enabled=0, AppCaptureEnabled=0
::
::  ── 1. PRIVACY ──────────────────────────────────────────────────────────────
::    • AppCompat: DisableEngine/AIT/Problem Steps/PCA/Inventory/SbEnable
::    • Content Delivery Manager: ContentDeliveryAllowed=0, SubscribedContentEnabled=0,
::      отключение welcome-SCOOBE, tips, silent-install, pre-installed,
::      OemPreInstalled, FeatureManagement, всех SubscribedContent-*,
::      RotatingLockScreen + Overlay, удаление Subscriptions/SuggestedApps
::    • CEIP: SQMClient, AppV, IE, Messenger, UnattendSettings — везде off
::    • Cloud Content: DisableSoftLanding, ConfigureWindowsSpotlight=2,
::      DisableThirdPartySuggestions, DisableTailoredExperiencesWithDiagnosticData,
::      DisableWindowsSpotlightFeatures / OnActionCenter / OnSettings,
::      DisableCloudOptimizedContent
::    • Privacy general: MSAOptional=1, AllowMessageSync=0, DisableHelpSticker=1,
::      DisableMFUTracking=1
::    • Restrict Internet Communication (HKCU+HKLM):
::        NoPublishingWizard, NoWebServices, NoGenTicket, NoOnlinePrintsWizard,
::        NoInternetOpenWith, DisableHTTPPrinting, DisableWebPnPDownload,
::        PreventHandwriting* , WindowsMovieMaker web/codec/publish
::    • PCHealth/HelpSvc/ErrorReporting, Windows Error Reporting Disabled=1,
::      ExitOnMSICW, MicrosoftEventVwrDisableLinks, NoRegistration,
::      DisableContentFileUpdates
::    • NVIDIA telemetry OptInOrOutPreference=0
::    • Firewall (Defaults + Parameters): Block-Unified-Telemetry-Client,
::      Block-Windows-Error-Reporting (DiagTrack / WerSvc)
::    • Xbox Gaming Copilot block (ActivationType=0xFFFFFFFF)
::    • Telemetry:
::        AllowTelemetry=0 во всех путях (HKCU/HKLM/Wow6432Node/PolicyManager/
::        CPSS Store+DevicePolicy)
::        AllowCommercialDataPipeline=0, AllowDeviceNameInTelemetry=0,
::        DisableEnterpriseAuthProxy=1, MicrosoftEdgeDataOptIn=0,
::        DisableTelemetryOptInChangeNotification=1, ...Ux=1
::        EnableConfigFlighting=0, DoNotShowFeedbackNotifications=1,
::        LimitEnhancedDiagnosticDataWindowsAnalytics=0, AllowBuildPreview=0,
::        LimitDiagnosticLogCollection=1, LimitDumpCollection=1
::        AllowExperimentation=0
::        WMI Autologger: Diagtrack-Listener / SQMLogger / SetupPlatformTel = 0
::    • WER: AutoApproveOSDumps=0, LoggingDisabled=1, Disabled=1,
::      DefaultConsent=0, DontSendAdditionalData=1, DontShowUI=1, CustomConsent=0
::    • Advertising: Enabled=0, Id удалён, DisabledByGroupPolicy=1
::    • HttpAcceptLanguageOptOut=1, HasAccepted (speech)=0,
::      AllowLinguisticDataCollection=0, TIPC Enabled=0,
::      TailoredExperiences=0, EnableEventTranscript=0,
::      Siuf NumberOfSIUFInPeriod=0
::    • Activity history: Upload/Publish/EnableActivityFeed=0
::    • App permissions (HKCU+HKLM): Deny для location, activity,
::      userAccountInformation, appointments, userDataTasks, chat, radios,
::      bluetoothSync, appDiagnostics, documentsLibrary, picturesLibrary,
::      videosLibrary, broadFileSystemAccess. Allow для webcam/microphone.
::    • Wi-Fi Sense: AutoConnectAllowedOEM=0, PaidWifi=0, WiFiSenseOpen=0,
::      AllowWiFiHotSpotReporting=0, AllowAutoConnectToWiFiSenseHotspots=0
::    • ValueBanner.IdealStateFeatureControlProvider — блок
::    • WindowsAI DisableAIDataAnalysis=1 (Recall off)
::    • Sudo Enabled=3 (inline)
::
::  ── 3. SECURITY ─────────────────────────────────────────────────────────────
::    • AccountProtection_MicrosoftAccount_Disconnected=0 (скрыть в Defender)
::    • Defender: DisableGenericRePorts=1, DisableScheduledSignatureUpdateOnBattery=1
::    • SmartScreen: ConfigureAppInstallControlEnabled=1,
::      ConfigureAppInstallControl=Anywhere, EnableWebContentEvaluation=0,
::      MicrosoftEdge PhishingFilter EnabledV9=0
::    • HideSystray=1, SecurityHealth из Run удалён
::    • BitLocker: PreventDeviceEncryption=1 (отключить авто-шифрование)
::    • VBS/HVCI: EnableVirtualizationBasedSecurity=0,
::      HypervisorEnforcedCodeIntegrity Enabled=0
::
::  ── 4. SYSTEM ───────────────────────────────────────────────────────────────
::    • Boot: BootExecute="autocheck autochk /k:C*" (без проверки C:)
::    • Bypass requirements: SecureBoot/TPM/CPU/RAM/Storage, MoSetup,
::      UnsupportedHardwareNotificationCache, BypassNRO
::    • CrashControl: AutoReboot=0, CrashDumpEnabled=3 (small dump)
::    • IFEO:
::        • Debugger→taskkill для CompatTelRunner, AggregatorHost,
::          DeviceCensus, FeatureLoader, BingChatInstaller, BGAUpsell, BCILauncher
::        • PerfOptions: SearchIndexer/ctfmon=BelowNormal,
::          fontdrvhost/lsass/sihost=Idle
::    • Logon: EnableFirstLogonAnimation=0, DisableStartupSound=1,
::      DisableAutomaticRestartSignOn=1
::    • Multimedia: NetworkThrottlingIndex=10
::    • Power: ShowSleepOption=1, ShutdownWithoutLogon=1
::    • Win32PrioritySeparation=38 (short quantum, 3x fg boost)
::    • OOBE: HideOnlineAccountScreens, HideEULAPage, HideWirelessSetupInOOBE,
::      NetworkLocation=Home, ProtectYourPC=3, DisablePrivacyExperience,
::      HideOEMRegistrationScreen, EnableCortanaVoice=0, DisableVoice=1,
::      HideLocalAccountScreen=0, Skype consent=0
::
::  ── 5. UPDATES ──────────────────────────────────────────────────────────────
::    • UpgradeAvailable=0, DontReportInfectionInformation=0
::    • DODownloadMode=0 (без P2P), AllowBuildPreview=0
::    • ShippedWithReserves=0 (без Reserved Storage)
::    • MediaPlayer DisableAutoUpdate=0
::    • Отключение принудительного DevHomeUpdate / OutlookUpdate
::      (UScheduler_Oobe + BlockedOobeUpdaters=["MS_Outlook"])
::    • HideMCTLink=1, RestartNotificationsAllowed2=0
::    • MS Store: AutoDownload=4, DisableOSUpgrade=1
::
::  ── 6. MISC FIXES ───────────────────────────────────────────────────────────
::    • RealTimeIsUniversal=1 (UTC — для dualboot с Linux)
::    • EnableLinkedConnections=1 (mapped drives при UAC)
::    • Mitigations: vgc.exe (Valorant CFG), osu!.exe (ASLR)
::    • EdgeUpdate policies: InstallDefault=0, Install Edge=0, Install WebView=1,
::      DoNotUpdateToEdgeWithChromium=1
::    • DisableWpbtExecution=1 (dropWPBT)
::    • Audio: UserDuckingPreference=3 (Do Nothing)
::    • Office: DisableLogManagement=1, TimerInterval=900000
::    • RSoPLogging=0 (без GP-логов)
::    • System Restore: RPSessionInterval=0, DiskPercent=0,
::      удаление SPP\Clients (пользователь сам настраивает)
::    • MSI в Safe Mode: MSIServer в Minimal + Network
::
::  ── 7. SERVICES ─────────────────────────────────────────────────────────────
::    Disabled: dam, GpuEnergyDrv, NetBT, Telemetry, diagnosticshub.standardcollector,
::              WerSvc, DiagTrack, wisvc, PcaSvc, WdiServiceHost, WdiSystemHost,
::              tcpipreg, Wecsvc, UCPD
::    Manual:   edgeupdate
::    Auto:     condrv (fix 0xd000003a)
::    + Disable-ScheduledTask "\Microsoft\Windows\AppxDeploymentClient" / "UCPD velocity"
::
::  ── 8. OPTIONAL FEATURES (DISM) ─────────────────────────────────────────────
::    Enable:  DirectPlay, LegacyComponents
::    Disable: MicrosoftWindowsPowerShellV2, MicrosoftWindowsPowerShellV2Root,
::             MSRDC-Infrastructure, Printing-Foundation-Features,
::             Printing-Foundation-InternetPrinting-Client, WorkFolders-Client
::
::  ── 9. APPX REMOVAL ────────────────────────────────────────────────────────
::    Основной список (appx.yml) + Photos / DevHome / Xbox / YourPhone /
::    Edge / Copilot. Для каждого пакета:
::      • Get-AppxPackage -AllUsers → Remove-AppxPackage -AllUsers
::      • Get-AppxProvisionedPackage → Remove-AppxProvisionedPackage
::      • Добавление в AppxAllUserStore\Deprovisioned (защита от переустановки
::        после апдейтов)
::
::  ── 10. WIN32 APPS ──────────────────────────────────────────────────────────
::    • OneDrive: OneDriveSetup /uninstall, чистка пользовательских папок,
::      Run-ключ, CLSID IsPinnedToNameSpaceTree=0, Appx (OneDrive +
::      microsoft.microsoftskydrive)
::    • Teams: процессы, Appx (MicrosoftTeams, MSTeams, Flipgrid), MSI
::      {A7AB73A3-...}, ConfigureChatAutoInstall=0
::    • Edge: AllowUninstall=1, NoRemove удалён, best-effort uninstall через
::      UninstallString + --force-uninstall --delete-profile, ярлыки удалены
::
::  ── 11. SCHEDULED TASKS ─────────────────────────────────────────────────────
::    Disable:
::      • Power Efficiency Diagnostics\AnalyzeSystem
::      • MemoryDiagnostic\ProcessMemoryDiagnosticEvents, RunFullMemoryDiagnostic
::      • WindowsUpdate\Scheduled Start
::      • Windows Error Reporting\QueueReporting
::      • Application Experience\AitAgent, Microsoft Compatibility Appraiser
::      • DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector
::      • Customer Experience Improvement Program\(Consolidator, UsbCeip, KernelCeipTask)
::      • UpdateOrchestrator\(StartOobeAppsScanAfterUpdate, Start Oobe Expedite Work, Schedule Scan)
::      • Все задачи Microsoft\Office\* (Disable-ScheduledTask)
::
::  ── 12. BOOT / FINALIZE ─────────────────────────────────────────────────────
::    • bcdedit: delete useplatformclock/disabledynamictick,
::      bootmenupolicy=Legacy, lastknowngood=yes
::    • setx DOTNET_CLI_TELEMETRY_OPTOUT / POWERSHELL_TELEMETRY_OPTOUT =1
::    • net accounts /maxpwage:unlimited
::    • Teredo = default, ipconfig /flushdns
::    • Брендинг ReviOS 10 / 11 по CurrentBuild (>19045 → 11)
::    • Set-WindowsReservedStorageState=Disabled
::    • Стоп bits/appidsvc/dps/wuauserv
::    • Чистка CbsTemp, Logs, SoftwareDistribution, System32\{LogFiles,SleepStudy,
::      sru,WDI\LogFiles,winevt\Logs}, SystemTemp, Temp
::    • gpupdate /force
::
::  ── НЕ ПРИМЕНЯЕТСЯ (по условию) ─────────────────────────────────────────────
::    • Темы: Set-Theme.ps1, dark.theme, SystemMode/AppMode,
::      AppsUseLightTheme/SystemUsesLightTheme
::    • Обои: WALLPAPER.ps1, WallpaperStartup.cmd, robocopy "Wallpapers",
::      RunOnce RevisionWallpaperStartup
::    • Helper-скрипты: APPX-REMOVER.ps1, CLEANER.ps1, EDGE.ps1,
::      DISM-FEATURES.ps1, ONED.cmd, FINALIZE.cmd, STARTMENU.cmd, FILEASSOC.cmd,
::      assoc.ps1, ngen.ps1, UPDATE-APPX.ps1 — их логика встроена inline
::    • revitool.exe-твики (NTFS last-access/8dot3, service-grouping,
::      WU pause, Intel TSX, hibernation) — заменены прямыми reg-эквивалентами
::      там, где возможно (VBS/HVCI), остальные опущены
::
::  ── ТРЕБОВАНИЯ / ПОВЕДЕНИЕ ──────────────────────────────────────────────────
::    • Windows 10 19041+ / Windows 11
::    • Права администратора (UAC-запрос при старте)
::    • После запуска рекомендуется перезагрузка
::    • Некоторые удаления (Edge, Teams MSI) могут требовать повторного
::      запуска или перезагрузки перед полным завершением
:: ============================================================================

echo ============================================================
echo  ReviOS-like configuration
echo  Themes, wallpapers and helper scripts are NOT applied.
echo ============================================================
echo.

:: ============================================================
:: 1. EXPLORER
:: ============================================================
echo [*] Explorer / context menu...
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /t REG_SZ /d "" /f >nul

:: Take Ownership
for %%K in ("HKCR\*\shell\runas" "HKCR\Directory\shell\runas" "HKCR\dllfile\shell\runas" "HKCR\exefile\shell\runas") do (
    reg add %%K /f >nul
    reg add %%K /ve /t REG_SZ /d "Take Ownership" /f >nul
    reg add %%K /v HasLUAShield /t REG_SZ /d "" /f >nul
    reg add %%K /v NoWorkingDirectory /t REG_SZ /d "" /f >nul
    reg add %%K /v Position /t REG_SZ /d "middle" /f >nul
)
reg add "HKCR\*\shell\runas\command" /ve /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant *S-1-3-4:F /c /l" /f >nul
reg add "HKCR\*\shell\runas\command" /v IsolatedCommand /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant *S-1-3-4:F /c /l" /f >nul
reg add "HKCR\Directory\shell\runas" /v AppliesTo /t REG_SZ /d "NOT (System.ItemPathDisplay:=\"C:\Users\" OR System.ItemPathDisplay:=\"C:\ProgramData\" OR System.ItemPathDisplay:=\"C:\Windows\" OR System.ItemPathDisplay:=\"C:\Windows\System32\" OR System.ItemPathDisplay:=\"C:\Program Files\" OR System.ItemPathDisplay:=\"C:\Program Files (x86)\")" /f >nul
reg add "HKCR\Directory\shell\runas\command" /ve /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant *S-1-3-4:F /t /c /l /q" /f >nul
reg add "HKCR\Directory\shell\runas\command" /v IsolatedCommand /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant *S-1-3-4:F /t /c /l /q" /f >nul
reg add "HKCR\dllfile\shell\runas\command" /ve /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant *S-1-3-4:F /c /l" /f >nul
reg add "HKCR\dllfile\shell\runas\command" /v IsolatedCommand /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant *S-1-3-4:F /c /l" /f >nul
reg add "HKCR\exefile\shell\runas" /v HasLUAShield /t REG_SZ /d "" /f >nul
reg add "HKCR\exefile\shell\runas\command" /ve /t REG_SZ /d "\"%%1\" %%*" /f >nul
reg add "HKCR\exefile\shell\runas\command" /v IsolatedCommand /t REG_SZ /d "\"%%1\" %%*" /f >nul

echo [*] Control Panel...
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

:: Ease of Access — убираем наследие
for %%H in (HKCU HKU\.DEFAULT) do (
  for %%K in (AudioDescription "Blind Access" HighContrast "Keyboard Preference" "Keyboard Response" MouseKeys On ShowSounds SlateLaunch SoundSentry StickyKeys TimeOut ToggleKeys) do (
    reg delete "%%H\Control Panel\Accessibility\%%~K" /f >nul 2>&1
    reg add    "%%H\Control Panel\Accessibility\%%~K" /v Flags /t REG_SZ /d "0" /f >nul
  )
)

echo [*] Explorer general...
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" /v FolderType /t REG_SZ /d "NotSpecified" /f >nul
reg add "HKU\.DEFAULT\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" /v FolderType /t REG_SZ /d "NotSpecified" /f >nul
reg add "HKCU\Software\Microsoft\DirectX\UserGpuPreferences" /v "C:\Windows\explorer.exe" /t REG_SZ /d "GpuPreference=2;" /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\DirectX\UserGpuPreferences" /v "C:\Windows\explorer.exe" /t REG_SZ /d "GpuPreference=2;" /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v DisableGraphRecentItems /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{2cc5ca98-6485-489a-920e-b3e88a6ccce3}" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v MultipleInvokePromptMinimum /t REG_DWORD /d 100 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer" /v MultipleInvokePromptMinimum /t REG_DWORD /d 100 /f >nul
reg add "HKCU\Software\Winaero.com\Winaero Tweaker\Changes" /v pageContextMenuSelectionLimit /t REG_DWORD /d 1 /f >nul
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
reg add "HKLM\SYSTEM\ControlSet001\Control" /v WaitToKillServiceTimeout /t REG_SZ /d "1500" /f >nul
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

echo [*] Notifications / Search / Start / Taskbar / View...
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v NoBalloonFeatureAdvertisements /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Policies\Microsoft\Windows\Explorer" /v NoBalloonFeatureAdvertisements /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v NoAutoTrayNotify /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Policies\Microsoft\Windows\Explorer" /v NoAutoTrayNotify /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v NoCloudApplicationNotification /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v UpdateNotificationLevel /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Context\CloudExperienceHostIntent\Wireless" /v ScoobeCheckCompleted /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Context\CloudExperienceHostIntent\Wireless" /v ScoobeCheckCompleted /t REG_DWORD /d 1 /f >nul

reg add "HKLM\Software\Microsoft\Windows Search\Gather\Windows\SystemIndex" /v RespectPowerModes /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v PreventIndexOnBattery /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCloudSearch /t REG_DWORD /d 2 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortanaAboveLock /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortanaInAAD /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortanaInAADPathOOBE /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowSearchToUseLocation /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v ConnectedSearchUseWeb /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v ConnectedSearchUseWebOverMeteredConnections /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableWebSearch /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v ConnectedSearchPrivacy /t REG_DWORD /d 3 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v CortanaConsent /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Search" /v CortanaConsent /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Speech_OneCore\Preferences" /v VoiceActivationEnableAboveLockscreen /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\WinStore.Tasks.WindowsSearchTask" /v ActivationType /t REG_DWORD /d 4294967295 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\WinStore.Tasks.WindowsSearchTask" /v Server /t REG_SZ /d "" /f >nul
reg add "HKLM\SYSTEM\ControlSet001\Policies\Microsoft\FeatureManagement\Overrides" /v 1694661260 /t REG_DWORD /d 0 /f >nul

reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v ConfigureStartPins /t REG_SZ /d "{\"pinnedList\":[{\"packagedAppId\":\"Microsoft.WindowsStore_8wekyb3d8bbwe!App\"},{\"packagedAppId\":\"windows.immersivecontrolpanel_cw5n1h2txyewy!microsoft.windows.immersivecontrolpanel\"},{\"packagedAppId\":\"Microsoft.WindowsNotepad_8wekyb3d8bbwe!App\"},{\"packagedAppId\":\"Microsoft.Paint_8wekyb3d8bbwe!App\"},{\"desktopAppLink\":\"%APPDATA%\\Microsoft\\Windows\\Start Menu\\Programs\\File Explorer.lnk\"},{\"packagedAppId\":\"Microsoft.WindowsCalculator_8wekyb3d8bbwe!App\"}]}" /f >nul
for %%P in (Documents Downloads FileExplorer HomeGroup Music Network PersonalFolder Pictures Videos) do (
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v AllowPinnedFolder%%P /t REG_DWORD /d 0 /f >nul
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v AllowPinnedFolder%%P_ProviderSet /t REG_DWORD /d 0 /f >nul
)
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v AllowPinnedFolderSettings /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v AllowPinnedFolderSettings_ProviderSet /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoResolveSearch /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoResolveSearch /t REG_DWORD /d 1 /f >nul

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v AllowNewsAndInterests /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v HidePeopleBar /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Policies\Microsoft\Windows\Explorer" /v HidePeopleBar /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Chat" /v ChatIcon /t REG_DWORD /d 3 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f >nul

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /v FullPath /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /v FullPath /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSyncProviderNotifications /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSyncProviderNotifications /t REG_DWORD /d 0 /f >nul

echo [*] Windows Settings...
reg add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility" /v HideInsiderPage /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v TrayIconVisibility /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v ConvertibleSlateModePromptPreference /t REG_DWORD /d 2 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v ConvertibleSlateModePromptPreference /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAppsVisibleInTabletMode /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAppsVisibleInTabletMode /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAutoHideInTabletMode /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAutoHideInTabletMode /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353698Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353698Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Clipboard" /v EnableClipboardHistory /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Clipboard" /v EnableClipboardHistory /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v AllowClipboardHistory /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v AllowCrossDeviceClipboard /t REG_DWORD /d 1 /f >nul

:: Typing / AutoPlay
reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v EnableAutocorrection /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v EnableAutocorrection /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v EnableSpellchecking /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v EnableSpellchecking /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v EnableTextPrediction /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v EnableTextPrediction /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v EnablePredictionSpaceInsertion /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v EnablePredictionSpaceInsertion /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v EnableDoubleTapSpace /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v EnableDoubleTapSpace /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Input\Settings" /v InsightsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings" /v InsightsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Input\Settings" /v EnableHwkbTextPrediction /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings" /v EnableHwkbTextPrediction /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Input\Settings" /v EnableHwkbAutocorrection /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings" /v EnableHwkbAutocorrection /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Input\Settings" /v MultilingualEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings" /v MultilingualEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v Value /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" /v Value /t REG_SZ /d "Allow" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v Value /t REG_SZ /d "Allow" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" /v Value /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v Value /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /v Value /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" /v Value /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" /v Value /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" /v Value /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" /v Value /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v Value /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" /v Value /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" /v Value /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" /v Value /t REG_SZ /d "Deny" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" /v Value /t REG_SZ /d "Deny" /f >nul

:: Wi-Fi Sense
reg add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" /v AutoConnectAllowedOEM /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features" /v PaidWifi /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features" /v WiFiSenseOpen /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v value /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v value /t REG_DWORD /d 0 /f >nul

:: Extra Settings
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\ValueBanner.IdealStateFeatureControlProvider" /v ActivationType /t REG_DWORD /d 4294967295 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\ValueBanner.IdealStateFeatureControlProvider" /v Server /t REG_SZ /d "" /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v DisableAIDataAnalysis /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Sudo" /v Enabled /t REG_DWORD /d 3 /f >nul

:: ============================================================
:: 2. PRIVACY
:: ============================================================
echo [*] Privacy...
:: AppCompat
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v DisableEngine /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v AITEnable /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v DisableUAR /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v DisablePCA /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v DisableInventory /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v SbEnable /t REG_DWORD /d 1 /f >nul

:: Content Delivery Manager
for %%V in (ContentDeliveryAllowed SubscribedContentEnabled SubscribedContent-310093Enabled SoftLandingEnabled SubscribedContent-338389Enabled SilentInstalledAppsEnabled PreInstalledAppsEnabled PreInstalledAppsEverEnabled OemPreInstalledAppsEnabled FeatureManagementEnabled RemediationRequired SubscribedContent-314559Enabled SubscribedContent-280815Enabled SubscribedContent-314563Enabled SubscribedContent-202914Enabled SubscribedContent-338387Enabled SubscribedContent-280810Enabled SubscribedContent-280811Enabled RotatingLockScreenEnabled RotatingLockScreenOverlayEnabled SubscribedContent-338388Enabled) do (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v %%V /t REG_DWORD /d 0 /f >nul
    reg add "HKU\.DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v %%V /t REG_DWORD /d 0 /f >nul
)
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions" /f >nul 2>&1
reg delete "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /f >nul 2>&1
reg delete "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /f >nul 2>&1

:: CEIP
reg add "HKLM\Software\Policies\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\AppV\CEIP" /v CEIPEnable /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Internet Explorer\SQM" /v DisableCustomerImprovementProgram /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Messenger\Client" /v CEIP /t REG_DWORD /d 2 /f >nul
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\UnattendSettings\SQMClient" /v CEIPEnabled /t REG_DWORD /d 0 /f >nul

:: Cloud Content
reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v DisableSoftLanding /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v ConfigureWindowsSpotlight /t REG_DWORD /d 2 /f >nul
reg add "HKU\.DEFAULT\Software\Policies\Microsoft\Windows\CloudContent" /v ConfigureWindowsSpotlight /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v IncludeEnterpriseSpotlight /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Software\Policies\Microsoft\Windows\CloudContent" /v IncludeEnterpriseSpotlight /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v DisableThirdPartySuggestions /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Policies\Microsoft\Windows\CloudContent" /v DisableThirdPartySuggestions /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v DisableTailoredExperiencesWithDiagnosticData /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableTailoredExperiencesWithDiagnosticData /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightFeatures /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightFeatures /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightWindowsWelcomeExperience /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightWindowsWelcomeExperience /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightOnActionCenter /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightOnActionCenter /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightOnSettings /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightOnSettings /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableCloudOptimizedContent /t REG_DWORD /d 1 /f >nul

:: Privacy general
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v MSAOptional /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\Messaging" /v AllowMessageSync /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\EdgeUI" /v DisableHelpSticker /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\EdgeUI" /v DisableMFUTracking /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Software\Policies\Microsoft\Windows\EdgeUI" /v DisableMFUTracking /t REG_DWORD /d 1 /f >nul

:: Restrict Internet Communication (HKCU/HKLM)
for %%R in (HKCU HKLM) do (
  reg add "%%R\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoPublishingWizard /t REG_DWORD /d 1 /f >nul
  reg add "%%R\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoWebServices /t REG_DWORD /d 1 /f >nul
  reg add "%%R\Software\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" /v NoGenTicket /t REG_DWORD /d 1 /f >nul
  reg add "%%R\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoOnlinePrintsWizard /t REG_DWORD /d 1 /f >nul
  reg add "%%R\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoInternetOpenWith /t REG_DWORD /d 1 /f >nul
  reg add "%%R\Software\Policies\Microsoft\Windows NT\Printers" /v DisableHTTPPrinting /t REG_DWORD /d 1 /f >nul
  reg add "%%R\Software\Policies\Microsoft\Windows NT\Printers" /v DisableWebPnPDownload /t REG_DWORD /d 1 /f >nul
  reg add "%%R\Software\Policies\Microsoft\Windows\HandwritingErrorReports" /v PreventHandwritingErrorReports /t REG_DWORD /d 1 /f >nul
  reg add "%%R\Software\Policies\Microsoft\Windows\TabletPC" /v PreventHandwritingDataSharing /t REG_DWORD /d 1 /f >nul
  reg add "%%R\Software\Policies\Microsoft\WindowsMovieMaker" /v WebHelp /t REG_DWORD /d 1 /f >nul
  reg add "%%R\Software\Policies\Microsoft\WindowsMovieMaker" /v CodecDownload /t REG_DWORD /d 1 /f >nul
  reg add "%%R\Software\Policies\Microsoft\WindowsMovieMaker" /v WebPublish /t REG_DWORD /d 1 /f >nul
)
reg add "HKLM\Software\Policies\Microsoft\PCHealth\HelpSvc" /v Headlines /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\PCHealth\HelpSvc" /v MicrosoftKBSearch /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\PCHealth\ErrorReporting" /v DoReport /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\Internet Connection Wizard" /v ExitOnMSICW /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\EventViewer" /v MicrosoftEventVwrDisableLinks /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\Registration Wizard Control" /v NoRegistration /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\SearchCompanion" /v DisableContentFileUpdates /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\NVIDIA Corporation\NVControlPanel2\Client" /v OptInOrOutPreference /t REG_DWORD /d 0 /f >nul

:: Firewall blocks
reg add "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Defaults\FirewallPolicy\FirewallRules" /v Block-Unified-Telemetry-Client /t REG_SZ /d "v2.31|Action=Block|Active=TRUE|Dir=Out|RA42=IntErnet|RA62=IntErnet|App=%%SystemRoot%%\system32\svchost.exe|Svc=DiagTrack|Name=Block-Unified-Telemetry-Client|Desc=Block-Unified-Telemetry-Client|EmbedCtxt=DiagTrack|" /f >nul
reg add "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Defaults\FirewallPolicy\FirewallRules" /v Block-Windows-Error-Reporting /t REG_SZ /d "v2.31|Action=Block|Active=TRUE|Dir=Out|RA42=IntErnet|RA62=IntErnet|App=%%SystemRoot%%\system32\svchost.exe|Svc=WerSvc|Name=Block-Unified-Error-Reporting|Desc=Block-Windows-Error-Reporting|EmbedCtxt=WerSvc|" /f >nul
reg add "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /v Block-Unified-Telemetry-Client /t REG_SZ /d "v2.31|Action=Block|Active=TRUE|Dir=Out|RA42=IntErnet|RA62=IntErnet|App=%%SystemRoot%%\system32\svchost.exe|Svc=DiagTrack|Name=Block-Unified-Telemetry-Client|Desc=Block-Unified-Telemetry-Client|EmbedCtxt=DiagTrack|" /f >nul
reg add "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /v Block-Windows-Error-Reporting /t REG_SZ /d "v2.31|Action=Block|Active=TRUE|Dir=Out|RA42=IntErnet|RA62=IntErnet|App=%%SystemRoot%%\system32\svchost.exe|Svc=WerSvc|Name=Block-Unified-Telemetry-Client|Desc=Block-Windows-Error-Reporting|EmbedCtxt=WerSvc|" /f >nul

:: Xbox Gaming Copilot block
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Microsoft.Xbox.GamingAI.Companion.Host.GamingCompanionHostOptions" /v ActivationType /t REG_DWORD /d 4294967295 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Microsoft.Xbox.GamingAI.Companion.Host.GamingCompanionHostOptions" /v Server /t REG_SZ /d "" /f >nul

:: Telemetry
for %%P in ("HKCU\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection") do (
    reg add %%P /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
)
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowTelemetry" /v value /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CPSS\DevicePolicy\AllowTelemetry" /v DefaultValue /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CPSS\Store\AllowTelemetry" /v Value /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v AllowCommercialDataPipeline /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v AllowDeviceNameInTelemetry /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v DisableEnterpriseAuthProxy /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v MicrosoftEdgeDataOptIn /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v DisableTelemetryOptInChangeNotification /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v DisableTelemetryOptInSettingsUx /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\PreviewBuilds" /v EnableConfigFlighting /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v LimitEnhancedDiagnosticDataWindowsAnalytics /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v AllowBuildPreview /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v LimitDiagnosticLogCollection /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v LimitDumpCollection /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System" /v AllowExperimentation /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\Diagtrack-Listener" /v Start /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\SQMLogger" /v Start /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\SetupPlatformTel" /v Start /t REG_DWORD /d 0 /f >nul

:: WER
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v AutoApproveOSDumps /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v LoggingDisabled /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Microsoft\Windows\Windows Error Reporting\Consent" /v DefaultConsent /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Microsoft\Windows\Windows Error Reporting\Consent" /v DefaultOverrideBehavior /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v DontSendAdditionalData /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v DontShowUI /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting\Consent" /v 0 /t REG_SZ /d "" /f >nul

:: Advertising & tailored
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Id /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Id /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f >nul
reg add "HKU\.DEFAULT\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v HasAccepted /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v HasAccepted /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\TextInput" /v AllowLinguisticDataCollection /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Input\TIPC" /v Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Input\TIPC" /v Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v TailoredExperiencesWithDiagnosticDataEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Privacy" /v TailoredExperiencesWithDiagnosticDataEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CPSS\DevicePolicy\TailoredExperiencesWithDiagnosticDataEnabled" /v DefaultValue /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\EventTranscriptKey" /v EnableEventTranscript /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f >nul
reg delete "HKCU\Software\Microsoft\Siuf\Rules" /v PeriodInNanoSeconds /f >nul 2>&1
reg add "HKU\.DEFAULT\Software\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f >nul
reg delete "HKU\.DEFAULT\Software\Microsoft\Siuf\Rules" /v PeriodInNanoSeconds /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v UploadUserActivities /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /t REG_DWORD /d 0 /f >nul

:: App permissions (HKCU)
for %%C in (location webcam microphone activity userAccountInformation appointments userDataTasks chat radios bluetoothSync appDiagnostics documentsLibrary picturesLibrary videosLibrary broadFileSystemAccess) do (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\%%C" /v Value /t REG_SZ /d "Deny" /f >nul
)
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" /v Value /t REG_SZ /d "Allow" /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v Value /t REG_SZ /d "Allow" /f >nul

:: ============================================================
:: 3. SECURITY
:: ============================================================
echo [*] Security...
reg add "HKCU\Software\Microsoft\Windows Security Health\State" /v AccountProtection_MicrosoftAccount_Disconnected /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows Security Health\State" /v AccountProtection_MicrosoftAccount_Disconnected /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Reporting" /v DisableGenericRePorts /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v DisableScheduledSignatureUpdateOnBattery /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\SmartScreen" /v ConfigureAppInstallControlEnabled /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\SmartScreen" /v ConfigureAppInstallControl /t REG_SZ /d "Anywhere" /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v EnableWebContentEvaluation /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v EnabledV9 /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v HideSystray /t REG_DWORD /d 1 /f >nul
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v SecurityHealth /f >nul 2>&1

:: BitLocker
reg add "HKLM\SYSTEM\ControlSet001\Control\BitLocker" /v PreventDeviceEncryption /t REG_DWORD /d 1 /f >nul

:: VBS / HVCI — прямое отключение
reg add "HKLM\SYSTEM\ControlSet001\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\ControlSet001\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f >nul

:: ============================================================
:: 4. SYSTEM
:: ============================================================
echo [*] System...
:: Boot
reg add "HKLM\SYSTEM\ControlSet001\Control\Session Manager" /v BootExecute /t REG_MULTI_SZ /d "autocheck autochk /k:C*" /f >nul

:: Bypass requirements
reg add "HKLM\SYSTEM\Setup\LabConfig" /v BypassSecureBootCheck /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\Setup\LabConfig" /v BypassTPMCheck /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\Setup\LabConfig" /v BypassCPUCheck /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\Setup\LabConfig" /v BypassRAMCheck /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\Setup\LabConfig" /v BypassStorageCheck /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\Setup\MoSetup" /v AllowUpgradesWithUnsupportedTPMOrCPU /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Control Panel\UnsupportedHardwareNotificationCache" /v SV1 /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Control Panel\UnsupportedHardwareNotificationCache" /v SV2 /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Control Panel\UnsupportedHardwareNotificationCache" /v SV1 /t REG_DWORD /d 0 /f >nul
reg add "HKU\.DEFAULT\Control Panel\UnsupportedHardwareNotificationCache" /v SV2 /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v BypassNRO /t REG_DWORD /d 1 /f >nul

:: Crash control
reg add "HKLM\SYSTEM\ControlSet001\Control\CrashControl" /v AutoReboot /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\ControlSet001\Control\CrashControl" /v CrashDumpEnabled /t REG_DWORD /d 3 /f >nul

:: IFEO
for %%E in (CompatTelRunner.exe AggregatorHost.exe DeviceCensus.exe FeatureLoader.exe BingChatInstaller.exe BGAUpsell.exe BCILauncher.exe) do (
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%E" /v Debugger /t REG_SZ /d "%%windir%%\System32\taskkill.exe" /f >nul
)
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchIndexer.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 5 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ctfmon.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 5 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\fontdrvhost.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\fontdrvhost.exe\PerfOptions" /v IoPriority /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\sihost.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\sihost.exe\PerfOptions" /v IoPriority /t REG_DWORD /d 0 /f >nul

:: Logon
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableFirstLogonAnimation /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableStartupSound /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableAutomaticRestartSignOn /t REG_DWORD /d 1 /f >nul

:: Multimedia / Power / Win32PS
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 10 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" /v ShowSleepOption /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ShutdownWithoutLogon /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\ControlSet001\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f >nul

:: OOBE
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

:: ============================================================
:: 5. UPDATES
:: ============================================================
echo [*] Updates...
reg add "HKLM\SYSTEM\Setup\UpgradeNotification" /v UpgradeAvailable /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\MRT" /v DontReportInfectionInformation /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v DODownloadMode /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v AllowBuildPreview /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" /v ShippedWithReserves /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Policies\Microsoft\WindowsMediaPlayer" /v DisableAutoUpdate /t REG_DWORD /d 0 /f >nul
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\DevHomeUpdate" /f >nul 2>&1
reg add    "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\UScheduler\DevHomeUpdate" /v workCompleted /t REG_DWORD /d 1 /f >nul
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\OutlookUpdate" /f >nul 2>&1
reg add    "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\UScheduler\OutlookUpdate" /v workCompleted /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe" /v BlockedOobeUpdaters /t REG_SZ /d "[\"MS_Outlook\"]" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v HideMCTLink /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v RestartNotificationsAllowed2 /t REG_DWORD /d 0 /f >nul

:: MS Store
reg add "HKLM\Software\Policies\Microsoft\WindowsStore" /v AutoDownload /t REG_DWORD /d 4 /f >nul
reg add "HKLM\Software\Policies\Microsoft\WindowsStore" /v DisableOSUpgrade /t REG_DWORD /d 1 /f >nul

:: ============================================================
:: 6. MISC FIXES
:: ============================================================
echo [*] Misc fixes...
reg add "HKLM\System\CurrentControlSet\Control\TimeZoneInformation" /v RealTimeIsUniversal /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLinkedConnections /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vgc.exe" /v MitigationOptions /t REG_BINARY /d 000000000001000000000000000000000000000000000000 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vgc.exe" /v MitigationAuditOptions /t REG_BINARY /d 000000000000000000000000000000000000000000000000 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vgc.exe" /v EAFModules /t REG_SZ /d "" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\osu!.exe" /v MitigationOptions /t REG_BINARY /d 000021000000000000000000000000000000000000000000 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\osu!.exe" /v MitigationAuditOptions /t REG_BINARY /d 000000000000000000000000000000000000000000000000 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\osu!.exe" /v EAFModules /t REG_SZ /d "" /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v InstallDefault /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "Install{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "Install{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v DoNotUpdateToEdgeWithChromium /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\ControlSet001\Control\Session Manager" /v DisableWpbtExecution /t REG_DWORD /d 1 /f >nul

:: Audio communications
reg add "HKCU\Software\Microsoft\Multimedia\Audio" /v UserDuckingPreference /t REG_DWORD /d 3 /f >nul
reg add "HKU\.DEFAULT\Software\Microsoft\Multimedia\Audio" /v UserDuckingPreference /t REG_DWORD /d 3 /f >nul

:: Office logging
reg add "HKLM\SOFTWARE\Microsoft\ClickToRun\OverRide" /v DisableLogManagement /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Office\ClickToRun\Configuration" /v TimerInterval /t REG_SZ /d "900000" /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v RSoPLogging /t REG_DWORD /d 0 /f >nul

:: System Restore pre-defined config
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SPP\Clients" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v RPSessionInterval /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore\cfg" /v DiskPercent /t REG_DWORD /d 0 /f >nul

:: MSI in safe mode
reg add "HKLM\SYSTEM\ControlSet001\Control\SafeBoot\Minimal\MSIServer" /ve /t REG_SZ /d "Service" /f >nul
reg add "HKLM\SYSTEM\ControlSet001\Control\SafeBoot\Network\MSIServer" /ve /t REG_SZ /d "Service" /f >nul

:: ============================================================
:: 7. SERVICES
:: ============================================================
echo [*] Services...
for %%S in (dam GpuEnergyDrv NetBT Telemetry diagnosticshub.standardcollector.service WerSvc DiagTrack wisvc PcaSvc WdiServiceHost WdiSystemHost tcpipreg Wecsvc UCPD) do (
    sc config "%%S" start= disabled >nul 2>&1
)
sc config "edgeupdate" start= demand >nul 2>&1
sc config "condrv" start= auto >nul 2>&1
powershell -NoProfile -Command "Disable-ScheduledTask -TaskPath '\Microsoft\Windows\AppxDeploymentClient' -TaskName 'UCPD velocity' -ErrorAction SilentlyContinue" >nul 2>&1

:: ============================================================
:: 8. OPTIONAL FEATURES (DISM)
:: ============================================================
echo [*] Optional features...
dism /online /enable-feature  /featurename:DirectPlay /all /norestart >nul
dism /online /enable-feature  /featurename:LegacyComponents /all /norestart >nul
for %%F in (MicrosoftWindowsPowerShellV2 MicrosoftWindowsPowerShellV2Root MSRDC-Infrastructure Printing-Foundation-Features Printing-Foundation-InternetPrinting-Client WorkFolders-Client) do (
    dism /online /disable-feature /featurename:%%F /norestart >nul
)

:: ============================================================
:: 9. APPX REMOVAL (inline, no helper scripts)
:: ============================================================
echo [*] Removing Appx packages (main list)...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; $list='Microsoft.Windows.SecureAssessmentBrowser Microsoft.Windows.PeopleExperienceHost Microsoft.WindowsCamera MicrosoftWindows.Client.WebExperience Microsoft.WidgetsPlatformRuntime Microsoft.WindowsAlarms Microsoft.WindowsMaps Microsoft.MicrosoftStickyNotes microsoft.windowscommunicationsapps Microsoft.People Microsoft.BingNews Microsoft.BingSearch Microsoft.BingWeather Microsoft.MicrosoftSolitaireCollection Microsoft.WindowsFeedbackHub Microsoft.GetHelp Microsoft.Getstarted Microsoft.Todos Microsoft.PowerAutomateDesktop Microsoft.549981C3F5F10 MicrosoftCorporationII.QuickAssist MicrosoftCorporationII.MicrosoftFamily Microsoft.ZuneMusic Microsoft.ZuneVideo Microsoft.WindowsSoundRecorder Clipchamp.Clipchamp Microsoft.Whiteboard Microsoft.MicrosoftTeamsforSurfaceHub MicrosoftCorporationII.MailforSurfaceHub Microsoft.MicrosoftPowerBIForWindows Microsoft.SkypeApp Microsoft.MicrosoftOfficeHub Microsoft.Office.Excel Microsoft.Office.PowerPoint Microsoft.Office.Word Microsoft.Office.OneNote Microsoft.OutlookForWindows SpotifyAB.SpotifyMusic OutlookPWA Microsoft.Microsoft3DViewer Microsoft.Advertising MixedReality.Portal Microsoft.MSPaint Microsoft.StartExperiencesApp'.Split(' '); foreach($n in $list){ Get-AppxPackage -AllUsers -Name $n | ForEach-Object { $d='HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned\'+$_.PackageFamilyName; if(!(Test-Path $d)){New-Item -Path $d -Force|Out-Null}; Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue }; Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -like ($n+'*')} | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue }"

echo [*] Removing Photos / DevHome / Xbox / YourPhone / Edge / Copilot...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; $list='Microsoft.Windows.Photos Microsoft.Windows.DevHome Microsoft.Xbox Microsoft.XboxApp Microsoft.GamingApp Microsoft.Edge.GameAssist Microsoft.YourPhone MicrosoftWindows.CrossDevice Microsoft.MicrosoftEdge Microsoft.MicrosoftEdgeDevToolsClient Microsoft.Copilot'.Split(' '); foreach($n in $list){ Get-AppxPackage -AllUsers -Name $n | ForEach-Object { $d='HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned\'+$_.PackageFamilyName; if(!(Test-Path $d)){New-Item -Path $d -Force|Out-Null}; Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue }; Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -like ($n+'*')} | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue }"

:: ============================================================
:: 10. WIN32 APPS
:: ============================================================
echo [*] OneDrive removal...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; Stop-Process -Name OneDrive* -Force -ErrorAction SilentlyContinue; $p=@($env:SystemRoot+'\System32\OneDriveSetup.exe',$env:SystemRoot+'\SysWOW64\OneDriveSetup.exe'); foreach($f in $p){ if(Test-Path $f){ Start-Process $f '/uninstall' -Wait -NoNewWindow } }; Get-ChildItem 'C:\Users' -Directory | ForEach-Object { $od=$_.FullName+'\AppData\Local\Microsoft\OneDrive'; if(Test-Path $od){Remove-Item $od -Recurse -Force}; $lnk=$_.FullName+'\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk'; if(Test-Path $lnk){Remove-Item $lnk -Force} }; Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' -Name OneDrive -ErrorAction SilentlyContinue; [microsoft.win32.registry]::SetValue('HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}','System.IsPinnedToNameSpaceTree',0,[Microsoft.Win32.RegistryValueKind]::DWord); Get-AppxPackage -AllUsers -Name OneDrive | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue; Get-AppxPackage -AllUsers -Name microsoft.microsoftskydrive | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v OneDrive /f >nul 2>&1

echo [*] Teams removal...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; Stop-Process -Name Teams -Force; Stop-Process -Name ms-teamsupdate -Force; foreach($n in @('MicrosoftTeams','MSTeams','Flipgrid')){ Get-AppxPackage -AllUsers -Name $n | Remove-AppxPackage -AllUsers; Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -like ($n+'*')} | Remove-AppxProvisionedPackage -Online }"
msiexec /qn /norestart /X{A7AB73A3-CB10-4AA5-9D38-6AEFFBDE4C91} >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Communications" /v ConfigureChatAutoInstall /t REG_DWORD /d 0 /f >nul

echo [*] Edge removal (best-effort)...
reg delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /v NoRemove /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdateDev" /v AllowUninstall /t REG_DWORD /d 1 /f >nul
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; $key='HKLM:\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\ClientState\{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}'; if(Test-Path $key){ $u=(Get-ItemProperty $key).UninstallString; $a=(Get-ItemProperty $key).UninstallArguments; if($u){ $env:windir=''; Start-Process -FilePath $u -ArgumentList ($a+' --force-uninstall --delete-profile') -Wait -NoNewWindow } }; foreach($s in @($env:ProgramData+'\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk',$env:PUBLIC+'\Desktop\Microsoft Edge.lnk',$env:USERPROFILE+'\Desktop\Microsoft Edge.lnk')){ if(Test-Path $s){Remove-Item $s -Force} }"

:: ============================================================
:: 11. SCHEDULED TASKS (from FINALIZE.cmd)
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
) do schtasks /Change /TN "%%~T" /Disable >nul 2>&1

powershell -NoProfile -Command "Disable-ScheduledTask -TaskPath '\Microsoft\Office\*' -ErrorAction SilentlyContinue" >nul 2>&1

:: ============================================================
:: 12. BOOT / FINAL
:: ============================================================
echo [*] Boot settings...
bcdedit /deletevalue useplatformclock >nul 2>&1
bcdedit /deletevalue disabledynamictick >nul 2>&1
bcdedit /set bootmenupolicy Legacy >nul 2>&1
bcdedit /set lastknowngood yes >nul 2>&1

echo [*] Finalizing...
setx DOTNET_CLI_TELEMETRY_OPTOUT 1 >nul
setx POWERSHELL_TELEMETRY_OPTOUT 1 >nul
net accounts /maxpwage:unlimited >nul 2>&1
netsh interface Teredo set state type=default >nul 2>&1
netsh interface Teredo set state servername=default >nul 2>&1
ipconfig /flushdns >nul

:: Build description
for /f "tokens=3" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild 2^>nul') do set "BUILD=%%i"
if defined BUILD if !BUILD! GTR 19045 (
    bcdedit /set description "ReviOS 11" >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v Model /t REG_SZ /d "ReviOS 11" /f >nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v RegisteredOrganization /t REG_SZ /d "ReviOS 11" /f >nul
) else (
    bcdedit /set description "ReviOS 10" >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v Model /t REG_SZ /d "ReviOS 10" /f >nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v RegisteredOrganization /t REG_SZ /d "ReviOS 10" /f >nul
)

:: Disable Reserved Storage & cleanup
powershell -NoProfile -Command "Set-WindowsReservedStorageState -State Disabled -ErrorAction SilentlyContinue" >nul 2>&1
Stop-Service bits -Force >nul 2>&1
Stop-Service appidsvc -Force >nul 2>&1
Stop-Service dps -Force >nul 2>&1
Stop-Service wuauserv -Force >nul 2>&1
for %%F in (CbsTemp Logs SoftwareDistribution System32\LogFiles System32\SleepStudy System32\sru System32\WDI\LogFiles System32\winevt\Logs SystemTemp Temp) do (
    if exist "%SystemRoot%\%%F" del /f /q /s "%SystemRoot%\%%F\*" >nul 2>&1
)

:: GPUpdate
gpupdate /force >nul 2>&1

echo.
echo ============================================================
echo  DONE. ReviOS-like configuration applied.
echo  Themes / wallpapers / helper scripts were NOT applied.
echo  A reboot is recommended.
echo ============================================================