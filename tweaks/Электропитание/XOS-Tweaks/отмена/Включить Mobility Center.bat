@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Mobility Center

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Mobility Center
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\MobilityCenter" /v NoMobilityCenter /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Mobility Center
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
