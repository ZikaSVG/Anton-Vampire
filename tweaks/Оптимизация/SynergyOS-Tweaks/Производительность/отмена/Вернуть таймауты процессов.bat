@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить таймауты процессов

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Настроить таймауты процессов
echo.

reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "5000" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "WaitToKillTimeout" /t REG_SZ /d "5000" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "5000" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть таймауты процессов
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
