@echo off
setlocal EnableExtensions
title Отключение служб из BoosterX и SystemX

:: ============================================================================
::                        КРУТАЯ ШАПКА
:: ============================================================================
::  Данный батник отключает (Start=4) службы, которые были найдены
::  в конфигурационных файлах BoosterX и SystemX.
::  Каждый блок — это одна служба с кратким описанием её назначения.
::  Файл создан для ознакомительных целей. Используйте на свой страх и риск.
:: ============================================================================

:: ============================================================================
::                              СЛУЖБЫ BOOSTERX
:: ============================================================================

:: Отключить службу Intel Content Protection
:: cphs (Intel Content Protection HDCP Service) — служба, связанная с защитой
:: цифрового контента (HDCP) на оборудовании Intel.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\cphs" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Intel Content Protection (вспомогательную)
:: cplspcon (Intel Content Protection HDCP Service) — вспомогательная служба,
:: также связанная с HDCP на платформах Intel.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\cplspcon" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу диагностики
:: diagsvc (Diagnostic Service Host) — хост-служба диагностики, используется
:: для запуска диагностических пакетов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\diagsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу встраиваемого режима
:: embeddedmode (Embedded Mode) — служба, связанная с режимом встраиваемых
:: устройств (Windows IoT/Embedded).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\embeddedmode" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Центра обновления Windows
:: wuauserv (Windows Update) — служба, отвечающая за загрузку и установку
:: обновлений Windows. В BoosterX ей выставлялся Start=3 (вручную),
:: здесь для единообразия выставляется 4 (отключено).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d "4" /f


:: ============================================================================
::                              СЛУЖБЫ SYSTEMX
:: ============================================================================

:: Отключить службу маршрутизатора AllJoyn
:: AJRouter (AllJoyn Router Service) — перенаправляет сообщения протокола AllJoyn
:: для локальных клиентов (IoT-интеграция).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AJRouter" /v "Start" /t REG_DWORD /d "4" /f

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

