@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить UIPI SQM

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить UIPI SQM
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\UIPI" /v EnableMessageSQM /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить UIPI SQM
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
