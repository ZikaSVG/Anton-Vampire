@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить MaxTelemetryAllowed

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить MaxTelemetryAllowed
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v MaxTelemetryAllowed /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить MaxTelemetryAllowed
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
