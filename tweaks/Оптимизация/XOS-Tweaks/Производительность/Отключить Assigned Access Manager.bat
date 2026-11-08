@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Assigned Access Manager

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Assigned Access Manager
echo.

sc config AssignedAccessManagerSvc start= disabled >nul 2>&1
sc stop AssignedAccessManagerSvc >nul 2>&1

echo.
echo [OK] Готово: Отключить Assigned Access Manager
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
