@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить таймауты

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Настроить таймауты
echo.

powercfg /x monitor-timeout-ac 0 >nul 2>&1
powercfg /x monitor-timeout-dc 0 >nul 2>&1
powercfg /x disk-timeout-ac 0 >nul 2>&1
powercfg /x disk-timeout-dc 0 >nul 2>&1
powercfg /x standby-timeout-ac 0 >nul 2>&1
powercfg /x standby-timeout-dc 0 >nul 2>&1
powercfg /x hibernate-timeout-ac 0 >nul 2>&1
powercfg /x hibernate-timeout-dc 0 >nul 2>&1

echo.
echo [OK] Готово: Настроить таймауты
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
