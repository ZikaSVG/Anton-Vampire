@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title CopyFileBufferedSynchronousIo 1

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] CopyFileBufferedSynchronousIo 1
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v CopyFileBufferedSynchronousIo /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: CopyFileBufferedSynchronousIo 1
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
