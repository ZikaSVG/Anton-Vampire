@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Заблокировать DeviceCensus.exe

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Заблокировать DeviceCensus.exe
echo.

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v DisallowRun /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /v 1 /t REG_SZ /d "DeviceCensus.exe" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\DeviceCensus.exe" /v Debugger /t REG_SZ /d "%%SYSTEMROOT%%\System32\taskkill.exe" /f

echo.
echo [OK] Готово: Заблокировать DeviceCensus.exe
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
