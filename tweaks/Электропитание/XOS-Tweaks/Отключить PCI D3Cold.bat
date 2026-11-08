@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить PCI D3Cold

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить PCI D3Cold
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v D3ColdSupported /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v D3ColdSupport /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить PCI D3Cold
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
