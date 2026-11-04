@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Активация плана: Muren_Idle_Enabled
net session >nul 2>&1 || (
    echo [!] Запустите от имени администратора.
    pause & exit /b 1
)

echo [!] Поиск плана: Muren_Idle_Enabled

set "FOUND_GUID="
set "COUNT=0"
for /f "tokens=2 delims=()" %%G in ('powercfg /list ^| findstr /i /c:"Muren_Idle_Enabled"') do (
    set "FOUND_GUID=%%G"
    set /a COUNT+=1
)
set "FOUND_GUID=!FOUND_GUID: =!"
set "FOUND_GUID=!FOUND_GUID:(=!"
set "FOUND_GUID=!FOUND_GUID:)=!"

if not defined FOUND_GUID (
    echo [ERROR] План "Muren_Idle_Enabled" не найден в системе.
    echo [!] Сначала импортируйте его через кнопку "Импортировать план".
    pause
    exit /b 1
)

if !COUNT! gtr 1 (
    echo [WARNING] Обнаружено !COUNT! копий плана "Muren_Idle_Enabled".
    echo [!] Будет активирована последняя найденная копия.
    echo [!] Рекомендуется удалить дубликаты вручную через: powercfg /list
)

echo [+] Найдено копий: !COUNT!
echo [+] GUID: !FOUND_GUID!
echo [!] Активация...
powercfg /setactive !FOUND_GUID! >nul 2>&1
if !errorlevel! equ 0 (
    echo [OK] План "Muren_Idle_Enabled" активирован.
) else (
    echo [ERROR] Не удалось активировать план.
)
echo.
pause
