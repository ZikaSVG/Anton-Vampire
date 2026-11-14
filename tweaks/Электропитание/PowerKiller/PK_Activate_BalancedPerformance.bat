@echo off
setlocal
set "GUID=90a358c8-3bbc-4fb3-8b4e-d7ab065d2614"

:: Ensure scheme exists
powercfg /list | findstr /i "%GUID%" >nul
if not errorlevel 1 goto :activate

echo [*] Creating scheme...
powercfg /duplicatescheme 381b4222-f694-41f0-9685-ff5bb260df2e %GUID% >nul
powercfg /changename %GUID% "Balanced Performance" "Balanced performance for everyday tasks" >nul
powercfg /setacvalueindex %GUID% 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 900 >nul 2>&1
powercfg /setdcvalueindex %GUID% 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 300 >nul 2>&1

:activate
powercfg /setactive %GUID%
if errorlevel 1 (
    echo [!] Failed to activate "Balanced Performance"
    exit /b 1
)
echo OK: "Balanced Performance" activated.
