@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить таймауты AC

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить таймауты AC
echo.

powercfg /x monitor-timeout-ac 15
powercfg /x disk-timeout-ac 20
powercfg /x standby-timeout-ac 30

echo.
echo [OK] Отменено: Вернуть таймауты AC
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
