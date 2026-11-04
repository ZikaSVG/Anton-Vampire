@echo off
setlocal EnableExtensions
chcp 65001 >nul
title ImmortalOS - только службы

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Запустите от имени администратора.
    pause
    exit /b 1
)

:: ============================================================================
::                           КРУТАЯ ШАПКА
:: ============================================================================
::  Standalone-батник по ImmortalOS (merged_project.txt).
::  Включены ТОЛЬКО отключения служб: sc config "X" start= disabled.
::  Папки "отмена" не включены. Дубликаты оставлены намеренно.
::  Ряд записей — драйверы (не службы); sc config к ним тоже применим.
:: ============================================================================

:: AarSvc — вспомогательная пользовательская служба уведомлений/фона.
sc config "AarSvc" start= disabled >nul 2>&1

:: AppIDSvc — идентификация приложений (AppLocker).
sc config "AppIDSvc" start= disabled >nul 2>&1

:: AppReadiness — подготовка приложений к первому запуску.
sc config "AppReadiness" start= disabled >nul 2>&1

:: AppXSvc — развёртывание приложений Microsoft Store.
sc config "AppXSvc" start= disabled >nul 2>&1

:: Appinfo — запуск интерактивных приложений с повышением прав.
sc config "Appinfo" start= disabled >nul 2>&1

:: BDESVC — шифрование дисков BitLocker.
sc config "BDESVC" start= disabled >nul 2>&1

:: BFE — базовый фильтрующий движок брандмауэра/IPsec.
sc config "BFE" start= disabled >nul 2>&1

:: BITS — фоновая интеллектуальная передача.
sc config "BITS" start= disabled >nul 2>&1

:: BTAGService — шлюз Bluetooth-аудио.
sc config "BTAGService" start= disabled >nul 2>&1

:: BTHPORT — драйвер последовательных портов Bluetooth.
sc config "BTHPORT" start= disabled >nul 2>&1

:: BTHUSB — драйвер USB Bluetooth.
sc config "BTHUSB" start= disabled >nul 2>&1

:: BcastDVRUserService — пользовательская служба записи трансляций.
sc config "BcastDVRUserService" start= disabled >nul 2>&1

:: BluetoothUserService — пользовательская служба Bluetooth.
sc config "BluetoothUserService" start= disabled >nul 2>&1

:: BthA2dp — драйвер профиля A2DP Bluetooth.
sc config "BthA2dp" start= disabled >nul 2>&1

:: BthAvctpSvc — служба AVCTP для Bluetooth.
sc config "BthAvctpSvc" start= disabled >nul 2>&1

:: BthEnum — драйвер перечисления Bluetooth-устройств.
sc config "BthEnum" start= disabled >nul 2>&1

:: BthHFEnum — драйвер перечисления Bluetooth Hands-Free.
sc config "BthHFEnum" start= disabled >nul 2>&1

:: BthLEEnum — драйвер перечисления Bluetooth LE.
sc config "BthLEEnum" start= disabled >nul 2>&1

:: BthMini — драйвер Bluetooth miniport.
sc config "BthMini" start= disabled >nul 2>&1

:: BthPan — драйвер PAN Bluetooth.
sc config "BthPan" start= disabled >nul 2>&1

:: CDPSvc — платформа подключённых устройств.
sc config "CDPSvc" start= disabled >nul 2>&1

:: CDPUserSvc — пользовательская часть CDP.
sc config "CDPUserSvc" start= disabled >nul 2>&1

:: COMSysApp — приложение COM+.
sc config "COMSysApp" start= disabled >nul 2>&1

:: CaptureService — пользовательская служба захвата экрана/игр.
sc config "CaptureService" start= disabled >nul 2>&1

:: ClipSVC — лицензирование клиента Microsoft Store.
sc config "ClipSVC" start= disabled >nul 2>&1

:: ConsentUxUserSvc — запросы согласия пользователя.
sc config "ConsentUxUserSvc" start= disabled >nul 2>&1

:: CredentialEnrollmentManagerUserSvc — управление регистрацией учётных данных.
sc config "CredentialEnrollmentManagerUserSvc" start= disabled >nul 2>&1

