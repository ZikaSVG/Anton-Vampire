@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить KeyGuard Telemetry

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить KeyGuard Telemetry
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\KeyGuard" /v DisableTelemetry /f >nul 2>&1

echo.
echo [OK] Отменено: Включить KeyGuard Telemetry
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
