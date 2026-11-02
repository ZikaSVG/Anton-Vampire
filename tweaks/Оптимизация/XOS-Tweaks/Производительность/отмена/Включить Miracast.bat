@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Miracast

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Miracast
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v MiracastForceDisable /t REG_DWORD /d 0 /f

echo.
echo [OK] Отменено: Включить Miracast
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
