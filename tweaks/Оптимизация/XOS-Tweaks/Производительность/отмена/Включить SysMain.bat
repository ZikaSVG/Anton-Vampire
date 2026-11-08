@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить SysMain Superfetch

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить SysMain Superfetch
echo.

sc config SysMain start= auto >nul 2>&1
sc start SysMain >nul 2>&1

echo.
echo [OK] Отменено: Включить SysMain
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
