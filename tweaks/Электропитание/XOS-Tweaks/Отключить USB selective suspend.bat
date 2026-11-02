@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить USB selective suspend

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить USB selective suspend
echo.

for %%a in (EnhancedPowerManagementEnabled AllowIdleIrpInD3 EnableSelectiveSuspend DeviceSelectiveSuspended SelectiveSuspendEnabled SelectiveSuspendOn WaitWakeEnabled D3ColdSupported WdfDirectedPowerTransitionEnable EnableIdlePowerManagement IdleInWorkingState WakeEnabled) do (
  for /f "delims=" %%b in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "%%a" 2^>nul ^| findstr "HKEY"') do reg add "%%b" /v "%%a" /t REG_DWORD /d 0 /f >nul 2>&1
)

echo.
echo [OK] Готово: Отключить USB selective suspend
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
