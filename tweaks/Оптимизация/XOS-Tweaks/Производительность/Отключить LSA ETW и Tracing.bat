@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить LSA ETW и Tracing

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить LSA ETW и Tracing
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa\Audit" /v EtwDirect /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa\Tracing" /v TracingDisabled /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Отключить LSA ETW и Tracing
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
