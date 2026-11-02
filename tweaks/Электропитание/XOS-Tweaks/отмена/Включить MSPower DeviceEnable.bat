@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить MSPower DeviceEnable

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить MSPower DeviceEnable
echo.

powershell -NoProfile -Command "Get-WmiObject MSPower_DeviceEnable -Namespace root\wmi -EA 0 | ForEach-Object { try { $_.Enable = $true; $_.psbase.Put() | Out-Null } catch {} }"

echo.
echo [OK] Отменено: Включить MSPower DeviceEnable
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
