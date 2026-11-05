@Echo Off
SetLocal
Title Disable Services

Echo ============================================
Echo  Отключение служб (Start = 4, disabled)
Echo  Перезагрузка обязательна после применения.
Echo ============================================
Echo.

:: Отключить службу шлюза прикладного уровня
:: ALG (Application Layer Gateway Service) — поддержка сторонних плагинов
:: протоколов для общего доступа к интернет-соединению.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ALG" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу идентификации приложений
:: AppIDSvc (Application Identity) — определяет и проверяет идентичность
:: приложений. При отключении AppLocker не сможет применяться.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AppIDSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу информации о приложениях
:: Appinfo (Application Information) — упрощает запуск интерактивных приложений
:: с повышенными привилегиями.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Appinfo" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу управления приложениями
:: AppMgmt (Application Management) — обрабатывает запросы на установку и удаление
:: программ через групповую политику.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AppMgmt" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу готовности приложений
:: AppReadiness (App Readiness) — подготавливает приложения к работе при первом
:: входе пользователя и при добавлении новых приложений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AppReadiness" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу-брокера проверки подлинности
:: AuthBroker (AuthBroker) — брокер проверки подлинности Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AuthBroker" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу установки ActiveX
:: AxInstSV (ActiveX Installer) — установка элементов ActiveX из интернета.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AxInstSV" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу захвата игр
:: BcastDVRUserService — запись и трансляция игр (Game DVR).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BcastDVRUserService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу фоновой интеллектуальной передачи
:: BITS (Background Intelligent Transfer Service) — передача файлов в фоне.
:: Отключение ломает обновления Windows и Windows Update.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу поддержки Bluetooth
:: BTAGService (Bluetooth Audio Gateway) — шлюз аудио Bluetooth.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BTAGService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Bluetooth
:: bthserv (Bluetooth Support Service) — поддержка Bluetooth-устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\bthserv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу управления сертификатами
:: CertPropSvc (Certificate Propagation) — копирует сертификаты со смарт-карт.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\CertPropSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу COM+ System Application
:: COMSysApp — управление конфигурацией и отслеживанием компонентов COM+.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\COMSysApp" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу дефрагментации
:: defragsvc (Optimize drives) — оптимизация и дефрагментация дисков.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\defragsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу брокера ассоциации устройств
:: DeviceAssociationBrokerSvc — сопряжение и ассоциация устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DeviceAssociationBrokerSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу выбора устройств
:: DevicePickerUserSvc — интерфейс выбора устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DevicePickerUserSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу брокера запросов устройств
:: DevQueryBroker — фоновое обнаружение устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DevQueryBroker" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу центра диагностики
:: diagnosticshub.standardcollector.service — сбор диагностических данных.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу блокировки диалогов
:: DialogBlockingService — блокировка нежелательных диалогов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DialogBlockingService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу расширения отображения
:: DisplayEnhancementService — управление яркостью/цветом дисплея.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DisplayEnhancementService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу регистрации в MDM
:: DmEnrollmentSvc — регистрация устройства в MDM.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DmEnrollmentSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу оптимизации доставки
:: DoSvc (Delivery Optimization) — раздача обновлений по P2P.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу 802.1x
:: dot3svc (Wired AutoConfig) — автоматическая настройка проводных сетей 802.1x.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dot3svc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу политики диагностики
:: DPS (Diagnostic Policy Service) — обнаружение и устранение неполадок.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DPS" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу управления устройствами
:: DsmSvc (Device Setup Manager) — установка и настройка устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DsmSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу безопасности данных
:: DsSvc (Data Sharing Service) — обмен данными между приложениями.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DsSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу использования данных
:: DusmSvc (Data Usage) — учёт трафика по сетям.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DusmSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу расширяемой проверки подлинности
:: Eaphost (Extensible Authentication Protocol) — EAP-аутентификация.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Eaphost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу шифрованной файловой системы
:: EFS (Encrypting File System) — шифрование файлов EFS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\EFS" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу встраиваемого режима
:: embeddedmode (Embedded Mode) — режим встроенных систем.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\embeddedmode" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу приложений предприятия
:: EntAppSvc (Enterprise App Management) — управление корпоративными приложениями.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\EntAppSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу публикации обнаружения
:: fdPHost (Function Discovery Provider Host) — хост-процесс поставщиков FD.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\fdPHost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу ресурсов обнаружения
:: FDResPub (Function Discovery Resource Publication) — публикация ресурсов в сети.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\FDResPub" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу кэша шрифтов
:: FontCache (Windows Font Cache Service) — кэширование шрифтов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\FontCache" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу сервера кадров
:: FrameServer — сервер захвата медиапотоков (камера).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\FrameServer" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу зависимостей фильтрации
:: FsDepends (File System Dependency Minifilter) — зависимости ФС.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\FsDepends" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу групповой политики
:: gpsvc (Group Policy Client) — применение групповых политик.
:: Отключение ломает домен и политики.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\gpsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу драйвера энергосбережения GPU
:: GpuEnergyDrv (GPU Energy Driver) — энергосбережение GPU.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу производительности графики
:: GraphicsPerfSvc (Graphics Perf Monitor) — мониторинг графики.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GraphicsPerfSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу батареи HID
:: HidBatt (HID Battery) — батарея HID-устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\HidBatt" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу HID Bluetooth
:: HidBth (Bluetooth HID Driver) — HID через Bluetooth.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\HidBth" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу HID
:: hidserv (Human Interface Device Service) — доступ к HID-устройствам.
:: ВНИМАНИЕ: отключение лишает мышь/клавиатуру спец-функций (мультимедиа-клавиши).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\hidserv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу HTTP
:: HTTP (HTTP Service) — поддержка HTTP-API (WinRM, IIS и др.).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\HTTP" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу IKE и AuthIP
:: IKEEXT (IKE and AuthIP IPsec Keying Modules) — модули ключей IPsec.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\IKEEXT" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу установки
:: InstallService (Microsoft Store Install Service) — установка приложений из Store.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\InstallService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу трансляции IP
:: IPNAT (IP Translation) — NAT для ICS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\IPNAT" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу IP-помощи
:: iphlpsvc (IP Helper) — туннели IPv6 и IP-HTTPS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\iphlpsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу конфигурации IPx
:: IpxlatCfgSvc (IP Translation Configuration) — конфигурация трансляции IP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\IpxlatCfgSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу диспетчера транзакций ядра
:: KtmRm (KtmRm for Distributed Transaction Coordinator) — транзакции ядра.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\KtmRm" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу сервера SMB
:: LanmanServer (Server) — общий доступ к файлам/принтерам.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу рабочей станции SMB
:: LanmanWorkstation (Workstation) — доступ к сетевым ресурсам.
:: ВНИМАНИЕ: отключение ломает сетевые диски и SMB.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Location Framework
:: lfsvc (Geolocation Service) — определение местоположения.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу моста lltd
:: lltdsvc (Link-Layer Topology Discovery Mapper) — карта сети.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\lltdsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу диспетчера подключений
:: MapsBroker (Downloaded Maps Manager) — загрузка карт.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу McpManagementService
:: McpManagementService — управление мобильными устройствами.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\McpManagementService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу обмена сообщениями
:: MessagingService (MessagingService) — SMS/обмен сообщениями.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MessagingService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу DTC
:: MSDTC (Distributed Transaction Coordinator) — распределённые транзакции.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MSDTC" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу iSCSI
:: MSiSCSI (Microsoft iSCSI Initiator Service) — iSCSI-инициатор.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MSiSCSI" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу LLDP
:: MsLldp (Microsoft LLDP Protocol Driver) — LLDP-протокол.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MsLldp" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу естественной проверки подлинности
:: NaturalAuthentication (Natural Authentication) — аутентификация по присутствию.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NaturalAuthentication" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу помощника сетевого подключения
:: NcaSvc (Network Connectivity Assistant) — диагностика DirectAccess.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NcaSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу автоматической настройки сетевых устройств
:: NcdAutoSetup (Network Connected Devices Auto-Setup) — авто-настройка сетевых устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NcdAutoSetup" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Netlogon
:: Netlogon — аутентификация в домене.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Netlogon" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу общего доступа к портам TCP
:: NetTcpPortSharing (Net.Tcp Port Sharing) — общий доступ к портам WCF.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NetTcpPortSharing" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу контейнера NGC
:: NgcCtnrSvc (NGC Container Service) — контейнер ключей NGC.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NgcCtnrSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу NGC
:: NgcSvc (Microsoft Passport) — Windows Hello / PIN.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NgcSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу синхронизации OneSync
:: OneSyncSvc (Sync Host) — синхронизация почты/контактов/календаря.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу P2P-обмена
:: p2pimsvc (Peer Networking Identity Manager) — идентификация P2P.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\p2pimsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу P2P
:: p2psvc (Peer Networking Grouping) — группировка P2P.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\p2psvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу поддержки совместимости приложений
:: PcaSvc (Program Compatibility Assistant) — отслеживание совместимости программ.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PcaSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу PE auth
:: PEAUTH (PE Authentication) — проверка подлинности PE-образов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PEAUTH" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу имитации восприятия
:: perceptionsimulation (Perception Simulation Service) — симуляция сенсоров.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\perceptionsimulation" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу монитора производительности
:: PerfHost (Performance Counter DLL Host) — хост DLL счётчиков производительности.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PerfHost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу телефонии
:: PhoneSvc (Phone Service) — управление телефонией.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PhoneSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу обслуживания индексов PIM
:: PimIndexMaintenanceSvc (Contact Data) — индексация контактов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PimIndexMaintenanceSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу PktMon
:: PktMon (Packet Monitor) — мониторинг пакетов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PktMon" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу журналов производительности
:: pla (Performance Logs & Alerts) — сбор журналов производительности.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\pla" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу PNRP
:: PNRPAutoReg (PNRP Machine Name Publication Service) — публикация имён PNRP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PNRPAutoReg" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу PNRP
:: PNRPsvc (Peer Name Resolution Protocol) — разрешение имён P2P.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PNRPsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу уведомлений печати
:: PrintNotify (PrintNotify) — расширение печати для проводника.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PrintNotify" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу рабочего процесса печати
:: PrintWorkflowUserSvc (PrintWorkflow) — печать через UWP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PrintWorkflowUserSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу PushToInstall
:: PushToInstall (Push To Install Service) — удалённая установка приложений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PushToInstall" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу QWAVE
:: QWAVE (Quality Windows Audio Video Experience) — QoS для мультимедиа.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\QWAVE" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить драйвер QWAVE
:: QWAVEdrv (Quality Windows Audio Video Experience Driver) — драйвер QWAVE.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\QWAVEdrv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу RAS ACD
:: RasAcd (Remote Access Auto Connection Driver) — автоподключение удалённого доступа.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RasAcd" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Agile VPN
:: RasAgileVpn (Agile VPN) — VPN с IKEv2.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RasAgileVpn" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу автоматического подключения RAS
:: RasAuto (Remote Access Auto Connection Manager) — автоматическое создание подключений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RasAuto" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу L2TP
:: Rasl2tp (WAN Miniport L2TP) — VPN L2TP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Rasl2tp" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу PPPoE
:: RasPppoe (WAN Miniport PPPOE) — PPPoE-подключения.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RasPppoe" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SSTP
:: RasSstp (WAN Miniport SSTP) — VPN SSTP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RasSstp" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу RemoteAccess
:: RemoteAccess (Routing and Remote Access) — маршрутизация и удалённый доступ.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RemoteAccess" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу удалённого реестра
:: RemoteRegistry (Remote Registry) — удалённое редактирование реестра.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RemoteRegistry" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу RetailDemo
:: RetailDemo (Retail Demo Service) — демонстрационный режим в магазинах.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RetailDemo" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу RPC Locator
:: RpcLocator (Remote Procedure Call Locator) — устаревший локатор RPC.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RpcLocator" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу ответчика LLTD
:: rspndr (Link-Layer Topology Discovery Responder) — ответчик LLTD.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\rspndr" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу смарт-карт
:: SCardSvr (Smart Card) — поддержка смарт-карт.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SCardSvr" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу перечисления смарт-карт
:: ScDeviceEnum (Smart Card Device Enumeration Service) — перечисление смарт-карт.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ScDeviceEnum" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить фильтр смарт-карт
:: scfilter (Smart card filter driver) — фильтр смарт-карт.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\scfilter" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу управления сеансами смарт-карт
:: SCPolicySvc (Smart Card Removal Policy) — политика извлечения смарт-карт.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SCPolicySvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SDRSVC
:: SDRSVC (Windows Backup) — резервное копирование Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SDRSVC" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу вторичного входа
:: seclogon (Secondary Logon) — запуск от другого пользователя.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\seclogon" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу менеджера смарт-карт
:: SEMgrSvc (Payments and NFC/SE Manager) — платежи и NFC.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SEMgrSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу уведомлений о системных событиях
:: SENS (System Event Notification Service) — уведомления о событиях.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SENS" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу датчиков
:: SensorService (Sensor Service) — поддержка датчиков.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SensorService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SensrSvc
:: SensrSvc (Sensor Monitoring Service) — мониторинг датчиков.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SensrSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу удалённых рабочих столов
:: SessionEnv (Remote Desktop Configuration) — конфигурация RDP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SessionEnv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SharedRealitySvc
:: SharedRealitySvc (Spatial Data Service) — пространственные данные Mixed Reality.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SharedRealitySvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу обнаружения оборудования
:: ShellHWDetection (Shell Hardware Detection) — автозапуск и уведомления о оборудовании.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ShellHWDetection" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу shpamsvc
:: shpamsvc (Shared PC Account Manager) — управление общими ПК.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\shpamsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SMB Direct
:: smbdirect (SMBDirect) — RDMA для SMB.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\smbdirect" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу smphost
:: smphost (Microsoft Storage Spaces SMP) — провайдер SMP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\smphost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу маршрутизатора SMS
:: SmsRouter (Microsoft Windows SMS Router Service) — маршрутизация SMS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SmsRouter" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SNMP Trap
:: SNMPTRAP (SNMP Trap) — приём SNMP-ловушек.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SNMPTRAP" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу диспетчера очереди печати
:: Spooler (Print Spooler) — очередь печати.
:: ВНИМАНИЕ: отключение ломает печать.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Spooler" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SSDP
:: SSDPSRV (SSDP Discovery) — обнаружение UPnP-устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SSDPSRV" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SSTP
:: SstpSvc (Secure Socket Tunneling Protocol Service) — VPN SSTP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SstpSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WIA
:: stisvc (Windows Image Acquisition) — получение изображений со сканеров/камер.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\stisvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу StorSvc
:: StorSvc (Storage Service) — служба хранилища.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\StorSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу svsvc
:: svsvc (Spot Verifier) — проверка потенциальных повреждений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\svsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу ввода планшета
:: TabletInputService (Touch Keyboard and Handwriting Panel Service) — экранная клавиатура и рукописный ввод.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TabletInputService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу TAPI
:: TapiSrv (Telephony) — поддержка TAPI.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TapiSrv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу телеметрии
:: Telemetry (Connected User Experiences and Telemetry) — сбор телеметрии.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Telemetry" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу TermService
:: TermService (Remote Desktop Services) — службы удалённых рабочих столов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TermService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу TieringEngineService
:: TieringEngineService (Storage Tiers Management) — управление уровнями хранения.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TieringEngineService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу отслеживания ссылок
:: TrkWks (Distributed Link Tracking Client) — отслеживание ссылок NTFS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TrkWks" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу устранения неполадок
:: TroubleshootingSvc (Recommended Troubleshooting Service) — авто-устранение неполадок.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TroubleshootingSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу TsUsbFlt
:: TsUsbFlt (Remote Desktop USB Hub) — USB-перенаправление в RDP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TsUsbFlt" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу TsUsbGD
:: TsUsbGD (Remote Desktop Generic USB Device) — USB-устройства в RDP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TsUsbGD" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу автообновления часового пояса
:: tzautoupdate (Auto Time Zone Updater) — автоматическая смена часового пояса.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\tzautoupdate" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу UmRdpService
:: UmRdpService (Remote Desktop Services UserMode Port Redirector) — перенаправление портов RDP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UmRdpService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу upnphost
:: upnphost (UPnP Device Host) — хост UPnP-устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\upnphost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу данных пользователя
:: UserDataSvc (User Data Access) — доступ к данным пользователя.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UserDataSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу обновления Windows
:: UsoSvc (Update Orchestrator Service) — оркестратор обновлений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу VacSvc
:: VacSvc (Volumetric Audio Compositor) — объёмное аудио.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\VacSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу хранилища учётных данных
:: VaultSvc (Credential Manager) — диспетчер учётных данных.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\VaultSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу проверки драйверов
:: VerifierExt (Driver Verifier) — расширение проверки драйверов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\VerifierExt" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу виртуальных дисков
:: vhdmp (VHD MP) — поддержка виртуальных дисков VHD.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vhdmp" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу VacSvc
:: VirtualRender (Virtual Render) — виртуальный рендеринг.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\VirtualRender" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WaaSMedicSvc
:: WaaSMedicSvc (Windows Update Medic Service) — восстановление компонентов обновления.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WacomPen
:: WacomPen (Wacom Pen) — поддержка планшетов Wacom.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WacomPen" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WalletService
:: WalletService (WalletService) — кошелёк Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WalletService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WarpJITSvc
:: WarpJITSvc (Warp JIT Service) — JIT-компилятор Warp.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WarpJITSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу резервного копирования
:: wbengine (Block Level Backup Engine) — блочное резервное копирование.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wbengine" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу биометрии
:: WbioSrvc (Windows Biometric Service) — биометрическая аутентификация.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WbioSrvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу wcifs
:: wcifs (Windows Container Isolation) — изоляция контейнеров.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wcifs" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу wcncsvc
:: wcncsvc (Windows Connect Now) — настройка Wi-Fi через USB.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wcncsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу wcnfs
:: wcnfs (Windows Container Network Driver) — сетевой драйвер контейнеров.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wcnfs" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WdiServiceHost
:: WdiServiceHost (Diagnostic Service Host) — хост диагностических служб.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdiServiceHost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WdiSystemHost
:: WdiSystemHost (Diagnostic System Host) — системный хост диагностики.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdiSystemHost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить драйвер wdiwifi
:: wdiwifi (WDI Driver) — драйвер Wi-Fi.
:: ВНИМАНИЕ: отключение ломает Wi-Fi.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wdiwifi" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WdmCompanionFilter
:: WdmCompanionFilter (WDM Companion Filter) — сопутствующий фильтр WDM.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdmCompanionFilter" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WebClient
:: WebClient (WebClient) — доступ к WebDAV.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WebClient" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Wecsvc
:: Wecsvc (Windows Event Collector) — сбор событий.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Wecsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WEPHOSTSVC
:: WEPHOSTSVC (Windows Encryption Provider Host Service) — хост шифрования.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WEPHOSTSVC" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу wercplsupport
:: wercplsupport (Problem Reports Control Panel Support) — панель отчётов об ошибках.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wercplsupport" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WiaRpc
:: WiaRpc (WIA RPC) — RPC для WIA.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WiaRpc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WIMMount
:: WIMMount (WIM Mount) — монтирование WIM-образов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WIMMount" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Windows Trusted RT
:: WindowsTrustedRT (Windows Trusted Runtime Service) — доверенная среда выполнения.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WindowsTrustedRT" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить прокси Windows Trusted RT
:: WindowsTrustedRTProxy (Windows Trusted Runtime Proxy) — прокси доверенной среды.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WindowsTrustedRTProxy" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу авто-прокси WinHTTP
:: WinHttpAutoProxySvc (WinHTTP Web Proxy Auto-Discovery Service) — авто-обнаружение прокси.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WinHttpAutoProxySvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WinMad
:: WinMad (WinMad Service) — сетевой сервис WinMad.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WinMad" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WinNat
:: WinNat (Windows NAT Driver) — NAT.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WinNat" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WinRM
:: WinRM (Windows Remote Management) — удалённое управление WS-Management.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WinRM" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WinVerbs
:: WinVerbs (WinVerbs) — RDMA Verbs.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WinVerbs" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу wisvc
:: wisvc (Windows Insider Service) — программа предварительной оценки Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wisvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WlanSvc
:: WlanSvc (WLAN AutoConfig) — настройка Wi-Fi.
:: ВНИМАНИЕ: отключение ломает Wi-Fi.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WlanSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Live ID
:: wlidsvc (Microsoft Account Sign-in Assistant) — вход через учётную запись Microsoft.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wlidsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу wlpasvc
:: wlpasvc (Windows Local Profile Assistant) — локальный профиль eSIM.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wlpasvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WManSvc
:: WManSvc (Windows Management Service) — управление Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WManSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WmiAcpi
:: WmiAcpi (Microsoft Windows Management Interface for ACPI) — WMI для ACPI.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WmiAcpi" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу wmiApSrv
:: wmiApSrv (WMI Performance Adapter) — адаптер производительности WMI.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wmiApSrv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу сетевого доступа к медиа
:: WMPNetworkSvc (Windows Media Player Network Sharing Service) — общий доступ к медиа.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WMPNetworkSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу родительского контроля
:: WpcMonSvc (Parental Controls) — родительский контроль.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WpcMonSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу перечисления портативных устройств
:: WPDBusEnum (Portable Device Enumerator Service) — перечисление портативных устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WPDBusEnum" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу push-уведомлений
:: WpnService (Windows Push Notifications System Service) — системные push-уведомления.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WpnService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу ws2ifsl
:: ws2ifsl (Winsock IFS Layer) — слой IFS Winsock.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ws2ifsl" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу поиска Windows
:: WSearch (Windows Search) — индексация поиска.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WSearch" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу обновления Windows
:: wuauserv (Windows Update) — центр обновления Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WUDFRd
:: WUDFRd (Windows Driver Foundation - User-mode Driver Framework Reflector) — отражатель UMDF.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WUDFRd" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WwanSvc
:: WwanSvc (WWAN AutoConfig) — настройка мобильного интернета.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WwanSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу XblAuthManager
:: XblAuthManager (Xbox Live Auth Manager) — авторизация Xbox Live.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\XblAuthManager" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу сохранений Xbox
:: XblGameSave (Xbox Live Game Save) — сохранение игр Xbox Live.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\XblGameSave" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу xboxgip
:: xboxgip (Xbox Game Input Protocol Driver) — протокол ввода Xbox.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\xboxgip" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу XboxGipSvc
:: XboxGipSvc (Xbox Accessory Management Service) — управление аксессуарами Xbox.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\XboxGipSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу XboxNetApiSvc
:: XboxNetApiSvc (Xbox Live Networking Service) — сеть Xbox Live.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\XboxNetApiSvc" /v "Start" /t REG_DWORD /d "4" /f

Echo.
Echo ============================================
Echo  Готово. Перезагрузите ПК для применения.
Echo ============================================
Pause
Exit /B 0