@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title VampireOS — PK: Power Throttling & Dynamic Tick
cd /d "%~dp0"

net session >nul 2>&1 || ( echo [!] Запустите от администратора. & pause & exit /b 1 )

echo ============================================================
echo  VampireOS — PK: Power Throttling & Dynamic Tick
echo ============================================================
echo.
rem --- Power Throttling off ---
echo [*] Power Throttling off...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 1 /f >nul 2>&1

rem --- BCD: disabledynamictick ---
echo [*] BCD: disabledynamictick...
bcdedit /set disabledynamictick yes >nul 2>&1

rem --- Memory Compression off ---
echo [*] Memory Compression off...
powershell -NoProfile -Command "Disable-MMAgent -MemoryCompression -ErrorAction SilentlyContinue" >nul 2>&1

echo.
echo ============================================================
echo  Готово: Power Throttling off, disabledynamictick yes, Memory Compression off.
echo ============================================================
echo.
