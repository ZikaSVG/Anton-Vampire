@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Sleep Study

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Sleep Study
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v SleepStudyDisabled /t REG_DWORD /d 0 /f

echo.
echo [OK] Отменено: Включить Sleep Study
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
