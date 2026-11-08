@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title VampireOS - только службы
cd /d "%~dp0"

rem ============================================================================
rem  Отключение служб из VampireOS.bat
rem  ---------------------------------------------------------------------------
rem  Выставляет Start = 4 (disabled) или Start = 3 (manual) для всех служб,
rem  которые в оригинальном VampireOS.bat отключаются через sc config.
rem
rem  - Start = 4 — служба отключена, не запускается.
rem  - Start = 3 — служба запускается вручную.
rem
rem  Изменения вступают в силу после перезагрузки (или после sc stop).
rem  Требуются права администратора.
rem ============================================================================

echo ============================================================
echo  Отключение служб (выборка из VampireOS.bat)
echo ============================================================
echo.

rem ============================================================================
rem 1. ТЕЛЕМЕТРИЯ И ДИАГНОСТИКА
rem ============================================================================

:: Отключить службу подключённых пользовательских возможностей и телеметрии
:: DiagTrack (Connected User Experiences and Telemetry) — основная служба
:: телеметрии Windows, собирает и отправляет диагностические данные.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу WAP push для управления устройством
:: dmwappushservice (Device Management WAP Push) — push-уведомления для MDM,
:: используется в телеметрии.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу сбора диагностических данных
:: diagnosticshub.standardcollector.service (Microsoft Diagnostics Hub Standard
:: Collector) — сбор диагностических данных Visual Studio и Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу политик диагностики
:: DPS (Diagnostic Policy Service) — диагностика проблем с компонентами Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DPS" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу диагностики
:: diagsvc (Diagnostic Service Host) — хост диагностических служб.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\diagsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить диагностическую службу DSSvc
:: DSSvc (Diagnostic Service) — вспомогательная диагностическая служба.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DSSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить хост диагностических служб
:: WdiServiceHost (Diagnostic Service Host) — хост диагностических служб.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdiServiceHost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить системный хост диагностики
:: WdiSystemHost (Diagnostic System Host) — системный хост диагностики.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdiSystemHost" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу телеметрии
:: Telemetry (Telemetry) — служба телеметрии Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Telemetry" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу инвентаризации и оценки совместимости
:: InventorySvc (Inventory and Compatibility Appraisal) — сбор инвентаризации
:: для оценки совместимости.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\InventorySvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу учёта использования данных
:: dusmsvc (Data Usage Service) — учёт сетевого трафика.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dusmsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу помощника по совместимости программ
:: PcaSvc (Program Compatibility Assistant Service) — отслеживание программ
:: на совместимость.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PcaSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу проверки SPOT
:: svsvc (Spot Verifier) — проверка System Protection (SPOT).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\svsvc" /v "Start" /t REG_DWORD /d "4" /f

rem ============================================================================
rem 2. ОТЧЁТЫ ОБ ОШИБКАХ
rem ============================================================================

:: Отключить службу отчётов об ошибках Windows
:: WerSvc (Windows Error Reporting Service) — сбор и отправка отчётов об ошибках.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WerSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу поддержки панели отчётов о проблемах
:: wercplsupport (Problem Reports and Solutions Control Panel Support) —
:: поддержка панели «Отчёты о проблемах и решения».
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wercplsupport" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу устранения неполадок
:: troubleshootingsvc (Troubleshooting Service) — мастер устранения неполадок.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\troubleshootingsvc" /v "Start" /t REG_DWORD /d "4" /f

rem ============================================================================
rem 3. ОБНОВЛЕНИЯ WINDOWS И INSIDER
rem ============================================================================

:: Отключить службу оркестратора обновлений
:: UsoSvc (Update Orchestrator Service) — координация установки обновлений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу восстановления Windows Update
:: WaaSMedicSvc (Windows Update Medic Service) — восстановление компонентов WU.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу Windows Insider
:: wisvc (Windows Insider Service) — получение предварительных сборок Windows.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wisvc" /v "Start" /t REG_DWORD /d "4" /f

rem ============================================================================
rem 4. ПЕЧАТЬ / СКАНИРОВАНИЕ / ФАКС
rem ============================================================================

:: Отключить диспетчер печати
:: Spooler (Print Spooler) — служба диспетчера печати.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Spooler" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу уведомлений принтера
:: PrintNotify (PrintNotify) — уведомления от принтеров и заданий печати.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PrintNotify" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу печати из UWP-приложений
:: PrintWorkflowUserSvc (Print Workflow User Service) — печать из UWP-приложений.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PrintWorkflowUserSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу конфигурации устройств печати
:: PrintDeviceConfigurationService (Print Device Configuration Service) —
:: конфигурация устройств печати.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PrintDeviceConfigurationService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу брокера печати и сканирования
:: PrintScanBrokerService (Print Scan Broker Service) — брокер заданий
:: печати и сканирования.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\PrintScanBrokerService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу USB-принтеров
:: usbprint (USB Printer) — поддержка USB-принтеров.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\usbprint" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу факса
:: Fax (Fax) — отправка и приём факсов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Fax" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу получения изображений (сканеры, камеры)
:: stisvc (Windows Image Acquisition, WIA) — поддержка сканеров и камер.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\stisvc" /v "Start" /t REG_DWORD /d "4" /f

rem ============================================================================
rem 5. УДАЛЁННЫЙ РАБОЧИЙ СТОЛ (RDP)
rem ============================================================================

:: Отключить службы удалённых рабочих столов
:: TermService (Remote Desktop Services) — сервер RDP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TermService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу перенаправления портов RDP
:: UmRdpService (Remote Desktop Services UserMode Port Redirector) —
:: перенаправление портов в RDP-сессиях.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UmRdpService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу конфигурации RDP
:: SessionEnv (Remote Desktop Configuration) — конфигурация удалённых сессий.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SessionEnv" /v "Start" /t REG_DWORD /d "4" /f