:: Отключить клиент Microsoft App-V
:: AppVClient (Microsoft App-V Client) — управляет пользователями и
:: виртуализированными приложениями App-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AppVClient" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу развертывания AppX
:: AppXSvc (AppX Deployment Service) — обеспечивает инфраструктурную поддержку
:: для развертывания приложений Microsoft Store.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AppXSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу диспетчера назначенного доступа
:: AssignedAccessManagerSvc (Assigned Access Manager Service) — управляет
:: киоск-режимом (назначенным доступом) в Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AssignedAccessManagerSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу маршрутизатора AarSvc
:: AarSvc (AarSvc) — вспомогательная пользовательская служба,
:: связанная с уведомлениями и работой в фоне.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AarSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу автоматического времени
:: autotimesvc (Auto Time Zone Updater) — автоматически обновляет часовой пояс.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\autotimesvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить установщик ActiveX
:: AxInstSV (ActiveX Installer) — обеспечивает установку элементов ActiveX
:: из доверенных источников.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AxInstSV" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу шифрования дисков BitLocker
:: BDESVC (BitLocker Drive Encryption Service) — хостит службу шифрования
:: дисков BitLocker.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BDESVC" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить базовый фильтрующий движок
:: BFE (Base Filtering Engine) — управляет политиками брандмауэра и IPsec,
:: реализует пользовательскую фильтрацию. Отключение снижает безопасность.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BFE" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу фоновой интеллектуальной передачи
:: BITS (Background Intelligent Transfer Service) — передает файлы в фоновом
:: режиме, используется Windows Update и другими приложениями.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу шлюза Bluetooth-аудио
:: BTAGService (Bluetooth Audio Gateway Service) — поддерживает работу
:: Bluetooth-аудиоустройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BTAGService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу AVCTP
:: BthAvctpSvc (AVCTP service) — поддерживает профиль управления аудио/видео
:: через Bluetooth (AVCTP).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BthAvctpSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу поддержки Bluetooth
:: bthserv (Bluetooth Support Service) — обеспечивает работу Bluetooth-устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\bthserv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить пользовательскую службу записи трансляций
:: BcastDVRUserService (BcastDVRUserService) — пользовательская служба для
:: записи игровых трансляций (Game DVR).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BcastDVRUserService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить пользовательскую службу Bluetooth
:: BluetoothUserService (BluetoothUserService) — пользовательская служба,
:: связанная с Bluetooth-устройствами.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BluetoothUserService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу захвата
:: CaptureService (CaptureService) — пользовательская служба для захвата
:: экрана и игрового процесса.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\CaptureService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить пользовательскую службу буфера обмена
:: cbdhsvc (Clipboard User Service) — обеспечивает работу буфера обмена
:: для пользователя.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\cbdhsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу платформы подключенных устройств
:: CDPSvc (Connected Devices Platform Service) — поддерживает сценарии
:: подключенных устройств и общий доступ.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\CDPSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить пользовательскую службу платформы подключенных устройств
:: CDPUserSvc (CDPUserSvc) — пользовательская часть службы CDP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу распространения сертификатов
:: CertPropSvc (Certificate Propagation) — распространяет сертификаты
:: со смарт-карт.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\CertPropSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу лицензирования клиента
:: ClipSVC (Client License Service) — обеспечивает инфраструктуру лицензирования
:: для приложений Microsoft Store.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ClipSVC" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить системное приложение COM+
:: COMSysApp (COM+ System Application) — управляет конфигурацией и
:: отслеживанием компонентов COM+.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\COMSysApp" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить пользовательскую службу согласия
:: ConsentUxUserSvc (ConsentUxUserSvc) — позволяет системе запрашивать
:: согласие пользователя на доступ приложений к ресурсам.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ConsentUxUserSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу регистрации учетных данных
:: CredentialEnrollmentManagerUserSvc (Credential Enrollment Manager) —
:: управляет регистрацией учетных данных.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\CredentialEnrollmentManagerUserSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу автономных файлов
:: CscService (Offline Files) — обеспечивает поддержку автономных файлов
:: (кеширование сетевых ресурсов).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\CscService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу оптимизации дисков
:: defragsvc (Optimize drives) — выполняет дефрагментацию и оптимизацию дисков.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\defragsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу сопоставления устройств
:: DeviceAssociationService (Device Association Service) — обеспечивает
:: сопоставление между устройствами (например, Bluetooth).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DeviceAssociationService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить пользовательскую службу выбора устройств
:: DevicePickerUserSvc (DevicePickerUserSvc) — интерфейс выбора устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DevicePickerUserSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить пользовательскую службу потоков устройств
:: DevicesFlowUserSvc (DevicesFlowUserSvc) — управляет потоками данных устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DevicesFlowUserSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить брокер фонового обнаружения DevQuery
:: DevQueryBroker (DevQuery Background Discovery Broker) — фоновое обнаружение
:: устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DevQueryBroker" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить стандартный сборщик диагностического хаба
:: diagnosticshub.standardcollector.service (Microsoft Diagnostics Hub Standard
:: Collector Service) — собирает диагностические данные для Visual Studio
:: и других инструментов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу телеметрии
:: DiagTrack (Connected User Experiences and Telemetry) — собирает и отправляет
:: телеметрические данные в Microsoft.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу политики отображения
:: DispBrokerDesktopSvc (Display Policy Service) — управляет политиками
:: отображения для рабочих столов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DispBrokerDesktopSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу улучшения отображения
:: DisplayEnhancementService (Display Enhancement Service) — управляет
:: улучшениями изображения (яркость, цвет и т.д.).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DisplayEnhancementService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу маршрутизации push-сообщений WAP
:: dmwappushservice (Device Management WAP Push Message Routing Service) —
:: маршрутизирует push-сообщения WAP для управления устройствами.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить клиент DNS
:: Dnscache (DNS Client) — кэширует DNS-имена и регистрирует имя компьютера.
:: ⚠️ Отключение может нарушить разрешение имен в сети.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу оптимизации доставки
:: DoSvc (Delivery Optimization) — оптимизирует загрузку обновлений и
:: контента из Microsoft Store, используя пиринговые сети.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу автонастройки проводной сети
:: dot3svc (Wired AutoConfig) — автоматическая настройка проводных
:: сетевых подключений (802.1X).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dot3svc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу политики диагностики
:: DPS (Diagnostic Policy Service) — управляет политиками диагностики,
:: запускает диагностические сценарии.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DPS" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу управления настройкой устройств
:: DsmSvc (Device Setup Manager) — управляет установкой и настройкой устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DsmSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу DsSvc
:: DsSvc (DsSvc) — вспомогательная служба, связанная с управлением данными.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DsSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу использования данных
:: DusmSvc (Data Usage) — отслеживает использование сетевого трафика.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DusmSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу EAP-хоста
:: Eaphost (Extensible Authentication Protocol) — обеспечивает аутентификацию
:: по протоколу EAP (например, для Wi-Fi).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Eaphost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу обновления Microsoft Edge
:: edgeupdate (Microsoft Edge Update Service) — обновляет браузер Microsoft Edge.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\edgeupdate" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу обновления Microsoft Edge (ручной запуск)
:: edgeupdatem (Microsoft Edge Update Service) — ручной вариант службы
:: обновления Edge.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\edgeupdatem" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить файловую систему шифрования
:: EFS (Encrypting File System) — обеспечивает шифрование файлов на томах NTFS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\EFS" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу управления корпоративными приложениями
:: EntAppSvc (Enterprise App Management Service) — управляет корпоративными
:: приложениями.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\EntAppSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить журнал событий Windows
:: EventLog (Windows Event Log) — записывает события системы и приложений.
:: ⚠️ Отключение крайне не рекомендуется.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\EventLog" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу системных событий
:: EventSystem (COM+ Event System) — поддерживает доставку событий COM+.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\EventSystem" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить хост поставщика обнаружения функций
:: fdPHost (Function Discovery Provider Host) — хостит поставщиков обнаружения
:: функций (например, для сетевых устройств).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\fdPHost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить публикацию ресурсов обнаружения функций
:: FDResPub (Function Discovery Resource Publication) — публикует ресурсы
:: компьютера в сети для обнаружения.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\FDResPub" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу истории файлов
:: fhsvc (File History Service) — создает резервные копии файлов пользователя.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\fhsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу кэша шрифтов
:: FontCache (Windows Font Cache Service) — кэширует шрифты для повышения
:: производительности приложений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\FontCache" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу кэша шрифтов (версия 3.0.0.0)
:: FontCache3.0.0.0 (Windows Presentation Foundation Font Cache) — кэш шрифтов
:: для WPF-приложений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\FontCache3.0.0.0" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу кадрового сервера
:: FrameServer (Windows Camera Frame Server) — обеспечивает доступ к камере
:: для нескольких приложений одновременно.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\FrameServer" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу повышения прав Google Chrome
:: GoogleChromeElevationService (Google Chrome Elevation Service) — используется
:: для повышения прав Chrome.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GoogleChromeElevationService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу производительности графики
:: GraphicsPerfSvc (GraphicsPerfSvc) — собирает данные о производительности
:: графической подсистемы.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GraphicsPerfSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу обновления Google
:: gupdate (Google Update Service) — обновляет продукты Google.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\gupdate" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу обновления Google (ручной запуск)
:: gupdatem (Google Update Service) — ручной вариант службы обновления Google.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\gupdatem" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу интерфейса человека-машины
:: hidserv (Human Interface Device Service) — активирует горячие клавиши
:: на клавиатуре и пультах.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\hidserv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу узла Hyper-V
:: HvHost (HV Host Service) — предоставляет интерфейс для гипервизора Hyper-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\HvHost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу ICS
:: icssvc (Windows Mobile Hotspot Service) — обеспечивает работу мобильной
:: точки доступа.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\icssvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу IKE и AuthIP
:: IKEEXT (IKE and AuthIP IPsec Keying Modules) — управляет ключами IPsec.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\IKEEXT" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу установки
:: InstallService (Microsoft Store Install Service) — устанавливает приложения
:: из Microsoft Store.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\InstallService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить вспомогательную службу IP
:: iphlpsvc (IP Helper) — обеспечивает туннелирование IPv6 и другие
:: сетевые функции.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\iphlpsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу настройки преобразования IP-адресов
:: IpxlatCfgSvc (IP Translation Configuration Service) — настраивает
:: преобразование IP-адресов (NAT).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\IpxlatCfgSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу KAPSService
:: KAPSService (KAPSService) — служба, связанная с управлением питанием
:: (возможно, от производителя).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\KAPSService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу KNDBWM
:: KNDBWM (KNDBWM) — служба, связанная с управлением пропускной способностью
:: (возможно, от производителя).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\KNDBWM" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу KtmRm
:: KtmRm (KtmRm for Distributed Transaction Coordinator) — координатор
:: транзакций ядра.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\KtmRm" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу сервера
:: LanmanServer (Server) — обеспечивает поддержку общего доступа к файлам
:: и принтерам по сети.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу рабочей станции
:: LanmanWorkstation (Workstation) — обеспечивает доступ к сетевым ресурсам.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу определения местоположения
:: lfsvc (Geolocation Service) — определяет географическое положение компьютера.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу лицензирования Windows
:: LicenseManager (Windows License Manager Service) — управляет лицензиями
:: Microsoft Store.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LicenseManager" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу сопоставления топологии канального уровня
:: lltdsvc (Link-Layer Topology Discovery Mapper) — создает карту сети.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\lltdsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить помощник NetBIOS по TCP/IP
:: lmhosts (TCP/IP NetBIOS Helper) — поддерживает разрешение имен NetBIOS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\lmhosts" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу LxpSvc
:: LxpSvc (Language Experience Service) — обеспечивает языковой интерфейс
:: и раскладки клавиатуры.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LxpSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить диспетчер загруженных карт
:: MapsBroker (Downloaded Maps Manager) — управляет загруженными картами
:: для приложения «Карты».
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу обмена сообщениями
:: MessagingService (MessagingService) — пользовательская служба для обмена
:: сообщениями (SMS, MMS).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MessagingService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу повышения прав Microsoft Edge
:: MicrosoftEdgeElevationService (Microsoft Edge Elevation Service) —
:: используется для повышения прав браузера Edge.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MicrosoftEdgeElevationService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Mixed Reality OpenXR
:: MixedRealityOpenXRSvc (Windows Mixed Reality OpenXR Service) — поддерживает
:: приложения смешанной реальности.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MixedRealityOpenXRSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу брандмауэра Windows
:: mpssvc (Windows Defender Firewall) — обеспечивает фильтрацию сетевого
:: трафика. ⚠️ Отключение снижает безопасность.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mpssvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить координатор распределенных транзакций
:: MSDTC (Distributed Transaction Coordinator) — координирует транзакции,
:: распределенные по нескольким ресурсам.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MSDTC" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу iSCSI
:: MSiSCSI (Microsoft iSCSI Initiator Service) — управляет подключениями iSCSI.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MSiSCSI" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу естественной аутентификации
:: NaturalAuthentication (Natural Authentication) — использует датчики
:: для аутентификации (например, по лицу).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NaturalAuthentication" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу помощника по подключению к сети
:: NcaSvc (Network Connectivity Assistant) — помогает диагностировать
:: проблемы с подключением к сети.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NcaSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу посредника подключений к сети
:: NcbService (Network Connection Broker) — управляет подключениями
:: для приложений Microsoft Store.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NcbService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу автонастройки сетевых подключенных устройств
:: NcdAutoSetup (Network Connected Devices Auto-Setup) — автоматически
:: настраивает сетевые устройства.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NcdAutoSetup" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Netlogon
:: Netlogon (Netlogon) — поддерживает аутентификацию в домене.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Netlogon" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу сетевого профиля
:: netprofm (Network List Service) — определяет сети, к которым подключен
:: компьютер, и уведомляет приложения об изменениях.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\netprofm" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить общий доступ к портам TCP
:: NetTcpPortSharing (Net.Tcp Port Sharing Service) — позволяет совместно
:: использовать порты TCP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NetTcpPortSharing" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить контейнер Microsoft Passport
:: NgcCtnrSvc (Microsoft Passport Container) — управляет контейнером
:: учетных данных Windows Hello.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NgcCtnrSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Microsoft Passport
:: NgcSvc (Microsoft Passport) — обеспечивает вход в систему с помощью
:: Windows Hello (PIN, биометрия).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NgcSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу сетевого расположения
:: NlaSvc (Network Location Awareness) — определяет сетевое расположение
:: (например, домашняя/рабочая сеть).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу OneSync
:: OneSyncSvc (Sync Host) — синхронизирует почту, контакты, календарь
:: и другие данные.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу P2P-группировки
:: p2pimsvc (Peer Networking Grouping) — обеспечивает многоточечную связь
:: через P2P.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\p2pimsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу P2P-сети
:: p2psvc (Peer Networking Grouping) — обеспечивает одноранговые сетевые
:: функции.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\p2psvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу помощника по совместимости программ
:: PcaSvc (Program Compatibility Assistant Service) — помогает запускать
:: старые программы на новых версиях Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PcaSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу BranchCache
:: PeerDistSvc (BranchCache) — кэширует сетевой контент от пиров в локальной
:: подсети.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PeerDistSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу моделирования восприятия
:: perceptionsimulation (Perception Simulation Service) — используется для
:: симуляции сенсорного ввода.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\perceptionsimulation" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу телефонии
:: PhoneSvc (Phone Service) — управляет телефонными звонками.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PhoneSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу обслуживания индекса PIM
:: PimIndexMaintenanceSvc (Contact Data) — индексирует контакты и данные PIM.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PimIndexMaintenanceSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Performance Logs & Alerts
:: pla (Performance Logs & Alerts) — собирает данные о производительности.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\pla" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Plug and Play
:: PlugPlay (Plug and Play) — управляет обнаружением и установкой устройств.
:: ⚠️ Отключение не рекомендуется.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PlugPlay" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу публикации имен PNRP
:: PNRPAutoReg (PNRP Machine Name Publication Service) — публикует имя
:: компьютера с помощью PNRP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PNRPAutoReg" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить протокол PNRP
:: PNRPsvc (Peer Name Resolution Protocol) — обеспечивает разрешение имен
:: без сервера через PNRP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PNRPsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить агент политики IPsec
:: PolicyAgent (IPsec Policy Agent) — запускает политики IPsec.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу управления питанием
:: Power (Power) — управляет политиками питания и уведомлениями.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Power" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить уведомления принтера
:: PrintNotify (Printer Extensions and Notifications) — открывает диалоги
:: принтера и обрабатывает уведомления.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PrintNotify" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить пользовательскую службу рабочих процессов печати
:: PrintWorkflowUserSvc (PrintWorkflowUserSvc) — управляет рабочими процессами
:: печати для пользователя.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PrintWorkflowUserSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу профилей пользователей
:: ProfSvc (User Profile Service) — загружает и выгружает профили пользователей.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ProfSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу PushToInstall
:: PushToInstall (Windows PushToInstall Service) — устанавливает приложения
:: по запросу из Microsoft Store.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PushToInstall" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу качества аудио и видео Windows
:: QWAVE (Quality Windows Audio Video Experience) — улучшает качество
:: потокового аудио/видео в сети.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\QWAVE" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу удаленного доступа (автоматическое подключение)
:: RasAuto (Remote Access Auto Connection Manager) — автоматически подключается
:: к удаленной сети.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RasAuto" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить диспетчер удаленных подключений
:: RasMan (Remote Access Connection Manager) — управляет удаленными
:: подключениями (VPN, dial-up).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RasMan" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу маршрутизации и удаленного доступа
:: RemoteAccess (Routing and Remote Access) — обеспечивает маршрутизацию
:: и удаленный доступ.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RemoteAccess" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить удаленный реестр
:: RemoteRegistry (Remote Registry) — позволяет удаленным пользователям
:: изменять реестр.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RemoteRegistry" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу демонстрации розничной торговли
:: RetailDemo (Retail Demo Service) — используется в демонстрационных
:: режимах в магазинах.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RetailDemo" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу управления радио
:: RmSvc (Radio Management Service) — управляет радиомодулями (Wi-Fi, Bluetooth).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RmSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить локатор RPC
:: RpcLocator (Remote Procedure Call Locator) — управляет базой данных
:: службы имен RPC.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RpcLocator" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить диспетчер учетных записей безопасности
:: SamSs (Security Accounts Manager) — управляет базой данных учетных записей.
:: ⚠️ Критически важная служба.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SamSs" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу смарт-карт
:: SCardSvr (Smart Card) — управляет доступом к смарт-картам.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SCardSvr" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу перечисления устройств чтения смарт-карт
:: ScDeviceEnum (Smart Card Device Enumeration Service) — перечисляет
:: устройства чтения смарт-карт.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ScDeviceEnum" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить планировщик заданий
:: Schedule (Task Scheduler) — позволяет планировать автоматические задачи.
:: ⚠️ Отключение нарушит работу многих компонентов Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Schedule" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить политику удаления смарт-карт
:: SCPolicySvc (Smart Card Removal Policy) — настраивает действия при
:: извлечении смарт-карты.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SCPolicySvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу резервного копирования Windows
:: SDRSVC (Windows Backup) — обеспечивает резервное копирование и восстановление.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SDRSVC" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу вторичного входа в систему
:: seclogon (Secondary Logon) — позволяет запускать процессы от имени
:: другого пользователя.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\seclogon" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу безопасности Windows
:: SecurityHealthService (Windows Security Service) — обеспечивает работу
:: Центра безопасности Windows Defender.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить диспетчер платежей и NFC
:: SEMgrSvc (Payments and NFC/SE Manager) — управляет платежами и NFC.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SEMgrSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу уведомления о системных событиях
:: SENS (System Event Notification Service) — отслеживает системные события
:: и уведомляет подписчиков.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SENS" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить расширенную защиту от угроз
:: Sense (Windows Defender Advanced Threat Protection Service) — обеспечивает
:: расширенную защиту от угроз (ATP).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Sense" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу данных датчиков
:: SensorDataService (Sensor Data Service) — предоставляет данные от различных
:: датчиков.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SensorDataService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу мониторинга датчиков
:: SensorService (Sensor Service) — управляет датчиками и их данными.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SensorService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу мониторинга датчиков (SensrSvc)
:: SensrSvc (Sensor Monitoring Service) — отслеживает датчики для адаптации
:: яркости экрана и других параметров.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SensrSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу настройки удаленного рабочего стола
:: SessionEnv (Remote Desktop Configuration) — настраивает удаленный рабочий стол.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SessionEnv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить брокер мониторинга System Guard
:: SgrmBroker (System Guard Runtime Monitor Broker) — отслеживает целостность
:: системы.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SgrmBroker" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить общий доступ к интернет-соединению
:: SharedAccess (Internet Connection Sharing) — позволяет использовать
:: компьютер как шлюз для общего доступа в интернет.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу пространственных данных
:: SharedRealitySvc (Spatial Data Service) — обеспечивает пространственные
:: данные для Mixed Reality.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SharedRealitySvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу обнаружения оборудования оболочки
:: ShellHWDetection (Shell Hardware Detection) — уведомляет оболочку
:: о подключении/отключении устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ShellHWDetection" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить диспетчер общих учетных записей ПК
:: shpamsvc (Shared PC Account Manager) — управляет общими учетными записями
:: на ПК.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\shpamsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить хост-службу WMI
:: smphost (Microsoft Storage Spaces SMP) — хост-служба для поставщиков WMI.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\smphost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу маршрутизатора SMS
:: SmsRouter (Microsoft Windows SMS Router Service) — маршрутизирует SMS-сообщения.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SmsRouter" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить ловушку SNMP
:: SNMPTRAP (SNMP Trap) — принимает ловушки SNMP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SNMPTRAP" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу восприятия Windows
:: spectrum (Windows Perception Service) — обеспечивает восприятие
:: (например, для Windows Mixed Reality).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\spectrum" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить диспетчер печати
:: Spooler (Print Spooler) — управляет очередями печати.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Spooler" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу защиты программного обеспечения
:: sppsvc (Software Protection) — обеспечивает активацию и лицензирование Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\sppsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить обнаружение SSDP
:: SSDPSRV (SSDP Discovery) — обнаруживает устройства UPnP в сети.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SSDPSRV" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить агент аутентификации SSH
:: ssh-agent (OpenSSH Authentication Agent) — управляет ключами SSH.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\ssh-agent" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SSTP
:: SstpSvc (Secure Socket Tunneling Protocol Service) — поддерживает VPN
:: через SSTP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SstpSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу репозитория состояний
:: StateRepository (State Repository Service) — хранит состояние приложений
:: и системы.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\StateRepository" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу захвата изображений
:: stisvc (Windows Image Acquisition) — обеспечивает поддержку сканеров
:: и камер.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\stisvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу хранилища
:: StorSvc (Storage Service) — управляет хранилищем и настройками томов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\StorSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу svsvc
:: svsvc (svsvc) — вспомогательная служба, связанная с системными операциями.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\svsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить поставщик теневых копий
:: swprv (Microsoft Software Shadow Copy Provider) — управляет теневыми
:: копиями томов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\swprv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу SysMain
:: SysMain (SysMain) — ранее Superfetch, оптимизирует загрузку приложений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SysMain" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить брокер системных событий
:: SystemEventsBroker (System Events Broker) — управляет фоновыми задачами
:: и событиями.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SystemEventsBroker" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу планшета и рукописного ввода
:: TabletInputService (Touch Keyboard and Handwriting Panel Service) —
:: обеспечивает работу сенсорной клавиатуры и рукописного ввода.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TabletInputService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу телефонии (TAPI)
:: TapiSrv (Telephony) — обеспечивает поддержку телефонных API (TAPI).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TapiSrv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу TeamViewer
:: TeamViewer (TeamViewer) — служба удаленного доступа TeamViewer.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TeamViewer" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу удаленных рабочих столов
:: TermService (Remote Desktop Services) — позволяет пользователям
:: подключаться к компьютеру удаленно.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TermService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу тем
:: Themes (Themes) — обеспечивает работу визуальных тем.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Themes" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу управления уровнями хранения
:: TieringEngineService (Storage Tiers Management) — управляет уровнями
:: хранения данных.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TieringEngineService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить брокер времени
:: TimeBrokerSvc (Time Broker) — управляет фоновыми задачами, запускаемыми
:: по расписанию.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TimeBrokerSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить диспетчер веб-учетных записей
:: TokenBroker (Web Account Manager) — управляет веб-учетными записями
:: (например, Microsoft Account).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TokenBroker" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить клиент распределенного отслеживания ссылок
:: TrkWks (Distributed Link Tracking Client) — отслеживает ссылки между
:: файлами на разных томах и компьютерах.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TrkWks" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу рекомендуемых действий по устранению неполадок
:: TroubleshootingSvc (Recommended Troubleshooting Service) — рекомендует
:: и автоматически применяет исправления.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TroubleshootingSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить установщик модулей Windows
:: TrustedInstaller (Windows Modules Installer) — устанавливает, удаляет
:: и обновляет компоненты Windows. ⚠️ Отключение может нарушить обновление
:: и обслуживание системы.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TrustedInstaller" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить автообновление часового пояса
:: tzautoupdate (Auto Time Zone Updater) — автоматически обновляет часовой пояс.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\tzautoupdate" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу виртуализации пользовательского опыта
:: UevAgentService (User Experience Virtualization Service) — обеспечивает
:: виртуализацию пользовательского опыта (UE-V).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UevAgentService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить перенаправление портов RDP в пользовательском режиме
:: UmRdpService (Remote Desktop Services UserMode Port Redirector) —
:: перенаправляет порты для RDP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UmRdpService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить хост-службу UPnP
:: upnphost (UPnP Device Host) — хостит устройства UPnP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\upnphost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить диспетчер пользователей
:: UserManager (User Manager) — управляет пользователями и их данными.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UserManager" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу обновления Windows (UsoSvc)
:: UsoSvc (Update Orchestrator Service) — управляет установкой обновлений
:: Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу VacSvc
:: VacSvc (VacSvc) — вспомогательная служба, связанная с управлением
:: виртуализацией (возможно, от стороннего ПО).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\VacSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить хранилище учетных данных
:: VaultSvc (Credential Manager) — предоставляет безопасное хранение
:: учетных данных.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\VaultSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу виртуальных дисков
:: vds (Virtual Disk Service) — управляет дисками и томами.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vds" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу гостевого интерфейса Hyper-V
:: vmicguestinterface (Hyper-V Guest Service Interface) — предоставляет
:: интерфейс для гостевых служб Hyper-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmicguestinterface" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Heartbeat Hyper-V
:: vmicheartbeat (Hyper-V Heartbeat Service) — сообщает, что виртуальная
:: машина работает нормально.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmicheartbeat" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу обмена данными Hyper-V
:: vmickvpexchange (Hyper-V Data Exchange Service) — обменивается метаданными
:: между виртуальной машиной и хостом.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmickvpexchange" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу удаленного рабочего стола Hyper-V
:: vmicrdv (Hyper-V Remote Desktop Virtualization Service) — обеспечивает
:: удаленный рабочий стол в Hyper-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmicrdv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу завершения работы гостя Hyper-V
:: vmicshutdown (Hyper-V Guest Shutdown Service) — позволяет хосту
:: инициировать завершение работы гостя.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmicshutdown" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу синхронизации времени Hyper-V
:: vmictimesync (Hyper-V Time Synchronization Service) — синхронизирует
:: время гостя с хостом.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmictimesync" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу сеансов Hyper-V
:: vmicvmsession (Hyper-V PowerShell Direct Service) — обеспечивает
:: PowerShell Direct в Hyper-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmicvmsession" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу теневых копий Hyper-V
:: vmicvss (Hyper-V Volume Shadow Copy Requestor) — запрашивает теневые
:: копии томов в Hyper-V.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmicvss" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу теневого копирования томов
:: VSS (Volume Shadow Copy) — создает теневые копии томов для резервного
:: копирования и восстановления.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\VSS" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу времени Windows
:: W32Time (Windows Time) — синхронизирует системное время с интернет-серверами.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Windows Update Medic
:: WaaSMedicSvc (Windows Update Medic Service) — восстанавливает компоненты
:: Windows Update при их повреждении.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WalletService
:: WalletService (WalletService) — управляет кошельком Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WalletService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WarpJITSvc
:: WarpJITSvc (Warp JIT Service) — служба JIT-компиляции (возможно, от
:: стороннего ПО).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WarpJITSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу резервного копирования на уровне блоков
:: wbengine (Block Level Backup Engine Service) — выполняет резервное
:: копирование на уровне блоков.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wbengine" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу биометрии Windows
:: WbioSrvc (Windows Biometric Service) — поддерживает биометрические
:: устройства (отпечатки пальцев, распознавание лиц).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WbioSrvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить диспетчер подключений Windows
:: Wcmsvc (Windows Connection Manager) — управляет сетевыми подключениями.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Wcmsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу настройки беспроводной сети
:: wcncsvc (Windows Connect Now) — настраивает беспроводные устройства.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wcncsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить хост-службу диагностики
:: WdiServiceHost (Diagnostic Service Host) — хостит диагностические службы.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdiServiceHost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить системный хост диагностики
:: WdiSystemHost (Diagnostic System Host) — хостит диагностические службы
:: уровня системы.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdiSystemHost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу сетевой инспекции Защитника Windows
:: WdNisSvc (Microsoft Defender Antivirus Network Inspection Service) —
:: обеспечивает сетевую инспекцию в реальном времени.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdNisSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить веб-клиент
:: WebClient (WebClient) — позволяет программам создавать, получать доступ
:: и изменять файлы в интернете (WebDAV).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WebClient" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить сборщик событий Windows
:: Wecsvc (Windows Event Collector) — собирает события с удаленных компьютеров.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Wecsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу поставщика шифрования Windows
:: WEPHOSTSVC (Windows Encryption Provider Host Service) — хостит поставщиков
:: шифрования для сторонних приложений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WEPHOSTSVC" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить поддержку панели управления отчетами о проблемах
:: wercplsupport (Problem Reports Control Panel Support) — поддерживает
:: панель управления отчетами о проблемах.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wercplsupport" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу отчетов об ошибках Windows
:: WerSvc (Windows Error Reporting Service) — собирает и отправляет отчеты
:: об ошибках в Microsoft.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WerSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить диспетчер подключений Wi-Fi Direct
:: WFDSConMgrSvc (Wi-Fi Direct Services Connection Manager Service) —
:: управляет подключениями Wi-Fi Direct.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WFDSConMgrSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить события получения неподвижных изображений
:: WiaRpc (Still Image Acquisition Events) — запускает приложения при
:: подключении камеры или сканера.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WiaRpc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить антивирусную службу Защитника Windows
:: WinDefend (Microsoft Defender Antivirus Service) — основной антивирусный
:: компонент Windows. ⚠️ Отключение оставляет систему без защиты.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу автообнаружения веб-прокси
:: WinHttpAutoProxySvc (WinHTTP Web Proxy Auto-Discovery Service) — обнаруживает
:: настройки прокси-сервера.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WinHttpAutoProxySvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить инструментарий управления Windows
:: Winmgmt (Windows Management Instrumentation) — обеспечивает управление
:: системой через WMI. ⚠️ Многие приложения зависят от WMI.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Winmgmt" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить удаленное управление Windows
:: WinRM (Windows Remote Management) — позволяет удаленное управление
:: через WS-Management.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WinRM" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Windows Insider
:: wisvc (Windows Insider Service) — обеспечивает участие в программе
:: предварительной оценки Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wisvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу автонастройки WLAN
:: WlanSvc (WLAN AutoConfig) — управляет беспроводными сетями Wi-Fi.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WlanSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить помощник по входу в учетную запись Microsoft
:: wlidsvc (Microsoft Account Sign-in Assistant) — помогает входить
:: в учетную запись Microsoft.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wlidsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу локального помощника по профилю
:: wlpasvc (Local Profile Assistant Service) — управляет локальными профилями.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wlpasvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу управления Windows
:: WManSvc (Windows Management Service) — вспомогательная служба управления.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WManSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить адаптер производительности WMI
:: wmiApSrv (WMI Performance Adapter) — предоставляет данные о
:: производительности через WMI.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wmiApSrv" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу сети Windows Media Player
:: WMPNetworkSvc (Windows Media Player Network Sharing Service) — обеспечивает
:: общий доступ к медиатеке.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WMPNetworkSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить родительский контроль
:: WpcMonSvc (Parental Controls) — обеспечивает родительский контроль.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WpcMonSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу перечисления портативных устройств
:: WPDBusEnum (Portable Device Enumerator Service) — перечисляет портативные
:: устройства (MTP).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WPDBusEnum" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить системную службу push-уведомлений
:: WpnService (Windows Push Notifications System Service) — отправляет
:: push-уведомления в систему.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WpnService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить пользовательскую службу push-уведомлений
:: WpnUserService (Windows Push Notifications User Service) — пользовательская
:: часть службы push-уведомлений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WpnUserService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить центр безопасности Windows
:: wscsvc (Security Center) — отслеживает состояние безопасности системы.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wscsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить поиск Windows
:: WSearch (Windows Search) — индексирует файлы и предоставляет поиск.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WSearch" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу автонастройки WWAN
:: WwanSvc (WWAN AutoConfig) — управляет мобильными широкополосными
:: подключениями.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WwanSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить диспетчер аутентификации Xbox Live
:: XblAuthManager (Xbox Live Auth Manager) — обеспечивает аутентификацию
:: для Xbox Live.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\XblAuthManager" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить сохранение игр Xbox Live
:: XblGameSave (Xbox Live Game Save) — синхронизирует сохранения игр
:: с Xbox Live.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\XblGameSave" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу аксессуаров Xbox
:: XboxGipSvc (Xbox Accessory Management Service) — управляет аксессуарами Xbox.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\XboxGipSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить сетевую службу Xbox Live
:: XboxNetApiSvc (Xbox Live Networking Service) — обеспечивает сетевые
:: функции Xbox Live.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\XboxNetApiSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу xTendSoftAPService
:: xTendSoftAPService (xTendSoftAPService) — служба точки доступа (возможно,
:: от стороннего ПО).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\xTendSoftAPService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу xTendUtilityService
:: xTendUtilityService (xTendUtilityService) — вспомогательная служба
:: (возможно, от стороннего ПО).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\xTendUtilityService" /v "Start" /t REG_DWORD /d "4" /f
