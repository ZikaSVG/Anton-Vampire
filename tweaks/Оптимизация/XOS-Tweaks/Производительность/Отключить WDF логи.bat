@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить WDF логи

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить WDF логи
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Wdf" /v WdfGlobalLogsDisabled /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Wdf" /v WdfGlobalSleepStudyDisabled /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Отключить WDF логи
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
