@echo off
setlocal EnableExtensions
chcp 65001 >nul
title MartyFiles - только службы

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Запустите от имени администратора.
    pause
    exit /b 1
)

:: ============================================================================
::                           КРУТАЯ ШАПКА
:: ============================================================================
::  Standalone-батник по MartyFiles.
::  Включены ТОЛЬКО действия над службами:
::    - Reg add Start=4 (отключение)
::    - sc config start= disabled / sc stop / net stop
::    - Reg delete ключа службы (закомментировано, см. ниже)
::  НЕ включены: powercfg, bcdedit, dism, schtasks, vssadmin,
::  удаление файлов/папок, hosts, reg-твики, очистка, компоненты и т.д.
:: ============================================================================


:: Отключить службу сбора диагностических данных
:: diagnosticshub.standardcollector.service (Microsoft Diagnostics Hub Standard
:: Collector) — хост-служба Visual Studio и других инструментов для сбора
:: диагностических данных.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /v "Start" /t REG_DWORD /d "4" /f


:: Отключить службу телеметрии DiagTrack
:: DiagTrack (Connected User Experiences and Telemetry) — собирает и отправляет
:: телеметрию в Microsoft.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f


:: Отключить службу маршрутизации WAP push-сообщений
:: dmwappushservice (Device Management WAP Push Message Routing Service) —
:: маршрутизирует WAP-push для управления устройствами; связана с телеметрией.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f


:: Отключить пользовательскую службу платформы подключённых устройств
:: CDPUserSvc (CDPUserSvc) — пользовательская часть Connected Devices Platform;
:: используется для «скрытого мониторинга» и синхронизации.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc" /v "Start" /t REG_DWORD /d "4" /f


:: Отключить службу телеметрии NVIDIA
:: NvTelemetryContainer (NVIDIA Telemetry Container) — отправляет телеметрию NVIDIA.
:: В источнике помимо Start=4 также применялись sc config disabled и остановка.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NvTelemetryContainer" /v "Start" /t REG_DWORD /d "4" /f
sc config NvTelemetryContainer start= disabled >nul 2>&1
net stop NvTelemetryContainer >nul 2>&1
sc stop NvTelemetryContainer >nul 2>&1


:: Удалить службы DiagTrack и dmwappushservice (как в файле
:: «Отключение и выпиливание шпионских модулей Microsoft.bat»).
:: Это НЕ отключение, а удаление ключа службы. По умолчанию закомментировано —
:: раскомментируйте, если действительно нужно удаление, а не отключение.
:: Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /f
:: Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /f