rem ============================================================================
rem 6. HYPER-V
rem ============================================================================

:: Отключить драйвер клавиатуры Hyper-V
:: hyperkbd (Hyper-V Keyboard) — эмуляция клавиатуры для виртуальных машин.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\hyperkbd" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить видеодрайвер Hyper-V
:: hypervideo (Hyper-V Video) — видеоадаптер для виртуальных машин.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\hypervideo" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить гостевой драйвер инфраструктуры Hyper-V
:: vmgid (Hyper-V Guest Infrastructure Driver) — инфраструктура гостевой ОС.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vmgid" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить драйвер PCI Hyper-V
:: vpci (Hyper-V PCI) — проброс PCI-устройств в виртуальные машины.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vpci" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить драйвер инфраструктуры виртуализации Hyper-V
:: vid (Hyper-V Virtualization Infrastructure Driver) — ядро виртуализации.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\vid" /v "Start" /t REG_DWORD /d "4" /f

rem ============================================================================
rem 7. АВТОНОМНЫЕ ФАЙЛЫ (OFFLINE FILES)
rem ============================================================================

:: Отключить службу автономных файлов
:: CSC (Offline Files) — кэш автономных файлов (Client-Side Caching).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\CSC" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу поддержки автономных файлов
:: CSCSERVICE (Offline Files) — служба автономных файлов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\CSCSERVICE" /v "Start" /t REG_DWORD /d "4" /f

rem ============================================================================
rem 8. СЕТЬ
rem ============================================================================

:: Отключить службу регистрации TCP/IP
:: tcpipreg (TCP/IP Registry Compatibility) — регистрация параметров TCP/IP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\tcpipreg" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить драйвер мониторинга сетевого трафика
:: Ndu (Windows Network Data Usage Monitoring Driver) — учёт использования сети.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Ndu" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу NetBIOS over TCP/IP
:: NetBT (NetBIOS over TCP/IP) — поддержка NetBIOS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NetBT" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить диспетчер загруженных карт
:: MapsBroker (Downloaded Maps Manager) — офлайн-карты.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу удалённого реестра
:: RemoteRegistry (Remote Registry) — удалённый доступ к реестру.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RemoteRegistry" /v "Start" /t REG_DWORD /d "4" /f

rem ============================================================================
rem 9. МЕДИА И ГРАФИКА
rem ============================================================================

:: Отключить службу сетевого доступа Windows Media Player
:: WMPNetworkSvc (Windows Media Player Network Sharing Service) — общий доступ
:: к медиатеке WMP по сети.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WMPNetworkSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу производительности графики
:: GraphicsPerfSvc (Graphics Perf Service) — телеметрия и производительность
:: графической подсистемы.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GraphicsPerfSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу MIDI
:: midisrv (MIDI Service) — поддержка MIDI-устройств.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\midisrv" /v "Start" /t REG_DWORD /d "4" /f

rem ============================================================================
rem 10. AMD
rem ============================================================================

:: Отключить службу AMD Crash Defender
:: amdfendr (AMD Crash Defender Service) — перехват сбоев драйверов AMD.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\amdfendr" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить утилиту внешних событий AMD
:: amdfendrmgr (AMD External Events Utility) — обработка внешних событий AMD.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\amdfendrmgr" /v "Start" /t REG_DWORD /d "4" /f

rem ============================================================================
rem 11. AI / ПРОЧИЕ
rem ============================================================================

:: Отключить службу Windows AI Fabric
:: WSAIFabricSvc (Windows AI Fabric Service) — инфраструктура Windows AI/Copilot.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WSAIFabricSvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу повышения прав Copilot
:: MicrosoftCopilotElevationService (Microsoft Copilot Elevation Service) —
:: повышение прав для Copilot.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MicrosoftCopilotElevationService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу управления Microsoft Defender Application Guard
:: McpManagementService — управление WDAG / Windows Sandbox.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\McpManagementService" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить драйвер защиты пользовательского выбора
:: UCPD (User Choice Protection Driver) — защита ассоциаций файлов и протоколов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\UCPD" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу встроенного режима
:: embeddedmode (Embedded Mode) — поддержка встраиваемых конфигураций (kiosk).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\embeddedmode" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу демонстрационного режима
:: RetailDemo (Retail Demo Service) — демонстрационный режим для магазинов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\RetailDemo" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу отслеживания ссылок
:: TrkWks (Distributed Link Tracking Client) — отслеживание перемещений
:: файлов и ярлыков в NTFS.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TrkWks" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить службу сбора событий Windows
:: Wecsvc (Windows Event Collector) — сбор событий с удалённых узлов.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Wecsvc" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить модератор активности рабочего стола
:: dam (Desktop Activity Moderator) — ограничение фоновой активности UWP.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dam" /v "Start" /t REG_DWORD /d "4" /f

:: Отключить координатор распределённых транзакций
:: MSDTC (Distributed Transaction Coordinator) — координация транзакций
:: между БД и приложениями.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\MSDTC" /v "Start" /t REG_DWORD /d "4" /f

rem ============================================================================
rem 12. WINDOWS TIME (Start = 3 — вручную)
rem ============================================================================

:: Перевести службу времени Windows в ручной режим
:: w32time (Windows Time) — синхронизация системного времени по NTP.
:: Start = 3 — запускается вручную, не отключена полностью.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\w32time" /v "Start" /t REG_DWORD /d "3" /f

echo.
echo ============================================================
echo  Готово. Всего обработано служб: 58
echo  57 отключено, 1 переведена в ручной режим
echo  Перезагрузите ПК, чтобы применить изменения.
echo ============================================================
echo.