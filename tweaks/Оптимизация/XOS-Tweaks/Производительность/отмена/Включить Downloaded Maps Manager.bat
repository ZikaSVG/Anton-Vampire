@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Downloaded Maps Manager

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Downloaded Maps Manager
echo.

sc config MapsBroker start= auto >nul 2>&1

echo.
echo [OK] Отменено: Включить Downloaded Maps Manager
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
