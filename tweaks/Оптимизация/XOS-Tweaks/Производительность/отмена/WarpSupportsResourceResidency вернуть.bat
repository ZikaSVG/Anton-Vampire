@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: WarpSupportsResourceResidency

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] WarpSupportsResourceResidency
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v WarpSupportsResourceResidency /f >nul 2>&1

echo.
echo [OK] Отменено: WarpSupportsResourceResidency вернуть
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
