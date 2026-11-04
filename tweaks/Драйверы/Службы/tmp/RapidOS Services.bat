@echo off
setlocal EnableExtensions
chcp 65001 >nul
title RapidOS - только службы

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Запустите от имени администратора.
    pause
    exit /b 1
)

:: ============================================================================
::                           КРУТАЯ ШАПКА
:: ============================================================================
::  Standalone-батник по RapidOS (RapidOS.txt).
::  Включены ТОЛЬКО отключения служб:
::    sc config "X" start= disabled
::    sc stop "X"
::  Папки "Отмена" не включены.
::  Удаляемых служб в RapidOS нет — только отключаемые, 35 штук.
::  Всё остальное (schtasks, bcdedit, netsh, fsutil, wevtutil, dism,
::  powercfg, reg add твики, reg delete параметров, winget, taskkill) —
::  исключено.
:: ============================================================================


:: ============================================================================
::  ИСТОЧНИК: Производительность\Отключить Windows Search Indexing.bat
:: ============================================================================

:: WSearch — Windows Search (индексирование файлов).
:: В источнике: sc stop + sc config disabled.
sc stop WSearch >nul 2>&1
sc config WSearch start= disabled >nul 2>&1


:: ============================================================================
::  ИСТОЧНИК: Производительность\Отключить центр уведомлений и WpnService.bat
:: ============================================================================

:: WpnService — системная служба push-уведомлений.
:: В источнике: sc config disabled + sc stop.
sc config WpnService start= disabled >nul 2>&1
sc stop WpnService >nul 2>&1

:: WpnUserService — пользовательская служба push-уведомлений.
:: В источнике только sc config disabled (без sc stop).
sc config WpnUserService start= disabled >nul 2>&1


:: ============================================================================
::  ИСТОЧНИК: Службы\Отключить SysMain.bat
:: ============================================================================

:: SysMain — SysMain (ранее Superfetch).
:: В источнике: sc stop + sc config disabled.
sc stop SysMain >nul 2>&1
sc config SysMain start= disabled >nul 2>&1


:: ============================================================================
::  ИСТОЧНИК: Службы\Отключить ненужные службы.bat
::  Порядок внутри for-цикла сохранён как в источнике.
::  Для каждой: sc config disabled + sc stop.
:: ============================================================================

:: AppMgmt — управление приложениями через групповую политику.
sc config AppMgmt start= disabled >nul 2>&1
sc stop AppMgmt >nul 2>&1

:: AxInstSV — установщик ActiveX.
sc config AxInstSV start= disabled >nul 2>&1
sc stop AxInstSV >nul 2>&1

:: DoSvc — оптимизация доставки (Delivery Optimization).
sc config DoSvc start= disabled >nul 2>&1
sc stop DoSvc >nul 2>&1

:: FontCache — кэш шрифтов Windows.
sc config FontCache start= disabled >nul 2>&1
sc stop FontCache >nul 2>&1

:: LanmanServer — сервер SMB (общий доступ к файлам/принтерам).
sc config LanmanServer start= disabled >nul 2>&1
sc stop LanmanServer >nul 2>&1

:: MSDTC — координатор распределённых транзакций.
sc config MSDTC start= disabled >nul 2>&1
sc stop MSDTC >nul 2>&1

:: PcaSvc — помощник по совместимости программ.
sc config PcaSvc start= disabled >nul 2>&1
sc stop PcaSvc >nul 2>&1

:: SEMgrSvc — платежи и NFC/SE Manager.
sc config SEMgrSvc start= disabled >nul 2>&1
sc stop SEMgrSvc >nul 2>&1

:: ShellHWDetection — обнаружение оборудования оболочки.
sc config ShellHWDetection start= disabled >nul 2>&1
sc stop ShellHWDetection >nul 2>&1

:: SSDPSRV — обнаружение SSDP/UPnP.
sc config SSDPSRV start= disabled >nul 2>&1
sc stop SSDPSRV >nul 2>&1