:: DPS — политика диагностики.
sc config "DPS" start= disabled >nul 2>&1

:: DevQueryBroker — брокер фонового обнаружения.
sc config "DevQueryBroker" start= disabled >nul 2>&1

:: DeviceAssociationBrokerSvc — брокер сопоставления устройств.
sc config "DeviceAssociationBrokerSvc" start= disabled >nul 2>&1

:: DeviceAssociationService — сопоставление устройств.
sc config "DeviceAssociationService" start= disabled >nul 2>&1

:: DeviceInstall — установка устройств.
sc config "DeviceInstall" start= disabled >nul 2>&1

:: DevicePickerUserSvc — выбор устройств в UI.
sc config "DevicePickerUserSvc" start= disabled >nul 2>&1

:: DevicesFlowUserSvc — потоки данных устройств.
sc config "DevicesFlowUserSvc" start= disabled >nul 2>&1

:: DiagTrack — телеметрия Connected User Experiences.
sc config "DiagTrack" start= disabled >nul 2>&1

:: DoSvc — оптимизация доставки (Delivery Optimization).
sc config "DoSvc" start= disabled >nul 2>&1

:: DsSvc — вспомогательная служба данных.
sc config "DsSvc" start= disabled >nul 2>&1

:: EFS — шифрующая файловая система.
sc config "EFS" start= disabled >nul 2>&1

:: Eaphost — EAP-аутентификация (Wi-Fi 802.1X).
sc config "Eaphost" start= disabled >nul 2>&1

:: EntAppSvc — управление корпоративными приложениями.
sc config "EntAppSvc" start= disabled >nul 2>&1

:: EventLog — журнал событий Windows. ⚠️ Критично.
sc config "EventLog" start= disabled >nul 2>&1

:: FDResPub — публикация ресурсов обнаружения.
sc config "FDResPub" start= disabled >nul 2>&1

:: Fax — факс.
sc config "Fax" start= disabled >nul 2>&1

:: FontCache — кэш шрифтов.
sc config "FontCache" start= disabled >nul 2>&1

:: FontCache3.0.0.0 — кэш шрифтов WPF.
sc config "FontCache3.0.0.0" start= disabled >nul 2>&1

:: GraphicsPerfSvc — производительность графики.
sc config "GraphicsPerfSvc" start= disabled >nul 2>&1

:: HidBth — драйвер HID Bluetooth.
sc config "HidBth" start= disabled >nul 2>&1

:: HvHost — узел Hyper-V.
sc config "HvHost" start= disabled >nul 2>&1

:: IKEEXT — модули ключей IKE/AuthIP.
sc config "IKEEXT" start= disabled >nul 2>&1

:: InstallService — установка из Microsoft Store.
sc config "InstallService" start= disabled >nul 2>&1

:: IpxlatCfgSvc — настройка преобразования IP-адресов.
sc config "IpxlatCfgSvc" start= disabled >nul 2>&1

:: KSecPkg — драйвер пакета безопасности Kerberos.
sc config "KSecPkg" start= disabled >nul 2>&1

:: KeyIso — изоляция ключей (CNG).
sc config "KeyIso" start= disabled >nul 2>&1

:: KtmRm — координатор транзакций KtmRm.
sc config "KtmRm" start= disabled >nul 2>&1

:: LanmanServer — сервер SMB.
sc config "LanmanServer" start= disabled >nul 2>&1

:: LanmanWorkstation — рабочая станция SMB. ⚠️ Сеть/шары.
sc config "LanmanWorkstation" start= disabled >nul 2>&1

:: LicenseManager — лицензирование Microsoft Store.
sc config "LicenseManager" start= disabled >nul 2>&1

:: LxpSvc — языковой интерфейс/раскладки.
sc config "LxpSvc" start= disabled >nul 2>&1

:: MSDTC — координатор распределённых транзакций.
sc config "MSDTC" start= disabled >nul 2>&1

:: MSiSCSI — инициатор iSCSI.
sc config "MSiSCSI" start= disabled >nul 2>&1

