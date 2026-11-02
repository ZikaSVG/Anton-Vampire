@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить USB power management

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить USB power management
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v DisableLPM /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v D3ColdSupported /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v Ceip /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v DisableSelectiveSuspendUI /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usbccgp\Parameters" /v D3ColdSupported /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить USB power management
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
