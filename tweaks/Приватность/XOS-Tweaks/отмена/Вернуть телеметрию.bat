@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить телеметрию

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить телеметрию
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 3 /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v MaxTelemetryAllowed /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowDeviceNameInTelemetry /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть телеметрию
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
