@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: ToastEnabled

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] ToastEnabled
echo.

reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v ToastEnabled /f >nul 2>&1

echo.
echo [OK] Отменено: ToastEnabled вернуть
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
