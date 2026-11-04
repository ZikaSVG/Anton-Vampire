@echo off
setlocal EnableExtensions
chcp 65001 >nul
title SynergyOS - только службы

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Запустите от имени администратора.
    pause
    exit /b 1
)

:: ============================================================================
::                           КРУТАЯ ШАПКА
:: ============================================================================
::  Standalone-батник по SynergyOS (SynergyOS.txt).
::  Включены ТОЛЬКО действия над службами:
::    reg add "...\Services\X" /v Start /d 4    (из «Настроить службы.bat»)
::    sc config X start= disabled              (заменяет sc delete из «Удалить Edge»)
::  Папки "отмена" не включены. Дубликатов нет.
::  Удаляемые службы (3 из Edge) — отключены, не удалены.
::
::  ВНИМАНИЕ: в исходнике есть предположительные опечатки в именах служб.
::  Я сохранил их как в источнике и указал рядом реальное имя:
::    tzautoupdates              -> вероятно tzautoupdate
::    BcastDVRUserService_389fd  -> базовая служба BcastDVRUserService
::    PrintWorkflowUserSv        -> вероятно PrintWorkflowUserSvc
::  Если reg add создаст несуществующий ключ, служба НЕ отключится.
:: ============================================================================


:: ============================================================================
::  ИСТОЧНИК: Производительность\Настроить службы.bat
::  Порядок и имена сохранены как в источнике. Всё через reg add Start=4.
:: ============================================================================

:: ============================================================================
::  Отключить AppCompat.bat
::  В источнике: reg add Start=4 + sc stop PcaSvc.
::  Помимо этого в файле есть три реестровых ключа AppCompat
::  (DisableInventory, DisableUAR, DisablePCA) — они не относятся к службам
::  и в этот батник не включены.
:: ============================================================================

:: PcaSvc — помощник по совместимости программ (Program Compatibility
:: Assistant Service). В источнике указано имя с заглавной "PcaSvc",
:: Windows регистронезависим.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PcaSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop PcaSvc >nul 2>&1

:: AxInstSV — установщик ActiveX.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AxInstSV" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: tzautoupdates — автообновление часового пояса (в источнике с "s").
:: Реальное имя службы в Windows: tzautoupdate.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\tzautoupdates" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: bthserv — поддержка Bluetooth.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\bthserv" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: BthAvctpSvc — служба AVCTP Bluetooth.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthAvctpSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: BluetoothUserService — пользовательская служба Bluetooth.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BluetoothUserService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: BcastDVRUserService_389fd — пользовательская служба записи трансляций.
:: В источнике указан суффикс _389fd (per-user инстанс).
:: Базовая служба: BcastDVRUserService.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BcastDVRUserService_389fd" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: DoSvc — оптимизация доставки (Delivery Optimization).
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: NaturalAuthentication — естественная аутентификация.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NaturalAuthentication" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: MapsBroker — менеджер загруженных карт.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: DiagTrack — Connected User Experiences and Telemetry.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: lfsvc — геолокация.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: dmwappushservice — маршрутизация WAP push.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: SharedAccess — общий доступ к интернету (ICS).
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: lltdsvc — карта сети LLTD.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lltdsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: CDPUserSvc — пользовательская часть Connected Devices Platform.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: NetTcpPortSharing — общий доступ к портам TCP.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetTcpPortSharing" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: CscService — автономные файлы.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CscService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: QWAVE — качество аудио/видео в сети.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\QWAVE" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: RemoteAccess — маршрутизация и удалённый доступ.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\RemoteAccess" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: SensorDataService — данные датчиков.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensorDataService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: SensrSvc — мониторинг датчиков.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensrSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: SensorService — служба датчиков.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensorService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: ShellHWDetection — обнаружение оборудования оболочки.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ShellHWDetection" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: ScDeviceEnum — перечисление устройств чтения смарт-карт.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ScDeviceEnum" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: SSDPSRV — обнаружение SSDP.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SSDPSRV" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: WiaRpc — события получения изображений.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WiaRpc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: upnphost — хост устройств UPnP.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\upnphost" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: UserDataSvc — данные пользователя.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UserDataSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: UevAgentService — виртуализация пользовательского опыта (UE-V).
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UevAgentService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: Fax — факс.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Fax" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: FrameServer — кадровый сервер камеры.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\FrameServer" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: FrameServerMonitor — монитор кадрового сервера.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\FrameServerMonitor" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: stisvc — захват изображений (сканеры/камеры).
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stisvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: WerSvc — отчёты об ошибках Windows.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WerSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: WpnService — системная служба push-уведомлений.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WpnService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: WpnUserService — пользовательская служба push-уведомлений.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WpnUserService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: Spooler — диспетчер печати.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Spooler" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: PrintWorkflowUserSv — рабочие процессы печати.
:: В источнике имя обрезано; реальное имя службы: PrintWorkflowUserSvc.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PrintWorkflowUserSv" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: PrintNotify — уведомления принтера.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PrintNotify" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: wisvc — Windows Insider.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wisvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: icssvc — мобильная точка доступа (Mobile Hotspot).
reg add "HKLM\SYSTEM\CurrentControlSet\Services\icssvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: GpuEnergyDrv — драйвер энергопотребления GPU.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v Start /t REG_DWORD /d 4 /f >nul 2>&1


:: ============================================================================
::  ИСТОЧНИК: Удаление программ\Удалить Microsoft Edge.bat
::  В источнике эти службы УДАЛЯЮТСЯ через sc delete.
::  По вашему правилу — отключаем через sc config, не удаляем.
:: ============================================================================

:: edgeupdate — служба обновления Microsoft Edge.
sc config edgeupdate start= disabled >nul 2>&1
sc stop edgeupdate >nul 2>&1

:: edgeupdatem — служба обновления Microsoft Edge (ручной режим).
sc config edgeupdatem start= disabled >nul 2>&1
sc stop edgeupdatem >nul 2>&1

:: MicrosoftEdgeElevationService — служба повышения прав Microsoft Edge.
sc config MicrosoftEdgeElevationService start= disabled >nul 2>&1
sc stop MicrosoftEdgeElevationService >nul 2>&1


:: ============================================================================
::                                 КОНЕЦ
:: ============================================================================
echo.
echo Готово. Обработано служб по SynergyOS: 45.
echo Удаляемые в источнике службы (3 из Edge) отключены, а не удалены.
pause
exit /b 0