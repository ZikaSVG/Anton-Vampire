@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title W10 STARTMENU cleanup

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] W10 STARTMENU cleanup
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0W10STARTMENU.ps1"

echo.
echo [OK] Готово: W10 STARTMENU cleanup
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
