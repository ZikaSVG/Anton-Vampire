@echo off
setlocal
set "GUID=d8e76bb7-6943-4b7c-ab30-441296b72264"

:: Ensure scheme exists
powercfg /list | findstr /i "%GUID%" >nul
if not errorlevel 1 goto :activate

echo [*] Creating scheme...
powercfg /duplicatescheme a1841308-3541-4fab-bc81-f71556f20b4a %GUID% >nul
powercfg /changename %GUID% "Power Saving" "Reduced power consumption and maximum battery life" >nul
powercfg /setacvalueindex %GUID% 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 300 >nul 2>&1
powercfg /setdcvalueindex %GUID% 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 120 >nul 2>&1

:activate
powercfg /setactive %GUID%
if errorlevel 1 (
    echo [!] Failed to activate "Power Saving"
    exit /b 1
)
echo OK: "Power Saving" activated.
