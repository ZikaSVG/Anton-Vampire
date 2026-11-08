@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить StartOobeAppsScanAfterUpdate

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить StartOobeAppsScanAfterUpdate
echo.

powershell -NoProfile -Command "Disable-ScheduledTask -TaskPath '\Microsoft\Windows\UpdateOrchestrator' -TaskName 'StartOobeAppsScanAfterUpdate' -EA 0"

echo.
echo [OK] Готово: Отключить StartOobeAppsScanAfterUpdate
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
