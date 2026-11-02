@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title W11 STARTMENU cleanup

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] W11 STARTMENU cleanup
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0W11STARTMENU.ps1"

echo.
echo [OK] Готово: W11 STARTMENU cleanup
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
