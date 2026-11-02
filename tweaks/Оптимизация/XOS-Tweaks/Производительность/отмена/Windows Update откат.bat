@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Windows Update полный блок

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Windows Update полный блок
echo.

reg delete "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAUShutdownOption /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v PauseFeatureUpdatesStartTime /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v PauseFeatureUpdatesEndTime /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v PauseQualityUpdatesStartTime /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v PauseQualityUpdatesEndTime /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v PauseUpdatesStartTime /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v PauseUpdatesExpiryTime /f >nul 2>&1

echo.
echo [OK] Отменено: Windows Update откат
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
