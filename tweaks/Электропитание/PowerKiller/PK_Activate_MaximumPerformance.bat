@echo off
setlocal
set "GUID=a1b2c3d4-e5f6-4789-a0ab-cdef12345678"

:: Ensure scheme exists
powercfg /list | findstr /i "%GUID%" >nul
if not errorlevel 1 goto :activate

echo [*] Creating scheme...
powercfg /duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c %GUID% >nul
powercfg /changename %GUID% "Maximum Performance" "Maximum performance in games and work applications" >nul
powercfg /setacvalueindex %GUID% 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 900 >nul 2>&1
powercfg /setdcvalueindex %GUID% 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 600 >nul 2>&1

:activate
powercfg /setactive %GUID%
if errorlevel 1 (
    echo [!] Failed to activate "Maximum Performance"
    exit /b 1
)
echo OK: "Maximum Performance" activated.
