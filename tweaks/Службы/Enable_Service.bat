@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Включение службы
net session >nul 2>&1 || (
    echo [!] Запустите от имени администратора.
    pause
    exit /b 1
)

if "%~1"=="" (
    echo [ERROR] Не указано имя службы.
    echo Использование: %~nx0 ^<имя_службы^>
    pause
    exit /b 1
)

set "SVC_NAME=%~1"
echo [!] Включение службы: !SVC_NAME!

REM Возвращаем тип запуска в "Вручную" (Start=3)
reg add "HKLM\SYSTEM\CurrentControlSet\Services\!SVC_NAME!" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
sc config "!SVC_NAME!" start= demand >nul 2>&1

REM Пытаемся запустить службу
sc start "!SVC_NAME!" >nul 2>&1
if !errorlevel! equ 0 (
    echo [OK] Служба !SVC_NAME! включена и запущена.
) else (
    echo [OK] Служба !SVC_NAME! переведена в ручной режим (Start=3). Автозапуск невозможен или служба ещё не стартовала.
)

endlocal