@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Kernel DMA Protection

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить Kernel DMA Protection
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Kernel DMA Protection" /v "DeviceEnumerationPolicy" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Kernel DMA Protection
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
