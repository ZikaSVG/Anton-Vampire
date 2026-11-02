@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Delivery Optimization DownloadMode

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Delivery Optimization DownloadMode
echo.

reg add "HKEY_USERS\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v DownloadMode /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v SystemSettingsDownloadMode /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить Delivery Optimization DownloadMode
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
