@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить Mixed Reality Portal

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Удалить Mixed Reality Portal
echo.

powershell -NoProfile -Command "Get-AppxPackage -Name '*Microsoft.MixedReality.Portal*' -AllUsers -EA 0 | Remove-AppxPackage -AllUsers -EA 0"

echo.
echo [OK] Готово: Удалить Mixed Reality Portal
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
