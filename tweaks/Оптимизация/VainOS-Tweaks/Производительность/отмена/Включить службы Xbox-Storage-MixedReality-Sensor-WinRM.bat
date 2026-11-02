@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить службы Xbox-Storage-MixedReality-Sensor-WinRM

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить службы Xbox-Storage-MixedReality-Sensor-WinRM
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Services\XblAuthManager" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\XblGameSave" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\XboxGipSvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\XboxNetApiSvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\StorSvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WMPNetworkSvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedRealitySvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensorService" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensrSvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinRM" /v Start /t REG_DWORD /d 3 /f >nul 2>&1

echo.
echo [OK] Отменено: Включить службы Xbox-Storage-MixedReality-Sensor-WinRM
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
