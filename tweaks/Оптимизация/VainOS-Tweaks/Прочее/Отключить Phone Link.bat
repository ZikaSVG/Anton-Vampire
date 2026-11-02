@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Phone Link

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Отключить Phone Link
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "Get-AppxPackage Microsoft.YourPhone* | Remove-AppxPackage -EA 0;" ^
  "Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq 'Microsoft.YourPhone' } | Remove-AppxProvisionedPackage -Online -EA 0" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableMmx" /t REG_DWORD /d "0" /f >nul 2>&1

echo.
echo [OK] Готово: Отключить Phone Link
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
