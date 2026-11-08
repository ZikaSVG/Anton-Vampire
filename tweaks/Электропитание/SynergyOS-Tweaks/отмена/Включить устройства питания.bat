@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить устройства питания

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Отключить устройства питания
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "Get-WmiObject MSPower_DeviceEnable -Namespace root\wmi | ForEach-Object { $_.enable = $true; $_.psbase.put(); }" >nul 2>&1

echo.
echo [OK] Отменено: Включить устройства питания
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
