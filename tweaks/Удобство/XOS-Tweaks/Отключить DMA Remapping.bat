@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить DMA Remapping

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить DMA Remapping
echo.

reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\DmaGuard\DeviceEnumerationPolicy" /v value /t REG_DWORD /d 2 /f

echo.
echo [OK] Готово: Отключить DMA Remapping
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
