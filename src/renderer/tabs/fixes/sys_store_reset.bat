@echo off
setlocal EnableExtensions
chcp 65001 >nul

net session >nul 2>&1
if not "%errorlevel%"=="0" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs -Wait"
    exit /b
)

where wsreset.exe >nul 2>&1
if not "%errorlevel%"=="0" exit /b 0

start /wait "" wsreset.exe

exit /b 0