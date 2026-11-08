@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Print Spooler

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Print Spooler
echo.

sc config Spooler start= disabled >nul 2>&1
sc stop Spooler >nul 2>&1

echo.
echo [OK] Готово: Отключить Print Spooler
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
