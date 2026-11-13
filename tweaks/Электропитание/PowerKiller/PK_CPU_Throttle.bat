@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title VampireOS — PK: CPU Throttle off
cd /d "%~dp0"

net session >nul 2>&1 || ( echo [!] Запустите от администратора. & pause & exit /b 1 )

echo ============================================================
echo  VampireOS — PK: CPU Throttle off
echo ============================================================
echo.
rem --- Ultimate Performance ---
echo [*] Создание и активация Ultimate Performance...
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
if errorlevel 1 (
    powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
    powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
)

rem --- Раскрыть скрытые пункты электропитания (UI) ---
echo [*] Раскрытие скрытых пунктов электропитания...
for %%G in (
    0cc5b647-c1df-4637-891a-dec35c318583
    3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb
    5d76a2ca-e8c0-402f-a133-2158492d58ad
    a55612aa-f624-42c6-a443-7397d064c04f
    ea062031-0e34-4ff1-9b6d-eb1059334028
    bc5038f7-23e0-4960-96da-33abaf5935ec
) do reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\%%G" /v Attributes /t REG_DWORD /d 0 /f >nul 2>&1

rem --- CPU на AC: 100% min/max, idle off, core parking off ---
echo [*] CPU на AC: 100%%, idle off, core parking off...
powercfg -setacvalueindex scheme_current sub_processor 893dee8e-2bef-41e0-89c6-b55d0929964c 100 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor bc5038f7-23e0-4960-96da-33abaf5935ec 100 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 >nul 2>&1
powercfg -setacvalueindex scheme_current sub_processor 0cc5b647-c1df-4637-891a-dec35c318583 100 >nul 2>&1
powercfg /setactive scheme_current >nul 2>&1

rem --- Контекстное меню: Disable Idle / Enable Idle ---
echo [*] Контекстное меню: Disable Idle / Enable Idle...
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\05menu" /v MUIVerb /t REG_SZ /d "Disable Idle" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\05menu" /v Icon /t REG_SZ /d "powercpl.dll" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\05menu" /v CommandFlags /t REG_DWORD /d 32 /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\05menu\command" /ve /t REG_SZ /d "cmd.exe /c powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 && powercfg -setactive scheme_current" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\06menu" /v MUIVerb /t REG_SZ /d "Enable Idle" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\06menu" /v Icon /t REG_SZ /d "powercpl.dll" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\06menu\command" /ve /t REG_SZ /d "cmd.exe /c powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 0 && powercfg -setactive scheme_current" /f >nul 2>&1

echo.
echo ============================================================
echo  Готово: CPU throttle отключён, Ultimate Performance активен, idle off, core parking off.
echo ============================================================
echo.
