@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Включить DirectPlay

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Включить DirectPlay
echo.

powershell -NoProfile -Command "Disable-WindowsOptionalFeature -Online -FeatureName DirectPlay -NoRestart -EA 0"

echo.
echo [OK] Отменено: Отключить DirectPlay
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
