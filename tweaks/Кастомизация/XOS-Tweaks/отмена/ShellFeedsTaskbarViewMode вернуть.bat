@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: ShellFeedsTaskbarViewMode 2

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] ShellFeedsTaskbarViewMode 2
echo.

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 0 /f

echo.
echo [OK] Отменено: ShellFeedsTaskbarViewMode вернуть
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
