@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Delivery Optimization DownloadMode

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Delivery Optimization DownloadMode
echo.

reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v SystemSettingsDownloadMode /f >nul 2>&1

echo.
echo [OK] Отменено: Включить DO DownloadMode
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
