@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Скрыть Task View

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Скрыть Task View
echo.

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Скрыть Task View
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
