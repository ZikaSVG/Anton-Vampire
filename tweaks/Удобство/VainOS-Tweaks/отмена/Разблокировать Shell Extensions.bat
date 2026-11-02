@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Заблокировать Shell Extensions

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Заблокировать Shell Extensions
echo.

reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{e2bf9676-5f8f-435c-97eb-11607a5bedf7}" /f >nul 2>&1
reg delete "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{e2bf9676-5f8f-435c-97eb-11607a5bedf7}" /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1

echo.
echo [OK] Отменено: Разблокировать Shell Extensions
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
