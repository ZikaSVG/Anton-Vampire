@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Очистить Recent

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Очистить Recent
echo.

del /q /f /s "%APPDATA%\Microsoft\Windows\Recent\*.*" >nul 2>&1

echo.
echo [OK] Готово: Очистить Recent
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
