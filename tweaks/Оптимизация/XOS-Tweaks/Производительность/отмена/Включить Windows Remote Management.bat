@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Windows Remote Management

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Windows Remote Management
echo.

sc config WinRM start= demand >nul 2>&1

echo.
echo [OK] Отменено: Включить Windows Remote Management
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
