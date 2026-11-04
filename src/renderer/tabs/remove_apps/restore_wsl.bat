@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Удалить WSL

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Удалить WSL
echo.

powershell -NoProfile -Command "Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart -EA 0"
powershell -NoProfile -Command "Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart -EA 0"
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WslService" /v Start /t REG_DWORD /d 3 /f

echo.
echo [OK] Отменено: Восстановить WSL
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
