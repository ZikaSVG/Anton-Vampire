@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Включить MSI mode GPU Network

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Включить MSI mode GPU Network
echo.

powershell -NoProfile -Command ^
  "function S($w) { Get-WmiObject -Class $w -EA 0 | Where-Object { $_.PNPDeviceID -like 'PCI\VEN_*' } | ForEach-Object { $r='HKLM:\SYSTEM\CurrentControlSet\Enum\'+$_.PNPDeviceID+'\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties'; Remove-ItemProperty $r -Name 'MSISupported' -Force -EA 0 } }; S 'Win32_VideoController'; S 'Win32_NetworkAdapter'; S 'Win32_IDEController'"

echo.
echo [OK] Отменено: Отключить MSI mode
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
