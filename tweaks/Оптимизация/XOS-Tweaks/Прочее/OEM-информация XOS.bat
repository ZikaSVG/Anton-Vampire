@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title OEM-информация XOS

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] OEM-информация XOS
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v Manufacturer /t REG_SZ /d "XOS" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v SupportURL /t REG_SZ /d "https://discord.gg/XTYEjZNPgX" /f

echo.
echo [OK] Готово: OEM-информация XOS
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
