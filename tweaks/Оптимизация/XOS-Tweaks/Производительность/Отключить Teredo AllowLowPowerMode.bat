@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Teredo AllowLowPowerMode

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Teredo AllowLowPowerMode
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Services\iphlpsvc\Teredo" /v AllowLowPowerMode /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить Teredo AllowLowPowerMode
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
