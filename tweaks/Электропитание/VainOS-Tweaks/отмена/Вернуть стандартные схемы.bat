@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Применить VainOS Power Plan

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Применить VainOS Power Plan
echo.

:: --- Вернуть стандартные схемы
powercfg -restoredefaultschemes >nul 2>&1
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul 2>&1

:: --- Снять под-ключи Enum
for %%a in (
  EnhancedPowerManagementEnabled
  AllowIdleIrpInD3
  EnableSelectiveSuspend
  DeviceSelectiveSuspended
  SelectiveSuspendEnabled
  SelectiveSuspendOn
  WaitWakeEnabled
  D3ColdSupported
  WdfDirectedPowerTransitionEnable
  EnableIdlePowerManagement
  IdleInWorkingState
  WakeEnabled
) do (
  for /f "delims=" %%b in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum" /s /f "%%a" 2^>nul ^| findstr "HKEY"') do (
    reg delete "%%b" /v "%%a" /f >nul 2>&1
  )
)

echo.
echo [OK] Отменено: Вернуть стандартные схемы
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
