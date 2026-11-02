@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Удалить Microsoft Teams

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Удалить Microsoft Teams
echo.

echo Установите Teams с https://teams.microsoft.com

echo.
echo [OK] Отменено: Восстановить Microsoft Teams
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
