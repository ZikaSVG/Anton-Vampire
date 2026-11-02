@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить Power Session Manager

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Настроить Power Session Manager
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "PowerSettingProfile" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "WatchdogResumeTimeout" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "WatchdogSleepTimeout" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "Win32CalloutWatchdogBugcheckEnabled" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "IdleScanInterval" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "SleepStudyDisabled" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть Power Session Manager
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
