@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить File History и Maintenance

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить File History и Maintenance
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\FileHistory" /v "Disabled" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\ScheduledDiagnostics" /v "EnabledExecution" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Task Scheduler\Maintenance" /v "WakeUp" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\ScheduledDiagnostics" /v "EnabledExecution" /t REG_DWORD /d "1" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить File History и Maintenance
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
