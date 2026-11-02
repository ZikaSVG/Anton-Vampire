@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить SecurityAndMaintenance уведомления

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Отключить SecurityAndMaintenance уведомления
echo.

reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить SecurityAndMaintenance уведомления
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
