@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Coalescing Timer

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Coalescing Timer
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v CoalescingTimerInterval /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BrokerInfrastructure\Parameters" /v DisableTriggerCoalescing /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Отключить Coalescing Timer
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
