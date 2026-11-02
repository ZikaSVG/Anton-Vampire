@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить DMA Remapping

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить DMA Remapping
echo.

for /f "delims=" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /s /f "DmaRemappingCompatible" 2^>nul ^| findstr /i "Services"') do (
  reg delete "%%i" /v DmaRemappingCompatible /f >nul 2>&1
)

echo.
echo [OK] Отменено: Включить DMA Remapping
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
