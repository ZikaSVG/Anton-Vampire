@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Пересобрать Performance Counters

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Пересобрать Performance Counters
echo.

lodctr /r >nul 2>&1
lodctr /r >nul 2>&1
winmgmt /resyncperf >nul 2>&1

echo.
echo [OK] Готово: Пересобрать Performance Counters
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
