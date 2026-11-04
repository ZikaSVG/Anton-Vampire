@echo off
setlocal EnableExtensions
chcp 65001 >nul
title XOS - только службы

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Запустите от имени администратора.
    pause
    exit /b 1
)

:: ============================================================================
::                           КРУТАЯ ШАПКА
:: ============================================================================
::  Standalone-батник по XOS (XOS.txt).
::  Включены ТОЛЬКО отключения служб:
::    sc config X start= disabled
::    sc stop X
::    reg add "...\Services\X" /v Start /d 4
::  Удаляемые службы (3 из Edge) — отключены, не удалены.
::  Папки "отмена" не включены.
::  НЕ включены: SvcHostSplitDisable=1 (не отключает службы),
::  параметры Dhcp/Dnscache/BFE/iphlpsvc/BrokerInfrastructure,
::  а также sc config w32time start=demand (это включение в manual).
::  Дубликатов нет — 33 службы.
:: ============================================================================


:: ============================================================================
::  Производительность\Отключить Assigned Access Manager.bat
:: ============================================================================

:: AssignedAccessManagerSvc — диспетчер назначенного доступа (киоск-режим).
sc config AssignedAccessManagerSvc start= disabled >nul 2>&1
sc stop AssignedAccessManagerSvc >nul 2>&1


:: ============================================================================
::  Производительность\Отключить Connected Devices Platform.bat
:: ============================================================================

:: CDPSvc — платформа подключённых устройств.
sc config CDPSvc start= disabled >nul 2>&1
sc stop CDPSvc >nul 2>&1

:: CDPUserSvc — пользовательская часть CDP.
sc config CDPUserSvc start= disabled >nul 2>&1


:: ============================================================================
::  Производительность\Отключить DiagTrack.bat
:: ============================================================================

:: DiagTrack — Connected User Experiences and Telemetry.
sc config DiagTrack start= disabled >nul 2>&1
sc stop DiagTrack >nul 2>&1

:: dmwappushservice — маршрутизация WAP push.
sc config dmwappushservice start= disabled >nul 2>&1
sc stop dmwappushservice >nul 2>&1


:: ============================================================================
::  Производительность\Отключить Downloaded Maps Manager.bat
:: ============================================================================

:: MapsBroker — менеджер загруженных карт.
sc config MapsBroker start= disabled >nul 2>&1
sc stop MapsBroker >nul 2>&1


:: ============================================================================
::  Производительность\Отключить Mixed Reality OpenXR.bat
:: ============================================================================

:: MixedRealityOpenXRSvc — служба Windows Mixed Reality OpenXR.
sc config MixedRealityOpenXRSvc start= disabled >nul 2>&1
sc stop MixedRealityOpenXRSvc >nul 2>&1


:: ============================================================================
::  Производительность\Отключить Print Spooler.bat
:: ============================================================================

:: Spooler — диспетчер печати.
sc config Spooler start= disabled >nul 2>&1
sc stop Spooler >nul 2>&1


:: ============================================================================
::  Производительность\Отключить Push Notifications Services.bat
:: ============================================================================

:: WpnService — системная служба push-уведомлений.
sc config WpnService start= disabled >nul 2>&1
sc stop WpnService >nul 2>&1

:: WpnUserService — пользовательская служба push-уведомлений.
sc config WpnUserService start= disabled >nul 2>&1


:: ============================================================================
::  Производительность\Отключить Sensor Services.bat
:: ============================================================================

:: SensorService — служба датчиков.
sc config SensorService start= disabled >nul 2>&1
sc stop SensorService >nul 2>&1

:: SensrSvc — мониторинг датчиков.
sc config SensrSvc start= disabled >nul 2>&1
sc stop SensrSvc >nul 2>&1


:: ============================================================================
::  Производительность\Отключить Storage Service.bat
:: ============================================================================

:: StorSvc — служба хранилища.
sc config storSvc start= disabled >nul 2>&1
sc stop storSvc >nul 2>&1


:: ============================================================================
::  Производительность\Отключить SysMain Superfetch.bat
:: ============================================================================

