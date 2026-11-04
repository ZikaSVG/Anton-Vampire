@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить WSL

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Удалить WSL
echo.

powershell -NoProfile -Command "Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart -EA 0"
powershell -NoProfile -Command "Disable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart -EA 0"
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WslService" /v Start /t REG_DWORD /d 4 /f
del /f /q "%windir%\System32\wsl.exe" >nul 2>&1
del /f /q "%windir%\System32\wslconfig.exe" >nul 2>&1
del /f /q "%windir%\System32\wslg.exe" >nul 2>&1
del /f /q "%windir%\System32\wslhost.exe" >nul 2>&1

echo.
echo [OK] Готово: Удалить WSL
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
