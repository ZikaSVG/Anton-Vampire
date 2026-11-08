@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить DMA Remapping

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить DMA Remapping
echo.

reg delete "HKLM\SOFTWARE\Microsoft\PolicyManager\default\DmaGuard\DeviceEnumerationPolicy" /v value /f >nul 2>&1

echo.
echo [OK] Отменено: Включить DMA Remapping
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
