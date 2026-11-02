@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить WTDS

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить WTDS
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components" /v ServiceEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components" /v CaptureThreatWindow /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components" /v NotifyMalicious /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components" /v NotifyPasswordReuse /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components" /v NotifyUnsafeApp /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WTDS\Components" /v ServiceEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WTDS\Components" /v CaptureThreatWindow /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WTDS\Components" /v NotifyMalicious /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WTDS\Components" /v NotifyPasswordReuse /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WTDS\Components" /v NotifyUnsafeApp /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\FeatureFlags" /v BlockUxDisabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\FeatureFlags" /v TelemetryCallsEnabled /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить WTDS
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
