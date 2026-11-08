@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title WarpSupportsResourceResidency

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] WarpSupportsResourceResidency
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v WarpSupportsResourceResidency /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: WarpSupportsResourceResidency
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
