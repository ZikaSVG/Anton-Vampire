@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Включить DirectPlay

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Включить DirectPlay
echo.

powershell -NoProfile -Command "Enable-WindowsOptionalFeature -Online -FeatureName DirectPlay -NoRestart -All -EA 0"

echo.
echo [OK] Готово: Включить DirectPlay
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
