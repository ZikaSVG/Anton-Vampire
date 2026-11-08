@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить Xbox, Teams, DevHome, CrossDevice

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Удалить Xbox, Teams, DevHome, CrossDevice
echo.

:: --- Microsoft.YourPhone
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "Get-AppxPackage Microsoft.YourPhone* | Remove-AppxPackage -EA 0;" ^
  "Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq 'Microsoft.YourPhone' } | Remove-AppxProvisionedPackage -Online -EA 0" > nul 2>&1

:: --- MicrosoftTeams
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "Get-AppxPackage MicrosoftTeams* | Remove-AppxPackage -EA 0;" ^
  "Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq 'MicrosoftTeams' } | Remove-AppxProvisionedPackage -Online -EA 0" > nul 2>&1

:: --- Microsoft.Windows.DevHome
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "Get-AppxPackage Microsoft.Windows.DevHome* | Remove-AppxPackage -EA 0;" ^
  "Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq 'Microsoft.Windows.DevHome' } | Remove-AppxProvisionedPackage -Online -EA 0" > nul 2>&1

:: --- MicrosoftWindows.CrossDevice
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "Get-AppxPackage MicrosoftWindows.CrossDevice* | Remove-AppxPackage -EA 0;" ^
  "Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq 'MicrosoftWindows.CrossDevice' } | Remove-AppxProvisionedPackage -Online -EA 0" > nul 2>&1

echo.
echo [OK] Готово: Удалить Xbox, Teams, DevHome, CrossDevice
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
