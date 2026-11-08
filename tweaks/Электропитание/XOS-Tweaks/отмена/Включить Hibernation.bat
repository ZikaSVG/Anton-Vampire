@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Hibernation

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Hibernation
echo.

powercfg -h on

echo.
echo [OK] Отменено: Включить Hibernation
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
