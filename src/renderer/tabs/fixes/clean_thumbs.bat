@echo off
setlocal EnableExtensions
chcp 65001 >nul

net session >nul 2>&1
if not "%errorlevel%"=="0" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs -Wait"
    exit /b
)

set "THUMB=%LocalAppData%\Microsoft\Windows\Explorer"
if exist "%THUMB%" (
    del /f /q "%THUMB%\thumbcache_*.db" >nul 2>&1
    del /f /q "%THUMB%\iconcache*" >nul 2>&1
)
exit /b 0