@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить ядро

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Настроить ядро
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableExceptionChainValidation" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableControlFlowGuardXfg" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableControlFlowGuardExportSuppression" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "AlwaysTrackIoBoosting" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "ForceBugcheckForDpcWatchdog" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "EnableWerUserReporting" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "SeLpacEnableWatsonReporting" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "SerializeTimerExpiration" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DriveRemappingMitigation" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть ядро
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
