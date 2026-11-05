@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключение службы
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
echo [!] Отключение службы: !SVC_NAME!

REM Останавливаем службу (если запущена)
sc stop "!SVC_NAME!" >nul 2>&1

REM Переводим в "Отключено" через sc config
sc config "!SVC_NAME!" start= disabled >nul 2>&1

REM Дублируем через реестр (Start=4)
reg add "HKLM\SYSTEM\CurrentControlSet\Services\!SVC_NAME!" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

echo [OK] Служба !SVC_NAME! отключена (Start=4).

endlocal