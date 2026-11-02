@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Разрешить удаление Edge через Dev Policy

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Разрешить удаление Edge через Dev Policy
echo.

reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdateDev" /v AllowUninstall /t REG_DWORD /d 1 /f
for /f "tokens=*" %%K in ('reg query "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" 2^>nul') do (
  reg delete "%%K" /v NoRemove /f >nul 2>&1
)
reg delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update" /v NoRemove /f >nul 2>&1
for /f "tokens=*" %%K in ('reg query "HKLM\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\ClientState" /s 2^>nul ^| findstr "ClientState"') do (
  reg delete "%%K" /v experiment_control_labels /f >nul 2>&1
)

echo.
echo [OK] Готово: Разрешить удаление Edge через Dev Policy
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
