@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Defender AntiSpyware

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить Defender AntiSpyware
echo.

:: --- Вернуть AntiSpyware
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiVirus" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "PassiveMode" /f >nul 2>&1
:: --- TamperProtection = 1
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" /v "TamperProtection" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" /v "TamperProtectionSource" /t REG_DWORD /d "5" /f >nul 2>&1
:: --- Запустить службы
sc start WinDefend >nul 2>&1
sc start wscsvc >nul 2>&1
:: --- Переустановить UI Defender
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers *SecHealthUI* | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register ($_.InstallLocation + '\AppxManifest.xml') -EA 0 }" >nul 2>&1

echo.
echo [OK] Отменено: Включить Defender AntiSpyware
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
