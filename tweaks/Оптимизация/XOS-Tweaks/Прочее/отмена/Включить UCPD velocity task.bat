@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить UCPD velocity task

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить UCPD velocity task
echo.

powershell -NoProfile -Command "Enable-ScheduledTask -TaskPath '\Microsoft\Windows\AppxDeploymentClient' -TaskName 'UCPD velocity' -EA 0"

echo.
echo [OK] Отменено: Включить UCPD velocity task
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
