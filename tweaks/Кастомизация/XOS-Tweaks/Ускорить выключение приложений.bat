@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Ускорить выключение приложений

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Ускорить выключение приложений
echo.

reg add "HKU\.DEFAULT\Control Panel\Desktop" /v CriticalAppShutdownCleanupTimeout /t REG_DWORD /d 5000 /f
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v CriticalAppShutdownTimeout /t REG_DWORD /d 5000 /f
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v WaitToKillTimeout /t REG_DWORD /d 5000 /f

echo.
echo [OK] Готово: Ускорить выключение приложений
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
