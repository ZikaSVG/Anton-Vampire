@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить MaxTelemetryAllowed

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить MaxTelemetryAllowed
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v MaxTelemetryAllowed /f >nul 2>&1

echo.
echo [OK] Отменено: Включить MaxTelemetryAllowed
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
