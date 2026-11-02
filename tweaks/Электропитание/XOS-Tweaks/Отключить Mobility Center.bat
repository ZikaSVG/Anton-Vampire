@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Mobility Center

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Mobility Center
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\MobilityCenter" /v NoMobilityCenter /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Отключить Mobility Center
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
