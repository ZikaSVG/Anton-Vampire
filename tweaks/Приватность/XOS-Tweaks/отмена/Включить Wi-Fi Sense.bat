@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Wi-Fi Sense power management

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Wi-Fi Sense power management
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local" /v fDisablePowerManagement /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy" /v fDisablePowerManagement /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Wi-Fi Sense
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
