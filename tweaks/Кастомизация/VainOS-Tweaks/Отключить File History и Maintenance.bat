@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить File History и Maintenance

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Отключить File History и Maintenance
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\FileHistory" /v "Disabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\ScheduledDiagnostics" /v "EnabledExecution" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Task Scheduler\Maintenance" /v "WakeUp" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\ScheduledDiagnostics" /v "EnabledExecution" /t REG_DWORD /d "0" /f >nul 2>&1

echo.
echo [OK] Готово: Отключить File History и Maintenance
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
