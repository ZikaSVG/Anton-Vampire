@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Очистить кэш Store

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Очистить кэш Store
echo.

wsreset.exe >nul 2>&1

echo.
echo [OK] Готово: Очистить кэш Store
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