:: MapsBroker — менеджер загруженных карт.
sc config "MapsBroker" start= disabled >nul 2>&1

:: MessagingService — обмен сообщениями (SMS/MMS).
sc config "MessagingService" start= disabled >nul 2>&1

:: NaturalAuthentication — естественная аутентификация (датчики).
sc config "NaturalAuthentication" start= disabled >nul 2>&1

:: NcaSvc — помощник подключения к сети.
sc config "NcaSvc" start= disabled >nul 2>&1

:: NcbService — брокер сетевых подключений.
sc config "NcbService" start= disabled >nul 2>&1

:: NcdAutoSetup — автонастройка сетевых устройств.
sc config "NcdAutoSetup" start= disabled >nul 2>&1

:: NetSetupSvc — установка сетевых компонентов.
sc config "NetSetupSvc" start= disabled >nul 2>&1

:: NetTcpPortSharing — общий доступ к портам TCP.
sc config "NetTcpPortSharing" start= disabled >nul 2>&1

:: Netlogon — аутентификация в домене.
sc config "Netlogon" start= disabled >nul 2>&1

:: Netman — сетевые подключения.
sc config "Netman" start= disabled >nul 2>&1

:: NgcCtnrSvc — контейнер Microsoft Passport.
sc config "NgcCtnrSvc" start= disabled >nul 2>&1

:: NgcSvc — Microsoft Passport (Windows Hello).
sc config "NgcSvc" start= disabled >nul 2>&1

:: NlaSvc — сетевое расположение.
sc config "NlaSvc" start= disabled >nul 2>&1

:: OneSyncSvc — синхронизация почты/контактов/календаря.
sc config "OneSyncSvc" start= disabled >nul 2>&1

:: PNRPAutoReg — публикация имени через PNRP.
sc config "PNRPAutoReg" start= disabled >nul 2>&1

:: PNRPsvc — разрешение одноранговых имён.
sc config "PNRPsvc" start= disabled >nul 2>&1

:: ParentalControls — родительский контроль.
sc config "ParentalControls" start= disabled >nul 2>&1

:: PcaSvc — помощник по совместимости программ.
sc config "PcaSvc" start= disabled >nul 2>&1

:: PeerDistSvc — BranchCache.
sc config "PeerDistSvc" start= disabled >nul 2>&1

:: PerfHost — хост производительности (WMI).
sc config "PerfHost" start= disabled >nul 2>&1

:: PhoneSvc — телефония.
sc config "PhoneSvc" start= disabled >nul 2>&1

:: PimIndexMaintenanceSvc — индексирование контактов/PIM.
sc config "PimIndexMaintenanceSvc" start= disabled >nul 2>&1

:: PlugPlay — Plug and Play. ⚠️ Критично.
sc config "PlugPlay" start= disabled >nul 2>&1

:: PolicyAgent — агент политики IPsec.
sc config "PolicyAgent" start= disabled >nul 2>&1

:: Power — управление питанием. ⚠️ Критично.
sc config "Power" start= disabled >nul 2>&1

:: PptpMiniport — драйвер PPTP.
sc config "PptpMiniport" start= disabled >nul 2>&1

:: PrintNotify — уведомления принтеров.
sc config "PrintNotify" start= disabled >nul 2>&1

:: PrintWorkflowUserSvc — рабочие процессы печати.
sc config "PrintWorkflowUserSvc" start= disabled >nul 2>&1

:: ProfSvc — профили пользователей. ⚠️ Критично.
sc config "ProfSvc" start= disabled >nul 2>&1

:: PushToInstall — установка по запросу (Store).
sc config "PushToInstall" start= disabled >nul 2>&1

:: QWAVE — качество аудио/видео в сети.
sc config "QWAVE" start= disabled >nul 2>&1

:: RFCOMM — драйвер RFCOMM Bluetooth.
sc config "RFCOMM" start= disabled >nul 2>&1

:: RasAgileVpn — драйвер Agile VPN.
sc config "RasAgileVpn" start= disabled >nul 2>&1

