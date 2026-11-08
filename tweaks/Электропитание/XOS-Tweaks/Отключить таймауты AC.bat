@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить таймауты AC

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить таймауты AC
echo.

powercfg /x monitor-timeout-ac 0
powercfg /x disk-timeout-ac 0
powercfg /x standby-timeout-ac 0
powercfg /x hibernate-timeout-ac 0

echo.
echo [OK] Готово: Отключить таймауты AC
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
