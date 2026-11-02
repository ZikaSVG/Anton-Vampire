@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Audio Health Monitor

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Audio Health Monitor
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Audio" /v AudioHealthMonitorLimit /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить Audio Health Monitor
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
