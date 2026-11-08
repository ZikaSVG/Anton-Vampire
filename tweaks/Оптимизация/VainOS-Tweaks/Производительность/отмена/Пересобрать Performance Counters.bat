@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Пересобрать Performance Counters

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Пересобрать Performance Counters
echo.

echo [!] Пересборка счётчиков производительности не откатывается.

echo.
echo [OK] Отменено: Пересобрать Performance Counters
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
