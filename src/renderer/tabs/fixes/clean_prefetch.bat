@echo off
setlocal EnableExtensions
chcp 65001 >nul

net session >nul 2>&1
if not "%errorlevel%"=="0" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs -Wait"
    exit /b
)

if exist "C:\Windows\Prefetch" (
    attrib -h -s -r "C:\Windows\Prefetch\*" /s /d >nul 2>&1
    del /f /s /q "C:\Windows\Prefetch\*" >nul 2>&1
    for /d %%D in ("C:\Windows\Prefetch\*") do rd /s /q "%%~fD" >nul 2>&1
)
exit /b 0