@echo off
setlocal EnableExtensions
chcp 65001 >nul

net session >nul 2>&1
if not "%errorlevel%"=="0" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs -Wait"
    exit /b
)

if exist "%TEMP%" (
    attrib -h -s -r "%TEMP%\*" /s /d >nul 2>&1
    del /f /s /q "%TEMP%\*" >nul 2>&1
    for /d %%D in ("%TEMP%\*") do rd /s /q "%%~fD" >nul 2>&1
)
exit /b 0