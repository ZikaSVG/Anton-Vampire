@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Win32PrioritySeparation 38

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Win32PrioritySeparation 38
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f

echo.
echo [OK] Готово: Win32PrioritySeparation 38
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
