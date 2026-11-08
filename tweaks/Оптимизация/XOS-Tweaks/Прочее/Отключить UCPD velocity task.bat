@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить UCPD velocity task

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить UCPD velocity task
echo.

powershell -NoProfile -Command "Disable-ScheduledTask -TaskPath '\Microsoft\Windows\AppxDeploymentClient' -TaskName 'UCPD velocity' -EA 0"

echo.
echo [OK] Готово: Отключить UCPD velocity task
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
