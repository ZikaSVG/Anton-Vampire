@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Импорт плана: Amit_v3_low latency
net session >nul 2>&1 || (
    echo [!] Запустите от имени администратора.
    pause & exit /b 1
)

echo [!] Проверка плана: Amit_v3_low latency

REM Проверяем, есть ли уже план с таким именем в системе
set "FOUND_GUID="
for /f "tokens=2 delims=()" %%G in ('powercfg /list ^| findstr /i /c:"Amit_v3_low latency"') do (
    set "FOUND_GUID=%%G"
)
REM Убираем пробелы и скобки из GUID
set "FOUND_GUID=!FOUND_GUID: =!"
set "FOUND_GUID=!FOUND_GUID:(=!"
set "FOUND_GUID=!FOUND_GUID:)=!"

if defined FOUND_GUID (
    echo [i] План "Amit_v3_low latency" УЖЕ импортирован в систему.
    echo [i] GUID: !FOUND_GUID!
    echo [i] Повторный импорт пропущен, чтобы не создавать дубликат.
    echo [!] Активирую существующий план...
    powercfg /setactive !FOUND_GUID! >nul 2>&1
    if !errorlevel! equ 0 (
        echo [OK] План активирован.
    ) else (
        echo [ERROR] Не удалось активировать план.
    )
) else (
    echo [+] План не найден. Выполняю импорт...
    if not exist "%~dp0Amit_v3_low latency.pow" (
        echo [ERROR] Файл Amit_v3_low latency.pow не найден в папке скрипта!
        pause
        exit /b 1
    )
    powercfg /import "%~dp0Amit_v3_low latency.pow" >nul 2>&1
    if !errorlevel! neq 0 (
        echo [ERROR] Не удалось импортировать план.
        pause
        exit /b 1
    )
    echo [OK] План импортирован. Выполняю активацию...
    REM Получаем GUID только что импортированного плана
    set "NEW_GUID="
    for /f "tokens=2 delims=()" %%G in ('powercfg /list ^| findstr /i /c:"Amit_v3_low latency"') do (
        set "NEW_GUID=%%G"
    )
    set "NEW_GUID=!NEW_GUID: =!"
    set "NEW_GUID=!NEW_GUID:(=!"
    set "NEW_GUID=!NEW_GUID:)=!"
    if defined NEW_GUID (
        powercfg /setactive !NEW_GUID! >nul 2>&1
        echo [OK] План "Amit_v3_low latency" импортирован и активирован. GUID: !NEW_GUID!
    ) else (
        echo [WARNING] План импортирован, но не удалось получить GUID для активации.
        echo [!] Активируйте план вручную через Панель управления - Электропитание.
    )
)
echo.
pause
