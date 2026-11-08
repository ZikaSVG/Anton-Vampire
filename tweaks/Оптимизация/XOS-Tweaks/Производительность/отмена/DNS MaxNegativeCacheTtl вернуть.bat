@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: DNS MaxNegativeCacheTtl 5

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] DNS MaxNegativeCacheTtl 5
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v MaxNegativeCacheTtl /f >nul 2>&1

echo.
echo [OK] Отменено: DNS MaxNegativeCacheTtl вернуть
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
