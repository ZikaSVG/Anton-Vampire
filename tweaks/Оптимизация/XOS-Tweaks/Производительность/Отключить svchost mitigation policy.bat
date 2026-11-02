@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить svchost mitigation policy

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить svchost mitigation policy
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\SCMConfig" /v EnableSvchostMitigationPolicy /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить svchost mitigation policy
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
