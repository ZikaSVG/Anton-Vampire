@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить DMA Remapping

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Отключить DMA Remapping
echo.

for /f %%i in ('Reg.exe query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services" /s /f DmaRemappingCompatible 2^>nul ^| find /i "Services\"') do (
  Reg.exe add "%%i" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
)
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storahci\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f >nul 2>&1

echo.
echo [OK] Готово: Отключить DMA Remapping
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
