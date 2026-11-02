@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Заблокировать Shell Extensions

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Заблокировать Shell Extensions
echo.

reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{e2bf9676-5f8f-435c-97eb-11607a5bedf7}" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{e2bf9676-5f8f-435c-97eb-11607a5bedf7}" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{596AB062-B4D2-4215-9F74-E9109B0A8153}" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{596AB062-B4D2-4215-9F74-E9109B0A8153}" /t REG_SZ /d "" /f >nul 2>&1

echo.
echo [OK] Готово: Заблокировать Shell Extensions
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
