@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Удалить Xbox App

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Удалить Xbox App
echo.

echo Установите Xbox App из Microsoft Store.

echo.
echo [OK] Отменено: Восстановить Xbox App
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