:: SysMain — SysMain (бывший Superfetch).
sc config SysMain start= disabled >nul 2>&1
sc stop SysMain >nul 2>&1


:: ============================================================================
::  Производительность\Отключить Windows Biometric Service.bat
:: ============================================================================

:: WbioSrvc — служба биометрии Windows.
sc config WbioSrvc start= disabled >nul 2>&1
sc stop WbioSrvc >nul 2>&1


:: ============================================================================
::  Производительность\Отключить Windows Media Player Network Sharing.bat
:: ============================================================================

:: WMPNetworkSvc — общий доступ к медиатеке WMP.
sc config WMPNetworkSvc start= disabled >nul 2>&1
sc stop WMPNetworkSvc >nul 2>&1


:: ============================================================================
::  Производительность\Отключить Windows Remote Management.bat
:: ============================================================================

:: WinRM — удалённое управление Windows (WS-Management).
sc config WinRM start= disabled >nul 2>&1
sc stop WinRM >nul 2>&1


:: ============================================================================
::  Производительность\Отключить Windows Search Indexer.bat
:: ============================================================================

:: WSearch — Windows Search (индексирование).
sc config WSearch start= disabled >nul 2>&1
sc stop WSearch >nul 2>&1


:: ============================================================================
::  Производительность\Отключить Windows Update службу.bat
::  В источнике помимо службы ещё reg add NoAutoUpdate=1 — это не служба,
::  поэтому в этот батник оно НЕ включено.
:: ============================================================================

:: wuauserv — Центр обновления Windows.
sc config wuauserv start= disabled >nul 2>&1
sc stop wuauserv >nul 2>&1


:: ============================================================================
::  Производительность\Отключить Xbox Live Services.bat
:: ============================================================================

:: XblAuthManager — аутентификация Xbox Live.
sc config XblAuthManager start= disabled >nul 2>&1
sc stop XblAuthManager >nul 2>&1

:: XblGameSave — сохранения Xbox Live.
sc config XblGameSave start= disabled >nul 2>&1
sc stop XblGameSave >nul 2>&1

:: XboxNetApiSvc — сетевая служба Xbox Live.
sc config XboxNetApiSvc start= disabled >nul 2>&1
sc stop XboxNetApiSvc >nul 2>&1


:: ============================================================================
::  Производительность\Отключить Desktop-only службы.bat
::  Все — reg add Start=4. Имена сохранены как в источнике.
:: ============================================================================

:: Cmbatt — имя как в источнике (возможно, опечатка; реальной службы
:: с таким именем в Windows нет — ключ просто создастся пустым).
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Cmbatt" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: acpiex — драйвер ACPI Extension (критичный). ⚠️
reg add "HKLM\SYSTEM\CurrentControlSet\Services\acpiex" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: acpipagr — ACPI-агрегатор процессора.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\acpipagr" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: acpipmi — ACPI-драйвер управления питанием.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\acpipmi" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: acpitime — ACPI-драйвер времени.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\acpitime" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: bam — Background Activity Moderator.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\bam" /v Start /t REG_DWORD /d 4 /f >nul 2>&1


:: ============================================================================
::  Прочее\Server MSDTC отключить.bat
::  В источнике порядок обратный: сначала stop, потом config.
:: ============================================================================

:: MSDTC — координатор распределённых транзакций.
sc stop MSDTC >nul 2>&1
sc config MSDTC start= disabled >nul 2>&1


:: ============================================================================
::  Удаление программ\Удалить WSL.bat
::  В источнике: reg add Start=4 для WslService.
:: ============================================================================

:: WslService — служба Windows Subsystem for Linux.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WslService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1


:: ============================================================================
::  Удаление программ\Удалить Microsoft Edge.bat
::  В источнике эти службы УДАЛЯЮТСЯ через sc delete.
::  По вашему правилу — отключаем, не удаляем.
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
echo Готово. Обработано служб по XOS: 33.
echo Удаляемые в источнике службы Edge (3) отключены, а не удалены.
pause
exit /b 0