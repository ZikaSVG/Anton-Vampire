@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title RunAsTI

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] RunAsTI
echo.

reg import "%~dp0RunAsTI.reg"

echo.
echo [OK] Готово: RunAsTI
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
