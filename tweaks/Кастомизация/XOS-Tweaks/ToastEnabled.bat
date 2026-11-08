@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ToastEnabled

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] ToastEnabled
echo.

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v ToastEnabled /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: ToastEnabled
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
