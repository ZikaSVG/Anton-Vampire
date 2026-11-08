@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Nagle Ethernet

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Nagle Ethernet
echo.

set "WIFI_GUIDS= "
for /f %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /v "*PhyType" /s 2^>nul ^| findstr "HKEY"') do (
  for /f "tokens=3" %%g in ('reg query "%%a" /v "NetCfgInstanceId" 2^>nul ^| findstr /i "NetCfgInstanceId"') do set "WIFI_GUIDS=!WIFI_GUIDS!%%g "
)
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" 2^>nul ^| findstr "HKEY"') do (
  set "IFGUID=%%~ni"
  echo !WIFI_GUIDS! | findstr /i /c:"!IFGUID!" > nul
  if errorlevel 1 (
    reg add "%%i" /v "TcpAckFrequency" /t REG_DWORD /d 1 /f > nul 2>&1
    reg add "%%i" /v "TCPNoDelay" /t REG_DWORD /d 1 /f > nul 2>&1
  )
)

echo.
echo [OK] Готово: Отключить Nagle Ethernet
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
