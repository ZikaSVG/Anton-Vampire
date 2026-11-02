@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Dhcp PdcActivation

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Dhcp PdcActivation
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Dhcp" /v PdcActivationDisabled /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Dhcp PdcActivation
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
