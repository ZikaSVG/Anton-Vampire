@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить CPU Throttle (десктоп)

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Отключить CPU Throttle (десктоп)
echo.

:: --- Только для десктопов (без батареи)
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$bat=Get-CimInstance -ClassName Win32_Battery -EA 0;" ^
  "if($bat){Write-Host 'Laptop detected — skip CPU Throttle.'; exit 0};" ^
  "$p='HKLM:\SYSTEM\CurrentControlSet\Control\Power';" ^
  "New-ItemProperty -Path $p -Name 'DisableThrottling' -Value 1 -Type DWord -Force | Out-Null;" ^
  "New-ItemProperty -Path $p -Name 'PerfBoostMode' -Value 2 -Type DWord -Force | Out-Null;" ^
  "New-ItemProperty -Path $p -Name 'LatencyToleranceDefault' -Value 0 -Type DWord -Force | Out-Null" >nul 2>&1

echo.
echo [OK] Готово: Отключить CPU Throttle (десктоп)
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
