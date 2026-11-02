@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить AppCompat

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Отключить AppCompat
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisablePCA" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PcaSvc" /v Start /t REG_DWORD /d 2 /f >nul 2>&1

echo.
echo [OK] Отменено: Включить AppCompat
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
