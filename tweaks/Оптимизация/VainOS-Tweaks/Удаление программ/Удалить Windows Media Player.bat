@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить Windows Media Player

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Удалить Windows Media Player
echo.

DISM.exe /Online /Disable-Feature /FeatureName:"WindowsMediaPlayer" /NoRestart >nul 2>&1
DISM.exe /Online /Remove-Capability /CapabilityName:"Media.WindowsMediaPlayer~~~~0.0.12.0" /NoRestart >nul 2>&1
DISM.exe /Online /Disable-Feature /FeatureName:"MediaPlayback" /NoRestart >nul 2>&1
DISM.exe /Online /Disable-Feature /FeatureName:"SMBDirect" /NoRestart >nul 2>&1
DISM.exe /Online /Disable-Feature /FeatureName:"MSRDC-Infrastructure" /NoRestart >nul 2>&1
DISM.exe /Online /Disable-Feature /FeatureName:"Workfolders-client" /NoRestart >nul 2>&1
DISM.exe /Online /Disable-Feature /FeatureName:"WCF-Services45" /NoRestart >nul 2>&1
DISM.exe /Online /Disable-Feature /FeatureName:"WCF-TCP-PortSharing45" /NoRestart >nul 2>&1

echo.
echo [OK] Готово: Удалить Windows Media Player
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
