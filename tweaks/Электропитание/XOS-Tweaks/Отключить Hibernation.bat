@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Hibernation

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Hibernation
echo.

powercfg -h off

echo.
echo [OK] Готово: Отключить Hibernation
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
