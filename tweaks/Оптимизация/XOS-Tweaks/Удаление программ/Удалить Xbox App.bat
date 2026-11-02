@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить Xbox App

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Удалить Xbox App
echo.

powershell -NoProfile -Command "Get-AppxPackage -Name '*Microsoft.XboxApp*' -AllUsers -EA 0 | Remove-AppxPackage -AllUsers -EA 0"
powershell -NoProfile -Command "Get-AppxPackage -Name '*Microsoft.GamingApp*' -AllUsers -EA 0 | Remove-AppxPackage -AllUsers -EA 0"

echo.
echo [OK] Готово: Удалить Xbox App
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
