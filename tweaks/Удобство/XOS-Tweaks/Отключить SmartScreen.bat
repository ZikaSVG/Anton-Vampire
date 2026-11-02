@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить SmartScreen

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить SmartScreen
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v SmartScreenEnabled /t REG_SZ /d "Off" /f
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer" /v SmartScreenEnabled /t REG_SZ /d "Off" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableSmartScreen /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v ShellSmartScreenLevel /t REG_SZ /d "Warn" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v PreventOverride /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\AppHost" /v EnableWebContentEvaluation /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v AicEnabled /t REG_SZ /d "Anywhere" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\smartscreen.exe" /v Debugger /t REG_SZ /d "%%SYSTEMROOT%%\System32\taskkill.exe" /f
reg add "HKCU\SOFTWARE\Microsoft\Edge" /v SmartScreenEnabled /t REG_SZ /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v EnableWebContentEvaluation /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CI\Policy" /v VerifiedAndReputablePolicyState /t REG_DWORD /d 0 /f

:: Per-user AppHost + Edge SmartScreen (все SID пользователей)
powershell -NoProfile -Command ^
  "Get-Item 'Registry::HKEY_Users\S-1-5-21*\Software\Microsoft' -EA 0 | ForEach-Object {" ^
  "  $b=$_.PSPath;" ^
  "  New-Item \"$b\Windows\CurrentVersion\AppHost\" -Force -EA 0 | Out-Null;" ^
  "  Set-ItemProperty \"$b\Windows\CurrentVersion\AppHost\" -Name 'EnableWebContentEvaluation' -Value 0 -Type DWord -Force -EA 0;" ^
  "  Set-ItemProperty \"$b\Windows\CurrentVersion\AppHost\" -Name 'PreventOverride' -Value 0 -Type DWord -Force -EA 0;" ^
  "  New-Item \"$b\Edge\SmartScreenEnabled\" -Force -EA 0 | Out-Null;" ^
  "  Set-ItemProperty \"$b\Edge\SmartScreenEnabled\" -Name '(Default)' -Value 0 -Force -EA 0" ^
  "}"

taskkill /f /im smartscreen.exe >nul 2>&1

echo.
echo [OK] Готово: Отключить SmartScreen
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
