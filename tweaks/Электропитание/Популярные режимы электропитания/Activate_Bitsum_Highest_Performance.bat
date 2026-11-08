@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Активация плана: Bitsum Highest Performance
net session >nul 2>&1 || (
    echo [!] Запустите от имени администратора.
    pause & exit /b 1
)

echo [!] Поиск плана: Bitsum Highest Performance

set "FOUND_GUID="
set "COUNT=0"
for /f "tokens=2 delims=()" %%G in ('powercfg /list ^| findstr /i /c:"Bitsum Highest Performance"') do (
    set "FOUND_GUID=%%G"
    set /a COUNT+=1
)
set "FOUND_GUID=!FOUND_GUID: =!"
set "FOUND_GUID=!FOUND_GUID:(=!"
set "FOUND_GUID=!FOUND_GUID:)=!"

if not defined FOUND_GUID (
    echo [ERROR] План "Bitsum Highest Performance" не найден в системе.
    echo [!] Сначала импортируйте его через кнопку "Импортировать план".
    pause
    exit /b 1
)

if !COUNT! gtr 1 (
    echo [WARNING] Обнаружено !COUNT! копий плана "Bitsum Highest Performance".
    echo [!] Будет активирована последняя найденная копия.
    echo [!] Рекомендуется удалить дубликаты вручную через: powercfg /list
)

echo [+] Найдено копий: !COUNT!
echo [+] GUID: !FOUND_GUID!
echo [!] Активация...
powercfg /setactive !FOUND_GUID! >nul 2>&1
if !errorlevel! equ 0 (
    echo [OK] План "Bitsum Highest Performance" активирован.
) else (
    echo [ERROR] Не удалось активировать план.
)
echo.
pause
