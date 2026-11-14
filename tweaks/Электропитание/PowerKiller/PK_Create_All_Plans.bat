@echo off
setlocal
net session >nul 2>&1 || (echo [!] Run as Administrator. & pause & exit /b 1)

echo Creating all VampireOS power plans...

echo Checking: Balanced Performance
set "GUID=90a358c8-3bbc-4fb3-8b4e-d7ab065d2614"
powercfg /list | findstr /i "%GUID%" >nul
if not errorlevel 1 (
    echo   [OK] already exists
) else (
    echo   [*] creating...
    powercfg /duplicatescheme 381b4222-f694-41f0-9685-ff5bb260df2e %GUID% >nul
    powercfg /changename %GUID% "Balanced Performance" "Balanced performance for everyday tasks" >nul
    powercfg /setacvalueindex %GUID% 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 900 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 300 >nul 2>&1
    echo   [DONE]
)

echo Checking: Maximum Performance
set "GUID=a1b2c3d4-e5f6-4789-a0ab-cdef12345678"
powercfg /list | findstr /i "%GUID%" >nul
if not errorlevel 1 (
    echo   [OK] already exists
) else (
    echo   [*] creating...
    powercfg /duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c %GUID% >nul
    powercfg /changename %GUID% "Maximum Performance" "Maximum performance in games and work applications" >nul
    powercfg /setacvalueindex %GUID% 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 900 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 600 >nul 2>&1
    echo   [DONE]
)

echo Checking: Power Saving
set "GUID=d8e76bb7-6943-4b7c-ab30-441296b72264"
powercfg /list | findstr /i "%GUID%" >nul
if not errorlevel 1 (
    echo   [OK] already exists
) else (
    echo   [*] creating...
    powercfg /duplicatescheme a1841308-3541-4fab-bc81-f71556f20b4a %GUID% >nul
    powercfg /changename %GUID% "Power Saving" "Reduced power consumption and maximum battery life" >nul
    powercfg /setacvalueindex %GUID% 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 300 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 120 >nul 2>&1
    echo   [DONE]
)

echo Checking: NFS Racing
set "GUID=b2c3d4e5-f6a7-4890-b1c2-def345678901"
powercfg /list | findstr /i "%GUID%" >nul
if not errorlevel 1 (
    echo   [OK] already exists
) else (
    echo   [*] creating...
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
    echo   [DONE]
)

echo Checking: Shooter Low-Latency
set "GUID=c3d4e5f6-a7b8-4901-c2d3-ef4567890123"
powercfg /list | findstr /i "%GUID%" >nul
if not errorlevel 1 (
    echo   [OK] already exists
) else (
    echo   [*] creating...
    powercfg /duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c %GUID% >nul
    powercfg /changename %GUID% "Shooter Low-Latency" "Low input latency for competitive shooters" >nul
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 893dee8e-2bef-41e0-89c6-b55d0929964c 100 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 893dee8e-2bef-41e0-89c6-b55d0929964c 100 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 100 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 100 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 100 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 100 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 465e1f50-b610-473a-ab58-00d1077dc418 2 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 465e1f50-b610-473a-ab58-00d1077dc418 2 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 40fbefc7-2e9d-4d25-a185-0cfd8574bac6 1 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 40fbefc7-2e9d-4d25-a185-0cfd8574bac6 1 >nul 2>&1
    powercfg /setacvalueindex %GUID% 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 900 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 600 >nul 2>&1
    echo   [DONE]
)

echo Checking: Minimal Input Lag
set "GUID=d4e5f6a7-b8c9-4012-d3e4-f56789012345"
powercfg /list | findstr /i "%GUID%" >nul
if not errorlevel 1 (
    echo   [OK] already exists
) else (
    echo   [*] creating...
    powercfg /duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c %GUID% >nul
    powercfg /changename %GUID% "Minimal Input Lag" "Aggressive latency reduction for esports" >nul
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 893dee8e-2bef-41e0-89c6-b55d0929964c 100 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 893dee8e-2bef-41e0-89c6-b55d0929964c 100 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 100 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 100 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 100 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 100 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 465e1f50-b610-473a-ab58-00d1077dc418 2 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 465e1f50-b610-473a-ab58-00d1077dc418 2 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 40fbefc7-2e9d-4d25-a185-0cfd8574bac6 1 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 40fbefc7-2e9d-4d25-a185-0cfd8574bac6 1 >nul 2>&1
    powercfg /setacvalueindex %GUID% 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 900 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 600 >nul 2>&1
    echo   [DONE]
)

