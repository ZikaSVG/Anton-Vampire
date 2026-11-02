@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Teredo AllowLowPowerMode

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Teredo AllowLowPowerMode
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Services\iphlpsvc\Teredo" /v AllowLowPowerMode /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Teredo AllowLowPowerMode
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
