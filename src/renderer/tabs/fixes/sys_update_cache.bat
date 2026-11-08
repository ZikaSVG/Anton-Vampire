@echo off
setlocal EnableExtensions
chcp 65001 >nul

net session >nul 2>&1
if not "%errorlevel%"=="0" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs -Wait"
    exit /b
)

call :stop_service "wuauserv"
call :stop_service "bits"
call :stop_service "cryptsvc"
call :stop_service "msiserver"

timeout /t 2 >nul

call :rename_if_exists "%SystemRoot%\SoftwareDistribution" "SoftwareDistribution.old_%RANDOM%"
call :rename_if_exists "%SystemRoot%\System32\catroot2"    "catroot2.old_%RANDOM%"

call :start_service "cryptsvc"
call :start_service "bits"
call :start_service "wuauserv"
call :start_service "msiserver"

exit /b 0

:stop_service
set "SRV=%~1"
sc query "%SRV%" >nul 2>&1
if not "%errorlevel%"=="0" exit /b 0
sc query "%SRV%" | find /i "RUNNING" >nul 2>&1
if not "%errorlevel%"=="0" exit /b 0
net stop "%SRV%" >nul 2>&1
exit /b 0

:start_service
set "SRV=%~1"
sc query "%SRV%" >nul 2>&1
if not "%errorlevel%"=="0" exit /b 0
sc query "%SRV%" | find /i "RUNNING" >nul 2>&1
if "%errorlevel%"=="0" exit /b 0
net start "%SRV%" >nul 2>&1
exit /b 0

:rename_if_exists
set "TARGET=%~1"
set "NEWNAME=%~2"
if not exist "%TARGET%" exit /b 0
ren "%TARGET%" "%NEWNAME%" >nul 2>&1
exit /b 0