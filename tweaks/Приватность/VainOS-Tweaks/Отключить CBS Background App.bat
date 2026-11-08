@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить CBS Background App

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Отключить CBS Background App
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$b=[int](Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').CurrentBuildNumber;" ^
  "if($b -ge 26100){Write-Host 'SKIP: build 26100+'; exit 0};" ^
  "$p='HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\MicrosoftWindows.Client.CBS_cw5n1h2txyewy';" ^
  "if(-not(Test-Path $p)){New-Item $p -Force|Out-Null};" ^
  "Set-ItemProperty $p -Name 'Disabled' -Value 1 -Type DWord -Force;" ^
  "Set-ItemProperty $p -Name 'DisabledByUser' -Value 1 -Type DWord -Force" >nul 2>&1

echo.
echo [OK] Готово: Отключить CBS Background App
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
