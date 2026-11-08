@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Применить SOS Power Plan

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Применить SOS Power Plan
echo.

:: --- Вернуть стандартные схемы
powercfg -restoredefaultschemes >nul 2>&1
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul 2>&1

:: --- Снять под-ключи Enum
for %%i in (
  EnhancedPowerManagementEnabled
  AllowIdleIrpInD3
  EnableSelectiveSuspend
  DeviceSelectiveSuspended
  SelectiveSuspendEnabled
  SelectiveSuspendOn
  EnumerationRetryCount
  ExtPropDescSemaphore
  WaitWakeEnabled
  D3ColdSupported
  WdfDirectedPowerTransitionEnable
  EnableIdlePowerManagement
  IdleInWorkingState
) do (
  for /f %%a in ('Reg.exe query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "%%i" 2^>nul ^| findstr "HKEY"') do (
    Reg.exe delete "%%a" /v "%%i" /f >nul 2>&1
  )
)

echo.
echo [OK] Отменено: Вернуть стандартные схемы
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
