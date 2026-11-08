@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить DMA Remapping

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Отключить DMA Remapping
echo.

for /f %%i in ('Reg.exe query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services" /s /f DmaRemappingCompatible 2^>nul ^| find /i "Services\"') do (
  Reg.exe delete "%%i" /v "DmaRemappingCompatible" /f >nul 2>&1
)
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\storahci\Parameters" /v "DmaRemappingCompatible" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters" /v "DmaRemappingCompatible" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить DMA Remapping
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
