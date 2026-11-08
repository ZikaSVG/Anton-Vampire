@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Включить MSI mode GPU Network

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Включить MSI mode GPU Network
echo.

powershell -NoProfile -Command ^
  "function S($w,$m) { Get-WmiObject -Class $w -EA 0 | Where-Object { $_.PNPDeviceID -like 'PCI\VEN_*' } | ForEach-Object { $r='HKLM:\SYSTEM\CurrentControlSet\Enum\'+$_.PNPDeviceID+'\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties'; if (-not (Test-Path $r)) { New-Item $r -Force | Out-Null }; Set-ItemProperty $r -Name 'MSISupported' -Value $m -Type DWord -Force -EA 0 } }; S 'Win32_VideoController' 1; S 'Win32_NetworkAdapter' 1; S 'Win32_IDEController' 1"

echo.
echo [OK] Готово: Включить MSI mode GPU Network
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
