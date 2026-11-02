@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить SecHealthUI Cache

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Удалить SecHealthUI Cache
echo.

powershell -NoProfile -Command "Get-AppxPackage -Name '*Microsoft.Windows.SecHealthUI*' -AllUsers -EA 0 | ForEach-Object { Reset-AppxPackage -Package $_.PackageFullName -EA 0 }"

echo.
echo [OK] Готово: Удалить SecHealthUI Cache
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
