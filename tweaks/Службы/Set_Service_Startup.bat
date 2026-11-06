@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Установка типа запуска службы

net session >nul 2>&1 || (
    echo [!] Запустите от имени администратора.
    exit /b 1
)

if "%~1"=="" (
    echo [ERROR] Не указан аргумент.
    echo Использование: %~nx0 ^<service_name^>,^<start_type^>
    echo start_type: 0=Boot, 1=System, 2=Auto, 3=Manual, 4=Disabled
    exit /b 1
)

REM Парсим "Имя,Тип"
for /f "tokens=1,2 delims=," %%A in ("%~1") do (
    set "SVC_NAME=%%A"
    set "START_TYPE=%%B"
)

if "!SVC_NAME!"=="" (
    echo [ERROR] Не указано имя службы.
    exit /b 1
)
if "!START_TYPE!"=="" (
    echo [ERROR] Не указан тип запуска.
    exit /b 1
)

echo [!] Настройка службы: !SVC_NAME! (Start=!START_TYPE!)

REM --- 1. Реестр (основной способ) ---
reg add "HKLM\SYSTEM\CurrentControlSet\Services\!SVC_NAME!" /v Start /t REG_DWORD /d !START_TYPE! /f >nul 2>&1

REM --- 2. sc config + попытка применить ---
if "!START_TYPE!"=="0" (
    sc config "!SVC_NAME!" start= boot >nul 2>&1
    sc start "!SVC_NAME!" >nul 2>&1
) else if "!START_TYPE!"=="1" (
    sc config "!SVC_NAME!" start= system >nul 2>&1
    sc start "!SVC_NAME!" >nul 2>&1
) else if "!START_TYPE!"=="2" (
    sc config "!SVC_NAME!" start= auto >nul 2>&1
    sc start "!SVC_NAME!" >nul 2>&1
) else if "!START_TYPE!"=="3" (
    sc config "!SVC_NAME!" start= demand >nul 2>&1
    sc start "!SVC_NAME!" >nul 2>&1
) else if "!START_TYPE!"=="4" (
    sc config "!SVC_NAME!" start= disabled >nul 2>&1
    sc stop "!SVC_NAME!" >nul 2>&1

    REM Проверяем, действительно ли остановилась
    set "STILL_RUNNING="
    for /f "tokens=3" %%S in ('sc query "!SVC_NAME!" ^| findstr /i "STATE"') do (
        if "%%S"=="4" set "STILL_RUNNING=1"
    )
    if defined STILL_RUNNING (
        echo [!] Служба не принимает sc stop (нет STOP в SERVICE_ACCEPT^).
        echo [!] Убиваю процесс принудительно через taskkill...
        for /f "tokens=2 delims=: " %%P in ('sc queryex "!SVC_NAME!" ^| findstr /i "PID"') do (
            if not "%%P"=="0" (
                taskkill /PID %%P /F >nul 2>&1
            )
        )
    )
) else (
    echo [ERROR] Неверный тип запуска: !START_TYPE!
    exit /b 1
)

REM --- 3. Проверка реестра ---
set "CHECK_VAL="
for /f "tokens=3" %%S in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\!SVC_NAME!" /v Start 2^>nul ^| findstr /i "Start"') do set "CHECK_VAL=%%S"

REM --- 4. Текущее состояние ---
set "CUR_STATE=unknown"
for /f "tokens=3" %%S in ('sc query "!SVC_NAME!" ^| findstr /i "STATE"') do set "CUR_STATE=%%S"

echo [OK] !SVC_NAME!: Start=!CHECK_VAL! (в реестре), STATE=!CUR_STATE! (сейчас)

endlocal
exit /b 0