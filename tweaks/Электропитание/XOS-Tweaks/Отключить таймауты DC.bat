@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить таймауты DC

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить таймауты DC
echo.

powercfg /x monitor-timeout-dc 0
powercfg /x disk-timeout-dc 0
powercfg /x standby-timeout-dc 0
powercfg /x hibernate-timeout-dc 0

echo.
echo [OK] Готово: Отключить таймауты DC
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
