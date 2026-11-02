@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить таймауты процессов

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Настроить таймауты процессов
echo.

reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "1500" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "WaitToKillTimeout" /t REG_SZ /d "2500" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "2500" /f >nul 2>&1

echo.
echo [OK] Готово: Настроить таймауты процессов
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
