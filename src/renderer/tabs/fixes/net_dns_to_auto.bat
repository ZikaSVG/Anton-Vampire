@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul

net session >nul 2>&1
if not "%errorlevel%"=="0" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs -Wait"
    exit /b
)

for /f "skip=3 tokens=1,2,3,*" %%A in ('netsh interface show interface') do (
    if /i "%%A"=="Enabled" if /i "%%B"=="Connected" (
        netsh interface ip set dns name="%%D" dhcp >nul 2>&1
    )
)

exit /b 0