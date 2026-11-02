@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить SmartScreen App Install Control

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить SmartScreen App Install Control
echo.

reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\SmartScreen" /v ConfigureAppInstallControlEnabled /f >nul 2>&1
reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\SmartScreen" /v ConfigureAppInstallControl /f >nul 2>&1

echo.
echo [OK] Отменено: Включить App Install Control
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
