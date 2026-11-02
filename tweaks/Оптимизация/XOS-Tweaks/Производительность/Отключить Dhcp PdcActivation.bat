@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Dhcp PdcActivation

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Dhcp PdcActivation
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dhcp" /v PdcActivationDisabled /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Отключить Dhcp PdcActivation
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
