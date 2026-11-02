@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить Audio CPL

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Настроить Audio CPL
echo.

reg add "HKCU\SOFTWARE\Microsoft\Multimedia\Audio\DeviceCpl" /v "ShowDisconnectedDevices" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Multimedia\Audio\DeviceCpl" /v "ShowHiddenDevices" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Multimedia\Audio" /v "UserDuckingPreference" /t REG_DWORD /d "3" /f >nul 2>&1

echo.
echo [OK] Готово: Настроить Audio CPL
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
