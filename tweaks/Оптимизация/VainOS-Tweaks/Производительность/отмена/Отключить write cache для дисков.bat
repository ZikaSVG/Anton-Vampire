@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Включить write cache для дисков

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Включить write cache для дисков
echo.

for /f "delims=" %%k in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /f "{4d36e967-e325-11ce-bfc1-08002be10318}" /d /s 2^>nul ^| find "HKEY"') do (
  reg delete "%%k\Device Parameters\Disk" /v UserWriteCacheSetting /f >nul 2>&1
  reg delete "%%k\Device Parameters\Disk" /v CacheIsPowerProtected /f >nul 2>&1
)

echo.
echo [OK] Отменено: Отключить write cache для дисков
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
