@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить KeyGuard Telemetry

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить KeyGuard Telemetry
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\KeyGuard" /v DisableTelemetry /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Отключить KeyGuard Telemetry
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
