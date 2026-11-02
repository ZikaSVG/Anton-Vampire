@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить TamperProtection

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить TamperProtection
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" /v TamperProtection /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить TamperProtection
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
