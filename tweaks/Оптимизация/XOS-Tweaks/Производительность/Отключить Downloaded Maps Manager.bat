@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Downloaded Maps Manager

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Downloaded Maps Manager
echo.

sc config MapsBroker start= disabled >nul 2>&1
sc stop MapsBroker >nul 2>&1

echo.
echo [OK] Готово: Отключить Downloaded Maps Manager
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
