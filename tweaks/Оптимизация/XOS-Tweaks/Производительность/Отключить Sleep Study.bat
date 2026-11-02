@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Sleep Study

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Sleep Study
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v SleepStudyDisabled /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Отключить Sleep Study
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
