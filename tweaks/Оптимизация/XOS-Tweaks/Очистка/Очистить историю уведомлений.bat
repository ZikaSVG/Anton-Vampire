@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Очистить историю уведомлений

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Очистить историю уведомлений
echo.

del /q /f /s "%LOCALAPPDATA%\Microsoft\Windows\Notifications\*.*" >nul 2>&1

echo.
echo [OK] Готово: Очистить историю уведомлений
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
