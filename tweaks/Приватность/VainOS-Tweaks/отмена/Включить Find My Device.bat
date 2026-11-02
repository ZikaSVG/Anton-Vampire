@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Find My Device

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить Find My Device
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\FindMyDevice" /v "AllowFindMyDevice" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\FindMyDevice" /v "LocationSyncEnabled" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Find My Device
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
