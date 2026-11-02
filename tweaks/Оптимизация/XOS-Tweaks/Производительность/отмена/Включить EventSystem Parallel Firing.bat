@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить EventSystem Parallel Firing

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить EventSystem Parallel Firing
echo.

reg delete "HKLM\SOFTWARE\Microsoft\EventSystem" /v ParallelFiringTimeoutEnabled /f >nul 2>&1

echo.
echo [OK] Отменено: Включить EventSystem Parallel Firing
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
