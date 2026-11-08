@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Defender AntiSpyware

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Отключить Defender AntiSpyware
echo.

:: --- Отключить AntiSpyware
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiVirus" /t REG_DWORD /d "1" /f >nul 2>&1
:: --- Passive mode, чтобы службы не воскресли
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "PassiveMode" /t REG_DWORD /d "1" /f >nul 2>&1
:: --- Отключить UI Defender (SecHealthUI)
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage *SecHealthUI* | Remove-AppxPackage" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.Windows.Apprep.ChxApp* | Remove-AppxPackage" >nul 2>&1
:: --- Убить процессы
taskkill /f /im NisSrv.exe >nul 2>&1
taskkill /f /im SecurityHealthHost.exe >nul 2>&1
taskkill /f /im SecurityHealthService.exe >nul 2>&1
taskkill /f /im SecurityHealthSystray.exe >nul 2>&1
taskkill /f /im MsMpEng.exe >nul 2>&1

echo.
echo [OK] Готово: Отключить Defender AntiSpyware
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
