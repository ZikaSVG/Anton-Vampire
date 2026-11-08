@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Assigned Access Manager

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Assigned Access Manager
echo.

sc config AssignedAccessManagerSvc start= demand >nul 2>&1

echo.
echo [OK] Отменено: Включить Assigned Access Manager
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
