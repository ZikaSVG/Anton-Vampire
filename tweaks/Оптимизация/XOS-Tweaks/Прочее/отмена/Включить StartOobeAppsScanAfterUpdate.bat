@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить StartOobeAppsScanAfterUpdate

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить StartOobeAppsScanAfterUpdate
echo.

powershell -NoProfile -Command "Enable-ScheduledTask -TaskPath '\Microsoft\Windows\UpdateOrchestrator' -TaskName 'StartOobeAppsScanAfterUpdate' -EA 0"

echo.
echo [OK] Отменено: Включить StartOobeAppsScanAfterUpdate
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
