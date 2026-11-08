@echo off
setlocal EnableExtensions
chcp 65001 >nul

net session >nul 2>&1
if not "%errorlevel%"=="0" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs -Wait"
    exit /b
)

if exist "%LocalAppData%\D3DSCache" (
    attrib -h -s -r "%LocalAppData%\D3DSCache\*" /s /d >nul 2>&1
    del /f /s /q "%LocalAppData%\D3DSCache\*" >nul 2>&1
    for /d %%D in ("%LocalAppData%\D3DSCache\*") do rd /s /q "%%~fD" >nul 2>&1
)
exit /b 0