@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: DelayedDesktopSwitchTimeout 0

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] DelayedDesktopSwitchTimeout 0
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v DelayedDesktopSwitchTimeout /f >nul 2>&1

echo.
echo [OK] Отменено: DelayedDesktopSwitchTimeout вернуть
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
