@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Синхронизировать системное время

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Синхронизировать системное время
echo.

sc config w32time start=demand >nul 2>&1
net stop w32time >nul 2>&1
w32tm /unregister >nul 2>&1
w32tm /register >nul 2>&1
net start w32time >nul 2>&1
w32tm /config /manualpeerlist:"time.windows.com,0x9 pool.ntp.org,0x9 time.nist.gov,0x9" /syncfromflags:manual /reliable:yes /update >nul 2>&1
net stop w32time >nul 2>&1
net start w32time >nul 2>&1
w32tm /resync /rediscover >nul 2>&1

echo.
echo [OK] Готово: Синхронизировать системное время
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
