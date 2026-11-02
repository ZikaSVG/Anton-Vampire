@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Включить Memory Integrity HVCI

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Включить Memory Integrity HVCI
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1

echo.
echo [OK] Готово: Включить Memory Integrity HVCI
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
