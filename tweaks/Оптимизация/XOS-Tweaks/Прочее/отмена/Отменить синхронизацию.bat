@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Синхронизировать системное время

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Синхронизировать системное время
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\W32Time\Parameters" /v NtpServer /t REG_SZ /d "time.windows.com,0x9" /f

echo.
echo [OK] Отменено: Отменить синхронизацию
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
