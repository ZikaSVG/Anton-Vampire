@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title TdrDelay 12

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] TdrDelay 12
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrDelay /t REG_DWORD /d 12 /f

echo.
echo [OK] Готово: TdrDelay 12
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
