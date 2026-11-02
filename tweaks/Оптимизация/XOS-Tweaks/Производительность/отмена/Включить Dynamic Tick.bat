@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Dynamic Tick

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Dynamic Tick
echo.

bcdedit /deletevalue disabledynamictick >nul 2>&1

echo.
echo [OK] Отменено: Включить Dynamic Tick
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
