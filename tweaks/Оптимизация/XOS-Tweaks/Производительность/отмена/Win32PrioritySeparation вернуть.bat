@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Win32PrioritySeparation 38

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Win32PrioritySeparation 38
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 2 /f

echo.
echo [OK] Отменено: Win32PrioritySeparation вернуть
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
