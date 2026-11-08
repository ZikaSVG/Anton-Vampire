@echo off
chcp 65001 >nul
title Призрачные устройства
net session >nul 2>&1
if errorlevel 1 (
    echo [!] Нужны права администратора.
    exit /b 1
)
set devmgr_show_nonpresent_devices=1

echo ============================================================
echo   СКРЫТЫЕ / ПРОБЛЕМНЫЕ УСТРОЙСТВА
echo ============================================================
echo.
powershell -NoProfile -Command "Get-PnpDevice | Where-Object {$_.Status -eq 'Error' -or $_.Status -eq 'Unknown'} | Select-Object -First 30 | Format-Table Status, Class, FriendlyName -AutoSize"
echo.

set /p DEL="Удалить перечисленные устройства? [y/N]: "
if /i not "%DEL%"=="y" goto SKIP

echo Удаление...
powershell -NoProfile -Command "Get-PnpDevice | Where-Object {$_.Status -eq 'Error' -or $_.Status -eq 'Unknown'} | ForEach-Object { pnputil /remove-device $_.InstanceId }"

:SKIP
echo Готово.