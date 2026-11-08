@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Dynamic Tick

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Dynamic Tick
echo.

bcdedit /set disabledynamictick yes

echo.
echo [OK] Готово: Отключить Dynamic Tick
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
