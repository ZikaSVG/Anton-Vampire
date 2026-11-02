@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Sleep Study логи

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Sleep Study логи
echo.

wevtutil sl Microsoft-Windows-SleepStudy/Diagnostic /e:true >nul 2>&1
wevtutil sl Microsoft-Windows-Kernel-Processor-Power/Diagnostic /e:true >nul 2>&1
wevtutil sl Microsoft-Windows-UserModePowerService/Diagnostic /e:true >nul 2>&1

echo.
echo [OK] Отменено: Включить Sleep Study логи
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
