@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul

rem ============================================================
rem  Бэкап состояния служб перед применением игрового режима.
rem  Сохраняет только те службы, которые СЕЙЧАС НЕ отключены (Start != 4).
rem  Результат: GameMode\services.backup  (формат: имя=StartType)
rem ============================================================

net session >nul 2>&1 || (echo [!] Запустите от администратора. & pause & exit /b 1)

set "BACKUP_FILE=%~dp0services.backup"
set "LIST_FILE=%~dp0services.txt"

if not exist "%LIST_FILE%" (
    echo [ОШИБКА] Не найден "%LIST_FILE%"
    pause & exit /b 1
)

if exist "%BACKUP_FILE%" del /f /q "%BACKUP_FILE%"
echo # services backup ^(name=StartType^) > "%BACKUP_FILE%"

echo Бэкап состояния служб...
set "COUNT=0"
for /f "usebackq eol=# delims=" %%S in ("%LIST_FILE%") do (
    if not "%%S"=="" (
        set "ST="
        for /f "tokens=3" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /v Start 2^>nul ^| findstr /i "Start"') do set "ST=%%A"
        if defined ST (
            if not "!ST!"=="0x4" (
                echo %%S=!ST!>>"%BACKUP_FILE%"
                set /a COUNT+=1
            )
        )
    )
)

echo.
echo [OK] Сохранено служб: %COUNT%
echo Бэкап: "%BACKUP_FILE%"
endlocal