:: RasAuto — автоподключение удалённого доступа.
sc config "RasAuto" start= disabled >nul 2>&1

:: RasMan — диспетчер удалённых подключений.
sc config "RasMan" start= disabled >nul 2>&1

:: RasPppoe — драйвер PPPoE.
sc config "RasPppoe" start= disabled >nul 2>&1

:: RasSstp — драйвер SSTP.
sc config "RasSstp" start= disabled >nul 2>&1

:: Rasl2tp — драйвер L2TP.
sc config "Rasl2tp" start= disabled >nul 2>&1

:: RemoteAccess — маршрутизация и удалённый доступ.
sc config "RemoteAccess" start= disabled >nul 2>&1

:: RemoteRegistry — удалённый реестр.
sc config "RemoteRegistry" start= disabled >nul 2>&1

:: RetailDemo — демонстрационный режим магазина.
sc config "RetailDemo" start= disabled >nul 2>&1

:: RmSvc — управление радио (Wi-Fi/Bluetooth).
sc config "RmSvc" start= disabled >nul 2>&1

:: RpcEptMapper — сопоставитель конечных точек RPC. ⚠️ Критично.
sc config "RpcEptMapper" start= disabled >nul 2>&1

:: RpcLocator — локатор RPC.
sc config "RpcLocator" start= disabled >nul 2>&1

:: RpcSs — RPC. ⚠️ Критично.
sc config "RpcSs" start= disabled >nul 2>&1

:: SCPolicySvc — политика удаления смарт-карт.
sc config "SCPolicySvc" start= disabled >nul 2>&1

:: SCardSvr — смарт-карты.
sc config "SCardSvr" start= disabled >nul 2>&1

:: SDRSVC — резервное копирование Windows.
sc config "SDRSVC" start= disabled >nul 2>&1

:: SEMgrSvc — платежи/NFC.
sc config "SEMgrSvc" start= disabled >nul 2>&1

:: SENS — системные события.
sc config "SENS" start= disabled >nul 2>&1

:: SNMPTRAP — ловушка SNMP.
sc config "SNMPTRAP" start= disabled >nul 2>&1

:: SSDPSRV — обнаружение SSDP/UPnP.
sc config "SSDPSRV" start= disabled >nul 2>&1

:: SamSs — диспетчер учётных записей. ⚠️ Критично.
sc config "SamSs" start= disabled >nul 2>&1

:: ScDeviceEnum — перечисление устройств чтения смарт-карт.
sc config "ScDeviceEnum" start= disabled >nul 2>&1

:: Schedule — планировщик заданий. ⚠️ Критично.
sc config "Schedule" start= disabled >nul 2>&1

:: SecurityHealthService — Центр безопасности Windows.
sc config "SecurityHealthService" start= disabled >nul 2>&1

:: Sense — расширенная защита Defender ATP.
sc config "Sense" start= disabled >nul 2>&1

:: SensorDataService — данные датчиков.
sc config "SensorDataService" start= disabled >nul 2>&1

:: Sensorservice — служба датчиков.
sc config "Sensorservice" start= disabled >nul 2>&1

:: SensrSvc — мониторинг датчиков.
sc config "SensrSvc" start= disabled >nul 2>&1

:: SessionEnv — настройка удалённого рабочего стола.
sc config "SessionEnv" start= disabled >nul 2>&1

:: SharedAccess — общий доступ к интернету (ICS).
sc config "SharedAccess" start= disabled >nul 2>&1

:: ShellHWDetection — обнаружение оборудования оболочки.
sc config "ShellHWDetection" start= disabled >nul 2>&1

:: SmsRouter — маршрутизатор SMS.
sc config "SmsRouter" start= disabled >nul 2>&1

:: Spooler — диспетчер печати.
sc config "Spooler" start= disabled >nul 2>&1

:: SstpSvc — SSTP VPN.
sc config "SstpSvc" start= disabled >nul 2>&1

:: StateRepository — репозиторий состояний.
sc config "StateRepository" start= disabled >nul 2>&1

