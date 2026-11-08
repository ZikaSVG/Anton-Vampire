@echo off
setlocal EnableExtensions
chcp 65001 >nul

net session >nul 2>&1
if not "%errorlevel%"=="0" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs -Wait"
    exit /b
)

call :ensure_service "wuauserv"       "demand"
call :ensure_service "bits"           "demand"
call :ensure_service "cryptsvc"       "auto"
call :ensure_service "msiserver"      "demand"
call :ensure_service "DoSvc"          "demand"
call :ensure_service "UsoSvc"         "demand"
call :ensure_service "ClipSVC"        "demand"
call :ensure_service "InstallService" "demand"

exit /b 0

:ensure_service
setlocal
set "SRV=%~1"
set "SRV_START=%~2"

sc query "%SRV%" >nul 2>&1
if not "%errorlevel%"=="0" ( endlocal & exit /b 0 )

sc qc "%SRV%" | find /i "DISABLED" >nul 2>&1
if "%errorlevel%"=="0" ( sc config "%SRV%" start= %SRV_START% >nul 2>&1 )

sc query "%SRV%" | find /i "RUNNING" >nul 2>&1
if "%errorlevel%"=="0" ( endlocal & exit /b 0 )

net start "%SRV%" >nul 2>&1
endlocal & exit /b 0