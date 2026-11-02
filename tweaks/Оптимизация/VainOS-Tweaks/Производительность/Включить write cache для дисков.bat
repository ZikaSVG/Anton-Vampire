@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Включить write cache для дисков

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Включить write cache для дисков
echo.

for /f "delims=" %%k in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /f "{4d36e967-e325-11ce-bfc1-08002be10318}" /d /s 2^>nul ^| find "HKEY"') do (
  reg add "%%k\Device Parameters\Disk" /v UserWriteCacheSetting /t REG_DWORD /d 1 /f >nul 2>&1
  reg add "%%k\Device Parameters\Disk" /v CacheIsPowerProtected /t REG_DWORD /d 1 /f >nul 2>&1
)

echo.
echo [OK] Готово: Включить write cache для дисков
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
