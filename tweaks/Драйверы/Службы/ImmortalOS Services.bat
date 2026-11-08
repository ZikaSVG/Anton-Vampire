@echo off
chcp 65001 >nul
:: ============================================================
::  Отключение служб (Start = 4) по списку из исходного файла
::  ВНИМАНИЕ: отдельные службы критичны для работы Windows!
::  Опасные помечены [!]. Рекомендуется проверять/тестировать
::  каждый блок отдельно и делать точку восстановления.
:: ============================================================

:: ============================================================
::  Пользовательские / редко используемые
:: ============================================================

:: Отключить клиент Microsoft App-V
:: AppVClient (Microsoft App-V Client) — управляет виртуализированными
:: приложениями App-V. На домашних ПК не используется.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AppVClient" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить драйвер модерации фоновой активности
:: bam (Background Activity Moderator Driver) — ограничивает фоновую
:: активность приложений для экономии ресурсов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\bam" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить драйвер системного динамика
:: Beep (Beep) — воспроизводит звуки через встроенный спикер.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Beep" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить пользовательскую службу Bluetooth
:: BluetoothUserService (Bluetooth User Support Service) — поддержка
:: Bluetooth-сценариев для текущего пользователя.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BluetoothUserService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить драйвер браузинга сети
:: bowser (Browser Support Driver) — устаревший протокол обзора сети
:: NetBIOS. Не нужен в современных сетях.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\bowser" /v "Start" /t REG_DWORD /d "4" /f

:: ============================================================
::  Bluetooth (если не используется — можно отключить всё разом)
:: ============================================================

:: BTAGService (Bluetooth Audio Gateway) — шлюз аудио для гарнитур.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BTAGService" /v "Start" /t REG_DWORD /d "4" /f

:: BthA2dp — профиль Advanced Audio Distribution (A2DP).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BthA2dp" /v "Start" /t REG_DWORD /d "4" /f

:: BthAvctpSvc — транспорт AVCTP для управления BT-аудио/видео.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BthAvctpSvc" /v "Start" /t REG_DWORD /d "4" /f

:: BthEnum — перечислитель Bluetooth-устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BthEnum" /v "Start" /t REG_DWORD /d "4" /f

:: BthHFEnum — перечислитель Bluetooth Hands-Free.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BthHFEnum" /v "Start" /t REG_DWORD /d "4" /f

:: BthLEEnum — перечислитель Bluetooth Low Energy.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BthLEEnum" /v "Start" /t REG_DWORD /d "4" /f

:: BTHMODEM — Bluetooth-модем.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BTHMODEM" /v "Start" /t REG_DWORD /d "4" /f

:: bthserv (Bluetooth Support Service) — обнаружение и подключение BT-устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\bthserv" /v "Start" /t REG_DWORD /d "4" /f

:: bttflt — фильтр-драйвер Bluetooth.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\bttflt" /v "Start" /t REG_DWORD /d "4" /f

:: Microsoft_Bluetooth_AvrcpTransport — AVRCP-транспорт.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Microsoft_Bluetooth_AvrcpTransport" /v "Start" /t REG_DWORD /d "4" /f

:: RFCOMM — Bluetooth RFCOMM (последовательный порт по BT).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RFCOMM" /v "Start" /t REG_DWORD /d "4" /f

:: ============================================================
::  Оптические приводы / файловые системы (если не нужны)
:: ============================================================

:: cdfs — файловая система CD/DVD.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\cdfs" /v "Start" /t REG_DWORD /d "4" /f

:: [!] cdrom — драйвер CD/DVD. Не отключайте, если есть оптический привод.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\cdrom" /v "Start" /t REG_DWORD /d "4" /f

:: udfs — файловая система UDF (DVD-RAM/BD). Отключение сломает чтение UDF-дисков.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\udfs" /v "Start" /t REG_DWORD /d "4" /f

:: ============================================================
::  Облако / телеметрия / диагностика
:: ============================================================