:: TrkWks — клиент распределённого отслеживания ссылок.
sc config TrkWks start= disabled >nul 2>&1
sc stop TrkWks >nul 2>&1

:: UCPD — User Choice Protection Driver.
sc config UCPD start= disabled >nul 2>&1
sc stop UCPD >nul 2>&1

:: WEPHOSTSVC — хост поставщиков шифрования Windows.
sc config WEPHOSTSVC start= disabled >nul 2>&1
sc stop WEPHOSTSVC >nul 2>&1

:: WinRM — удалённое управление Windows (WS-Management).
sc config WinRM start= disabled >nul 2>&1
sc stop WinRM >nul 2>&1

:: AssignedAccessManagerSvc — диспетчер назначенного доступа (киоск-режим).
sc config AssignedAccessManagerSvc start= disabled >nul 2>&1
sc stop AssignedAccessManagerSvc >nul 2>&1

:: NvTelemetryContainer — телеметрия NVIDIA.
sc config NvTelemetryContainer start= disabled >nul 2>&1
sc stop NvTelemetryContainer >nul 2>&1

:: TroubleshootingSvc — рекомендуемые действия по устранению неполадок.
sc config TroubleshootingSvc start= disabled >nul 2>&1
sc stop TroubleshootingSvc >nul 2>&1

:: UdkUserSvc — вспомогательная пользовательская служба.
sc config UdkUserSvc start= disabled >nul 2>&1
sc stop UdkUserSvc >nul 2>&1

:: uhssvc — вспомогательная служба (MSIX/сторонняя).
sc config uhssvc start= disabled >nul 2>&1
sc stop uhssvc >nul 2>&1

:: WarpJITSvc — Warp JIT Service.
sc config WarpJITSvc start= disabled >nul 2>&1
sc stop WarpJITSvc >nul 2>&1

:: Wecsvc — сборщик событий Windows.
sc config Wecsvc start= disabled >nul 2>&1
sc stop Wecsvc >nul 2>&1

:: wercplsupport — поддержка панели отчётов о проблемах.
sc config wercplsupport start= disabled >nul 2>&1
sc stop wercplsupport >nul 2>&1

:: NetBT — NetBIOS over TCP/IP.
sc config NetBT start= disabled >nul 2>&1
sc stop NetBT >nul 2>&1

:: GpuEnergyDrv — драйвер энергопотребления GPU.
sc config GpuEnergyDrv start= disabled >nul 2>&1
sc stop GpuEnergyDrv >nul 2>&1


:: ============================================================================
::  ИСТОЧНИК: Службы\Отключить телеметрию и диагностику.bat
::  Для каждой: sc config disabled + sc stop.
:: ============================================================================

:: DiagTrack — Connected User Experiences and Telemetry.
sc config DiagTrack start= disabled >nul 2>&1
sc stop DiagTrack >nul 2>&1

:: dmwappushservice — маршрутизация WAP push.
sc config dmwappushservice start= disabled >nul 2>&1
sc stop dmwappushservice >nul 2>&1

:: diagnosticshub.standardcollector.service — сборщик диагностики.
sc config diagnosticshub.standardcollector.service start= disabled >nul 2>&1
sc stop diagnosticshub.standardcollector.service >nul 2>&1

:: pla — Performance Logs & Alerts.
sc config pla start= disabled >nul 2>&1
sc stop pla >nul 2>&1

:: WdiServiceHost — хост службы диагностики.
sc config WdiServiceHost start= disabled >nul 2>&1
sc stop WdiServiceHost >nul 2>&1

:: WdiSystemHost — системный хост диагностики.
sc config WdiSystemHost start= disabled >nul 2>&1
sc stop WdiSystemHost >nul 2>&1

:: WerSvc — отчёты об ошибках Windows.
sc config WerSvc start= disabled >nul 2>&1
sc stop WerSvc >nul 2>&1


:: ============================================================================
::                                 КОНЕЦ
:: ============================================================================
echo.
echo Готово. Отключено служб по RapidOS: 35.
pause
exit /b 0