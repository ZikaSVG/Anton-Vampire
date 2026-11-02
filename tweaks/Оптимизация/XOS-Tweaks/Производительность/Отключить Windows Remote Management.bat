@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Windows Remote Management

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Windows Remote Management
echo.

sc config WinRM start= disabled >nul 2>&1
sc stop WinRM >nul 2>&1

echo.
echo [OK] Готово: Отключить Windows Remote Management
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
