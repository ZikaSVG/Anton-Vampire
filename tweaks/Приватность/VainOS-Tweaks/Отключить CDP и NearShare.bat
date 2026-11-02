@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить CDP и NearShare

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Отключить CDP и NearShare
echo.

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CDP\SettingsPage" /v "BluetoothLastDisabledNearShare" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CDP" /v "NearShareChannelUserAuthzPolicy" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CDP" /v "CdpSessionUserAuthzPolicy" /t REG_DWORD /d "1" /f >nul 2>&1

echo.
echo [OK] Готово: Отключить CDP и NearShare
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
