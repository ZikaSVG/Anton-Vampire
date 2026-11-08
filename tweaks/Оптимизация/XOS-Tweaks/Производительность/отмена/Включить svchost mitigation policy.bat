@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить svchost mitigation policy

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить svchost mitigation policy
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\SCMConfig" /v EnableSvchostMitigationPolicy /f >nul 2>&1

echo.
echo [OK] Отменено: Включить svchost mitigation policy
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
