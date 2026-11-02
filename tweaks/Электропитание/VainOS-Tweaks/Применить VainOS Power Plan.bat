@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Применить VainOS Power Plan

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Применить VainOS Power Plan
echo.

:: --- Импорт vain.pow из корня дерева
if not exist "%~dp0..\vain.pow" (
  echo [!] vain.pow не найден в корне VainOS-Tweaks.
  echo [!] Положите его туда и запустите снова.
  pause & exit /b 1
)
powercfg -import "%~dp0..\vain.pow" 77777777-7777-7777-7777-777777777777 >nul 2>&1
powercfg -setactive 77777777-7777-7777-7777-777777777777 >nul 2>&1

:: --- Удалить стандартные схемы
powercfg -delete 381b4222-f694-41f0-9685-ff5bb260df2e >nul 2>&1
powercfg -delete 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
powercfg -delete a1841308-3541-4fab-bc81-f71556f20b4a >nul 2>&1

:: --- 12 под-ключей Enum для отключения энергосбережения устройств
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
    reg add "%%b" /v "%%a" /t REG_DWORD /d 0 /f >nul 2>&1
  )
)

echo.
echo [OK] Готово: Применить VainOS Power Plan
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
