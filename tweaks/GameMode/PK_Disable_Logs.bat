@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title VampireOS — PK: Disable power diagnostic logs
cd /d "%~dp0"

net session >nul 2>&1 || ( echo [!] Запустите от администратора. & pause & exit /b 1 )

echo ============================================================
echo  VampireOS — PK: Disable power diagnostic logs
echo ============================================================
echo.
rem --- wevtutil sl power diagnostic logs off ---
echo [*] Отключение диагностических журналов питания...
wevtutil sl Microsoft-Windows-SleepStudy/Diagnostic /e:false >nul 2>&1
wevtutil sl Microsoft-Windows-Kernel-Processor-Power/Diagnostic /e:false >nul 2>&1
wevtutil sl Microsoft-Windows-UserModePowerService/Diagnostic /e:false >nul 2>&1

rem --- CEIP off ---
reg add "HKLM\Software\Policies\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\SQMClient" /v UploadDisableFlag /t REG_DWORD /d 1 /f >nul 2>&1

rem --- Teredo AllowLowPowerMode=0 ---
reg add "HKLM\SYSTEM\CurrentControlSet\Services\iphlpsvc\Teredo" /v AllowLowPowerMode /t REG_DWORD /d 0 /f >nul 2>&1

rem --- NoMobilityCenter ---
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\MobilityCenter" /v NoMobilityCenter /t REG_DWORD /d 1 /f >nul 2>&1

rem --- InsightsEnabled off ---
for /f "usebackq delims=" %%s in (`reg query HKU 2^>nul ^| findstr /r "S-1-5-21-[0-9]*-[0-9]*-[0-9]*$"`) do reg add "%%s\Software\Microsoft\input\Settings" /v InsightsEnabled /t REG_DWORD /d 0 /f >nul 2>&1

echo.
echo ============================================================
echo  Готово: Диагностические журналы питания отключены, CEIP off, Teredo low power off.
echo ============================================================
echo.
