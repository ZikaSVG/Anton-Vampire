@echo off
setlocal EnableExtensions
chcp 65001 >nul

net session >nul 2>&1
if not "%errorlevel%"=="0" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs -Wait"
    exit /b
)

ipconfig /flushdns >nul 2>&1
exit /b 0