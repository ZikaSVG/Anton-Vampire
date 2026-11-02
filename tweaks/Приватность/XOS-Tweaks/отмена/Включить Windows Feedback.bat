@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Windows Feedback

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Windows Feedback
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 0 /f

echo.
echo [OK] Отменено: Включить Windows Feedback
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
