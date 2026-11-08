@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Schedule Adapter Logging

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Schedule Adapter Logging
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Configuration" /v AdapterLoggingEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Configuration" /v EnableAt /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить Schedule Adapter Logging
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
