@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Windows Feedback

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Windows Feedback
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f
reg delete "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v PeriodInNanoSeconds /f >nul 2>&1

echo.
echo [OK] Готово: Отключить Windows Feedback
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
