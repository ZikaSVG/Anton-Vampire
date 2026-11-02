@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить LSA ETW и Tracing

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить LSA ETW и Tracing
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Lsa\Audit" /v EtwDirect /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Lsa\Tracing" /v TracingDisabled /f >nul 2>&1

echo.
echo [OK] Отменено: Включить LSA ETW
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
