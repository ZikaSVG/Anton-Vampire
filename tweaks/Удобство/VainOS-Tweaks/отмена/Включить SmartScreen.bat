@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить SmartScreen

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить SmartScreen
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Warn" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "ShellSmartScreenLevel" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "PreventOverride" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "AicEnabled" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\smartscreen.exe" /v "Debugger" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Edge" /v "SmartScreenEnabled" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\CI\Policy" /v "VerifiedAndReputablePolicyState" /f >nul 2>&1

:: --- Per-user
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "Get-Item 'Registry::HKEY_Users\S-1-5-21*\Software\Microsoft' -EA 0 | ForEach-Object {" ^
  "  $b=$_.PSPath;" ^
  "  Remove-ItemProperty \"$b\Windows\CurrentVersion\AppHost\" -Name 'EnableWebContentEvaluation' -EA 0;" ^
  "  Remove-ItemProperty \"$b\Windows\CurrentVersion\AppHost\" -Name 'PreventOverride' -EA 0" ^
  "}" >nul 2>&1

echo.
echo [OK] Отменено: Включить SmartScreen
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
