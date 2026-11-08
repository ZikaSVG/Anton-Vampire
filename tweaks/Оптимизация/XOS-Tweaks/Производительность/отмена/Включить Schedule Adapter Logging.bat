@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Schedule Adapter Logging

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Schedule Adapter Logging
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Configuration" /v AdapterLoggingEnabled /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Configuration" /v EnableAt /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Schedule Adapter Logging
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
