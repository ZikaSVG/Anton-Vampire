@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить устройства питания

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Отключить устройства питания
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "Get-WmiObject MSPower_DeviceEnable -Namespace root\wmi | ForEach-Object { $_.enable = $false; $_.psbase.put(); }" >nul 2>&1

echo.
echo [OK] Готово: Отключить устройства питания
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
