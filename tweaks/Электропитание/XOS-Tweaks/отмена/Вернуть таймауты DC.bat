@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить таймауты DC

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить таймауты DC
echo.

powercfg /x monitor-timeout-dc 5
powercfg /x disk-timeout-dc 10
powercfg /x standby-timeout-dc 15

echo.
echo [OK] Отменено: Вернуть таймауты DC
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
