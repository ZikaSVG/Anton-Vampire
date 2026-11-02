@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Удалить Mixed Reality Portal

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Удалить Mixed Reality Portal
echo.

echo Установите Mixed Reality Portal из Microsoft Store.

echo.
echo [OK] Отменено: Восстановить Mixed Reality Portal
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
