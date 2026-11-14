@echo off
setlocal
set "GUID=b2c3d4e5-f6a7-4890-b1c2-def345678901"

:: Ensure scheme exists
powercfg /list | findstr /i "%GUID%" >nul
if not errorlevel 1 goto :activate

echo [*] Creating scheme...
powercfg /duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c %GUID% >nul
powercfg /changename %GUID% "NFS Racing" "Race-optimized, stable frametime, no CPU throttle" >nul
powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 893dee8e-2bef-41e0-89c6-b55d0929964c 100 >nul 2>&1
powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 893dee8e-2bef-41e0-89c6-b55d0929964c 100 >nul 2>&1
powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 100 >nul 2>&1
powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 100 >nul 2>&1
powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 100 >nul 2>&1
powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 100 >nul 2>&1
powercfg /setacvalueindex %GUID% 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 900 >nul 2>&1
powercfg /setdcvalueindex %GUID% 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 600 >nul 2>&1

:activate
powercfg /setactive %GUID%
if errorlevel 1 (
    echo [!] Failed to activate "NFS Racing"
    exit /b 1
)
echo OK: "NFS Racing" activated.
