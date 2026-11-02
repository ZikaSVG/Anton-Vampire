@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить Config Time

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Настроить Config Time
echo.

w32tm /config /syncfromflags:domhier /update >nul 2>&1
w32tm /resync >nul 2>&1

echo.
echo [OK] Отменено: Вернуть Config Time
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
