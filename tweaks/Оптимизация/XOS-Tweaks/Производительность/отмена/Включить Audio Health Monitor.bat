@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Audio Health Monitor

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Audio Health Monitor
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Audio" /v AudioHealthMonitorLimit /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Audio Health Monitor
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
