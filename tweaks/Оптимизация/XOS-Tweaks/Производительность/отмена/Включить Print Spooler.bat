@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Print Spooler

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Print Spooler
echo.

sc config Spooler start= auto >nul 2>&1
sc start Spooler >nul 2>&1

echo.
echo [OK] Отменено: Включить Print Spooler
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
