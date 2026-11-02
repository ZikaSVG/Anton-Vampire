@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить облачный контент CloudContent

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить облачный контент CloudContent
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableSoftLanding /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightFeatures /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableCloudOptimizedContent /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть облачный контент
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
