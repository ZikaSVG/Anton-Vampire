@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title RunLogonScriptSync 0

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] RunLogonScriptSync 0
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v RunLogonScriptSync /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v RunStartupScriptSync /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v RunLogonScriptSync /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v RunStartupScriptSync /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: RunLogonScriptSync 0
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
