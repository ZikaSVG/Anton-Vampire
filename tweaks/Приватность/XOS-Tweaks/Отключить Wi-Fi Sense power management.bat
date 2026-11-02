@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Wi-Fi Sense power management

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Wi-Fi Sense power management
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local" /v fDisablePowerManagement /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy" /v fDisablePowerManagement /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Отключить Wi-Fi Sense power management
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
