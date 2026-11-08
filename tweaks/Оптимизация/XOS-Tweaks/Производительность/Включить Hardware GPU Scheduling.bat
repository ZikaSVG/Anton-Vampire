@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Включить Hardware GPU Scheduling

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Включить Hardware GPU Scheduling
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f

echo.
echo [OK] Готово: Включить Hardware GPU Scheduling
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
