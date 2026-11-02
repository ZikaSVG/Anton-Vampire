@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title DelayedDesktopSwitchTimeout 0

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] DelayedDesktopSwitchTimeout 0
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v DelayedDesktopSwitchTimeout /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: DelayedDesktopSwitchTimeout 0
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
