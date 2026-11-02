@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: OEM-информация XOS

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] OEM-информация XOS
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v Manufacturer /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v SupportURL /f >nul 2>&1

echo.
echo [OK] Отменено: Убрать OEM-информацию
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
