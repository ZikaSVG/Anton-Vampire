@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Удалить Microsoft Edge

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Удалить Microsoft Edge
echo.

echo Скачайте Edge: https://www.microsoft.com/edge

echo.
echo [OK] Отменено: Восстановить Microsoft Edge
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
