@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title VampireOS — PK: USB Power (LPM / D3Cold)
cd /d "%~dp0"

net session >nul 2>&1 || ( echo [!] Запустите от администратора. & pause & exit /b 1 )

echo ============================================================
echo  VampireOS — PK: USB Power (LPM / D3Cold)
echo ============================================================
echo.
rem --- USB selective suspend off ---
echo [*] USB selective suspend off...
for %%a in (
    EnhancedPowerManagementEnabled
    AllowIdleIrpInD3
    EnableSelectiveSuspend
    DeviceSelectiveSuspended
    SelectiveSuspendEnabled
    SelectiveSuspendOn
    WaitWakeEnabled
    D3ColdSupported
    WdfDirectedPowerTransitionEnable
    EnableIdlePowerManagement
    IdleInWorkingState
    WakeEnabled
) do for /f "delims=" %%b in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "%%a" ^| findstr "HKEY"') do reg add "%%b" /v "%%a" /t REG_DWORD /d 0 /f >nul 2>&1

rem --- USBHUB3 / usbccgp / pci ---
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v DisableLPM /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v D3ColdSupported /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v Ceip /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v DisableSelectiveSuspendUI /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usbccgp\Parameters" /v D3ColdSupported /t REG_DWORD /d 0 /f >nul 2>&1

rem --- Энергопотребление: отключить MSPower_DeviceEnable ---
echo [*] MSPower_DeviceEnable off...
powershell -NoProfile -Command "Get-WmiObject MSPower_DeviceEnable -Namespace root\wmi -ErrorAction SilentlyContinue | ForEach-Object { try { $_.Enable = $false; $_.psbase.Put() | Out-Null } catch {} }" >nul 2>&1

echo.
echo ============================================================
echo  Готово: USB LPM / D3Cold / selective suspend отключены.
echo ============================================================
echo.