:: CldFlt (Cloud Files Filter) — фильтр облачных файлов OneDrive.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\CldFlt" /v "Start" /t REG_DWORD /d "4" /f

:: cnghwassist — аппаратное ускорение CNG (криптография). Можно отключить.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\cnghwassist" /v "Start" /t REG_DWORD /d "4" /f

:: [!] dcpsvc — Data Collection and Publishing Service (сбор данных).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dcpsvc" /v "Start" /t REG_DWORD /d "4" /f

:: diagnosticshub.standardcollector.service — стандартный сборщик диагностики.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /v "Start" /t REG_DWORD /d "4" /f

:: diagsvc (Diagnostic Execution Service) — выполнение сценариев диагностики.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\diagsvc" /v "Start" /t REG_DWORD /d "4" /f

:: DiagTrack (Connected User Experiences and Telemetry) — телеметрия.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f

:: DialogBlockingService — блокировка диалогов UAC-подобного типа.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DialogBlockingService" /v "Start" /t REG_DWORD /d "4" /f

:: DispBrokerDesktopSvc (Display Policy Service) — политики отображения.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DispBrokerDesktopSvc" /v "Start" /t REG_DWORD /d "4" /f

:: [!] dmwappushservice — WAP Push для MDM/управления устройствами.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f

:: [!] DPS (Diagnostic Policy Service) — политика диагностики. Ломает устранение неполадок.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DPS" /v "Start" /t REG_DWORD /d "4" /f

:: DsSvc (Data Sharing Service) — общий доступ к данным (Store-приложения).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DsSvc" /v "Start" /t REG_DWORD /d "4" /f

:: DusmSvc (Data Usage) — учёт трафика.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DusmSvc" /v "Start" /t REG_DWORD /d "4" /f

:: FontCache (Windows Font Cache Service) — кэш шрифтов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\FontCache" /v "Start" /t REG_DWORD /d "4" /f

:: FontCache3.0.0.0 (WPF Font Cache) — кэш шрифтов WPF.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\FontCache3.0.0.0" /v "Start" /t REG_DWORD /d "4" /f

:: gencounter — драйвер счётчиков производительности.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\gencounter" /v "Start" /t REG_DWORD /d "4" /f

:: GpuEnergyDrv — энергосбережение GPU.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f

:: Telemetry — служба телеметрии Windows (дубль DiagTrack).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Telemetry" /v "Start" /t REG_DWORD /d "4" /f

:: tzautoupdate (Auto Time Zone Updater) — авто-обновление часового пояса.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\tzautoupdate" /v "Start" /t REG_DWORD /d "4" /f

:: uhssvc (Microsoft Update Health Service) — проверка работоспособности обновлений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\uhssvc" /v "Start" /t REG_DWORD /d "4" /f

:: Wecsvc (Windows Event Collector) — приём событий от других систем.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Wecsvc" /v "Start" /t REG_DWORD /d "4" /f

:: WdiServiceHost / WdiSystemHost — хосты диагностики Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdiServiceHost" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdiSystemHost"   /v "Start" /t REG_DWORD /d "4" /f

:: ============================================================
::  Гипервизор / виртуализация (если Hyper-V не нужен)
:: ============================================================

:: hvcrash — дамп крэша гипервизора.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\hvcrash" /v "Start" /t REG_DWORD /d "4" /f

:: HvHost (HV Host Service) — гипервизор.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\HvHost" /v "Start" /t REG_DWORD /d "4" /f

:: hvservice — служба гипервизора.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\hvservice" /v "Start" /t REG_DWORD /d "4" /f

:: hyperkbd — клавиатура Hyper-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\hyperkbd" /v "Start" /t REG_DWORD /d "4" /f

:: hypervideo — видео Hyper-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\hypervideo" /v "Start" /t REG_DWORD /d "4" /f

:: vmgid (Hyper-V Guest Infrastructure Driver)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmgid" /v "Start" /t REG_DWORD /d "4" /f

