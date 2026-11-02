@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить Win32PrioritySeparation

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Настроить Win32PrioritySeparation
echo.

reg add "HKLM\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "36" /f >nul 2>&1

echo.
echo [OK] Готово: Настроить Win32PrioritySeparation
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
