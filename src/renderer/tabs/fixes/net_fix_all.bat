@echo off
setlocal EnableExtensions
chcp 65001 >nul

net session >nul 2>&1
if not "%errorlevel%"=="0" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs -Wait"
    exit /b
)

cd /d "%~dp0"

call "net_dns_flush.bat"
call "net_dns_to_auto.bat"
call "net_ip_renew.bat"
call "net_winsock_reset.bat"
call "net_tcpip_reset.bat"

exit /b 0