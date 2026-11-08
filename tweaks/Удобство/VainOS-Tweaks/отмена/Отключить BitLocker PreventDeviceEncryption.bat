@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Включить BitLocker PreventDeviceEncryption

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Включить BitLocker PreventDeviceEncryption
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\BitLocker" /v "PreventDeviceEncryption" /f >nul 2>&1

echo.
echo [OK] Отменено: Отключить BitLocker PreventDeviceEncryption
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
