@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Nagle Ethernet

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Nagle Ethernet
echo.

for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" 2^>nul ^| findstr "HKEY"') do (
  reg delete "%%i" /v "TcpAckFrequency" /f > nul 2>&1
  reg delete "%%i" /v "TCPNoDelay" /f > nul 2>&1
)

echo.
echo [OK] Отменено: Включить Nagle Ethernet
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
