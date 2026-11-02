@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить PCI D3Cold

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить PCI D3Cold
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v D3ColdSupported /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v D3ColdSupport /f >nul 2>&1

echo.
echo [OK] Отменено: Включить PCI D3Cold
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
