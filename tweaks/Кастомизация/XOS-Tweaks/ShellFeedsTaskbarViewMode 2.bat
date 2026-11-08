@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ShellFeedsTaskbarViewMode 2

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] ShellFeedsTaskbarViewMode 2
echo.

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f

echo.
echo [OK] Готово: ShellFeedsTaskbarViewMode 2
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