echo Checking: Energetic Death
set "GUID=7f8e9d0c-1b2a-4c3d-9e8f-a0b1c2d3e4f5"
powercfg /list | findstr /i "%GUID%" >nul
if not errorlevel 1 (
    echo   [OK] already exists
) else (
    echo   [*] creating...
    powercfg /duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c %GUID% >nul
    powercfg /changename %GUID% "Energetic Death" "Maximum CPU power, no idle, aggressive boost" >nul
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 893dee8e-2bef-41e0-89c6-b55d0929964c 100 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 893dee8e-2bef-41e0-89c6-b55d0929964c 100 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 100 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 100 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 100 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 100 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 465e1f50-b610-473a-ab58-00d1077dc418 2 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 465e1f50-b610-473a-ab58-00d1077dc418 2 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 40fbefc7-2e9d-4d25-a185-0cfd8574bac6 0 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 40fbefc7-2e9d-4d25-a185-0cfd8574bac6 0 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 36687f9e-e3a5-4dbf-b1dc-15eb381c6863 0 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 36687f9e-e3a5-4dbf-b1dc-15eb381c6863 0 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 be337238-0d82-4146-a960-4f3749d470c7 2 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 be337238-0d82-4146-a960-4f3749d470c7 2 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 94d3a615-a899-4ac5-ae2b-e4d8f634367f 1 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 94d3a615-a899-4ac5-ae2b-e4d8f634367f 1 >nul 2>&1
    powercfg /setacvalueindex %GUID% 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 0 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 0 >nul 2>&1
    powercfg /setacvalueindex %GUID% 0012ee47-9041-4b5d-9b77-535fba8b1442 6738e2c4-e8a5-4a42-b16a-e040e769756e 0 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 0012ee47-9041-4b5d-9b77-535fba8b1442 6738e2c4-e8a5-4a42-b16a-e040e769756e 0 >nul 2>&1
    powercfg /setacvalueindex %GUID% 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul 2>&1
    echo   [DONE]
)

echo Checking: Power Killer
set "GUID=8f0a1b2c-3d4e-5f60-a1b2-c3d4e5f60718"
powercfg /list | findstr /i "%GUID%" >nul
if not errorlevel 1 (
    echo   [OK] already exists
) else (
    echo   [*] creating...
    powercfg /duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c %GUID% >nul
    powercfg /changename %GUID% "Power Killer" "Absolute maximum, all cores pinned" >nul
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 893dee8e-2bef-41e0-89c6-b55d0929964c 100 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 893dee8e-2bef-41e0-89c6-b55d0929964c 100 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 100 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 100 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 100 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 100 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 ea062031-0e34-4ff1-9b6d-eb1059334028 100 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 ea062031-0e34-4ff1-9b6d-eb1059334028 100 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 465e1f50-b610-473a-ab58-00d1077dc418 2 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 465e1f50-b610-473a-ab58-00d1077dc418 2 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 40fbefc7-2e9d-4d25-a185-0cfd8574bac6 0 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 40fbefc7-2e9d-4d25-a185-0cfd8574bac6 0 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 36687f9e-e3a5-4dbf-b1dc-15eb381c6863 0 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 36687f9e-e3a5-4dbf-b1dc-15eb381c6863 0 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 be337238-0d82-4146-a960-4f3749d470c7 2 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 be337238-0d82-4146-a960-4f3749d470c7 2 >nul 2>&1
    powercfg /setacvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 94d3a615-a899-4ac5-ae2b-e4d8f634367f 1 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 54533251-82be-4824-96c1-47b60b740d00 94d3a615-a899-4ac5-ae2b-e4d8f634367f 1 >nul 2>&1
    powercfg /setacvalueindex %GUID% 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 0 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 0 >nul 2>&1
    powercfg /setacvalueindex %GUID% 0012ee47-9041-4b5d-9b77-535fba8b1442 6738e2c4-e8a5-4a42-b16a-e040e769756e 0 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 0012ee47-9041-4b5d-9b77-535fba8b1442 6738e2c4-e8a5-4a42-b16a-e040e769756e 0 >nul 2>&1
    powercfg /setacvalueindex %GUID% 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul 2>&1
    powercfg /setdcvalueindex %GUID% 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul 2>&1
    echo   [DONE]
)

echo.
echo All plans are ready.
powercfg /list
