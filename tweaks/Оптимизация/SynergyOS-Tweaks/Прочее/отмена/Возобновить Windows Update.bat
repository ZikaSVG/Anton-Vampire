@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Приостановить Windows Update

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Приостановить Windows Update
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "FlightSettingsMaxPauseDays" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesStartTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesEndTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesStartTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesEndTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesStartTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesExpiryTime" /f >nul 2>&1
reg delete "HKLM\SYSTEM\Setup\UpgradeNotification" /v "UpgradeAvailable" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "AllowBuildPreview" /f >nul 2>&1

echo.
echo [OK] Отменено: Возобновить Windows Update
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
