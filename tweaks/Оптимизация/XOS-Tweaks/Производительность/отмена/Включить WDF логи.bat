@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить WDF логи

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить WDF логи
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Wdf" /v WdfGlobalLogsDisabled /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Wdf" /v WdfGlobalSleepStudyDisabled /f >nul 2>&1

echo.
echo [OK] Отменено: Включить WDF логи
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
