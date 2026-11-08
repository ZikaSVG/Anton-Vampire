@echo off
setlocal EnableExtensions
chcp 65001 >nul

net session >nul 2>&1
if not "%errorlevel%"=="0" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs -Wait"
    exit /b
)

call :stop_svc wuauserv
call :stop_svc bits
call :stop_svc dosvc

if exist "C:\Windows\SoftwareDistribution\Download" (
    attrib -h -s -r "C:\Windows\SoftwareDistribution\Download\*" /s /d >nul 2>&1
    del /f /s /q "C:\Windows\SoftwareDistribution\Download\*" >nul 2>&1
    for /d %%D in ("C:\Windows\SoftwareDistribution\Download\*") do rd /s /q "%%~fD" >nul 2>&1
)

exit /b 0

:stop_svc
set "SVC=%~1"
sc query "%SVC%" >nul 2>&1
if errorlevel 1 exit /b 0
sc query "%SVC%" | find /I "STOPPED" >nul 2>&1
if not errorlevel 1 exit /b 0
sc stop "%SVC%" >nul 2>&1
timeout /t 2 /nobreak >nul
exit /b 0