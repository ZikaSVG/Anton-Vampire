@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Включить write cache

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Включить write cache
echo.

for /f "tokens=*" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum\SCSI" 2^>nul ^| findstr "HKEY"') do (
  for /f "tokens=*" %%a in ('reg query "%%i" 2^>nul ^| findstr "HKEY"') do (
    reg.exe add "%%a\Device Parameters\Disk" /v CacheIsPowerProtected /t REG_DWORD /d 1 /f >nul 2>&1
    reg.exe add "%%a\Device Parameters\Disk" /v UserWriteCacheSetting /t REG_DWORD /d 1 /f >nul 2>&1
  )
)

echo.
echo [OK] Готово: Включить write cache
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