:: StorSvc — служба хранилища.
sc config "StorSvc" start= disabled >nul 2>&1

:: SysMain — Superfetch/SysMain.
sc config "SysMain" start= disabled >nul 2>&1

:: SystemEventsBroker — брокер системных событий.
sc config "SystemEventsBroker" start= disabled >nul 2>&1

:: TabletInputService — сенсорная клавиатура/рукописный ввод.
sc config "TabletInputService" start= disabled >nul 2>&1

:: TapiSrv — телефония TAPI.
sc config "TapiSrv" start= disabled >nul 2>&1

:: TermService — удалённые рабочие столы.
sc config "TermService" start= disabled >nul 2>&1

:: Themes — темы оформления.
sc config "Themes" start= disabled >nul 2>&1

:: TieringEngineService — управление уровнями хранения.
sc config "TieringEngineService" start= disabled >nul 2>&1

:: TimeBrokerSvc — брокер времени.
sc config "TimeBrokerSvc" start= disabled >nul 2>&1

:: TokenBroker — диспетчер веб-учётных записей.
sc config "TokenBroker" start= disabled >nul 2>&1

:: TrkWks — распределённое отслеживание ссылок.
sc config "TrkWks" start= disabled >nul 2>&1

:: TroubleshootingSvc — рекомендуемые действия по устранению неполадок.
sc config "TroubleshootingSvc" start= disabled >nul 2>&1

:: TrustedInstaller — установщик компонентов Windows.
sc config "TrustedInstaller" start= disabled >nul 2>&1

:: UevAgentService — виртуализация пользовательского опыта (UE-V).
sc config "UevAgentService" start= disabled >nul 2>&1

:: UmRdpService — перенаправление портов RDP.
sc config "UmRdpService" start= disabled >nul 2>&1

:: UnistoreSvc — хранилище пользовательских данных.
sc config "UnistoreSvc" start= disabled >nul 2>&1

:: UserDataSvc — данные пользователя.
sc config "UserDataSvc" start= disabled >nul 2>&1

:: UserManager — диспетчер пользователей.
sc config "UserManager" start= disabled >nul 2>&1

:: UsoSvc — оркестратор обновлений Windows.
sc config "UsoSvc" start= disabled >nul 2>&1

:: VSS — теневые копии тома.
sc config "VSS" start= disabled >nul 2>&1

:: VacSvc — вспомогательная служба (сторонняя).
sc config "VacSvc" start= disabled >nul 2>&1

:: VaultSvc — хранилище учётных данных.
sc config "VaultSvc" start= disabled >nul 2>&1

:: W32Time — служба времени Windows.
sc config "W32Time" start= disabled >nul 2>&1

:: WEPHOSTSVC — хост поставщиков шифрования.
sc config "WEPHOSTSVC" start= disabled >nul 2>&1

:: WFDSConMgrSvc — подключения Wi-Fi Direct.
sc config "WFDSConMgrSvc" start= disabled >nul 2>&1

:: WMPNetworkSvc — общий доступ к медиатеке WMP.
sc config "WMPNetworkSvc" start= disabled >nul 2>&1

:: WManSvc — служба управления Windows.
sc config "WManSvc" start= disabled >nul 2>&1

:: WPDBusEnum — перечисление портативных устройств.
sc config "WPDBusEnum" start= disabled >nul 2>&1

:: WSearch — поиск Windows.
sc config "WSearch" start= disabled >nul 2>&1

:: WaaSMedicSvc — восстановление Windows Update.
sc config "WaaSMedicSvc" start= disabled >nul 2>&1

:: WalletService — кошелёк Windows.
sc config "WalletService" start= disabled >nul 2>&1

:: WarpJITSvc — служба Warp JIT (сторонняя).
sc config "WarpJITSvc" start= disabled >nul 2>&1

:: WbioSrvc — биометрия Windows.
sc config "WbioSrvc" start= disabled >nul 2>&1

:: WdiServiceHost — хост службы диагностики.
sc config "WdiServiceHost" start= disabled >nul 2>&1

:: WdiSystemHost — системный хост диагностики.
sc config "WdiSystemHost" start= disabled >nul 2>&1

