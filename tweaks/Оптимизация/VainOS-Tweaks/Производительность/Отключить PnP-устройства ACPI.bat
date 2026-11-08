@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить PnP-устройства ACPI

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Отключить PnP-устройства ACPI
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$devices=@('ACPI Processor Aggregator','ACPI Wake Alarm','ACPI Thermal Zone','Microsoft Windows Management Interface for ACPI','Intel(R) Platform Monitoring Technology Device');" ^
  "Get-PnpDevice -FriendlyName $devices -ErrorAction Ignore | Disable-PnpDevice -Confirm:$false -ErrorAction Ignore" >nul 2>&1

echo.
echo [OK] Готово: Отключить PnP-устройства ACPI
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
