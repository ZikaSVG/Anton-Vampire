@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить Win32PrioritySeparation

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Настроить Win32PrioritySeparation
echo.

reg delete "HKLM\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть Win32PrioritySeparation
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