:: WebClient — WebDAV клиент.
sc config "WebClient" start= disabled >nul 2>&1

:: Wecsvc — сборщик событий Windows.
sc config "Wecsvc" start= disabled >nul 2>&1

:: WerSvc — отчёты об ошибках Windows.
sc config "WerSvc" start= disabled >nul 2>&1

:: WiaRpc — события получения изображений.
sc config "WiaRpc" start= disabled >nul 2>&1

:: WinDefend — антивирус Microsoft Defender. ⚠️ Без защиты.
sc config "WinDefend" start= disabled >nul 2>&1

:: WinHttpAutoProxySvc — автообнаружение прокси WinHTTP.
sc config "WinHttpAutoProxySvc" start= disabled >nul 2>&1

:: WinRM — удалённое управление Windows.
sc config "WinRM" start= disabled >nul 2>&1

:: Winmgmt — WMI. ⚠️ Многие приложения зависят.
sc config "Winmgmt" start= disabled >nul 2>&1

:: WlanSvc — WLAN AutoConfig (Wi-Fi).
sc config "WlanSvc" start= disabled >nul 2>&1

:: WpcMonSvc — родительский контроль.
sc config "WpcMonSvc" start= disabled >nul 2>&1

:: WpnService — системные push-уведомления.
sc config "WpnService" start= disabled >nul 2>&1

:: WpnUserService — пользовательские push-уведомления.
sc config "WpnUserService" start= disabled >nul 2>&1

:: WwanSvc — WWAN AutoConfig (мобильная сеть).
sc config "WwanSvc" start= disabled >nul 2>&1

:: XblAuthManager — аутентификация Xbox Live.
sc config "XblAuthManager" start= disabled >nul 2>&1

:: XblGameSave — сохранения Xbox Live.
sc config "XblGameSave" start= disabled >nul 2>&1

:: XboxGipSvc — аксессуары Xbox.
sc config "XboxGipSvc" start= disabled >nul 2>&1

:: XboxNetApiSvc — сеть Xbox Live.
sc config "XboxNetApiSvc" start= disabled >nul 2>&1

:: bthserv — поддержка Bluetooth.
sc config "bthserv" start= disabled >nul 2>&1

:: cbdhsvc — пользовательский буфер обмена.
sc config "cbdhsvc" start= disabled >nul 2>&1

:: diagnosticshub.standardcollector.service — сборщик диагностики.
sc config "diagnosticshub.standardcollector.service" start= disabled >nul 2>&1

:: diagsvc — хост диагностики.
sc config "diagsvc" start= disabled >nul 2>&1

:: dmwappushservice — маршрутизация WAP push.
sc config "dmwappushservice" start= disabled >nul 2>&1

:: embeddedmode — встраиваемый режим.
sc config "embeddedmode" start= disabled >nul 2>&1

:: fdPHost — хост обнаружения функций.
sc config "fdPHost" start= disabled >nul 2>&1

:: fhsvc — история файлов.
sc config "fhsvc" start= disabled >nul 2>&1

:: gpsvc — групповая политика.
sc config "gpsvc" start= disabled >nul 2>&1

:: hidserv — HID (горячие клавиши).
sc config "hidserv" start= disabled >nul 2>&1

:: iphlpsvc — IP Helper (IPv6, туннели).
sc config "iphlpsvc" start= disabled >nul 2>&1

:: lfsvc — геолокация.
sc config "lfsvc" start= disabled >nul 2>&1

:: lltdsvc — карта сети LLTD.
sc config "lltdsvc" start= disabled >nul 2>&1

:: lmhosts — помощник NetBIOS по TCP/IP.
sc config "lmhosts" start= disabled >nul 2>&1

:: mpssvc — брандмауэр Windows. ⚠️ Безопасность.
sc config "mpssvc" start= disabled >nul 2>&1

:: netprofm — сетевой профиль.
sc config "netprofm" start= disabled >nul 2>&1

:: nsi — интерфейс сетевого хранилища. ⚠️ Сеть.
sc config "nsi" start= disabled >nul 2>&1

