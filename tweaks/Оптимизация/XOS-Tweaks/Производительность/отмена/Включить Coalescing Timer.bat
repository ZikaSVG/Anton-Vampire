@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Coalescing Timer

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Coalescing Timer
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v CoalescingTimerInterval /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\BrokerInfrastructure\Parameters" /v DisableTriggerCoalescing /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Coalescing Timer
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
