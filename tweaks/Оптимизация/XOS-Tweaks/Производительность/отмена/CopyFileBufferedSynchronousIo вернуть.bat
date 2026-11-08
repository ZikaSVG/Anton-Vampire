@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: CopyFileBufferedSynchronousIo 1

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] CopyFileBufferedSynchronousIo 1
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v CopyFileBufferedSynchronousIo /f >nul 2>&1

echo.
echo [OK] Отменено: CopyFileBufferedSynchronousIo вернуть
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
