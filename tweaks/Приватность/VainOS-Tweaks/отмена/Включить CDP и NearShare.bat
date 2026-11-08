@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить CDP и NearShare

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить CDP и NearShare
echo.

reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\CDP\SettingsPage" /v "BluetoothLastDisabledNearShare" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\CDP" /v "NearShareChannelUserAuthzPolicy" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\CDP" /v "CdpSessionUserAuthzPolicy" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить CDP и NearShare
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
