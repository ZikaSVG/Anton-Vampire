@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title VampireOS — Power: Restore from Saver
cd /d "%~dp0"

net session >nul 2>&1 || ( echo [!] Запустите от администратора. & pause & exit /b 1 )

echo ============================================================
echo  VampireOS — Power: Restore (Balanced)
echo ============================================================
echo.

rem --- Balanced ---
echo [*] Активация Balanced...
powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul 2>&1
if errorlevel 1 powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a >nul 2>&1

rem --- CPU: 5% / 100% ---
echo [*] CPU: 5%% / 100%%, idle on...
powercfg -setacvalueindex scheme_current sub_processor 893dee8e-2bef-41e0-89c6-b55d0929964c 5 >nul 2>&1
powercfg -setdcvalueindex scheme_current sub_processor 893dee8e-2bef-41e0-89c6-b55d0929964c 5 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor bc5038f7-23e0-4960-96da-33abaf5935ec 100 >nul 2>&1
powercfg -setdcvalueindex scheme_current sub_processor bc5038f7-23e0-4960-96da-33abaf5935ec 100 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 0 >nul 2>&1
powercfg -setdcvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 0 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor 0cc5b647-c1df-4637-891a-dec35c318583 100 >nul 2>&1
powercfg -setdcvalueindex scheme_current sub_processor 0cc5b647-c1df-4637-891a-dec35c318583 100 >nul 2>&1

rem --- Boost default, cool active ---
powercfg -setacvalueindex scheme_current sub_processor be337238-0d82-4146-a960-4f3749d470c7 2 >nul 2>&1
powercfg -setdcvalueindex scheme_current sub_processor be337238-0d82-4146-a960-4f3749d470c7 2 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor 94d3a615-a899-4ac5-ae2b-e4d8f634367f 1 >nul 2>&1
powercfg -setdcvalueindex scheme_current sub_processor 94d3a615-a899-4ac5-ae2b-e4d8f634367f 1 >nul 2>&1

rem --- Таймауты default ---
powercfg /change monitor-timeout-ac 10 >nul 2>&1
powercfg /change monitor-timeout-dc 5 >nul 2>&1
powercfg /change disk-timeout-ac 20 >nul 2>&1
powercfg /change disk-timeout-dc 10 >nul 2>&1
powercfg /change standby-timeout-ac 30 >nul 2>&1
powercfg /change standby-timeout-dc 15 >nul 2>&1
powercfg /change hibernate-timeout-ac 180 >nul 2>&1
powercfg /change hibernate-timeout-dc 60 >nul 2>&1

rem --- Яркость 100% ---
powercfg -setacvalueindex scheme_current sub_video aded5e82-b909-4619-9949-f5d71dac0bcb 100 >nul 2>&1
powercfg -setdcvalueindex scheme_current sub_video aded5e82-b909-4619-9949-f5d71dac0bcb 100 >nul 2>&1

rem --- Power Throttling on (default) ---
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 0 /f >nul 2>&1

rem --- Гибернация on ---
powercfg /h on >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v HibernateEnabled /t REG_DWORD /d 1 /f >nul 2>&1

powercfg /setactive scheme_current >nul 2>&1

echo.
echo ============================================================
echo  Готово. Balanced активен.
echo ============================================================
echo.