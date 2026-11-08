@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Активация плана: Zoyata_Low Latency
net session >nul 2>&1 || (
    echo [!] Запустите от имени администратора.
    pause & exit /b 1
)

echo [!] Поиск плана: Zoyata_Low Latency

set "FOUND_GUID="
set "COUNT=0"
for /f "tokens=2 delims=()" %%G in ('powercfg /list ^| findstr /i /c:"Zoyata_Low Latency"') do (
    set "FOUND_GUID=%%G"
    set /a COUNT+=1
)
set "FOUND_GUID=!FOUND_GUID: =!"
set "FOUND_GUID=!FOUND_GUID:(=!"
set "FOUND_GUID=!FOUND_GUID:)=!"

if not defined FOUND_GUID (
    echo [ERROR] План "Zoyata_Low Latency" не найден в системе.
    echo [!] Сначала импортируйте его через кнопку "Импортировать план".
    pause
    exit /b 1
)

if !COUNT! gtr 1 (
    echo [WARNING] Обнаружено !COUNT! копий плана "Zoyata_Low Latency".
    echo [!] Будет активирована последняя найденная копия.
    echo [!] Рекомендуется удалить дубликаты вручную через: powercfg /list
)

echo [+] Найдено копий: !COUNT!
echo [+] GUID: !FOUND_GUID!
echo [!] Активация...
powercfg /setactive !FOUND_GUID! >nul 2>&1
if !errorlevel! equ 0 (
    echo [OK] План "Zoyata_Low Latency" активирован.
) else (
    echo [ERROR] Не удалось активировать план.
)
echo.
pause
