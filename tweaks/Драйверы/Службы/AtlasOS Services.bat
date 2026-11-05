@echo off
chcp 65001 >nul

:: Отключить службу шлюза прикладного уровня
:: ALG (Application Layer Gateway Service) — поддержка сторонних плагинов
:: протоколов для общего доступа к интернет-соединению.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ALG" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: Отключить службу идентификации приложений
:: AppIDSvc (Application Identity) — определяет и проверяет идентичность
:: приложений. При отключении AppLocker не сможет применяться.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AppIDSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: Отключить службу информации о приложениях
:: Appinfo (Application Information) — упрощает запуск интерактивных приложений
:: с повышенными привилегиями.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Appinfo" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: Отключить службу управления приложениями
:: AppMgmt (Application Management) — обрабатывает запросы на установку и удаление
:: программ через групповую политику.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AppMgmt" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: Отключить службу готовности приложений
:: AppReadiness (App Readiness) — подготавливает приложения к работе при первом
:: входе пользователя и при добавлении новых приложений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AppReadiness" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: AppVClient (Microsoft App-V Client) — клиент виртуализации приложений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AppVClient" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: AppvStrm (App-V Streaming) — потоковая передача виртуализированных приложений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AppvStrm" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: AppvVemgr (App-V Management) — управление виртуализированными приложениями.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AppvVemgr" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: AppvVfs (App-V File System) — файловая система виртуализации приложений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AppvVfs" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: AssignedAccessManagerSvc — режим назначенного доступа / киоск.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AssignedAccessManagerSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: BcastDVRUserService — запись игр и трансляции Xbox Game DVR.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BcastDVRUserService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: BcastDVRUserService_310f2 — экземпляр службы Game DVR.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BcastDVRUserService_310f2" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: BTAGService (Bluetooth Audio Gateway Service) — аудиошлюз Bluetooth.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BTAGService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: BthAvctpSvc (Bluetooth AVCTP Service) — управление аудио/видео по Bluetooth.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BthAvctpSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: bthserv (Bluetooth Support Service) — поддержка Bluetooth-устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\bthserv" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: CDD (Cloud Desktop Display) — отображение облачного рабочего стола.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\CDD" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: CloudBackupRestoreSvc — облачное резервное копирование и восстановление.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\CloudBackupRestoreSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: CloudBackupRestoreSvc_310f2 — экземпляр службы облачного backup.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\CloudBackupRestoreSvc_310f2" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: cloudidsvc (Microsoft Cloud Identity Service) — облачная идентификация.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\cloudidsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: cnghwassist — помощник сетевого оборудования.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\cnghwassist" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: DiagTrack (Connected User Experiences and Telemetry) — телеметрия.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: DialogBlockingService — блокировка диалоговых окон.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DialogBlockingService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: DmEnrollmentSvc (Device Management Enrollment Service) — регистрация в MDM.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DmEnrollmentSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: dmwappushservice (WAP Push Message Routing) — маршрутизация WAP-сообщений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: edgeupdatem (Microsoft Edge Update Service) — обновление Edge.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\edgeupdatem" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: fdPHost (Function Discovery Provider Host) — обнаружение устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\fdPHost" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: FDResPub (Function Discovery Resource Publication) — публикация ресурсов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\FDResPub" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: GameInputSvc — игровой ввод.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GameInputSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: hpatchmon — мониторинг исправлений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\hpatchmon" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: InstallService (Microsoft Store Install Service) — установка из Store.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\InstallService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: LicenseManager — лицензирование Store/приложений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LicenseManager" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: lfsvc (Geolocation Service) — геолокация.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: MapsBroker (Downloaded Maps Manager) — менеджер загруженных карт.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: McpManagementService — управление защитой Microsoft.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\McpManagementService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: MessagingService — обмен сообщениями.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MessagingService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: MessagingService_310f2 — экземпляр службы обмена сообщениями.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MessagingService_310f2" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: midisrv — MIDI-служба.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\midisrv" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: MsKeyboardFilter — фильтр клавиатуры.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MsKeyboardFilter" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: MsSecFlt — фильтр безопасности Microsoft.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MsSecFlt" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: NcaSvc (Network Connectivity Assistant) — помощник подключения к сети.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NcaSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: NcbService (Network Connection Broker) — брокер сетевых подключений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NcbService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: NcdAutoSetup (Network Connected Devices Auto-Setup) — автонастройка сетевых устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NcdAutoSetup" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: NetTcpPortSharing (Net.Tcp Port Sharing Service) — общий доступ к TCP-портам.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NetTcpPortSharing" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: OneSyncSvc — синхронизация почты/контактов/календаря.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: PcaSvc (Program Compatibility Assistant) — помощник совместимости программ.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PcaSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: PeerDistSvc (BranchCache) — кэширование BranchCache.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PeerDistSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: PhoneSvc (Phone Service) — телефонная служба.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PhoneSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: PimIndexMaintenanceSvc — обслуживание индекса контактов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PimIndexMaintenanceSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: PushToInstall (Windows Push To Install Service) — удалённая установка приложений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PushToInstall" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: RemoteAccess (Routing and Remote Access) — маршрутизация и удалённый доступ.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RemoteAccess" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: RemoteRegistry — удалённый реестр.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RemoteRegistry" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: RetailDemo (Retail Demo Service) — демонстрационный режим магазина.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RetailDemo" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: SEMgrSvc (Payments and NFC/SE Manager) — платежи и NFC.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SEMgrSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: SensorDataService — служба данных датчиков.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SensorDataService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: SensorService — служба датчиков.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SensorService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: SensrSvc (Sensor Monitoring Service) — мониторинг датчиков.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SensrSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: shpamsvc (Shared PC Account Manager) — управление общими ПК.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\shpamsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: SmsRouter (Microsoft Windows SMS Router Service) — маршрутизация SMS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SmsRouter" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: SNMPTrap — приём SNMP-ловушек.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SNMPTrap" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: ssh-agent (OpenSSH Authentication Agent) — агент SSH-ключей.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ssh-agent" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: StiSvc (Windows Image Acquisition) — получение изображений со сканеров/камер.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\StiSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: TieringEngineService — управление уровнями хранения.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TieringEngineService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: TrkWks (Distributed Link Tracking Client) — отслеживание связей NTFS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TrkWks" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: tzautoupdate (Auto Time Zone Updater) — автообновление часового пояса.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\tzautoupdate" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: UCPD (User Choice Protection Driver) — защита пользовательского выбора ассоциаций.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UCPD" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: UevAgentDriver (User Experience Virtualization Agent Driver) — драйвер UE-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UevAgentDriver" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: UevAgentService (User Experience Virtualization Service) — служба UE-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UevAgentService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: WaaSMedicSvc (Windows Update Medic Service) — восстановление компонентов обновления.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: WalletService — служба кошелька.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WalletService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: WbioSrvc (Windows Biometric Service) — биометрия.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WbioSrvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: wcncsvc (Windows Connect Now) — настройка беспроводных устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wcncsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: WebClient (WebClient) — WebDAV-клиент.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WebClient" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: WEPHOSTSVC (Windows Encryption Provider Host Service) — хост-провайдеры шифрования.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WEPHOSTSVC" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: wercplsupport — поддержка отчётов об ошибках панели управления.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wercplsupport" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: WerSvc (Windows Error Reporting Service) — отчёты об ошибках.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WerSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: WFDSConMgrSvc (Wi-Fi Direct Services Connection Manager) — Wi-Fi Direct.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WFDSConMgrSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: WiaRpc — удалённый вызов WIA.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WiaRpc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: WMPNetworkSvc (Windows Media Player Network Sharing Service) — общий доступ к медиа.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WMPNetworkSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: workfolderssvc (Work Folders) — рабочие папки.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\workfolderssvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: WpcMonSvc (Parental Controls) — родительский контроль.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WpcMonSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: WPDBusEnum — перечисление портативных устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WPDBusEnum" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: WpnService (Windows Push Notifications System Service) — push-уведомления.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WpnService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: WpnUserService — пользовательская служба push-уведомлений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WpnUserService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: ws2ifsl — Winsock IFS-провайдер.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ws2ifsl" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: XblAuthManager (Xbox Live Auth Manager) — авторизация Xbox Live.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\XblAuthManager" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: XblGameSave (Xbox Live Game Save) — сохранения Xbox Live.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\XblGameSave" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: XboxGipSvc — служба Xbox Game Input Protocol.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\XboxGipSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: XboxNetApiSvc (Xbox Live Networking Service) — сеть Xbox Live.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\XboxNetApiSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: ZTDNS — DNS-компонент Zero Trust.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ZTDNS" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: ZTHELPER — вспомогательный компонент Zero Trust.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ZTHELPER" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