:: p2pimsvc — P2P-группировка.
sc config "p2pimsvc" start= disabled >nul 2>&1

:: p2psvc — P2P-сеть.
sc config "p2psvc" start= disabled >nul 2>&1

:: perceptionsimulation — симуляция восприятия.
sc config "perceptionsimulation" start= disabled >nul 2>&1

:: pla — журналы и оповещения производительности.
sc config "pla" start= disabled >nul 2>&1

:: rdbss — драйвер редиректора сетевых мини-переадресаторов.
sc config "rdbss" start= disabled >nul 2>&1

:: seclogon — вторичный вход в систему.
sc config "seclogon" start= disabled >nul 2>&1

:: shpamsvc — диспетчер общих учётных записей ПК.
sc config "shpamsvc" start= disabled >nul 2>&1

:: smphost — хост поставщиков WMI.
sc config "smphost" start= disabled >nul 2>&1

:: spectrum — служба восприятия Windows.
sc config "spectrum" start= disabled >nul 2>&1

:: sppsvc — защита программного обеспечения. ⚠️ Активация.
sc config "sppsvc" start= disabled >nul 2>&1

:: stisvc — захват изображений (сканеры/камеры).
sc config "stisvc" start= disabled >nul 2>&1

:: svsvc — вспомогательная служба.
sc config "svsvc" start= disabled >nul 2>&1

:: swprv — поставщик теневых копий.
sc config "swprv" start= disabled >nul 2>&1

:: tzautoupdate — автообновление часового пояса.
sc config "tzautoupdate" start= disabled >nul 2>&1

:: upnphost — хост устройств UPnP.
sc config "upnphost" start= disabled >nul 2>&1

:: vds — служба виртуальных дисков.
sc config "vds" start= disabled >nul 2>&1

:: vmicguestinterface — интерфейс гостевых служб Hyper-V.
sc config "vmicguestinterface" start= disabled >nul 2>&1

:: vmicheartbeat — Heartbeat Hyper-V.
sc config "vmicheartbeat" start= disabled >nul 2>&1

:: vmickvpexchange — обмен данными Hyper-V.
sc config "vmickvpexchange" start= disabled >nul 2>&1

:: vmicrdv — удалённый рабочий стол Hyper-V.
sc config "vmicrdv" start= disabled >nul 2>&1

:: vmicshutdown — завершение работы гостя Hyper-V.
sc config "vmicshutdown" start= disabled >nul 2>&1

:: vmictimesync — синхронизация времени Hyper-V.
sc config "vmictimesync" start= disabled >nul 2>&1

:: vmicvmsession — PowerShell Direct Hyper-V.
sc config "vmicvmsession" start= disabled >nul 2>&1

:: vmicvss — теневые копии Hyper-V.
sc config "vmicvss" start= disabled >nul 2>&1

:: vwififlt — драйвер фильтра virtual Wi-Fi.
sc config "vwififlt" start= disabled >nul 2>&1

:: wbengine — резервное копирование на уровне блоков.
sc config "wbengine" start= disabled >nul 2>&1

:: wercplsupport — поддержка панели отчётов о проблемах.
sc config "wercplsupport" start= disabled >nul 2>&1

:: wisvc — Windows Insider.
sc config "wisvc" start= disabled >nul 2>&1

:: wlidsvc — помощник входа в учётную запись Microsoft.
sc config "wlidsvc" start= disabled >nul 2>&1

:: wlpasvc — локальный помощник по профилю.
sc config "wlpasvc" start= disabled >nul 2>&1

:: wmiApSrv — адаптер производительности WMI.
sc config "wmiApSrv" start= disabled >nul 2>&1

:: wscsvc — Центр безопасности Windows.
sc config "wscsvc" start= disabled >nul 2>&1

:: wuauserv — Центр обновления Windows.
sc config "wuauserv" start= disabled >nul 2>&1

:: ============================================================================
::                                 КОНЕЦ
:: ============================================================================
echo.
echo Готово. Отключено служб по ImmortalOS.
pause
exit /b 0