:: vmicguestinterface (Hyper-V Guest Service Interface)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmicguestinterface" /v "Start" /t REG_DWORD /d "4" /f

:: vmicheartbeat (Hyper-V Heartbeat)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmicheartbeat" /v "Start" /t REG_DWORD /d "4" /f

:: vmickvpexchange (Hyper-V Data Exchange)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmickvpexchange" /v "Start" /t REG_DWORD /d "4" /f

:: vmicrdv (Hyper-V Remote Desktop Virtualization)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmicrdv" /v "Start" /t REG_DWORD /d "4" /f

:: vmicshutdown (Hyper-V Guest Shutdown)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmicshutdown" /v "Start" /t REG_DWORD /d "4" /f

:: vmictimesync (Hyper-V Time Synchronization)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmictimesync" /v "Start" /t REG_DWORD /d "4" /f

:: vmicvmsession (Hyper-V VM Session Service)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmicvmsession" /v "Start" /t REG_DWORD /d "4" /f

:: vmicvss (Hyper-V Volume Shadow Copy Requestor)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmicvss" /v "Start" /t REG_DWORD /d "4" /f

:: vpci (Virtual PCI) — виртуальные PCI-устройства для VM.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vpci" /v "Start" /t REG_DWORD /d "4" /f

:: ============================================================
::  Сеть / NetBIOS / WSD
:: ============================================================

:: [!] iphlpsvc (IP Helper) — туннели IPv6, Teredo, ISATAP, IP-HTTPS.
:: Отключение может сломать VPN и IPv6-связность.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\iphlpsvc" /v "Start" /t REG_DWORD /d "4" /f

:: lltdio (Link-Layer Topology Discovery Mapper I/O)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\lltdio" /v "Start" /t REG_DWORD /d "4" /f

:: rspndr (Link-Layer Topology Discovery Responder)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\rspndr" /v "Start" /t REG_DWORD /d "4" /f

:: lmhosts (TCP/IP NetBIOS Helper) — разрешение имён NetBIOS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\lmhosts" /v "Start" /t REG_DWORD /d "4" /f

:: [!] NetBIOS (NetBIOS Interface) — интерфейс NetBIOS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NetBIOS" /v "Start" /t REG_DWORD /d "4" /f

:: [!] NetBT (NetBIOS over TCP/IP) — NetBIOS поверх TCP/IP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NetBT" /v "Start" /t REG_DWORD /d "4" /f

:: NdisCap (NDIS Capture Lightweight Filter)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NdisCap" /v "Start" /t REG_DWORD /d "4" /f

:: NdisVirtualBus (NDIS Virtual Bus Driver)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NdisVirtualBus" /v "Start" /t REG_DWORD /d "4" /f

:: [!] NDU (Windows Network Data Usage Monitoring Driver)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NDU" /v "Start" /t REG_DWORD /d "4" /f

:: MsLldp — агент LLDP от Microsoft.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MsLldp" /v "Start" /t REG_DWORD /d "4" /f

:: NetMsmqActivator (Net.Msmq Listener Adapter)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NetMsmqActivator" /v "Start" /t REG_DWORD /d "4" /f

:: NetTcpPortSharing (Net.Tcp Port Sharing)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NetTcpPortSharing" /v "Start" /t REG_DWORD /d "4" /f

:: ws2ifsl (Winsock IFS Layered Service Provider)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ws2ifsl" /v "Start" /t REG_DWORD /d "4" /f

:: ============================================================
::  Устройства / радио / сенсоры
:: ============================================================

:: RmSvc (Radio Management Service) — управление Wi-Fi/Bluetooth-радио.
:: Отключать только если Wi-Fi/BT не используются вообще.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RmSvc" /v "Start" /t REG_DWORD /d "4" /f

:: SCardSvr (Smart Card) — поддержка смарт-карт.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SCardSvr" /v "Start" /t REG_DWORD /d "4" /f

:: ScDeviceEnum (Smart Card Device Enumeration Service)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ScDeviceEnum" /v "Start" /t REG_DWORD /d "4" /f

