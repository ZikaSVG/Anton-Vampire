@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить Xbox Gaming Services

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Удалить Xbox Gaming Services
echo.

powershell -NoProfile -Command "Get-AppxPackage -Name '*Microsoft.GamingServices*' -AllUsers -EA 0 | Remove-AppxPackage -AllUsers -EA 0"

echo.
echo [OK] Готово: Удалить Xbox Gaming Services
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
