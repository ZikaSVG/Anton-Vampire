@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title DNS MaxNegativeCacheTtl 5

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] DNS MaxNegativeCacheTtl 5
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v MaxNegativeCacheTtl /t REG_DWORD /d 5 /f

echo.
echo [OK] Готово: DNS MaxNegativeCacheTtl 5
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
