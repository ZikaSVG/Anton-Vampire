@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Очистить Prefetch

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Очистить Prefetch
echo.

del /q /f /s "%windir%\Prefetch\*.*" >nul 2>&1

echo.
echo [OK] Готово: Очистить Prefetch
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
