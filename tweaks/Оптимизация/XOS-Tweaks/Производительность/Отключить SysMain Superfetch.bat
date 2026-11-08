@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить SysMain Superfetch

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить SysMain Superfetch
echo.

sc config SysMain start= disabled >nul 2>&1
sc stop SysMain >nul 2>&1

echo.
echo [OK] Готово: Отключить SysMain Superfetch
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
