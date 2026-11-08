@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить Audio CPL

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Настроить Audio CPL
echo.

reg delete "HKCU\SOFTWARE\Microsoft\Multimedia\Audio\DeviceCpl" /v "ShowDisconnectedDevices" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Multimedia\Audio\DeviceCpl" /v "ShowHiddenDevices" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Multimedia\Audio" /v "UserDuckingPreference" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть Audio CPL
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
