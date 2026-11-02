@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить таймауты

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Настроить таймауты
echo.

:: --- Вернуть дефолтные таймауты (монитор 10 мин, диск 20 мин, сон 30 мин)
powercfg /x monitor-timeout-ac 10 >nul 2>&1
powercfg /x monitor-timeout-dc 5 >nul 2>&1
powercfg /x disk-timeout-ac 20 >nul 2>&1
powercfg /x disk-timeout-dc 10 >nul 2>&1
powercfg /x standby-timeout-ac 30 >nul 2>&1
powercfg /x standby-timeout-dc 15 >nul 2>&1
powercfg /x hibernate-timeout-ac 0 >nul 2>&1
powercfg /x hibernate-timeout-dc 0 >nul 2>&1

echo.
echo [OK] Отменено: Вернуть таймауты
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