:: SCPolicySvc (Smart Card Removal Policy)
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SCPolicySvc" /v "Start" /t REG_DWORD /d "4" /f

:: SEMgrSvc (Payments and NFC/SE Manager) — платежи и NFC.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SEMgrSvc" /v "Start" /t REG_DWORD /d "4" /f

:: SensorDataService — служба данных датчиков.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SensorDataService" /v "Start" /t REG_DWORD /d "4" /f

:: SensrSvc (Sensor Service) — датчики (яркость, ориентация и т.п.).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SensrSvc" /v "Start" /t REG_DWORD /d "4" /f

:: [!] ShellHWDetection (Shell Hardware Detection) — автозапуск/обнаружение устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ShellHWDetection" /v "Start" /t REG_DWORD /d "4" /f

:: MsKeyboardFilter (Microsoft Keyboard Filter) — фильтр клавиатуры (Win10 IoT).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MsKeyboardFilter" /v "Start" /t REG_DWORD /d "4" /f

:: ============================================================
::  Печать / общий доступ
:: ============================================================

:: [!] LanmanServer (Server) — общий доступ к файлам и принтерам.
:: Отключение ломает SMB-шары.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer" /v "Start" /t REG_DWORD /d "4" /f

:: [!] Spooler (Print Spooler) — диспетчер печати.
:: Отключать только если принтеров нет — иначе печать не работает.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Spooler" /v "Start" /t REG_DWORD /d "4" /f

:: shpamsvc (Shared PC Account Manager) — режим общего ПК.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\shpamsvc" /v "Start" /t REG_DWORD /d "4" /f

:: ============================================================
::  Диски / кэш / SuperFetch
:: ============================================================

:: lfsvc (Geolocation Service) — определение местоположения.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v "Start" /t REG_DWORD /d "4" /f

:: [!] rdbss (Redirected Buffering Sub System) — клиент SMB-редиректора.
:: Отключение сломает сетевые диски и часть работы с шарами.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\rdbss" /v "Start" /t REG_DWORD /d "4" /f

:: rdyboost (ReadyBoost) — кэширование на флешках.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\rdyboost" /v "Start" /t REG_DWORD /d "4" /f

:: spaceport (Storage Spaces) — пулы хранения Storage Spaces.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\spaceport" /v "Start" /t REG_DWORD /d "4" /f

:: storflt — фильтр виртуальных дисков Storage Spaces.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\storflt" /v "Start" /t REG_DWORD /d "4" /f

:: storqosflt — фильтр Storage QoS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\storqosflt" /v "Start" /t REG_DWORD /d "4" /f

:: [!] SysMain (Superfetch) — предзагрузка часто используемых программ.
:: На SSD почти не нужна, на HDD отключение замедлит запуск.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SysMain" /v "Start" /t REG_DWORD /d "4" /f

:: [!] Themes — тема оформления. Отключение ломает Aero/визуальный стиль.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Themes" /v "Start" /t REG_DWORD /d "4" /f

:: TrkWks (Distributed Link Tracking Client) — отслеживание ярлыков NTFS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TrkWks" /v "Start" /t REG_DWORD /d "4" /f

:: ============================================================
::  Прочее
:: ============================================================

:: KSecPkg — пакет безопасности Kerberos.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\KSecPkg" /v "Start" /t REG_DWORD /d "4" /f

:: OneSyncSvc (Sync Host) — синхронизация почты/контактов/календаря.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc" /v "Start" /t REG_DWORD /d "4" /f

:: PcaSvc (Program Compatibility Assistant) — помощник совместимости.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PcaSvc" /v "Start" /t REG_DWORD /d "4" /f

:: VerifierExt (Driver Verifier Extension) — расширение верификатора драйверов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\VerifierExt" /v "Start" /t REG_DWORD /d "4" /f

:: W3SVC (World Wide Web Publishing Service, IIS) — веб-сервер IIS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\W3SVC" /v "Start" /t REG_DWORD /d "4" /f
