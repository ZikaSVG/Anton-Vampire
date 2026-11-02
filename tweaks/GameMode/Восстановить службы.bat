@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul

set "BACKUP_FILE=%~dp0services.backup"
if not exist "%BACKUP_FILE%" (
    echo [ОШИБКА] Файл бэкапа не найден: "%BACKUP_FILE%"
    exit /b 1
)

echo Восстановление служб из "%BACKUP_FILE%"...
set "COUNT=0"
for /f "usebackq tokens=1,2 delims==" %%L in ("%BACKUP_FILE%") do (
    set "NAME=%%L"
    set "VAL=%%M"
    if not "!NAME:~0,1!"=="#" (
        if not "!NAME!"=="" (
            reg add "HKLM\SYSTEM\CurrentControlSet\Services\!NAME!" /v Start /t REG_DWORD /d !VAL! /f >nul 2>&1
            if not errorlevel 1 set /a COUNT+=1
        )
    )
)
echo [OK] Восстановлено служб: %COUNT%
endlocal