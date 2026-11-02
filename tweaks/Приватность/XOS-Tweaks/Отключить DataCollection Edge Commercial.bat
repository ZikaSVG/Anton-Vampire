@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить DataCollection Edge Commercial

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить DataCollection Edge Commercial
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v MicrosoftEdgeDataOptIn /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowWUfBCloudProcessing /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowUpdateComplianceProcessing /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowCommercialDataPipeline /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DisableOneSettingsDownloads /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Отключить DataCollection Edge Commercial
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
