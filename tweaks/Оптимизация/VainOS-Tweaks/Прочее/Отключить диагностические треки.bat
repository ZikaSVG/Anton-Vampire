@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить диагностические треки

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Отключить диагностические треки
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Telemetry" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdiSystemHost" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdiServiceHost" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\troubleshootingsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\diagsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpmt" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pla" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wmiApSrv" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WerSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\svsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\diagtrack" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wercplsupport" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\kdnic" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Wecsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dps" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pcasvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dusmsvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ndu" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DSSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop Telemetry >nul 2>&1
sc stop WdiSystemHost >nul 2>&1
sc stop WdiServiceHost >nul 2>&1
sc stop diagtrack >nul 2>&1

echo.
echo [OK] Готово: Отключить диагностические треки
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
