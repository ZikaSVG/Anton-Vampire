@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Включить Hardware GPU Scheduling

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Включить Hardware GPU Scheduling
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 1 /f

echo.
echo [OK] Отменено: Отключить HwSchMode
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
