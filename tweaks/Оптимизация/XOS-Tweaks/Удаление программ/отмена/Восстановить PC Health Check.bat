@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Удалить PC Health Check

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Удалить PC Health Check
echo.

echo Скачайте PC Health Check: https://aka.ms/PCHealthCheck

echo.
echo [OK] Отменено: Восстановить PC Health Check
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
