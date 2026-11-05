@echo off
chcp 65001 >nul

:: Отключить службу 3ware
:: 3ware (3ware Disk Controller) — драйвер RAID-контроллера 3ware.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\3ware" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу агента регистрации AarSvc
:: AarSvc (Agent Activation Runtime) — среда активации агентов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AarSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить экземпляр службы агента регистрации AarSvc_234b2
:: AarSvc_234b2 — пользовательский экземпляр службы AarSvc.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AarSvc_234b2" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу расширений ACPI
:: acpiex (Microsoft ACPIEx Driver) — расширения ACPI.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\acpiex" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу ACPI-процессора
:: acpipagr (ACPI Processor Aggregator Driver) — агрегатор ACPI-процессора.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\acpipagr" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу ACPI PMI
:: AcpiPmi (ACPI Power Meter Interface) — интерфейс измерения питания ACPI.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AcpiPmi" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу ACPI Time
:: acpitime (ACPI Time Driver) — драйвер времени ACPI.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\acpitime" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу маршрутизатора AJRouter
:: AJRouter (AllJoyn Router Service) — маршрутизатор AllJoyn.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AJRouter" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу идентификации приложений
:: AppIDSvc (Application Identity) — определяет и проверяет идентичность приложений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AppIDSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить клиент App-V
:: AppVClient (Microsoft App-V Client) — клиент виртуализации приложений App-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AppVClient" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу arcsas
:: arcsas (ARC SCSI RAID Driver) — драйвер RAID-контроллера.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\arcsas" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу автонастройки времени
:: autotimesvc (Auto Time Service) — автоматическая установка времени.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\autotimesvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу установки ActiveX
:: AxInstSV (ActiveX Installer) — установка элементов ActiveX.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AxInstSV" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу bam
:: bam (Background Activity Moderator Driver) — управление фоновой активностью.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\bam" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Beep
:: Beep (Beep Driver) — драйвер звукового сигнала.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Beep" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу пользователя Bluetooth
:: BluetoothUserService (Bluetooth User Service) — пользовательские операции Bluetooth.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BluetoothUserService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить экземпляр службы пользователя Bluetooth
:: BluetoothUserService_234b2 — пользовательский экземпляр службы Bluetooth.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BluetoothUserService_234b2" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу обозревателя
:: bowser (Computer Browser) — обзор сети.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\bowser" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу BTAGService
:: BTAGService (Bluetooth Audio Gateway Service) — шлюз Bluetooth-аудио.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BTAGService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу BthA2dp
:: BthA2dp (Bluetooth A2DP) — профиль Bluetooth A2DP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BthA2dp" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу BthA4dp
:: BthA4dp (Bluetooth A4DP) — профиль Bluetooth A4DP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BthA4dp" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу BthAvctpSvc
:: BthAvctpSvc (Bluetooth AVCTP Service) — транспорт AVCTP Bluetooth.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BthAvctpSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу BthEnum
:: BthEnum (Bluetooth Enumerator) — перечислитель Bluetooth.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BthEnum" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу BthHFEnum
:: BthHFEnum (Bluetooth Hands-Free Enumerator) — перечислитель Bluetooth hands-free.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BthHFEnum" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу BthLEEnum
:: BthLEEnum (Bluetooth Low Energy Enumerator) — перечислитель Bluetooth LE.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BthLEEnum" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу BthMini
:: BthMini (Bluetooth Mini Driver) — мини-драйвер Bluetooth.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BthMini" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу BTHMODEM
:: BTHMODEM (Bluetooth Modem) — Bluetooth-модем.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BTHMODEM" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу BTHPORT
:: BTHPORT (Bluetooth Port Driver) — драйвер порта Bluetooth.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BTHPORT" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу поддержки Bluetooth
:: bthserv (Bluetooth Support Service) — поддержка Bluetooth.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\bthserv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу BTHUSB
:: BTHUSB (Bluetooth USB Driver) — драйвер Bluetooth USB.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BTHUSB" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу bttflt
:: bttflt (Bluetooth Filter Driver) — фильтр Bluetooth.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\bttflt" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу buttonconverter
:: buttonconverter (Button Converter Driver) — преобразователь кнопок.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\buttonconverter" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу cbdhsvc
:: cbdhsvc (Clipboard User Service) — пользовательская служба буфера обмена.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\cbdhsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить экземпляр службы cbdhsvc_234b2
:: cbdhsvc_234b2 — пользовательский экземпляр службы буфера обмена.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\cbdhsvc_234b2" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу cdfs
:: cdfs (CD/DVD File System Driver) — файловая система CD/DVD.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\cdfs" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу cdrom
:: cdrom (CD-ROM Driver) — драйвер CD-ROM.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\cdrom" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу circlass
:: circlass (Consumer IR Devices) — инфракрасные потребительские устройства.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\circlass" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу CldFlt
:: CldFlt (Cloud Files Filter Driver) — фильтр облачных файлов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\CldFlt" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу cloudidsvc
:: cloudidsvc (Microsoft Cloud Identity Service) — облачная идентификация.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\cloudidsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу cnghwassist
:: cnghwassist (CNG Hardware Assist) — аппаратное ускорение CNG.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\cnghwassist" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу CompositeBus
:: CompositeBus (Composite Bus Enumerator) — составная шина.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\CompositeBus" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу dam
:: dam (Desktop Activity Moderator) — модератор активности рабочего стола.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dam" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу defragsvc
:: defragsvc (Optimize drives) — оптимизация дисков.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\defragsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Dfsc
:: Dfsc (DFS Client) — клиент распределённой файловой системы.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Dfsc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу diagnosticshub.standardcollector.service
:: diagnosticshub.standardcollector.service — стандартный сборщик диагностики.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу diagsvc
:: diagsvc (Diagnostic Service Host) — хост диагностических служб.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\diagsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу DiagTrack
:: DiagTrack (Connected User Experiences and Telemetry) — телеметрия и пользовательские данные.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу DialogBlockingService
:: DialogBlockingService — блокировка диалоговых окон.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DialogBlockingService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу DispBrokerDesktopSvc
:: DispBrokerDesktopSvc (Display Broker Desktop Service) — брокер отображения.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DispBrokerDesktopSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу DisplayEnhancementService
:: DisplayEnhancementService — улучшение отображения.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DisplayEnhancementService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу dmwappushservice
:: dmwappushservice (Device Management WAP Push Service) — WAP Push для управления устройствами.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу DPS
:: DPS (Diagnostic Policy Service) — политика диагностики.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DPS" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу DsmSvc
:: DsmSvc (Device Setup Manager) — управление установкой устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DsmSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу DsSvc
:: DsSvc (Data Sharing Service) — общий доступ к данным.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DsSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу DusmSvc
:: DusmSvc (Data Usage Service) — учёт использования данных.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DusmSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу EapHost
:: EapHost (Extensible Authentication Protocol) — расширяемая проверка подлинности.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\EapHost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу edgeupdate
:: edgeupdate (Microsoft Edge Update Service) — обновление Microsoft Edge.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\edgeupdate" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу edgeupdatem
:: edgeupdatem (Microsoft Edge Update Service) — фоновое обновление Edge.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\edgeupdatem" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу EhStorClass
:: EhStorClass (Enhanced Storage Class Driver) — класс расширенного хранилища.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\EhStorClass" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу EhStorTcgDrv
:: EhStorTcgDrv (Enhanced Storage TCG Driver) — драйвер TCG расширенного хранилища.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\EhStorTcgDrv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу embeddedmode
:: embeddedmode (Embedded Mode) — режим встроенной системы.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\embeddedmode" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу ErrDev
:: ErrDev (Error Device Driver) — драйвер устройства ошибок.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ErrDev" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу EventSystem
:: EventSystem (COM+ Event System) — система событий COM+.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\EventSystem" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу fdc
:: fdc (Floppy Disk Controller Driver) — контроллер гибких дисков.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\fdc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Filetrace
:: Filetrace (File Trace Filter Driver) — фильтр трассировки файлов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Filetrace" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу flpydisk
:: flpydisk (Floppy Disk Driver) — драйвер гибких дисков.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\flpydisk" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу FontCache
:: FontCache (Windows Font Cache Service) — кэш шрифтов Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\FontCache" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу FontCache3.0.0.0
:: FontCache3.0.0.0 (Windows Presentation Foundation Font Cache) — кэш шрифтов WPF.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\FontCache3.0.0.0" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу fvevol
:: fvevol (BitLocker Drive Encryption Filter Driver) — фильтр BitLocker.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\fvevol" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу gencounter
:: gencounter (Generic Counter Driver) — универсальный драйвер счётчиков.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\gencounter" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу GpuEnergyDrv
:: GpuEnergyDrv (GPU Energy Driver) — энергопотребление GPU.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу GraphicsPerfSvc
:: GraphicsPerfSvc (Graphics Performance Service) — производительность графики.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GraphicsPerfSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу HidBth
:: HidBth (Bluetooth HID Driver) — HID-драйвер Bluetooth.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\HidBth" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу hvcrash
:: hvcrash (Hyper-V Crash Dump Driver) — дампы Hyper-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\hvcrash" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу HvHost
:: HvHost (Hyper-V Host Service) — хост Hyper-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\HvHost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу hvservice
:: hvservice (Hyper-V Service) — служба Hyper-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\hvservice" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу hyperkbd
:: hyperkbd (Hyper-V Keyboard Driver) — клавиатура Hyper-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\hyperkbd" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу HyperVideo
:: HyperVideo (Hyper-V Video Driver) — видео Hyper-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\HyperVideo" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу icssvc
:: icssvc (Windows Mobile Hotspot Service) — мобильная точка доступа.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\icssvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу IKEEXT
:: IKEEXT (IKE and AuthIP IPsec Keying Modules) — модули ключей IPsec.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\IKEEXT" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу iphlpsvc
:: iphlpsvc (IP Helper) — помощник IP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\iphlpsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу IpxlatCfgSvc
:: IpxlatCfgSvc (IP Translation Configuration Service) — настройка трансляции IP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\IpxlatCfgSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу KtmRm
:: KtmRm (KtmRm for Distributed Transaction Coordinator) — координатор транзакций.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\KtmRm" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу LanmanServer
:: LanmanServer (Server) — сервер SMB.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу LanmanWorkstation
:: LanmanWorkstation (Workstation) — рабочая станция SMB.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу lfsvc
:: lfsvc (Geolocation Service) — геолокация.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу lltdio
:: lltdio (Link-Layer Topology Discovery Mapper I/O Driver) — обнаружение топологии.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\lltdio" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу lmhosts
:: lmhosts (TCP/IP NetBIOS Helper) — помощник NetBIOS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\lmhosts" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу luafv
:: luafv (LUA File Virtualization Filter Driver) — виртуализация файлов UAC.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\luafv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу MapsBroker
:: MapsBroker (Downloaded Maps Manager) — менеджер загруженных карт.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу MessagingService
:: MessagingService (Messaging Service) — служба обмена сообщениями.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MessagingService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить экземпляр службы MessagingService_234b2
:: MessagingService_234b2 — пользовательский экземпляр службы обмена сообщениями.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MessagingService_234b2" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить экземпляр службы MessagingService_4bef7
:: MessagingService_4bef7 — пользовательский экземпляр службы обмена сообщениями.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MessagingService_4bef7" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу MicrosoftEdgeElevationService
:: MicrosoftEdgeElevationService — повышение прав Microsoft Edge.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MicrosoftEdgeElevationService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Microsoft_Bluetooth_AvrcpTransport
:: Microsoft_Bluetooth_AvrcpTransport — транспорт Bluetooth AVRCP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Microsoft_Bluetooth_AvrcpTransport" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу MixedRealityOpenXRSvc
:: MixedRealityOpenXRSvc (Windows Mixed Reality OpenXR Service) — OpenXR Mixed Reality.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MixedRealityOpenXRSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу mrxsmb
:: mrxsmb (SMB MiniRedirector) — мини-редиректор SMB.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу mrxsmb20
:: mrxsmb20 (SMB 2.0 MiniRedirector) — мини-редиректор SMB 2.0.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb20" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу MSDTC
:: MSDTC (Distributed Transaction Coordinator) — координатор распределённых транзакций.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MSDTC" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу MSiSCSI
:: MSiSCSI (Microsoft iSCSI Initiator Service) — инициатор iSCSI.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MSiSCSI" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу MsKeyboardFilter
:: MsKeyboardFilter (Microsoft Keyboard Filter) — фильтр клавиатуры.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MsKeyboardFilter" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу MsLldp
:: MsLldp (Microsoft LLDP Protocol Driver) — протокол LLDP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MsLldp" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу MsSecCore
:: MsSecCore (Microsoft Security Core) — ядро безопасности Microsoft.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MsSecCore" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу MsSecFlt
:: MsSecFlt (Microsoft Security Filter) — фильтр безопасности Microsoft.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MsSecFlt" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу MsSecWfp
:: MsSecWfp (Microsoft Security WFP) — WFP-безопасность Microsoft.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MsSecWfp" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу NdisCap
:: NdisCap (NDIS Capture) — захват NDIS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NdisCap" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу NdisVirtualBus
:: NdisVirtualBus (NDIS Virtual Bus) — виртуальная шина NDIS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NdisVirtualBus" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Ndu
:: Ndu (Network Data Usage Monitoring Driver) — мониторинг использования сети.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Ndu" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу NetBIOS
:: NetBIOS (NetBIOS Interface) — интерфейс NetBIOS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NetBIOS" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу NetBT
:: NetBT (NetBIOS over TCP/IP) — NetBIOS поверх TCP/IP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NetBT" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу NetTcpPortSharing
:: NetTcpPortSharing (Net.Tcp Port Sharing Service) — общий доступ к портам Net.Tcp.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NetTcpPortSharing" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу OneSyncSvc
:: OneSyncSvc (Sync Host) — синхронизация.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить экземпляр службы OneSyncSvc_234b2
:: OneSyncSvc_234b2 — пользовательский экземпляр службы синхронизации.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc_234b2" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу p2pimsvc
:: p2pimsvc (Peer Networking Identity Manager) — менеджер идентификации одноранговой сети.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\p2pimsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу p2psvc
:: p2psvc (Peer Networking Grouping) — группировка одноранговой сети.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\p2psvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу P9RdrService
:: P9RdrService (Plan 9 Redirector Service) — служба редиректора Plan 9.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\P9RdrService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить экземпляр службы P9RdrService_234b2
:: P9RdrService_234b2 — пользовательский экземпляр службы Plan 9.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\P9RdrService_234b2" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу PcaSvc
:: PcaSvc (Program Compatibility Assistant Service) — помощник совместимости программ.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PcaSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу PEAUTH
:: PEAUTH (PE Authentication) — проверка подлинности PE.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PEAUTH" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу PeerDistSvc
:: PeerDistSvc (BranchCache) — BranchCache.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PeerDistSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу PenService
:: PenService (Pen Service) — служба пера.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PenService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить экземпляр службы PenService_234b2
:: PenService_234b2 — пользовательский экземпляр службы пера.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PenService_234b2" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу perceptionsimulation
:: perceptionsimulation (Perception Simulation Driver) — симуляция восприятия.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\perceptionsimulation" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу PhoneSvc
:: PhoneSvc (Phone Service) — телефонная служба.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PhoneSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу PimIndexMaintenanceSvc
:: PimIndexMaintenanceSvc (Contact Data) — обслуживание индекса контактов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PimIndexMaintenanceSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить экземпляр службы PimIndexMaintenanceSvc_234b2
:: PimIndexMaintenanceSvc_234b2 — пользовательский экземпляр обслуживания контактов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PimIndexMaintenanceSvc_234b2" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить экземпляр службы PimIndexMaintenanceSvc_4bef7
:: PimIndexMaintenanceSvc_4bef7 — пользовательский экземпляр обслуживания контактов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PimIndexMaintenanceSvc_4bef7" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу PNRPsvc
:: PNRPsvc (Peer Name Resolution Protocol) — протокол разрешения имён одноранговой сети.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PNRPsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу PrintWorkflowUserSvc
:: PrintWorkflowUserSvc (PrintWorkflow) — пользовательский рабочий процесс печати.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PrintWorkflowUserSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить экземпляр службы PrintWorkflowUserSvc_234b2
:: PrintWorkflowUserSvc_234b2 — пользовательский экземпляр рабочего процесса печати.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PrintWorkflowUserSvc_234b2" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу QWAVE
:: QWAVE (Quality Windows Audio Video Experience) — качество аудио и видео.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\QWAVE" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу QWAVEdrv
:: QWAVEdrv (QWAVE Driver) — драйвер QWAVE.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\QWAVEdrv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу RasAcd
:: RasAcd (Remote Access Auto Connection Driver) — драйвер автоматического подключения.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RasAcd" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу RasAuto
:: RasAuto (Remote Access Auto Connection Manager) — менеджер автоматического подключения.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RasAuto" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу RasMan
:: RasMan (Remote Access Connection Manager) — менеджер удалённых подключений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RasMan" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу rdpbus
:: rdpbus (Remote Desktop Device Redirector Bus) — шина перенаправления RDP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\rdpbus" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу RDPDR
:: RDPDR (Remote Desktop Device Redirector) — перенаправление устройств RDP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RDPDR" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу RdpVideoMiniport
:: RdpVideoMiniport (Remote Desktop Video Miniport) — видео-минипорт RDP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RdpVideoMiniport" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу rdyboost
:: rdyboost (ReadyBoost) — ReadyBoost.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\rdyboost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу RemoteAccess
:: RemoteAccess (Routing and Remote Access) — маршрутизация и удалённый доступ.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RemoteAccess" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу RemoteRegistry
:: RemoteRegistry (Remote Registry) — удалённый реестр.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RemoteRegistry" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу RetailDemo
:: RetailDemo (Retail Demo Service) — демонстрационный режим.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RetailDemo" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу RFCOMM
:: RFCOMM (Bluetooth RFCOMM Driver) — драйвер RFCOMM Bluetooth.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RFCOMM" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу RmSvc
:: RmSvc (Radio Management Service) — управление радиомодулями.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RmSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу rspndr
:: rspndr (Link-Layer Topology Discovery Responder) — ответчик обнаружения топологии.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\rspndr" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SCardSvr
:: SCardSvr (Smart Card) — смарт-карты.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SCardSvr" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу ScDeviceEnum
:: ScDeviceEnum (Smart Card Device Enumeration Service) — перечисление смарт-карт.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ScDeviceEnum" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу scfilter
:: scfilter (Smart Card Filter Driver) — фильтр смарт-карт.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\scfilter" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SCPolicySvc
:: SCPolicySvc (Smart Card Removal Policy) — политика извлечения смарт-карты.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SCPolicySvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SecurityHealthService
:: SecurityHealthService (Windows Security Service) — безопасность Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SEMgrSvc
:: SEMgrSvc (Payments and NFC/SE Manager) — платежи и NFC.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SEMgrSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Sense
:: Sense (Windows Defender Advanced Threat Protection Service) — расширенная защита.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Sense" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SensorDataService
:: SensorDataService (Sensor Data Service) — данные датчиков.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SensorDataService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SensorService
:: SensorService (Sensor Service) — служба датчиков.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SensorService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SensrSvc
:: SensrSvc (Sensor Monitoring Service) — мониторинг датчиков.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SensrSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SessionEnv
:: SessionEnv (Remote Desktop Configuration) — настройка удалённого рабочего стола.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SessionEnv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу sfloppy
:: sfloppy (SFF Disk Driver) — драйвер SFF-диска.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\sfloppy" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SgrmBroker
:: SgrmBroker (System Guard Runtime Monitor Broker) — брокер System Guard.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SgrmBroker" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SharedAccess
:: SharedAccess (Internet Connection Sharing) — общий доступ к подключению.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SharedRealitySvc
:: SharedRealitySvc (Spatial Data Service) — пространственные данные.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SharedRealitySvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу ShellHWDetection
:: ShellHWDetection (Shell Hardware Detection) — обнаружение оборудования оболочкой.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ShellHWDetection" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу shpamsvc
:: shpamsvc (Shared PC Account Manager) — менеджер общих ПК.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\shpamsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SiSRaid2
:: SiSRaid2 (SiS RAID 2 Driver) — драйвер RAID SiS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SiSRaid2" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SiSRaid4
:: SiSRaid4 (SiS RAID 4 Driver) — драйвер RAID SiS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SiSRaid4" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SmsRouter
:: SmsRouter (Microsoft Windows SMS Router Service) — маршрутизатор SMS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SmsRouter" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу spaceport
:: spaceport (Storage Spaces Driver) — дисковые пространства.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\spaceport" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SpatialGraphFilter
:: SpatialGraphFilter (Spatial Graph Filter) — фильтр пространственного графа.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SpatialGraphFilter" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу spectrum
:: spectrum (Spectrum Driver) — драйвер spectrum.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\spectrum" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Spooler
:: Spooler (Print Spooler) — диспетчер печати.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Spooler" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу srv
:: srv (Server SMB 2.0 Driver) — драйвер сервера SMB.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\srv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SSDPSRV
:: SSDPSRV (SSDP Discovery) — обнаружение SSDP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SSDPSRV" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу ssh-agent
:: ssh-agent (OpenSSH Authentication Agent) — агент проверки подлинности OpenSSH.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ssh-agent" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SstpSvc
:: SstpSvc (Secure Socket Tunneling Protocol Service) — служба SSTP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SstpSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу storflt
:: storflt (Storage Filter Driver) — фильтр хранилища.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\storflt" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу storqosflt
:: storqosflt (Storage QoS Filter Driver) — QoS хранилища.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\storqosflt" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SysMain
:: SysMain (SysMain) — предзагрузка и оптимизация памяти.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SysMain" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу TapiSrv
:: TapiSrv (Telephony) — телефония.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TapiSrv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Tcpip6
:: Tcpip6 (Microsoft IPv6 Protocol Driver) — драйвер IPv6.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу tcpipreg
:: tcpipreg (TCP/IP Registry Compatibility) — совместимость реестра TCP/IP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\tcpipreg" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Telemetry
:: Telemetry (Telemetry) — телеметрия.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Telemetry" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу terminpt
:: terminpt (Remote Desktop Input Driver) — драйвер ввода удалённого рабочего стола.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\terminpt" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу TermService
:: TermService (Remote Desktop Services) — службы удалённых рабочих столов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TermService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Themes
:: Themes (Themes) — темы.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Themes" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу TrkWks
:: TrkWks (Distributed Link Tracking Client) — клиент отслеживания связей.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TrkWks" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу TroubleshootingSvc
:: TroubleshootingSvc (Recommended Troubleshooting Service) — рекомендуемое устранение неполадок.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TroubleshootingSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу TsUsbFlt
:: TsUsbFlt (Remote Desktop USB Hub Filter) — фильтр USB для RDP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TsUsbFlt" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу TsUsbGD
:: TsUsbGD (Remote Desktop Generic USB Device) — общее USB-устройство RDP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TsUsbGD" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу tsusbhub
:: tsusbhub (Remote Desktop USB Hub) — USB-концентратор RDP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\tsusbhub" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу tzautoupdate
:: tzautoupdate (Auto Time Zone Updater) — автообновление часового пояса.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\tzautoupdate" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу udfs
:: udfs (UDF File System Driver) — файловая система UDF.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\udfs" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу UevAgentDriver
:: UevAgentDriver (UE-V Agent Driver) — драйвер агента UE-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UevAgentDriver" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу UevAgentService
:: UevAgentService (User Experience Virtualization Service) — виртуализация пользовательского опыта.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UevAgentService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу umbus
:: umbus (User-Mode Bus Enumerator) — перечислитель пользовательской шины.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\umbus" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу UmRdpService
:: UmRdpService (Remote Desktop Services UserMode Port Redirector) — перенаправление портов RDP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UmRdpService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу UnistoreSvc
:: UnistoreSvc (User Data Storage) — хранилище пользовательских данных.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UnistoreSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить экземпляр службы UnistoreSvc_234b2
:: UnistoreSvc_234b2 — пользовательский экземпляр хранилища данных.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UnistoreSvc_234b2" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу UserDataSvc
:: UserDataSvc (User Data Access) — доступ к пользовательским данным.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UserDataSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить экземпляр службы UserDataSvc_234b2
:: UserDataSvc_234b2 — пользовательский экземпляр доступа к данным.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UserDataSvc_234b2" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить экземпляр службы UserDataSvc_4bef7
:: UserDataSvc_4bef7 — пользовательский экземпляр доступа к данным.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UserDataSvc_4bef7" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу UsoSvc
:: UsoSvc (Update Orchestrator Service) — оркестратор обновлений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу VacSvc
:: VacSvc (Volumetric Audio Compositor Service) — объёмное аудио.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\VacSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу VaultSvc
:: VaultSvc (Credential Manager) — диспетчер учётных данных.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\VaultSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу vdrvroot
:: vdrvroot (Virtual Drive Root Enumerator) — корневой перечислитель виртуальных дисков.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vdrvroot" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу VerifierExt
:: VerifierExt (Driver Verifier Extension) — расширение проверки драйверов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\VerifierExt" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Vid
:: Vid (Virtualization Infrastructure Driver) — драйвер инфраструктуры виртуализации.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Vid" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу vmgid
:: vmgid (Virtual Machine Guest Infrastructure Driver) — гостевая инфраструктура ВМ.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmgid" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу vmicguestinterface
:: vmicguestinterface (Hyper-V Guest Service Interface) — гостевой интерфейс Hyper-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmicguestinterface" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу vmicheartbeat
:: vmicheartbeat (Hyper-V Heartbeat Service) — пульс Hyper-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmicheartbeat" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу vmickvpexchange
:: vmickvpexchange (Hyper-V Data Exchange Service) — обмен данными Hyper-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmickvpexchange" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу vmicrdv
:: vmicrdv (Hyper-V Remote Desktop Virtualization Service) — виртуализация RDP Hyper-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmicrdv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу vmicshutdown
:: vmicshutdown (Hyper-V Guest Shutdown Service) — завершение работы гостя Hyper-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmicshutdown" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу vmictimesync
:: vmictimesync (Hyper-V Time Synchronization Service) — синхронизация времени Hyper-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmictimesync" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу vmicvmsession
:: vmicvmsession (Hyper-V PowerShell Direct Service) — PowerShell Direct Hyper-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmicvmsession" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу vmicvss
:: vmicvss (Hyper-V Volume Shadow Copy Requestor) — запросчик VSS Hyper-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmicvss" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу vpci
:: vpci (Virtual PCI Bus) — виртуальная шина PCI.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vpci" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу vsmraid
:: vsmraid (VSM RAID Driver) — драйвер RAID VSM.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vsmraid" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу VSS
:: VSS (Volume Shadow Copy) — теневое копирование томов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\VSS" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу VSTXRAID
:: VSTXRAID (VIA StorX RAID Driver) — драйвер RAID VIA StorX.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\VSTXRAID" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу W32Time
:: W32Time (Windows Time) — служба времени Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WaaSMedicSvc
:: WaaSMedicSvc (Windows Update Medic Service) — лечение Windows Update.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WalletService
:: WalletService (WalletService) — служба бумажника.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WalletService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WarpJITSvc
:: WarpJITSvc (Warp JIT Service) — JIT-служба Warp.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WarpJITSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу wbengine
:: wbengine (Block Level Backup Engine Service) — блочное резервное копирование.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wbengine" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WbioSrvc
:: WbioSrvc (Windows Biometric Service) — биометрия Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WbioSrvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу wcnfs
:: wcnfs (Windows Container Network File System) — сетевая ФС контейнеров.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wcnfs" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WdBoot
:: WdBoot (Windows Defender Boot Driver) — загрузочный драйвер Defender.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdBoot" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WdFilter
:: WdFilter (Windows Defender Mini-Filter Driver) — мини-фильтр Defender.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdFilter" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WdiServiceHost
:: WdiServiceHost (Diagnostic Service Host) — хост диагностических служб.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdiServiceHost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WdiSystemHost
:: WdiSystemHost (Diagnostic System Host) — системный хост диагностики.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdiSystemHost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WdNisDrv
:: WdNisDrv (Windows Defender Network Inspection System Driver) — драйвер сетевой проверки Defender.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdNisDrv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WdNisSvc
:: WdNisSvc (Microsoft Defender Network Inspection Service) — сетевая проверка Defender.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdNisSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Wecsvc
:: Wecsvc (Windows Event Collector) — сборщик событий Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Wecsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WEPHOSTSVC
:: WEPHOSTSVC (Windows Encryption Provider Host Service) — хост поставщиков шифрования.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WEPHOSTSVC" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу wercplsupport
:: wercplsupport (Problem Reports Control Panel Support) — поддержка отчётов о проблемах.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wercplsupport" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WerSvc
:: WerSvc (Windows Error Reporting Service) — отчёты об ошибках Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WerSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WinDefend
:: WinDefend (Microsoft Defender Antivirus Service) — антивирус Microsoft Defender.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WindowsTrustedRTProxy
:: WindowsTrustedRTProxy (Windows Trusted Runtime Proxy) — прокси доверенной среды.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WindowsTrustedRTProxy" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WinHttpAutoProxySvc
:: WinHttpAutoProxySvc (WinHTTP Web Proxy Auto-Discovery Service) — автообнаружение прокси.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WinHttpAutoProxySvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу wisvc
:: wisvc (Windows Insider Service) — служба Windows Insider.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wisvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WMPNetworkSvc
:: WMPNetworkSvc (Windows Media Player Network Sharing Service) — сетевой доступ WMP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WMPNetworkSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WpcMonSvc
:: WpcMonSvc (Parental Controls) — родительский контроль.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WpcMonSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WPDBusEnum
:: WPDBusEnum (Portable Device Enumerator Service) — перечисление портативных устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WPDBusEnum" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WpnService
:: WpnService (Windows Push Notifications System Service) — системные push-уведомления.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WpnService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу ws2ifsl
:: ws2ifsl (Winsock IFS Layer) — слой Winsock IFS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ws2ifsl" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WSearch
:: WSearch (Windows Search) — поиск Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WSearch" /v "Start" /t REG_DWORD /d "4" /f
