@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Включить BitLocker PreventDeviceEncryption

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Включить BitLocker PreventDeviceEncryption
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\BitLocker" /v "PreventDeviceEncryption" /t REG_DWORD /d "1" /f >nul 2>&1

echo.
echo [OK] Готово: Включить BitLocker PreventDeviceEncryption
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
