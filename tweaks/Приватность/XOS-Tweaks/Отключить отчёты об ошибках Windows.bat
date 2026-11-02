@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить отчёты об ошибках Windows

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить отчёты об ошибках Windows
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v DontSendAdditionalData /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v LoggingDisabled /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v DisableArchive /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v DisableWerUpload /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\Consent" /v DefaultConsent /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\Consent" /v DefaultOverrideBehavior /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Отключить отчёты об ошибках Windows
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
